let mapleader = " "
let maplocalleader = " "
set nu rnu hidden autoindent modifiable smartcase autoread 
set laststatus=3
set splitright noswapfile hlsearch autoindent
set smartindent equalalways ignorecase
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set signcolumn=yes
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set wcm=9
set nospell
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set mouse=

"lang en_US.UTF-8
set clipboard+=unnamedplus
function! IsNixOS()
    let l:uname_output = system('uname -a')
    if l:uname_output =~ 'NixOS'
        return 1
    else
        return 0
    endif
endfunction
if IsNixOS()
  set clipboard+=unnamedplus
  let g:netrw_browsex_viewer ='sudo mac open'
  let g:clipboard = {
            \   'name': 'yank',
            \   'copy': {
            \      '+': 'sudo mac pbcopy',
            \      '*': 'sudo mac pbcopy',
            \    },
            \   'paste': {
            \      '+': 'sudo mac pbpaste',
            \      '*': 'sudo mac pbpaste',
            \   },
            \   'cache_enabled': 0,
            \ }
  else
   set clipboard=unnamed
endif

set encoding=utf-8
set wildoptions-=pum
set sessionoptions="blank"
" nnoremap <Enter> <Nop>
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-U>zz
nnoremap <C-i> <C-i>zz
nnoremap <C-o> <C-o>zz
noremap {   {zz
noremap }   }zz
imap <C-a> <Home>
imap <C-e> <End>
" nnoremap <silent><expr> j v:count > 0 ? "m'" . v:count . "j" : 'gj'
" nnoremap <silent><expr> k v:count > 0 ? "m'" . v:count . "k" : 'gk'
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

let g:asyncrun_open = 6
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
nnoremap <silent> <C-q> :call ToggleQuickFix()<cr>
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>
nnoremap <c-t>   :on<CR><C-W>v<C-W>s<C-w>h
iabbrev :w <nop>


let g:myLang = 0
let g:myLangList = ['en_gb','nospell']
function! MySpellLang()
  "loop through languages
  if g:myLang == 0 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  if g:myLang == 1 | setlocal nospell | endif 
  if g:myLang == 2 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  echomsg 'language:' g:myLangList[g:myLang]
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
endfunction
map <F6> :<C-U>call MySpellLang()<CR>

" edit macro
nnoremap <leader>mm :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
" User Commands
command TSGDFunctionName norm 0[[$F(bzz
command TSNXFunctionName norm 0]]$F(bzz
command BufOnly :%bd|e#
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '‾'
" let g:gitgutter_sign_removed_above_and_below = '{'
" let g:gitgutter_sign_modified_removed = 'ww'
set updatetime=100

onoremap <silent> i/ :<C-U>normal! T/vt/<CR>
onoremap <silent> a/ :<C-U>normal! F/vf/<CR>
xnoremap <silent> i/ :<C-U>normal! T/vt/<CR>
xnoremap <silent> a/ :<C-U>normal! F/vf/<CR>
