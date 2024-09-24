local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local limitStr = function(str)
	if #str > 25 then
		str = string.sub(str, 1, 22) .. "..."
	end
	return str
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- local label_comparator = function(entry1, entry2)
-- 	return entry1.completion_item.label < entry2.completion_item.label
-- end

local M = {}
M.config = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-calc",
		{
			"onsails/lspkind.nvim",
			lazy = false,
			config = function()
				require("lspkind").init()
			end
		},
		{
			"saadparwaiz1/cmp_luasnip",
			dependencies = {
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
				}
			}
		},
	},
	config = function()
		M.configfunc()
	end
}

M.configfunc = function()
	local lspkind = require("lspkind")
	vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
	local cmp = require("cmp")
	require("luasnip.loaders.from_vscode").lazy_load()
	local luasnip = require("luasnip")

	cmp.setup({
		completion = {
			completeopt = "menu,menuone,preview,noselect",
		},
		preselect = cmp.PreselectMode.None,
		snippet = {
			expand = function(args)
				-- vim.fn["UltiSnips#Anon"](args.body)
				luasnip.lsp_expand(args.body)
			end,
		},
		window = {
			completion = {
				-- winhighlight = "Normal:CmpWin,FloatBorder:CmpWinBor,Search:None",
				col_offset = -3,
				side_padding = 0,
				boder = 'rounded',
				scrollbar = true,
			},
			documentation = cmp.config.window.bordered(),
		},
		sorting = {
			priority_weight = 0,
			comparators = {
				-- label_comparator,
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.kind,
			},
		},
		formatting = {
			expandable_indicator = true,
			fields = { "kind", "abbr", "menu" },
			maxwidth = 60,
			maxheight = 10,
			format = function(entry, vim_item)
				local kind = lspkind.cmp_format({
					mode = "symbol_text",
					symbol_map = { Codeium = "", },
				})(entry, vim_item)
				local strings = vim.split(kind.kind, "%s", { trimempty = true })
				kind.kind = " " .. (strings[1] or "") .. " "
				kind.menu = limitStr(entry:get_completion_item().detail or "")

				return kind
			end,
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "codeverse" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
			{ name = "nvim_lua" },
			{ name = "calc" },
		}),
		mapping = cmp.mapping.preset.insert({
			['<CR>'] = cmp.mapping.confirm({ select = true }),
			['<c-f>'] = cmp.mapping({
				i = function(fallback)
					cmp.close()
					fallback()
				end
			}),
			['<c-y>'] = cmp.mapping({ i = function(fallback) fallback() end }),
			['<c-u>'] = cmp.mapping({ i = function(fallback) fallback() end }),
			['<C-o>'] = cmp.mapping({
				i = function(fallback)
					if cmp.visible() and cmp.get_active_entry() then
						cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
					else
						fallback()
					end
				end
			}),
			["<Tab>"] = cmp.mapping(
				function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- they way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(
				function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
		}),
	})
end

return M
