return {
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		lazy = false,
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
