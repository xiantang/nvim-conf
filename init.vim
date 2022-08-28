syntax on
set nu ru et
set ts=2 sts=2 sw=2
set cursorline
set hlsearch
set mouse=a
set clipboard=unnamed
set modifiable

" Plugin
call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'vim-scripts/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim'

call plug#end()

lua require("lsp_config")
set omnifunc=syntaxcomplete#Complete
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua goimports(1000)



" leader
let mapleader=" "
noremap 0 ^
noremap <Leader>q :wq<CR>
noremap <Leader>t :NERDTree<CR>
noremap <Leader>s :vsp<CR>
noremap <Leader>w :w<CR>
noremap <Leader>e :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <Leader>[  <C-O>
nnoremap <Leader>]  <C-I>
noremap  <Leader>r :GoRename<CR>
noremap  <C-f> :Rg<CR>


inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" copilot
let g:copilot_enable = 1
" copilot enable markdown autocom
" "let g:copilot_filetypes = {
" "      \ 'markdown': v:true,
" "      \ 'yaml': v:true,
" "      \ 'go': v:true,
" "        \ }

let NERDTreeShowHidden=1


