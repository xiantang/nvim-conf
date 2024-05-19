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
		enabled = false,
		opts = {},
	},
	{
		"xiantang/darcula-dark.nvim",
		lazy = true,
		dev = true,
	},
}
