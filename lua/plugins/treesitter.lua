return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter.configs").setup({

				matchup = {
					enable = true, -- mandatory, false will disable the whole extension
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						node_incremental = "v",
						node_decremental = "<BS>",
					},
				},
				highlight = {
					-- disable highlight for variable and package in file
					enable = true,
					additional_vim_regex_highlighting = false,
					disable = {},
				},
				indent = {
					-- because it's buggy
					enable = false,
				},
				rainbow = {
					enable = true,
					colors = {
						"#a89984",
						"#b16286",
						"#d79921",
						"#689d6a",
						"#d65d0e",
						"#458588",
					},
					-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = nil, -- Do not enable for files with more than n lines, int
					-- colors = {}, -- table of hex strings
					-- termcolors = {} -- table of colour name strings
				},
			})
			vim.api.nvim_set_hl(0, "TSVariable", { link = "Normal" })
		end,
	},
	{ "mrjones2014/nvim-ts-rainbow", event = "VeryLazy" },
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
}
