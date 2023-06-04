return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{ "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
			{ "<leader>tb", "<cmd>Telescope git_branches<CR>", desc = "git git_branches" },
			{
				"<C-e>",
				":lua project_picker(require('telescope.themes').get_dropdown{})<CR>",
				desc = "jumping between project",
			},
			{ "<Leader>p", ":Telescope find_files<CR>", {} },
			{ "<Leader>rs", ":Telescope resume<CR>", {} },
			{ "<Leader>o", ":Telescope lsp_document_symbols<CR>", {} },
			{ "<Leader>P", ":Telescope live_grep<CR>", {} },
			{ "<C-q>", ":Telescope oldfiles<CR>", {} },
			{
				"<CR>",
				"<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>",
				{},
			},
		},
		config = function()
			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local conf = require("telescope.config").values
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")
			require("telescope").setup({
				pickers = {
					find_files = {
						on_input_filter_cb = function(prompt)
							local find_colon = string.find(prompt, ":")
							if find_colon then
								local ret = string.sub(prompt, 1, find_colon - 1)
								vim.schedule(function()
									local prompt_bufnr = vim.api.nvim_get_current_buf()
									local picker = action_state.get_current_picker(prompt_bufnr)
									local lnum = tonumber(prompt:sub(find_colon + 1))
									if type(lnum) == "number" and picker.previewer.state ~= nil then
										local win = picker.previewer.state.winid
										local bufnr = picker.previewer.state.bufnr
										local line_count = vim.api.nvim_buf_line_count(bufnr)
										vim.api.nvim_win_set_cursor(win, { math.max(1, math.min(lnum, line_count)), 0 })
									end
								end)
								return { prompt = ret }
							end
						end,
						attach_mappings = function()
							actions.select_default:enhance({
								post = function()
									-- if we found something, go to line
									local prompt = action_state.get_current_line()
									local find_colon = string.find(prompt, ":")
									if find_colon then
										local lnum = tonumber(prompt:sub(find_colon + 1))
										local line_count = vim.api.nvim_buf_line_count(0)
										if lnum >= line_count then
											lnum = line_count
										end
										vim.api.nvim_win_set_cursor(0, { lnum, 0 })
										vim.cmd("normal zz")
									end
								end,
							})
							return true
						end,
					},
				},
			})

			project_picker = function(opts)
				local bookmarks = vim.fn.readfile(vim.env.HOME .. "/.NERDTreeBookmarks")
				local choices = {}
				local pro_to_path = {}

				-- make a map key is the project name, value is the path
				for i, bookmark in ipairs(bookmarks) do
					local project_name = vim.split(bookmark, " ")[1]
					local path = vim.split(bookmark, " ")[2]
					if path ~= nil then
						pro_to_path[project_name] = path
						table.insert(choices, project_name)
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
								local project = action_state.get_selected_entry()
								-- print(vim.inspect(selection))
								require("telescope.builtin").find_files({
									-- exclude png files
									file_ignore_patterns = { "*.png", "*.ttf", ".git" },
									search_dirs = { pro_to_path[project.value] },
									-- relative path
									path_display = { "smart" },
									-- show hidden files
									hidden = true,
									attach_mappings = function(buf, m)
										actions.select_default:replace(function()
											actions.close(buf)
											local selected = action_state.get_selected_entry()
											if project.value == selected.value then
												vim.cmd("NERDTree " .. selected.value)
												return
											end
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
