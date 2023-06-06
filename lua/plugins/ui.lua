return {
	{ "rcarriga/nvim-notify" },
	{
		"folke/zen-mode.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"simrat39/symbols-outline.nvim",
		event = "VeryLazy",
		config = function()
			require("symbols-outline").setup()
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		event = "VeryLazy",
		config = function()
			require("scrollbar.handlers.gitsigns").setup()
			require("scrollbar").setup({
				set_highlights = true,
				marks = {
					GitAdd = {
						text = "│",
						priority = 5,
						color = "green",
						cterm = nil,
					},
					GitChange = {
						text = "│",
						priority = 5,
						color = "yellow",
						cterm = nil,
					},
					GitDelete = {
						text = "_",
						priority = 5,
						color = "red",
						cterm = nil,
					},
				},
			})
		end,
	},
}
