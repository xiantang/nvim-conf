M = {}
function RecentlySeesion()
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
	require("persistence").save()
	local messages = vim.api.nvim_exec("messages", true)
	-- write and append to file
	vim.fn.writefile({ messages }, "/tmp/nvim.log", "a")
	-- quit all
	vim.cmd("wa")
	vim.cmd("qa")
	-- write down all :messages to a file
	-- get output of :messages
	-- write to file
	-- .local/share/nvim/swap
end

return M
