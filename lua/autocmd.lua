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

vim.api.nvim_create_autocmd({ "CursorMoved", "TextYankPost", "InsertEnter" }, {
	pattern = { "*" },
	callback = function(env)
		-- read last line of  ~/logfile.txt
		local logfile = vim.fn.expand("~/logfile.txt")
		local lastline = vim.fn.system("tail -c 20 " .. logfile)
		local async = require("plenary.async")
		local notify = require("notify").async
		if env.event == "CursorMoved" then
			if string.match(lastline, "kkkk$") then
				local s = "You should use <count>k instead of kkkk"
				if last == s then
					return
				end
				require("notify")(s)
				last = s
			end
			if string.match(lastline, "bbbb$") then
				local s = "You should use F<key> instead of bbbb"
				if last == s then
					return
				end
				require("notify")(s)
				last = s
			end
			if string.match(lastline, "eeee$") then
				local s = "You should use f<key> instead of eeee"
				if last == s then
					return
				end
				require("notify")(s)
				last = s
			end
			if string.match(lastline, "jjjj$") then
				local s = "You should use <count>j instead of jjjj"
				if last == s then
					return
				end
				require("notify")(s)
				last = s
			end
			return
		end
		if env.event == "InsertEnter" then
			if string.match(lastline, "0i") then
				-- avoid send notification too often
				async.run(function()
					notify("You should use I instead of 0i")
				end)
			end
		end
		if env.event == "TextYankPost" then
			if string.match(lastline, "c%[left%-shift%]4$") then
				-- avoid send notification too often
				async.run(function()
					notify("You should use C instead of c$")
				end)
			end
			if string.match(lastline, "y%[left%-shift%]4$") then
				-- avoid send notification too often
				async.run(function()
					notify("You should use Y instead of y$")
				end)
			end
			if string.match(lastline, "d%[left%-shift%]4$") then
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
			return
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
