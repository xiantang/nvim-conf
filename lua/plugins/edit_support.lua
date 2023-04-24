return {
	{

		"takac/vim-hardtime",
		config = function()
			vim.cmd([[
			let g:hardtime_maxcount = 2
			let g:hardtime_timeout = 500
			let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
			let g:list_of_visual_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
			let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
			let g:list_of_disabled_keys = []
			]])
		end,
	},
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
	{ "RRethy/vim-illuminate", event = "VeryLazy" },
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
}
