return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			local enabled = {
				"ruby",
				"lua",
				"vim",
				"gomod",
				"gosum",
				"norg",
				"python",
				"yaml",
				"make",
				"gitignore",
				"http",
				"terraform",
				"sql",
				"json",
			}
			-- local path = "/usr/local/lib/nvim/parser"
			-- vim.opt.runtimepath:append(path)

			require("nvim-treesitter.configs").setup({

				-- parser_install_dir = path,

				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "v", -- set to `false` to disable one of the mappings
						node_incremental = "v",
						-- scope_incremental = "grc",
						node_decremental = "<BS>",
					},
				},
				ensure_installed = enabled,
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
						for _, enable in pairs(enabled) do
							if lang == enable then
								return false
							end
						end
						return true
					end,
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				parser_install_dir = "/opt/homebrew/Cellar/neovim/0.9.2/lib/nvim/parser",
				textobjects = {
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@function.outer", desc = "Next class start" },
							--
							-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
							["]o"] = "@loop.*",
							-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
							--
							-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
							-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[["] = "@function.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
						-- Below will go to either the start or the end, whichever is closer.
						-- Use if you want more granular movements
						-- Make it even more gradual by adding multiple queries and regex.
						goto_next = {
							["]d"] = "@conditional.outer",
						},
						goto_previous = {
							["[d"] = "@conditional.outer",
						},
					},
				},
			})
		end,
	},
}
