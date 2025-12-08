return {
	{
		"folke/snacks.nvim",
		keys = {
			{
				"<leader>up",
				function()
					Snacks.toggle.profiler():toggle()
				end,
				desc = "Toggle Profiler",
			},
			{
				"<leader>uh",
				function()
					Snacks.toggle.profiler_highlights():toggle()
				end,
				desc = "Toggle Profiler Highlights",
			},
			{
				"<leader>us",
				function()
					Snacks.profiler.scratch()
				end,
				desc = "Profiler Scratch Buffer",
			},
		},
	},
}
