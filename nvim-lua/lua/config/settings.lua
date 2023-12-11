local o = vim.o

o.shell = "/bin/bash"
vim.cmd([[filetype plugin indent on]])
o.cursorline = false
o.number = true
o.relativenumber = true
o.completeopt = "menuone,noinsert,noselect"
if vim.fn.has("nvim") == 1 then
    o.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
    o.inccommand = "nosplit"
    vim.keymap.set("n", "<C-q>", ":confirm qall<CR>", { noremap = true })
end
o.termguicolors = true
o.background = "dark"
o.syntax = "on"
o.autoindent = true
o.smartindent = true
o.timeoutlen = 300
o.encoding = "utf-8"
o.scrolloff = 2
o.showmode = false
o.hidden = true
o.wrap = true
o.joinspaces = false
o.signcolumn = "yes"
o.exrc = true
o.secure = true
o.splitright = true
o.splitbelow = true
o.backup = false
o.undodir = "/Users/jon/.vimdid"
o.undofile = true
o.wildmenu = true
o.wildmode = "list:longest"
o.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor"
o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 4
o.expandtab = false
o.textwidth = 100
o.formatoptions = "tc"
o.formatoptions = o.formatoptions .. "r"
o.formatoptions = o.formatoptions .. "q"
o.formatoptions = o.formatoptions .. "n"
o.formatoptions = o.formatoptions .. "b"
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.gdefault = true
o.foldenable = false
o.ruler = true
o.ttyfast = true
o.lazyredraw = ture
o.synmaxcol = 500
o.laststatus = 2
o.backspace = "indent,eol,start"
vim.opt.diffopt:append({ "iwhite", "algorithm:patience", "indent-heuristic" })
o.colorcolumn = '100'
o.showcmd = true
o.mouse= "a"
o.shortmess = o.shortmess .. "c"
-- o.list = true
-- o.listchars = 'tab:|\\ ,trail:▫'
o.listchars = "nbsp:¬,extends:»,precedes:«,trail:•"
o.sidescrolloff = 8
o.updatetime = 300
o.t_Co = 256
if vim.fn.has("nvim") == 1 then
    o.grepformat = "%f:%l:%c:%m"
    o.grepprg = "rg --vimgrep"
end

vim.cmd([[hi Normal ctermbg=NONE]])
-- set guioptions-=T " Remove toolbar
-- set vb t_vb= " No more beeps
vim.cmd([[set guioptions-=T]])
vim.cmd([[set vb t_vb=]])
-- vim.cmd([[call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")]])
-- vim.cmd([[call Base16hi("LspSignatureActiveParameter", g:base16_gui05, g:base16_gui03, g:base16_cterm05, g:base16_cterm03, "bold", "")]])

local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
vim.api.nvim_set_hl(0, 'Comment', bools)
local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
