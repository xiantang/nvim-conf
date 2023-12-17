return {
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		lazy = true,
		opts = {},
	},
	{
		"xiantang/darcula-dark.nvim",
		lazy = true,
		dev = true,
	},
}
