syntax on
set encoding=utf8
set termguicolors
set nu ru et
set ts=2 sts=2 sw=2
set cursorline
set hlsearch
set mouse=a
set clipboard=unnamed
set modifiable
set smartcase
set ignorecase
set sessionoptions-=blank



au BufEnter leetcode.cn_*.txt set filetype=go

lang en_US.UTF-8
au FileType go call rainbow#load()
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']


" Plugin
call plug#begin()
Plug 'RRethy/nvim-base16'
Plug 'mbbill/undotree'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'kkharji/sqlite.lua'
Plug 'frazrepo/vim-rainbow'
" jump"
" vimicon
Plug 'ryanoasis/vim-devicons'
Plug 'easymotion/vim-easymotion'
Plug 'bkad/CamelCaseMotion'
Plug 'junegunn/vim-emoji'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'folke/persistence.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'glepnir/dashboard-nvim'
Plug 'liuchengxu/vim-clap'
Plug 'sirver/ultisnips'
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
colorscheme base16-gruvbox-dark-soft


lua require("go_lsp_config")
lua require('lua_lsp_config')
lua require("start")
lua require("telescope").load_extension("frecency")
lua require('gitsign')
lua require('term')
lua require('syntex')
lua require('tele')
lua require('session')

" silent"
autocmd BufWritePost *.go silent lua  gofumpt(1000)
set omnifunc=syntaxcomplete#Complete


" vim-go "
" disable gopls
" "let g:go_debug=['shell-commands']
let g:go_debug_windows = {
      \ 'vars':  'rightbelow 60vnew',
\ }


command! -bar DuplicateTabpane
      \ let s:sessionoptions = &sessionoptions |
      \ try |
      \   let &sessionoptions = 'blank,help,folds,winsize,localoptions' |
      \   execute 'NERDTreeClose' |
      \   let s:file = tempname() |
      \   execute 'mksession! ' . s:file |
      \   tabnew |
      \   execute 'source ' . s:file |
      \ finally |
      \   silent call delete(s:file) |
      \   let &sessionoptions = s:sessionoptions |
      \   unlet! s:file s:sessionoptions |
      \ endtry
let g:EasyMotion_keys = 'sdfjklghalqiwe'

let g:go_debug_mappings = {
  \ '(go-debug-continue)': {'key': 'c', 'arguments': '<nowait>'},
  \ '(go-debug-stop)': {'key': 'q'},
  \ '(go-debug-next)': {'key': 'n', 'arguments': '<nowait>'},
  \ '(go-debug-step)': {'key': 's'},
  \ '(go-debug-stepout)': {'key': 'o'},
\}
let g:go_debug_commands="/usr/bin/arch -arch arm64 /Users/jingdizhu/.gvm/pkgsets/go1.17.1/global/bin/dlv"
let g:go_gopls_enabled = 0
let g:test_verbose = 1
let g:go_term_mode = 'split'
let g:go_term_enabled = 1
let g:go_term_close_on_exit = 0
let g:go_term_reuse = 1
let g:go_light_variable_declarations = 1
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
noremap <Leader>gb :Git blame<CR>
noremap <Leader>t :NERDTreeToggle<CR>
noremap <Leader>s :vsp<CR>
noremap <Leader>w :w<CR>
noremap <Leader>e :split ~/.config/nvim/init.vim<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <Leader>[  <C-O>
nnoremap <Leader>]  <C-I>
noremap  <Leader>r :GoRename<CR>

noremap <Leader>1 :1ToggleTerm<CR>
noremap <Leader>2 :2ToggleTerm<CR>
noremap <Leader>3 :3ToggleTerm<CR>
noremap <Leader>4 :4ToggleTerm<CR>
noremap <Leader>5 :5ToggleTerm<CR>
noremap <Leader>6 :6ToggleTerm<CR>
noremap <Leader>7 :7ToggleTerm<CR>
noremap <Leader>8 :8ToggleTerm<CR>
noremap <Leader>9 :9ToggleTerm<CR>

function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyword#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <C-f> incsearch#go(<SID>config_easyfuzzymotion())
tnoremap <silent><expr> <C-f> incsearch#go(<SID>config_easyfuzzymotion())

noremap  <Leader>p :Telescope find_files find_command=rg,--hidden,--files<CR>
noremap  <Leader>P :Telescope live_grep<CR>
noremap  <Leader>Q :wa<CR> :qa<CR>

" use contrl + hjkl to move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" golang test"
noremap <Leader>rt :GoTestFunc -v<CR>
noremap <Leader>dd :GoDebugTestFunc<CR> 
noremap <Leader>dc :GoDebugContinue<CR>
noremap <Leader>ds :GoDebugStop<CR>
noremap <Leader>dn :GoDebugNext<CR>
noremap <Leader>de :GoDebugBreakpoint<CR>


" git diffview
nnoremap <Leader>d :DiffviewOpen<CR>

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

tnoremap <Esc> <C-\><C-n>

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

noremap <C-e> :Telescope frecency <CR>


nnoremap <Leader>; <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <Leader>; <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
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


au VimEnter * if !exists('g:started_by_firenvim') | NERDTree | endif
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


function! SetFontSizeFirenvim(timer)
    set guifont=UbuntuMono:h18
endfunction


" https://github.com/glacambre/firenvim/issues/1006#issuecomment-1126785734
if exists('g:started_by_firenvim')
  let g:dashboard_disable_at_vimenter=1
  let g:NERDTreeHijackNetrw=0
  call timer_start(3000, function("SetFontSizeFirenvim"))
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


"" https://github.com/nvim-telescope/telescope.nvim/issues/2145
""hi NormalFloat ctermfg=darkcyan
""hi CocFloating ctermbg=Magenta ctermfg=black
""hi CursorLine  cterm=underline  guibg=Black
""hi SignColumn  ctermfg=14 ctermbg=242 guifg=Cyan guibg=black

echo 'read config good now'
