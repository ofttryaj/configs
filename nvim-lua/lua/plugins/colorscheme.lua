return {
	-- "morhetz/gruvbox",
	-- "craftzdog/solarized-osaka.nvim",
	-- "theniceboy/nvim-deus",
	-- "projekt0n/github-nvim-theme",
	"rebelot/kanagawa.nvim",
	-- "RRethy/nvim-base16",
	-- dir = vim.fn.stdpath("config") .. "/colors",
	lazy = false,
	priority = 1000,
	config = function()
		-- vim.g.base16_shell_path = vim.fn.stdpath("config") .. "/base16-shell/scripts/"
		-- vim.cmd([[colorscheme github_dark_dimmed]])
		require("kanagawa").setup()
		vim.cmd([[colorscheme kanagawa]])
		-- vim.cmd([[colorscheme base16-gruvbox-dark-hard]])
	end,
}
