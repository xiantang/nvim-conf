return {
	{ "romainl/vim-cool", event = "CursorMoved" },
	{
		"segeljakt/vim-silicon",
		cmd = "Silicon",
		config = function()
			vim.cmd([[
			 let g:silicon={}
			 let g:plug_window = 'botright 40vnew'
			 let g:silicon['output'] = '~/images/silicon-{time:%Y-%m-%d-%H%M%S}.png']])
		end,
	},
	{
		"andymass/vim-matchup",
		keys = { "%", "g%" },
		config = function()
			-- may set any options here
			vim.g.matchup_matchparen_offscreen = { method = "scrolloff" }
		end,
	},
	{
		"folke/neodev.nvim",
		ft = "lua",
		config = function()
			require("neodev").setup({})
		end,
	},
	{ "vim-scripts/ReplaceWithRegister", keys = "gr" },
	{
		"numToStr/Comment.nvim",
		keys = { { "gb", mode = { "n", "v" } }, { "gc", mode = { "n", "v" } } },
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		config = function()
			require("nvim-autopairs").setup({
				fast_wrap = {},
				disable_filetype = { "TelescopePrompt", "vim", "sh" },
			})
		end,
	},
	{
		"tpope/vim-sleuth",
		-- event = { "InsertEnter" },
		-- config = function()
		-- 	require("guess-indent").setup({})
		-- end,
	},
}
