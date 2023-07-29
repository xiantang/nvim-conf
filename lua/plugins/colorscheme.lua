return {
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{
		"RRethy/nvim-base16",
		lazy = true,
	},
	{
		"sainnhe/sonokai",
		lazy = true,
	},
	{
		"xiantang/darcula-dark.nvim",
		dev = true,
		dependencies = {
			"nvim-treesitter",
		},
	},
}
