local keylogger
local M = {}

function M.run(opts)
	if keylogger then
		vim.fn.jobstop(keylogger)
	end
	local pid = vim.fn.getpid()
	local logpath = string.format("~/logfile_%s", pid)
	M.logfile = vim.fn.expand(logpath)
	local args = { "keylogger", M.logfile }
	keylogger = vim.fn.jobstart(args)
end

function M.stop(opts)
	if keylogger then
		vim.fn.jobstop(keylogger)
	end
end

return M
