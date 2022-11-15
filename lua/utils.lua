local M = {}

function _G.console(str)
	local convert = tostring(str)
	-- check existing console
	local buf = 0
	if vim.fn.bufwinnr("LSP Console") ~= -1 then
		buf = vim.fn.bufnr("LSP Console")
	else
		-- split a new buffer with new window
		vim.cmd("vsplit")
		local win = vim.api.nvim_get_current_win()
		buf = vim.api.nvim_create_buf(true, true)
		vim.api.nvim_win_set_buf(win, buf)
		-- set buffer name
		vim.api.nvim_buf_set_name(buf, "LSP Console")
	end
	-- if include new line in string then split it
	local lines = vim.split(convert, "\n")
	-- append lines to buffer
	vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
end

function M.map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.get_all_buffers_name()
	local buffers = {}
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local name = vim.api.nvim_buf_get_name(buf)
		if name ~= "" then
			table.insert(buffers, name)
		end
	end
	return buffers
end

function M.get_buffer_contain_name(name)
	local names = M.get_all_buffers_name()
	for _, v in pairs(names) do
		-- include name as substrings
		-- check it is name is substring of vim
		if string.match(v, name) then
			print(name)
			return v
		end
	end
end

return M
