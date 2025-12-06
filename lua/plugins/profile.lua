return {
	{
		"folke/snacks.nvim",
		keys = {
			{
				"<leader>pp",
				function()
					Snacks.toggle.profiler():toggle()
				end,
				desc = "Toggle Profiler",
			},
			{
				"<leader>ph",
				function()
					Snacks.toggle.profiler_highlights():toggle()
				end,
				desc = "Toggle Profiler Highlights",
			},
			{
				"<leader>ps",
				function()
					Snacks.profiler.scratch()
				end,
				desc = "Profiler Scratch Buffer",
			},
		},
	},
}
