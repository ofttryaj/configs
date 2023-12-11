return {
	-- "morhetz/gruvbox",
	-- "craftzdog/solarized-osaka.nvim",
	-- "theniceboy/nvim-deus",
	-- "projekt0n/github-nvim-theme",
	-- "folke/tokyonight.nvim",
	"rebelot/kanagawa.nvim",
	-- "RRethy/nvim-base16",
	lazy = false,
    config = true,
	priority = 1000,
	config = function()
        require("kanagawa").setup()
		-- vim.cmd([[colorscheme github_dark_dimmed]])
		vim.cmd([[colorscheme kanagawa-wave]])
	end,
}