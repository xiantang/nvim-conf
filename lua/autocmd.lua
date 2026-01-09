-- Terminal: don't list terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

-- Filetype detection
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "leetcode.cn_*.txt",
	callback = function()
		vim.bo.filetype = "go"
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.conf",
	callback = function()
		vim.bo.filetype = "config"
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "Brewfile",
	callback = function()
		vim.bo.filetype = "ruby"
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = ".zpreztorc",
	callback = function()
		vim.bo.filetype = "zsh"
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.jq",
	callback = function()
		vim.bo.filetype = "jq"
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.http",
	callback = function()
		vim.bo.filetype = "http"
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.template",
	callback = function()
		vim.bo.filetype = "gotmpl"
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "sshconfig", "*/ssh/config" },
	callback = function()
		vim.bo.filetype = "sshconfig"
	end,
})

-- Disable auto-commenting on new lines
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Clear jump list on startup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("clearjumps")
	end,
})

-- Log messages on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		vim.cmd("redir >> ~/.config/nvim/messages.txt | silent messages | redir END")
	end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 50 })
	end,
})
