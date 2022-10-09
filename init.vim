syntax on
set nu ru et
set ts=2 sts=2 sw=2
set cursorline
set hlsearch
set mouse=a
set clipboard=unnamed
set modifiable
set smartcase
set ignorecase
" "set sessionoptions-=blank


au BufEnter leetcode.cn_*.txt set filetype=go
" au BufWinEnter,WinEnter term://* startinsert

lang en_US.UTF-8

" Plugin
call plug#begin()
Plug 'bkad/CamelCaseMotion'
Plug 'junegunn/vim-emoji'
Plug 's1n7ax/nvim-terminal'
Plug 'folke/persistence.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'glepnir/dashboard-nvim'
Plug 'liuchengxu/vim-clap'
Plug 'sirver/ultisnips'
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
Plug 'vim-scripts/vim-gitgutter'
Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-scripts/ctrlp.vim'
Plug 'plasticboy/vim-markdown'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'tpope/vim-surround'
Plug 'vim-scripts/argtextobj.vim'
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
lua require("start")
au VimEnter * lua require("term").setup()

lua << EOF
  require("persistence").setup {
  dir = vim.fn.expand(vim.fn.stdpath("config") .. "/sessions/"), -- directory where session files are saved
  options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
  }
EOF

set omnifunc=syntaxcomplete#Complete


" vim-go "
" disable gopls
" "let g:go_debug=['shell-commands']
let g:go_gopls_enabled = 0
let g:test_verbose = 1
let g:go_term_enabled = 1
let g:go_term_close_on_exit = 0
let g:go_term_reuse = 1
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

let g:go_snippet_engine = "automatic"


inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"


" leader
let mapleader=" "


" resize current buffer by +/- 5
" vertical resize +5 
noremap <silent> <C-Left> :vertical resize +5<CR>
noremap <silent> <C-Right> :vertical resize -5<CR>
noremap <silent> <C-Up> :resize +5<CR>
noremap <silent> <C-Down> :resize -5<CR>


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

" use contrl + hjkl to move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" golang test"
noremap <Leader>rt :GoTestFunc -v<CR>


inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

tnoremap <Esc> <C-\><C-n>

let g:camelcasemotion_key = '<leader>'
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie


let g:UltiSnipsExpandTrigger = "<nop>"

" copilot
let g:copilot_enable = 1
imap <silent><script><expr> <C-e> copilot#Accept('\<CR>')
let g:copilot_no_tab_map = v:true
" copilot enable markdown autocom
let g:copilot_filetypes = {
      \ 'markdown': v:true,
      \ 'yaml': v:true,
      \ 'go': v:true,
        \ }

let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let g:NERDTreeChDirMode = 2
noremap <Leader>l :NERDTreeFind<CR>


au VimEnter *  NERDTree
au WinEnter NERDTree

au VimEnter *  wincmd p

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(0) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction



inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

""let g:firenvim_config = {
""    \ 'localSettings': {
""        \ '.*': {
""            \ 'filename': '/tmp/{hostname}_{pathname%10}.{extension}',
""    \ }
""\ }

let g:vim_markdown_folding_disabled = 1

let g:firenvim_config = {
      \ 'localSettings' : {
        \ '.*' : {
            \ 'filename' : '{hostname%32}_{pathname%32}_{selector%32}_{timestamp%32}.go',
          \   },
    \ }
\}


" git gutter
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

silent! if emoji#available()
  let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
  let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
  let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
  let g:gitgutter_sign_modified_removed = emoji#for('collision')
endif

set signcolumn=number

if exists('g:started_by_firenvim')
  set guifont=Consolas:h22
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

echo 'read config good now'
