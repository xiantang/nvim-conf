return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 400
			require("which-key").setup({
				triggers = {
					-- marks
					"<leader>",
					"`",
					"g`",
					"g'",
					-- registers
					'"',
					"<c-r>",
					-- spelling
					"z=",
				},
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
}
