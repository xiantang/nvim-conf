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
}
