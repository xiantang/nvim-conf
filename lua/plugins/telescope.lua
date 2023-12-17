return {
	-- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		tag = "0.1.4",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>b", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
			-- { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "lsp_references" },
			{ "<leader>tb", "<cmd>Telescope git_branches<CR>", desc = "Git git_branches" },
			{ "<Leader>p", ":Telescope find_files<CR>", {} },
			{ "<Leader>rs", ":Telescope resume<CR>", {} },
			{ "<Leader>o", ":Telescope lsp_document_symbols<CR>", {} },
			{ "<Leader>P", ":Telescope live_grep<CR>", {} },
			-- {
			-- 	"<Leader>b",
			-- 	":lua require('telescope.builtin').buffers()<CR>",
			-- 	silent = true,
			-- 	desc = "buffers",
			-- },
		},
		config = function()
			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local conf = require("telescope.config").values
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
				pickers = {
					buffers = {
						theme = "dropdown",
						previewer = false,
						sort_mru = true,
						show_all_buffers = true,
						ignore_current_buffer = true,
						mappings = {
							n = {
								["dd"] = "delete_buffer",
							},
						},
						-- ignore current file
					},
					live_grep = {
						additional_args = function(opts)
							return { "--hidden" }
						end,
					},
					find_files = {
						hidden = true,
						--ignore git files
						file_ignore_patterns = { "%.git/.*", "node_modules/.*" },
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
		end,
	},
	{
		enabled = false,
		"nvim-pack/nvim-spectre",
	},
}
