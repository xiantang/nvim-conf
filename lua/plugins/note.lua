return {
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		--   "BufReadPre path/to/my-vault/**.md",
		--   "BufNewFile path/to/my-vault/**.md",
		-- },
		cmd = {
			"ObsidianToday",
		},

		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		-- wiki_link_func = "use_alias_only",
		wiki_link_func = "use_alias_only",
		markdown_link_func = "use_alias_only",
		opts = {
			mappings = {
				-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
				["gd"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				["<Leader>gr"] = {
					action = function()
						return [[<cmd>ObsidianBacklinks<CR>]]
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				-- Toggle check-boxes.
				-- ["<leader>ch"] = {
				-- 	action = function()
				-- 		return require("obsidian").util.toggle_checkbox()
				-- 	end,
				-- 	opts = { buffer = true },
				-- },
				-- Smart action depending on context, either follow link or toggle checkbox.
				-- ["<cr>"] = {
				-- 	action = function()
				-- 		return require("obsidian").util.smart_action()
				-- 	end,
				-- 	opts = { buffer = true, expr = true },
				-- },
			},
			workspaces = {
				{
					name = "personal",
					path = "~/vault",
				},
			},

			-- see below for full list of options 👇
		},
	},
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		enabled = false,
		ft = "norg",
		keys = {
			{ "<leader>jn", ":Neorg workspace notes<CR>:Neorg journal today<CR>", desc = "[J]ournal [N]owday " },
			{ "<leader>jy", ":Neorg workspace notes<CR>:Neorg journal yesterday<CR>", desc = "[J]ournal [Y]esterday" },
			{ "<leader>jt", ":Neorg workspace notes<CR>:Neorg journal tomorrow<CR>", desc = "[J]ournal [T]omorrow " },
		},
		opts = {
			load = {
				["core.keybinds"] = {
					config = {
						default_keybinds = false,
						hook = function(keybinds)
							keybinds.remap_event("norg", "i", "<M-CR>", "core.itero.next-iteration")
							keybinds.remap_event("norg", "n", "<M-CR>", "core.itero.next-iteration")
						end,
					},
				},
				["core.defaults"] = {}, -- Loads default behaviour
				-- ["core.presenter"] = { config = {
				-- 	zen_mode = "zen-mode",
				-- } },
				["core.export"] = {},
				["core.completion"] = { config = { engine = "nvim-cmp" } },
				["core.export.markdown"] = {
					config = {
						extensions = "all",
					},
				},
				["core.concealer"] = {
					config = {
						folds = false,
						icons = {
							todo = {
								undone = {
									icon = " ",
								},
							},
						},
					},
				}, -- Adds pretty icons to your documents
				["core.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = "~/notes",
						},
					},
				},
			},
		},
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
}
