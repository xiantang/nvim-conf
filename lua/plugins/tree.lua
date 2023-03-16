return {
	{
		"preservim/nerdtree",
		cmd = { "NERDTreeToggle", "NERDTree", "NERDTreeFind", "NerdSmartLocated" },
		keys = {
			{ "<leader>l", ":lua NerdSmartLocated()<CR>", desc = "smart location" },
			{ "<leader>t", ":NERDTreeToggle<CR>", desc = "toggle" },
		},

		config = function()
			vim.cmd([[
				let NERDTreeShowBookmarks=1
				let NERDTreeShowHidden=1
				let g:NERDTreeChDirMode = 2
				" width"
				let g:NERDTreeWinSize = 25
				" mini 
				let g:NERDTreeMinimalMenu=1


				let g:vim_markdown_folding_disabled = 1
			]])
			function _G.NerdSmartLocated()
				-- get curent buff path
				local current_win = vim.api.nvim_get_current_win()
				local current_path = vim.fn.expand("%:p")
				-- read  $HOME/.NERDTreeBookmarks
				local bookmarks = vim.fn.readfile(vim.env.HOME .. "/.NERDTreeBookmarks")
				--
				local prefix_len = 0
				local prefix = ""
				for _, bookmark in ipairs(bookmarks) do
					local path = vim.split(bookmark, " ")[2]
					if path == nil then
						goto continue
					end

					-- replace ~ with $HOME
					path = string.gsub(path, "~", vim.env.HOME)
					-- the dir should be longest prefix of current_path
					if string.find(current_path, path, 1, true) == 1 and string.len(path) > prefix_len then
						prefix_len = string.len(path)
						prefix = path
					end

					::continue::
				end
				-- nerdTree open prefix
				if prefix_len > 0 then
					local cmd = string.format("NERDTree %s ", prefix)
					vim.cmd(cmd)
					-- move cursor to current win
					vim.api.nvim_set_current_win(current_win)
				end

				vim.cmd("NERDTreeFind")
				-- type zz
				vim.cmd("normal zz")
			end
			-- create a cmd for this
			vim.cmd('command NerdSmartLocated lua NerdSmartLocated()')

		end,
		dependencies = "Xuyuanp/nerdtree-git-plugin",
	},
}
