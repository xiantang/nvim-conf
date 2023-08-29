return {
	{
		"skywind3000/asyncrun.vim",
	},
	{
		event = "VeryLazy",
		"vim-test/vim-test",
		dependencies = {
			"tpope/vim-dispatch",
		},
		config = function()
			vim.cmd([[
	let test#strategy = {
		\ 'nearest': 'asyncrun',
		\ 'file':    'dispatch',
		\ 'suite':   'basic',
	\}
	let test#neovim#term_position = "topleft"
	let test#neovim#term_position = "vert"
	let test#go#gotest#options = '-fullpath'
	let test#neovim#term_position = "vert botright 51"
  let g:asyncrun_open = 8
			]])
		end,
	},
}
