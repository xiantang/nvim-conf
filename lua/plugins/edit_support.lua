return {
	{ "romainl/vim-cool", event = "VeryLazy" },
	{
		"segeljakt/vim-silicon",
		event = "VeryLazy",
		config = function()
			vim.cmd([[
			 let g:silicon={}
			 let g:plug_window = 'botright 40vnew'
			 let g:silicon['output'] = '~/images/silicon-{time:%Y-%m-%d-%H%M%S}.png']])
		end,
	},
	{
		event = "BufReadPost",
		"andymass/vim-matchup",
		config = function()
			-- may set any options here
			vim.g.matchup_matchparen_offscreen = { method = "scrolloff" }
		end,
	},
	{
		"folke/neodev.nvim",
		event = "VeryLazy",
		config = function()
			require("neodev").setup({})
		end,
	},
	{ "vim-scripts/ReplaceWithRegister", event = "VeryLazy" },
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"echasnovski/mini.cursorword",
		version = "*",
		config = function()
			require("mini.cursorword").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
}
