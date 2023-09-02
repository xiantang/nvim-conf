return {
	{
		"petertriho/nvim-scrollbar",
		event = "VeryLazy",
		config = function()
			require("scrollbar").setup({
				handlers = {
					cursor = true,
					diagnostic = false,
					gitsigns = false, -- Requires gitsigns
					handle = true,
					search = false, -- Requires hlslens
					ale = false, -- Requires ALE
				},
				set_highlights = true,
			})
		end,
	},
}
