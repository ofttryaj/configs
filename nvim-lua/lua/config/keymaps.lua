vim.g.mapleader = " "
vim.g.localvimrc_ask = 0
vim.g.python3_host_prog = "/usr/local/bin/python3"
vim.g.base16_shell_path = "/Users/jon/.config/base16-shell/scripts/"

local km = vim.keymap
local opts = { noremap = true }
local ropts = { remap = true }

km.set("n", "<leader>m", "ct_", opts)
km.set("n", "<leader>n", "ct-", opts)
km.set("n", "<leader>q", "g<C-g>", opts)
km.set("n", "<leader>,", ":set invlist<CR>", opts)
km.set("n", "<leader>;", ":Buffers<CR>", opts)
km.set("n", "<leader>w", ":w<CR>", opts)
km.set("n", "<leader>i", "<C-w>l", opts)
km.set("n", "<leader>u", "<C-w>k", opts)
km.set("n", "<leader>n", "<C-w>h", opts)
km.set("n", "<leader>d", "<C-w>j", opts)
km.set("n", "<leader>r", ":res +5<CR>", opts)
km.set("n", "<leader>t", ":res -5<CR>", opts)
km.set("n", "<leader>a", ":vertical resize-5<CR>", opts)
km.set("n", "<leader>b", ":vertical resize+5<CR>", opts)
km.set("n", "<leader>p", [[:read !xsel --clipboard --output<cr>]], opts)
km.set("n", "<leader>c", [[:w !xsel -ib<cr><cr>]], opts)
km.set("n", "<leader>o", [[:e <C-R>=expand("%:p:h") . "/" <CR>]], opts)
km.set("n", "<leader><leader>", "<C-^>", opts)

km.set("n", "sv", "<C-w>t<C-w>H", opts)
km.set("n", "sh", "<C-w>t<C-w>K", opts)

km.set({ "n", "i", "v", "s", "x", "c", "o", "l", "t" }, "<C-c>", "<Esc>", opts)
km.set("i", "<C-j>", '<Esc>', opts)
km.set({ "n", "v" }, "<C-h>", ":nohlsearch<CR>", opts)

km.set("n", "n", "nzz", opts)
km.set("n", "N", "Nzz", opts)
km.set("n", "*", "*zz", opts)
km.set("n", "#", "#zz", opts)
km.set("n", "g*", "g*zz", opts)

-- km.set("n", "?", "?\v", { noremap = true })
-- km.set("n", "/", "/\v", { noremap = true })
km.set("c", "%s", "%sm/", { noremap = true })
km.set("n", "tu", ":tabe<CR>", opts)
km.set("n", "tn", ":-tabnext<CR>", opts)
km.set("n", "ti", ":+tabnext<CR>", opts)
km.set("n", ";", ":", { noremap = true })
km.set("n", "H", "^", opts)
km.set("n", "L", "$", opts)
km.set({ "n", "i" }, "<up>", "<nop>", opts)
km.set({ "n", "i" }, "<down>", "<nop>", opts)
km.set("i", "<left>", "<nop>", opts)
km.set("i", "<right>", "<nop>", opts)
km.set("n", "<left>", ":bp<CR>", opts)
km.set("n", "<right>", ":bn<CR>", opts)
km.set("n", "j", "gj", opts)
km.set("n", "k", "gk", opts)
km.set({ "n", "i" }, "<F1>", "<Esc>", opts)

km.set("n", "R", ":Joshuto<CR>", opts)
