return {
	{
		"echasnovski/mini.colors",
		config = function()
			require("mini.colors").setup()
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
