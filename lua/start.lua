function RecentlySeesion()
	require("persistence").load({ last = true })
	local pwd = vim.fn.getcwd()
	-- -- get current cursor position_self
	local cursor = vim.api.nvim_win_get_cursor(0)
	-- get current win
	local win = vim.api.nvim_get_current_win()
	local cmd = string.format("NERDTreeToggle %s", pwd)
	-- -- NerdTree
	vim.cmd(cmd)
	-- move cursor to last position_self
	vim.api.nvim_win_set_cursor(win, cursor)
end

-- https://github.com/neovim/neovim/issues/8136#issuecomment-373082539 nested
vim.cmd("silent! autocmd VimEnter *  nested lua RecentlySeesion()")
