vim.cmd([[
au BufEnter leetcode.cn_*.txt set filetype=go
au BufEnter *.conf set filetype=config
au FileType * set formatoptions-=cro
au FileType nerdtree setlocal relativenumber
au CursorHold * checktime
au BufRead,BufNewFile *.jq setfiletype jq
au BufWritePost *.go silent! :lua go_org_imports()
au BufNewFile,BufRead */ssh/config  setf sshconfig
au CursorHold,CursorHoldI * checktime
au BufWinEnter NvimTree setlocal rnu
]])

last = ""

vim.api.nvim_create_autocmd({ "CursorMoved", "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		-- read last line of  ~/logfile.txt
		local logfile = vim.fn.expand("~/logfile.txt")
		local lastline = vim.fn.system("tail -n 1 " .. logfile)
		-- get last 20 chars of lastline
		local lastchars = string.sub(lastline, -20)
		-- if lastchars match regex "jjj$" then
		if string.match(lastchars, "jjjj$") then
			s = "You should use <count>j instead of jjjj"
			if last == s then
				return
			end
			require("notify")(s)
			last = s
		end
		if string.match(lastchars, "kkkk$") then
			s = "You should use <count>k instead of kkkk"
			if last == s then
				return
			end
			require("notify")(s)
			last = s
		end
		local async = require("plenary.async")
		local notify = require("notify").async
		if string.match(lastchars, "d%[left%-shift%]4$") then
			-- avoid send notification too often
			async.run(function()
				s = "You should use D instead of d$"
				if last == s then
					return
				end
				notify(s)
				last = s
			end)
			return
		end
		if string.match(lastchars, "y%[left%-shift%]4$") then
			-- avoid send notification too often
			async.run(function()
				notify("You should use Y instead of y$")
			end)
		end
	end,
})
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
	end,
})
vim.api.nvim_create_autocmd({ "DirChanged", "UIEnter" }, {
	pattern = { "*" },
	callback = function(cwd)
		local current_path = cwd.file
		-- FIXME duplicate logic with nerdtree
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
		vim.cmd(string.format("silent !tmux set-environment NVIM_DIR %s", prefix))
	end,
})
