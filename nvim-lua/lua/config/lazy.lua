local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.keymap.set("n", "<leader>ll", ":Lazy<CR>", { noremap = true })

require("lazy").setup({
	{
		"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	},
	require("plugins.conform"),
	require("plugins.fzf"),
	require("plugins.colorscheme"),
	require("plugins.statusline"),
	require("plugins.autocomplete").config,
	require("plugins.lspconfig").config,
	require("plugins.go"),
	require("plugins.rust"),
	require("plugins.python"),
	require("plugins.yazi"),
	require("plugins.snippet"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.indent-blankline"),
	require("plugins.nvim-tree"),
	require("plugins.dressing"),
})
