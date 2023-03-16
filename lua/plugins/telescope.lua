return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{ "<C-e>", ":lua project_picker(require('telescope.themes').get_dropdown{})<CR>", desc = "smart location" },
		},
		config = function()
			require("telescope").setup({
				extensions = {},
			})
			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local conf = require("telescope.config").values
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			project_picker = function(opts)
				local bookmarks = vim.fn.readfile(vim.env.HOME .. "/.NERDTreeBookmarks")
				local choices = {}

				for i, bookmark in ipairs(bookmarks) do
					local path = vim.split(bookmark, " ")[2]
					if path ~= nil then
						table.insert(choices, path)
					end
				end
				opts = opts or {}
				pickers
					.new(opts, {
						prompt_title = "Jump Between Projects",
						finder = finders.new_table({
							results = choices,
						}),
						sorter = conf.generic_sorter(opts),
						attach_mappings = function(prompt_bufnr, map)
							actions.select_default:replace(function()
								actions.close(prompt_bufnr)
								local selection = action_state.get_selected_entry()
								-- print(vim.inspect(selection))
								require("telescope.builtin").find_files({
									-- exclude png files
									file_ignore_patterns = { "*.png", "*.ttf", ".git" },
									search_dirs = { selection.value },
									-- show hidden files
									hidden = true,
									attach_mappings = function(buf, m)
										actions.select_default:replace(function()
											actions.close(buf)
											local selected = action_state.get_selected_entry()
											-- print(vim.inspect(selection))
											vim.cmd("e " .. selected.value)
											vim.cmd("NerdSmartLocated")
											vim.cmd("wincmd p")
										end)
										return true
									end,
								})
							end)
							return true
						end,
					})
					:find()
			end
		end,
	},
	{ "junegunn/fzf", event = "VeryLazy" },
	{ "junegunn/fzf.vim", event = "VeryLazy" },
	{ "nvim-lua/plenary.nvim", event = "VeryLazy" },
}
