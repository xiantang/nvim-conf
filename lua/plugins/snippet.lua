return {
	{
		"hrsh7th/vim-vsnip-integ",
		event = "InsertEnter",
	},
	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip.loaders.from_vscode").load({
				include = { "norg", "c", "go", "python", "sh", "json", "lua", "gitcommit", "sql", "markdown" },
			})
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.expand("~/.config/nvim/my_snippets") } })
			require("luasnip.loaders.from_snipmate").lazy_load({
				paths = { vim.fn.expand("~/.config/nvim/my_snippets") },
			})
		end,

		event = "InsertEnter",
	},
	{
		"hrsh7th/vim-vsnip",
		event = "InsertEnter",
		config = function()
			vim.cmd([[
			  imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
			  smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
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
