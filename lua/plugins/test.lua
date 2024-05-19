return {
	{
		cmd = "AsyncRun",
		"skywind3000/asyncrun.vim",
	},
	{
		"vim-test/vim-test",
		keys = {
			"<Leader>tt",
			"<Leader>tf",
		},
		lazy = false,
		dependencies = {
			"tpope/vim-dispatch",
		},
		config = function()
			vim.keymap.set(
				"n",
				"<Leader>tt",
				":TestNearest -v<CR>",
				{ desc = "TestNearest", silent = true, noremap = true }
			)
			vim.keymap.set("n", "<Leader>tf", ":GoTestFile<CR>", { desc = "GoTestFile", silent = true, noremap = true })
			vim.keymap.set(
				"n",
				"<Leader>uv",
				":TestVisit<CR>",
				{ desc = "Go to last visit test file", silent = true, noremap = true }
			)

			vim.cmd([[
	let test#strategy = {
		\ 'nearest': 'asyncrun',
		\ 'file':    'dispatch',
		\ 'suite':   'basic',
	\}
	let test#neovim#term_position = "topleft"
	let test#neovim#term_position = "vert"
	let test#go#gotest#options = '-gcflags="all=-l -N" -v'
	let test#neovim#term_position = "vert botright 51"
  let g:asyncrun_open = 8
			]])
		end,
	},
}
