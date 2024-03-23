M = {}

function M.location()
	local buf_name = vim.api.nvim_buf_get_name(0)
	local val = vim.fn.filereadable(buf_name)
	if val == 1 then
		MiniFiles.open(buf_name)
		MiniFiles.reveal_cwd()
	else
		MiniFiles.open()
		MiniFiles.reveal_cwd()
	end
end

return M
