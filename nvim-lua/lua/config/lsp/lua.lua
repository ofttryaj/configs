return {
	setup = function(lspconfig, capabilities)
		require("neodev").setup({
			lspconfig = true,
			override = function()
			end
		})
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = function()
			end,
			settings = {
				Lua = {
					diagnostics = {
						globals = {
							'vim',
							'require'
						},
					},
					workspace = {
						checkThirdParty = false,
					},
					completion = {
						callSnippet = "Replace"
					}
				}
			}
		})
	end
}
