return {
	{
		"jinh0/eyeliner.nvim",
		keys = { "f", "t" },
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
			})
		end,
	},
}
