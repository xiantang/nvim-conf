return {
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local c = require("nordic.colors")
			require("nordic").setup({
				override = {
					LineNr = {
						fg = c.white0,
					}, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
					CursorLineNr = {
						fg = c.yellow.base,
					}, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
					VertSplit = {
						fg = c.blue1,
					}, -- the column separating vertically split windows
					WinSeparator = {
						fg = c.blue1,
						bold = true,
					}, -- the column separating vertically split windows
				},
			})
			require("nordic").load()
		end,
	},
	-- { "catppuccin/nvim", name = "catppuccin", lazy = true },
	-- {
	-- 	"RRethy/nvim-base16",
	-- 	lazy = true,
	-- },
	-- {
	-- 	"sainnhe/sonokai",
	-- 	lazy = true,
	-- },
}
