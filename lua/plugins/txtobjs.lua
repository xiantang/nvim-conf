return {
	{
		"kylechui/nvim-surround",
		keys = { "ys", "ds" },
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{
		"echasnovski/mini.nvim",
		lazy = false,
		version = "*",
		config = function()
			require("mini.ai").setup()
		end,
	},
}
