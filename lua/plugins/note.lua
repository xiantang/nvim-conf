return {
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		keys = {
			{ "<leader>jt", ":Neorg workspace notes<CR>:Neorg journal today<CR>", desc = "journal today" },
		},
		opts = {
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.export"] = {},
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
