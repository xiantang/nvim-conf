return {
	{
		"glacambre/firenvim",
		event = "VeryLazy",
		config = function()
			-- firenvim
			vim.cmd([[
function! SetFontSizeFirenvim(timer)
  set guifont=Fira_Code:h22
endfunction


" https://github.com/glacambre/firenvim/issues/1006#issuecomment-1126785734
if exists('g:started_by_firenvim')
  let g:firenvim_config = {
        \ 'localSettings' : {
          \ '.*' : {
              \ 'filename' : '{hostname%32}_{pathname%32}_{selector%32}_{timestamp%32}.go',
            \   },
      \ }
  \}
  let g:dashboard_disable_at_vimenter=1
  let g:NERDTreeHijackNetrw=0
  " call timer_start(3000, function("SetFontSizeFirenvim"))
  let g:copilot_enable = 0
  let g:copilot_filetypes = {
      \ 'markdown': v:true,
      \ 'yaml': v:true,
      \ 'go': v:false,
        \ }
  echo 'nvim good'
else
  set laststatus=2
endif

]])
		end,
	},
	{
		"ThePrimeagen/harpoon",
		keys = {
			{ "<C-q>", ':lua require("harpoon.ui").toggle_quick_menu()<CR>', {} },
			{ "<C-n>", ':lua require("harpoon.ui").nav_next()<CR>', {} },
			{ "<C-p>", ':lua require("harpoon.ui").nav_prev()<CR>', {} },
			{ "<Leader>a", ':lua require("harpoon.mark").add_file()<CR>', {} },
			{ "<Leader>1", ':lua require("harpoon.ui").nav_file(1)<CR>', {} },
			{ "<Leader>2", ':lua require("harpoon.ui").nav_file(2)<CR>', {} },
			{ "<Leader>3", ':lua require("harpoon.ui").nav_file(3)<CR>', {} },
		},
		config = function()
			require("harpoon").setup({})
			-- code
		end,
	},
}
