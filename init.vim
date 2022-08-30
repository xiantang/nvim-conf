syntax on
set nu ru et
set ts=2 sts=2 sw=2
set cursorline
set hlsearch
set mouse=a
set clipboard=unnamed
set modifiable
set sessionoptions-=blank

" Plugin
call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-scripts/ctrlp.vim'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'github/copilot.vim'
call plug#end()

lua require("lsp_config")
set omnifunc=syntaxcomplete#Complete


" vim-go "
" disable gopls
let g:go_gopls_enabled = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_variable_assignments=1
let g:go_fmt_command = "goimports"



inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"



" leader
let mapleader=" "
noremap 0 ^
noremap <Leader>q :wq<CR>
noremap <Leader>t :NERDTree<CR>
noremap <Leader>s :vsp<CR>
noremap <Leader>w :w<CR>
noremap <Leader>e :split ~/.config/nvim/init.vim<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <Leader>[  <C-O>
nnoremap <Leader>]  <C-I>
noremap  <Leader>r :GoRename<CR>
noremap  <C-f> :Rg<CR>
noremap  <Leader>p :CtrlP<CR>
noremap  <Leader>P :CtrlPLine<CR>
noremap  <Leader>Q :mks! ~/wks<CR> :wqa<CR>


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

" "let NERDTreeShowHidden=1
au VimEnter *  NERDTree



let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

echo 'read config good now'
