return {
	{
		"numToStr/Navigator.nvim",
		keys = {
			{ "<C-l>", "<CMD>NavigatorRight<CR>", {} },
			{ "<C-h>", "<CMD>NavigatorLeft<CR>", {} },
			{ "<C-k>", "<CMD>NavigatorUp<CR>", {} },
			{ "<C-j>", "<CMD>NavigatorDown<CR>", {} },
		},
		-- master
		config = function()
			require("Navigator").setup({})
		end,
	},
}
