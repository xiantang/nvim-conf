M = {}

string.startswith = function(self, str)
	return self:find("^" .. str) ~= nil
end
function RecentlySeesion()
	if vim.g.neovide then
		-- Put anything you want to happen only in Neovide here
		require("persistence").load({ last = true })
		return
	end
	-- get parameters from nvim start commands
	local args = vim.api.nvim_get_vvar("argv")
	-- embed
	if #args > 2 then
		return
	end

	-- check filenvim
	if vim.g.started_by_firenvim == true then
		-- set font size
		return
	end
	require("persistence").load({ last = true })
end

-- https://github.com/neovim/neovim/issues/8136#issuecomment-373082539 nested
vim.cmd("silent! autocmd VimEnter *  nested lua RecentlySeesion()")

function M.Stop()
	local args = vim.api.nvim_get_vvar("argv")
	if #args > 1 then
		vim.cmd.wa()
		vim.cmd.qa()
		return
	end
	require("persistence").save()
	local messages = vim.api.nvim_exec("messages", true)
	-- write and append to file
	vim.fn.writefile({ messages }, "/tmp/nvim.log", "a")
	-- quit all
	vim.cmd.wa()
	vim.cmd.qa()
	-- write down all :messages to a file
	-- get output of :messages
	-- write to file
	-- .local/share/nvim/swap
end

return M
