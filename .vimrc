let mapleader = " "
let maplocalleader = " "
set nu rnu hidden autoindent modifiable smartcase autoread 
set splitright noswapfile hlsearch autoindent
set smartindent equalalways ignorecase
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set wcm=9
set spell
set fillchars+=diff:╱
set spelllang=en,cjk
set spellsuggest=best,9
set spelloptions=camel
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set mouse=a
set clipboard=unnamed
set encoding=utf-8
set wildoptions-=pum
set sessionoptions="blank"
" nnoremap <Enter> <Nop>
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-U>zz
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
noremap {   {zz
noremap }   }zz
imap <C-a> <Home>
imap <C-e> <End>
noremap <C-a> <Home>
noremap <C-e> <End>
nnoremap <silent><expr> j v:count > 0 ? "m'" . v:count . "j" : 'gj'
nnoremap <silent><expr> k v:count > 0 ? "m'" . v:count . "k" : 'gk'
if !has('nvim')
syntax on
let g:netrw_bufsettings = 'noma nomod rnu nobl nowrap ro' 
colorscheme desert
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
noremap <Leader>s <C-w>s
noremap <Leader>v <C-w>v
" if not neovim
" vim only
if has('nvim')
	finish
endif

noremap <Leader>t :Vexplore<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
noremap - :Ntree<CR>
function! FZF() abort
		let l:tempname = tempname()
		execute 'silent !fzf --multi ' . '| awk ''{ print $1":1:0" }'' > ' . fnameescape(l:tempname)
		try
				execute 'cfile ' . l:tempname
				redraw!
		finally
				call delete(l:tempname)
		endtry
endfunction
command! -nargs=* Files call FZF()
nnoremap <leader>p :Files<cr>
function! RG(args) abort
		let l:tempname = tempname()
		let l:pattern = '.'
		if len(a:args) > 0
				let l:pattern = a:args
		endif
		execute 'silent !rg --vimgrep ''' . l:pattern . ''' | fzf -m > ' . fnameescape(l:tempname)
		try
				execute 'cfile ' . l:tempname
				redraw!
		finally
				call delete(l:tempname)
		endtry
endfunction
command! -nargs=* Rg call RG(<q-args>)
nnoremap <leader>P :Rg<cr>
endif
noremap <Leader>b :ls<CR>:b<space>
let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ 's'  : 'SNIPET ',
       \ 't'  : 'TEST ',
       \ "\<C-V>" : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \}

set statusline=%{toupper(g:currentmode[mode()])}%f\ %h%m%r\ %=%-14.(%l,%c%V%)\ %P\ %y
let g:asyncrun_open = 6
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry
