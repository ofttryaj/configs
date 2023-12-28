local function augroup(name)
	return vim.api.nvim_create_augroup("ofthoo_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 300 })
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_autocmd("BufRead", { pattern = "*.orig", command = "set readonly" })
vim.api.nvim_create_autocmd("BufRead", { pattern = "*.pacnew", command = "set readonly" })
vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "set nopaste" })
if vim.fn.has("autocmd") == 1 then
	vim.api.nvim_create_autocmd("BufReadPost",
		{
			pattern = "*",
			command =
			[[if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
		})
end
vim.api.nvim_create_autocmd("BufWritePost", { pattern = "*", command = [[if filereadable("Makefile") | make | endif]] })
vim.api.nvim_create_autocmd("FileType", { pattern = "json", command = [[syntax match Comment +\/\/.\+$+]] })

vim.cmd("autocmd FileType go nmap <Leader>gc :lua require('go.comment').gen()<CR>")
