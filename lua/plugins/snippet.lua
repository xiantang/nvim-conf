return {
	{
		"hrsh7th/vim-vsnip-integ",
	},
	{
		"L3MON4D3/LuaSnip",
		commit = "79f647218847b1cd204fede7dd89025e43fd00c3",
		event = "InsertEnter",
	},
	{
		"hrsh7th/vim-vsnip",
		config = function()
			vim.cmd([[
			  imap <expr> <C-k>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-k>'
			  smap <expr> <C-k>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-k>'
				imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
				smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
				let g:vsnip_filetypes = {}
				let g:vsnip_filetypes.go = ['go']
				let g:vsnip_filetypes.lua = ['lua']
				let g:vsnip_filetypes.python = ['python']
				let g:vsnip_filetypes.sh = ['sh']
				let g:vsnip_filetypes.json = ['json']
				let g:vsnip_filetypes.markdown = ['markdown']
				let g:vsnip_filetypes.gitcommit = ['gitcommit']
				let g:vsnip_filetypes.sql = ['sql']
				" let g:vsnip_filetypes.norg = ['norg']
				let g:vsnip_filetypes.c = ['c']
				let g:vsnip_snippet_dir = '~/.config/nvim/snippets'
			]])
		end,
	},
}
