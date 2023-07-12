return {
	{
		event = "VeryLazy",
		"vim-test/vim-test",
		dependencies = {
			"tpope/vim-dispatch",
		},
		config = function()
			vim.cmd([[
	let test#strategy = {
		\ 'nearest': 'neovim',
		\ 'file':    'dispatch',
		\ 'suite':   'basic',
	\}
	let test#neovim#term_position = "topleft"
	let test#neovim#term_position = "vert"
	let test#neovim#term_position = "vert botright 50"
			]])
		end,
	},
}
