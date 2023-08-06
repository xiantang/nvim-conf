return {
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeOpen", "NerdSmartLocated" },
		keys = {
			{ "<leader>l", ":lua NerdSmartLocated()<CR>", desc = "smart location" },
			{ "<leader>t", ":NvimTreeToggle<CR>", desc = "toggle" },
		},
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local function my_on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- custom mappings
				vim.keymap.set("n", "s", api.node.open.vertical, opts("Vsplit"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			end
			require("nvim-tree").setup({
				on_attach = my_on_attach,
				sort_by = "case_sensitive",
				view = {
					width = 30,
				},
				actions = {
					open_file = {
						window_picker = {
							chars = "fjkdslaqwergh",
						},
					},
				},
				renderer = {
					icons = {
						glyphs = {
							folder = {
								arrow_closed = "⏵",
								arrow_open = "⏷",
							},
							git = {
								unstaged = "✗",
								staged = "✓",
								unmerged = "⌥",
								renamed = "➜",
								untracked = "★",
								deleted = "⊖",
								ignored = "◌",
							},
						},
					},
				},
				filters = {},
			})
			require("nvim-tree.view").View.winopts.number = true
			require("nvim-tree.view").View.winopts.relativenumber = true
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
			require("nvim-tree").filesystem_watchers = true
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
			vim.keymap.set("n", "<Leader>-", require("oil").open, { desc = "Open parent directory" })
		end,
	},
}
