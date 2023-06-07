local M = {}

local logger = require("keylogger")
M.last = ""
M.logfile = vim.fn.expand(string.format("~/logfile_%s.log", vim.fn.getpid()))

M.setup = function(opts)
	-- add UserCmd to run UShouldUseStart

	vim.api.nvim_create_user_command("UShouldUseStart", function()
		logger.run(M.logfile)
	end, {})
	vim.api.nvim_create_user_command("UShouldUseStop", function()
		logger.stop()
	end, {})

	vim.cmd("UShouldUseStart")

	vim.api.nvim_create_autocmd({ "CursorMoved", "TextYankPost", "InsertEnter" }, {
		pattern = { "*" },
		callback = function(env)
			-- read last line of  ~/logfile.txt
			local lastchars = vim.fn.system("tail -c 20 " .. M.logfile)
			local async = require("plenary.async")
			local notify = require("notify").async
			local function check(regex, recommand, wrong)
				if string.match(lastchars, regex) then
					-- avoid send notification too often
					async.run(function()
						local s = string.format("you should use %s instead of %s", recommand, wrong)
						if M.last == s then
							return
						end
						notify(s)
						M.last = s
					end, function() end)
					return true
				end
			end
			if env.event == "CursorMoved" then
				if check("bbbb$", "F<key>", "bbbb") then
					return
				end
				if check("eeee$", "f<key>", "eeee") then
					return
				end
				if check("jjjj$", "<count>j", "jjjj") then
					return
				end
				if check("kkkk$", "<count>k", "kkkk") then
					return
				end
			end
			if env.event == "InsertEnter" then
				if check("0i", "I", "0i") then
					return
				end
				if check("%[left%-shift%]4a", "A", "$a") then
					return
				end
				if check("c%[left%-shift%]4$", "C", "c$") then
					return
				end
			end
			if env.event == "TextYankPost" then
				if check("y%[left%-shift%]4$", "Y", "y$") then
					return
				end
				if check("d%[left%-shift%]4$", "D", "d$") then
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
end

return M