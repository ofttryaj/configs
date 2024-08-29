local M = {}

local F = {}

M.config = {
	{
		'weilbith/nvim-code-action-menu',
		cmd = 'CodeActionMenu',
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v4.x',
		dependencies = {
			{
				"folke/trouble.nvim",
				opts = {
					use_diagnostic_signs = true,
					action_keys = {
						close = "<esc>",
						previous = "u",
						next = "e"
					},
				},
			},
			{ 'neovim/nvim-lspconfig' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{
				'j-hui/fidget.nvim',
				tag = "legacy"
			},
			"folke/neodev.nvim",
			"ray-x/lsp_signature.nvim",
			"ldelossa/nvim-dap-projects",
			{
				"lvimuser/lsp-inlayhints.nvim",
				branch = "anticonceal",
			},
			{ "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
			-- "mjlbach/lsp_signature.nvim",
		},

		config = function()
			local lsp_zero = require('lsp-zero')
			M.lsp_zero = lsp_zero
			-- F.configureInlayHints()

			local lsp_attach = function(client, bufnr)
                local opts = {buffer = bufnr}

                lsp_zero.default_keymaps({buffer = bufnr})

                client.server_capabilities.semanticTokensProvider = nil
                require("plugins.autocomplete").configfunc()

                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                vim.keymap.set('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({'n', 'x'}, '<leader>fr', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
               	vim.keymap.set('n', '[', vim.diagnostic.goto_prev, opts)
    			vim.keymap.set('n', ']', vim.diagnostic.goto_next, opts)
    			vim.keymap.set('n', '<leader>f', vim.diagnostic.open_float, opts)
                vim.diagnostic.config({
   					severity_sort = true,
   					underline = false,
   					signs = true,
   					virtual_text = false,
   					update_in_insert = false,
   					float = true,
				})
            end

            lsp_zero.extend_lspconfig({
                sign_text = {
                    error = '✘',
                    warn = '▲',
                    hint = '⚑',
                    info = '»',
                },
                float_border = 'rounded',
                lsp_attach = lsp_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })

            local lspconfig = require('lspconfig')
			require("config.lsp.lua").setup(lspconfig, lsp_zero)
			-- require("config.lsp.python").setup(lspconfig, lsp)
			-- require("config.lsp.csharp").setup(lspconfig, lsp)

			vim.lsp.set_log_level("off")

			require("fidget").setup({})

			-- require('nvim-dap-projects').search_project_config()

			F.configureDocAndSignature()

			local format_on_save_filetypes = {
				dart = true,
				json = true,
				go = true,
				lua = true,
				html = true,
				javascript = true,
				c = true,
				cpp = true,
				objc = true,
				objcpp = true,
				dockerfile = true,
				terraform = true,
				tex = true,
			}

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function()
					if format_on_save_filetypes[vim.bo.filetype] then
						local lineno = vim.api.nvim_win_get_cursor(0)
						vim.lsp.buf.format({ async = false })
						pcall(vim.api.nvim_win_set_cursor, 0, lineno)
					end
				end,
			})
		end
	},
}

F.signature_config = {}

F.configureInlayHints = function()
	require("lsp-inlayhints").setup({
		inlay_hints = {
			parameter_hints = {
				show = true,
				prefix = "<- ",
				separator = ", ",
				remove_colon_start = false,
				remove_colon_end = true,
			},
			type_hints = {
				-- type and other hints
				show = true,
				prefix = "",
				separator = ", ",
				remove_colon_start = false,
				remove_colon_end = false,
			},
			only_current_line = false,
			-- separator between types and parameter hints. Note that type hints are
			-- shown before parameter
			labels_separator = "  ",
			-- whether to align to the length of the longest line in the file
			max_len_align = false,
			-- padding from the left if max_len_align is true
			max_len_align_padding = 1,
			highlight = "Comment",
		},
	})
end

F.configureDocAndSignature = function()
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help, {
			-- silent = true,
			focusable = false,
			border = "none",
			zindex = 60,
		}
	)
	-- local group = vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
	-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
	-- 	pattern = "*",
	-- 	callback = function()
	-- 		vim.diagnostic.open_float({}, {
	-- 			scope = "cursor",
	-- 			focusable = false,
	-- 			zindex = 10,
	-- 			close_events = {
	-- 				"CursorMoved",
	-- 				"CursorMovedI",
	-- 				"BufHidden",
	-- 				"InsertCharPre",
	-- 				"InsertEnter",
	-- 				"WinLeave",
	-- 				"ModeChanged",
	-- 			},
	-- 		})
	-- 	end,
	-- 	group = group,
	-- })
end

return M
