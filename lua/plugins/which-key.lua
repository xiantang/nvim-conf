return {
	{
		"folke/which-key.nvim",
		keys = {
			"<space>",
			"z",
			"g",
			",",
			'"',
			"'",
			"@",
			{ "<C-R>", mode = "i" },
		},
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 400
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
}
