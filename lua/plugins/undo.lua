return {
	{
		"mbbill/undotree",
		config = function()
			vim.cmd([[
			" buff enter"
			function Undotree_record() abort
			if has("persistent_undo")
				 let target_path = expand('~/.undodir')
					" create the directory and any parent directories
					" if the location does not exist.
					if !isdirectory(target_path)
							call mkdir(target_path, "p", 0700)
					endif

					let &undodir=target_path
					set undofile
			endif
			endfunction
			let g:undotree_WindowLayout = 3
			autocmd BufEnter * call Undotree_record()
			]])
		end,
	},
}
