return {
	{
		"numToStr/Navigator.nvim",
		event = "VeryLazy",
		-- master
		config = function()
			require("Navigator").setup({})
		end,
	},
}
