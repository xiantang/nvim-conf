return {
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
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
