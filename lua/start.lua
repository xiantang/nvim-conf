M = {}

function M.Stop()
	vim.cmd.wa()
	vim.cmd.qa()
end

return M
