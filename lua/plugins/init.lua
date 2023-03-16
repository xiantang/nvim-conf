return {
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
	{ "romainl/vim-cool", event = "VeryLazy" },
}
