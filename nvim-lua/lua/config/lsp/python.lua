return {
	setup = function(lspconfig, lsp)
		lspconfig.ruff_lsp.setup({
			on_attach = function()
			end,
		})
	end
}
