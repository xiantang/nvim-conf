return {
	{
		"kylechui/nvim-surround",
		keys = { "cs", "ys", "ds" },
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{
		"echasnovski/mini.ai",
		version = "*",
		keys = {
			"c",
			"d",
			"y",
		},
		config = function()
			require("mini.ai").setup()
		end,
	},
}
