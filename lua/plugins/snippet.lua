return {
	{ "michaelb/sniprun", event = "VeryLazy", build = "bash ./install.sh" },
	{
		"hrsh7th/vim-vsnip-integ",
	},
	{
		"hrsh7th/vim-vsnip",
		config = function()
			vim.cmd([[
				let g:vsnip_filetypes.go = ['go']
				let g:vsnip_filetypes.lua = ['lua']
				let g:vsnip_filetypes.python = ['python']
				let g:vsnip_filetypes.sh = ['sh']
				let g:vsnip_filetypes.json = ['json']
				let g:vsnip_filetypes.markdown = ['markdown']
				let g:vsnip_filetypes.gitcommit = ['gitcommit']
				let g:vsnip_filetypes.sql = ['sql']
				let g:vsnip_filetypes.norg = ['norg']
				let g:vsnip_filetypes.c = ['c']
			]])
		end,
	},
}
