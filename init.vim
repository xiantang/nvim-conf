syntax on
set updatetime=3000
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

" leader
let mapleader=" "



au BufEnter leetcode.cn_*.txt set filetype=go

lang en_US.UTF-8

" Plugin
call plug#begin()
Plug 'leoluz/nvim-dap-go'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap'
Plug 'romainl/vim-cool'
Plug 'windwp/nvim-autopairs'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'ellisonleao/glow.nvim'
Plug 'RRethy/vim-illuminate'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'hrsh7th/cmp-path'
Plug 'rafamadriz/friendly-snippets'
Plug 'RRethy/nvim-base16'
Plug 'mbbill/undotree'
Plug 'nvim-lualine/lualine.nvim'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'xiantang/incsearch-easymotion.vim', {'branch': 'master'}
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
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
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
Plug 'tpope/vim-commentary'
call plug#end()

let g:plug_window = 'botright 40vnew'

colorscheme base16-tender

lua require('config')

" silent"
autocmd BufWritePost *.go silent lua  gofumpt(1000)
au CursorHold,CursorHoldI * checktime
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
noremap <Leader>s :sp<CR>
noremap <Leader>ss :source ~/.config/nvim/init.vim<CR>
noremap <Leader>v :vsp<CR>
noremap <Leader>vm :Glow!<CR>
noremap <Leader>w :w<CR>
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
noremap <expr> <C-f> incsearch#go(<SID>config_easyfuzzymotion())

noremap  <Leader>p :Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>
noremap  <Leader>P :Telescope live_grep<CR>
noremap  <Leader>Q :wa<CR> :qa<CR>

" use contrl + hjkl to move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" golang test"
noremap <Leader>rt :GoRunTestFun<CR>
noremap <Leader>rf :GoRunTestFile<CR>
noremap <Leader>de :lua require'dap'.toggle_breakpoint()<CR>
noremap <Leader>ut :UndotreeToggle<CR>


" git diffview
nnoremap <Leader>d :DiffviewOpen<CR>


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


nnoremap <Leader>; <Cmd>exe v:count1 . "ToggleTerm size=10"<CR>
let g:UltiSnipsExpandTrigger = "<nop>"


let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let g:NERDTreeChDirMode = 2
" width"
let g:NERDTreeWinSize = 25

noremap <Leader>l :NERDTreeFind<CR>


au VimEnter * if !exists('g:started_by_firenvim') | NERDTree | endif
au WinEnter NERDTree

au VimEnter *  wincmd p


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


" buff enter"
function Undotree_pr() abort
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

autocmd BufEnter * call Undotree_pr()


" copilot
let g:copilot_enable = 1
imap <silent><script><expr> <C-e> copilot#Accept('\<CR>')
let g:copilot_no_tab_map = v:true
let g:copilot_assume_mapped = v:true

""
" copilot enable markdown autocom
let g:copilot_filetypes = {
      \ 'markdown': v:true,
      \ 'yaml': v:true,
      \ 'go': v:true,
        \ }


echo 'read config good now'

