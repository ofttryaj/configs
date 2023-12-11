local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
  require("plugins.fzf"),
  require("plugins.colorscheme"),
  require("plugins.statusline"),
  require("plugins.autocomplete").config,
  require("plugins.lspconfig").config,
  require("plugins.go"),
  require("plugins.joshuto"),
  require("plugins.snippet"),
  require("plugins.treesitter"),
})
