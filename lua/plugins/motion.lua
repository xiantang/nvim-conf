return {
	{
		event = "VeryLazy",
		"edluffy/specs.nvim",
		config = function()
			require("specs").setup({
				{
					show_jumps = true,
					min_jump = 30,
					popup = {
						delay_ms = 0, -- delay before popup displays
						inc_ms = 10, -- time increments used for fade/resize effects
						blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
						width = 5,
						winhl = "PMenu",
						fader = require("specs").linear_fader,
						resizer = require("specs").shrink_resizer,
					},
					ignore_filetypes = {},
					ignore_buftypes = {
						nofile = true,
					},
				},
			})
		end,
	},
	{
		"jinh0/eyeliner.nvim",
		event = "VeryLazy",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
			})
		end,
	},
	{
		"phaazon/hop.nvim",
		event = "VeryLazy",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "dfgjkalwertyuizxcnm" })
		end,
	},
}
