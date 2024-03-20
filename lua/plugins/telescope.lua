return {
	-- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
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
				},
			})
			vim.api.nvim_create_autocmd("WinLeave", {
				callback = function()
					if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
						vim.api.nvim_feedkeys(
							vim.api.nvim_replace_termcodes([[<C-\><C-n>]], true, false, true),
							"i",
							false
						)
					end
				end,
			})
		end,
	},
}
