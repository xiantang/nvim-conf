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
	-- FIX duplicate with nerdtree.lua
	local current_path = vim.fn.expand("%:p")

	-- read  $HOME/.NERDTreeBookmarks
	local bookmarks = vim.fn.readfile(vim.env.HOME .. "/.NERDTreeBookmarks")
	--
	local prefix_len = 0
	local prefix = ""
	local project = ""
	for _, bookmark in ipairs(bookmarks) do
		local path = vim.split(bookmark, " ")[2]
		local p = vim.split(bookmark, " ")[1]
		if path == nil then
			goto continue
		end

		-- replace ~ with $HOME
		path = string.gsub(path, "~", vim.env.HOME)
		-- the dir should be longest prefix of current_path
		if string.find(current_path, path, 1, true) == 1 and string.len(path) > prefix_len then
			prefix_len = string.len(path)
			prefix = path
			project = p
		end

		::continue::
	end

	vim.cmd(string.format("silent !tmux rename-window %s", project))
end

-- https://github.com/neovim/neovim/issues/8136#issuecomment-373082539 nested
vim.cmd("silent! autocmd VimEnter *  nested lua RecentlySeesion()")

function M.Stop()
	local args = vim.api.nvim_get_vvar("argv")
	vim.cmd([[!tmux set-window-option automatic-rename "on" 1>/dev/null]])
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
