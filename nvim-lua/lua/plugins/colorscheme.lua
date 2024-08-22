return {
	-- "morhetz/gruvbox",
	-- "craftzdog/solarized-osaka.nvim",
	-- "theniceboy/nvim-deus",
	-- "projekt0n/github-nvim-theme",
	"rebelot/kanagawa.nvim",
	-- "wincent/base16-nvim",
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

		-- Make it clearly visible which argument we're at.
		local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
		vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
	end,
}
