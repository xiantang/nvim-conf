vim.cmd([[
autocmd VimResized * wincmd =
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

vim.api.nvim_create_autocmd({
	"BufWritePost",
}, {
	pattern = { "fugitive" },
	callback = function()
		vim.cmd("silent! :NvimTreeRefresh")
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
