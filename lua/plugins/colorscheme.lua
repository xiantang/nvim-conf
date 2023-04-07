return {
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local c = require("nordic.colors")
			require("nordic").setup({
				override = {
					WinSeparator = {
						fg = c.blue1,
						bold = true,
					}, -- the column separating vertically split windows
				},
			})
			require("nordic").load()
		end,
	},
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{
		"RRethy/nvim-base16",
		lazy = true,
	},
	{
		"sainnhe/sonokai",
		lazy = true,
	},
}
