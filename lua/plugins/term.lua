return {
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		config = function()
			require("toggleterm").setup({
				direction = "float",
			})
		end,
	},
	{
		"chomosuke/term-edit.nvim",
		ft = "toggleterm",
		version = "1.*",
		config = function()
			-- Calling require 'term-edit'.setup(opts) is mandatory
			require("term-edit").setup({
				-- Mandatory option:
				-- Set this to a lua pattern that would match the end of your prompt.
				-- Or a table of multiple lua patterns where at least one would match the
				-- end of your prompt at any given time.
				-- For most bash/zsh user this is '%$ '.
				-- For most powershell/fish user this is '> '.
				-- For most windows cmd user this is '>'.
				prompt_end = "%$ ",
				-- How to write lua patterns: https://www.lua.org/pil/20.2.html
			})
		end,
	},
}
