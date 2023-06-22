return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				char = {
					enabled = true,
					search = { wrap = false },
					highlight = { backdrop = true },
					jump = { register = false },
				},
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					-- default options: exact mode, multi window, all directions, with a backdrop
					require("flash").jump({
						search = { forward = true, wrap = false, multi_window = false },
					})
				end,
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					-- default options: exact mode, multi window, all directions, with a backdrop
					require("flash").jump({
						search = { forward = false, wrap = false, multi_window = false },
					})
				end,
			},
		},
	},
}
