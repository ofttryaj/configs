local M = {}

local F = {}

M.config = {
	{
		'weilbith/nvim-code-action-menu',
		cmd = 'CodeActionMenu',
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
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
			-- F.configureInlayHints()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local lspconfig = require('lspconfig')
			require("config.lsp.lua").setup(lspconfig, capabilities)
			require("config.lsp.python").setup(lspconfig, capabilities)
			-- require("config.lsp.csharp").setup(lspconfig)

			vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set('n', '<leader>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					--vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', '<leader>f', function()
						vim.lsp.buf.format { async = true }
					end, opts)

					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if client ~= nil then
						client.server_capabilities.semanticTokensProvider = nil
					end
					if client ~= nil and client.name == 'ruff_lsp' then
						client.server_capabilities.hoverProvider = false
					end
				end
			})

			local signs = {
				Error = '✘',
				Warn = '▲',
				Hint = '⚑',
				Info = '»',
			}
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end
			vim.lsp.set_log_level("off")

			require("fidget").setup({})

			-- require('nvim-dap-projects').search_project_config()

			F.configureDocAndSignature()
			vim.diagnostic.config({
				severity_sort = true,
				underline = false,
				virtual_text = false,
				update_in_insert = false,
				float = true,
			})

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
