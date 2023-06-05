" leader
" local leader
let mapleader = " "
let maplocalleader = " "
set nu
set rnu
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
set guicursor+=i:ver1
set guicursor+=a:blinkon1
set mouse=a
set clipboard=unnamed
" modifiable
set modifiable
set smartcase
set autoread
set splitright
set encoding=utf-8
set termguicolors
" no swap files
set noswapfile
syntax on
set hlsearch
set autoindent
set smartindent
set equalalways
set ignorecase
set sessionoptions="blank"
set hidden
set autoindent
" keymap
noremap <Leader>[ <C-O>
noremap <Leader>] <C-I>
" vim only, if it's neovim plz don't apply
if !has('nvim')
colorscheme desert
noremap <Leader>s <C-w>s
noremap <Leader>v <C-w>v
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap - :Ntree<CR>
function! FZF() abort
    let l:tempname = tempname()
    " fzf | awk '{ print $1":1:0" }' > file
    execute 'silent !fzf --multi ' . '| awk ''{ print $1":1:0" }'' > ' . fnameescape(l:tempname)
    try
        execute 'cfile ' . l:tempname
        redraw!
    finally
        call delete(l:tempname)
    endtry
endfunction
" :Files
command! -nargs=* Files call FZF()
nnoremap <leader>p :Files<cr>
endif
