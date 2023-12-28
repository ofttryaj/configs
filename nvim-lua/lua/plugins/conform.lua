return {
	"stevearc/conform.nvim",
	config = function()
		local opts = {
			formatters_by_ft = {
				cs = { "csharpier" },
			},
			formatters = {
				csharpier = {
					command = "dotnet-csharpier",
					args = { "--write-stdout" },
				},
			},
			-- format_on_save = {
			-- 	-- These options will be passed to conform.format()
			-- 	timeout_ms = 500,
			-- 	lsp_fallback = true,
			-- },
		}
		require("conform").setup(opts);
		local aug = vim.api.nvim_create_augroup("Conform", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.cs" },
			group = aug,
			callback = function(args)
				require("conform").format({ buf = args.buf, async = false, lsp_fallback = true, timeout_ms = 500 })
			end,
		})
	end
}
