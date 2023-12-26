return {
	{
		"nvim-neotest/neotest-python",
	},
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim' },
		cmd = "VenvSelect",
		opts = function(_, opts)
			return vim.tbl_deep_extend("force", opts, {
				name = {
					"venv",
					".venv",
					"env",
					".env",
				},
			})
		end,
		keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
	}
}
