return {
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NimTreeOpen", "NerdSmartLocated" },
		keys = {
			{ "<leader>l", ":lua NerdSmartLocated()<CR>", desc = "smart location" },
			{ "<leader>t", ":NvimTreeToggle<CR>", desc = "toggle" },
		},
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				view = {
					adaptive_size = true,
				},
			})
			function _G.NerdSmartLocated()
				-- get curent buff path
				local current_win = vim.api.nvim_get_current_win()
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
				-- nerdTree open prefix
				if prefix_len > 0 then
					vim.cmd(string.format("silent !tmux rename-window %s", project))
					vim.cmd(string.format("silent !tmux set-environment NVIM_DIR %s", prefix))
					local api = require("nvim-tree.api")
					api.tree.change_root(prefix)
					-- move cursor to current win
					vim.api.nvim_set_current_win(current_win)
				end

				vim.cmd("NvimTreeFindFile")
				-- type zz
				vim.cmd("normal zz")
			end
			-- create a cmd for this
			vim.cmd("command NerdSmartLocated lua NerdSmartLocated()")
		end,
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local fm = require("oil").setup({

				view_options = {
					-- Show files and directories that start with "."
					show_hidden = true,
					-- This function defines what is considered a "hidden" file
					is_hidden_file = function(name, bufnr)
						return vim.startswith(name, ".")
					end,
					-- This function defines what will never be shown, even when `show_hidden` is set
					is_always_hidden = function(name, bufnr)
						return false
					end,
				},
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["s"] = "actions.select_vsplit",
					["<C-t>"] = "actions.select_tab",
					["<C-p>"] = "actions.preview",
					["q"] = "actions.close",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["g."] = "actions.toggle_hidden",
				},
				use_default_keymaps = false,
			})
			vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
		end,
	},
	{ "Xuyuanp/nerdtree-git-plugin", event = "VeryLazy" },
	-- {
	-- 	"preservim/nerdtree",
	-- 	cmd = { "NERDTreeClose", "NERDTreeToggle", "NERDTree", "NERDTreeFind", "NerdSmartLocated" },
	-- 	keys = {
	-- 		{ "<leader>l", ":lua NerdSmartLocated()<CR>", desc = "smart location" },
	-- 		{ "<leader>t", ":NERDTreeToggle<CR>", desc = "toggle" },
	-- 	},
	--
	-- 	config = function()
	-- 		vim.cmd([[
	-- 			let g:NERDTreeShowHidden=1
	-- 			let g:NERDTreeChDirMode = 2
	-- 			" width"
	-- 			let g:NERDTreeWinSize = 27
	-- 			let g:NERDTreeShowLineNumbers=1
	-- 			" mini
	-- 			let g:NERDTreeMinimalMenu=1
	--
	--
	-- 			let g:vim_markdown_folding_disabled = 1
	-- 		]])
	-- 		function _G.NerdSmartLocated()
	-- 			-- get curent buff path
	-- 			local current_win = vim.api.nvim_get_current_win()
	-- 			local current_path = vim.fn.expand("%:p")
	-- 			-- read  $HOME/.NERDTreeBookmarks
	-- 			local bookmarks = vim.fn.readfile(vim.env.HOME .. "/.NERDTreeBookmarks")
	-- 			--
	-- 			local prefix_len = 0
	-- 			local prefix = ""
	-- 			local project = ""
	-- 			for _, bookmark in ipairs(bookmarks) do
	-- 				local path = vim.split(bookmark, " ")[2]
	-- 				local p = vim.split(bookmark, " ")[1]
	-- 				if path == nil then
	-- 					goto continue
	-- 				end
	--
	-- 				-- replace ~ with $HOME
	-- 				path = string.gsub(path, "~", vim.env.HOME)
	-- 				-- the dir should be longest prefix of current_path
	-- 				if string.find(current_path, path, 1, true) == 1 and string.len(path) > prefix_len then
	-- 					prefix_len = string.len(path)
	-- 					prefix = path
	-- 					project = p
	-- 				end
	--
	-- 				::continue::
	-- 			end
	-- 			-- nerdTree open prefix
	-- 			if prefix_len > 0 then
	-- 				vim.cmd(string.format("silent !tmux rename-window %s", project))
	-- 				vim.cmd(string.format("silent !tmux set-environment NVIM_DIR %s", prefix))
	-- 				local cmd = string.format("NERDTree %s ", prefix)
	-- 				vim.cmd(cmd)
	-- 				-- move cursor to current win
	-- 				vim.api.nvim_set_current_win(current_win)
	-- 			end
	--
	-- 			vim.cmd("NERDTreeFind")
	-- 			-- type zz
	-- 			vim.cmd("normal zz")
	-- 		end
	-- 		-- create a cmd for this
	-- 		vim.cmd("command NerdSmartLocated lua NerdSmartLocated()")
	-- 	end,
	-- 	dependencies = "Xuyuanp/nerdtree-git-plugin",
	-- },
}
