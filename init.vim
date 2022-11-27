" leader
let mapleader=" "
syntax on
set spell
set noswapfile
set shell=zsh\ -i
set spelllang=en,cjk
set spellsuggest=best,9
set guifont:DejaVuSansMono\ Nerd\ Font:h16
set relativenumber
set autoread
set updatetime=3000
set encoding=utf8
set termguicolors
set nu ru et
set ts=2 sts=2 sw=2
set hlsearch
set mouse=a
set clipboard=unnamed
set modifiable
set smartcase
set ignorecase
set sessionoptions-=blank

au BufEnter leetcode.cn_*.txt set filetype=go
" https://github.com/kamykn/spelunker.vim/issues/71#issuecomment-1023835797
" ignore big file more than 1000 lines
" au BufRead * if line('$') > 2000  | let g:enable_spelunker_vim = 0 | endif
au BufEnter *.conf set filetype=config
au FileType * set formatoptions-=cro
au CursorHold * checktime
au BufWritePost *.go silent! :lua gofumpt()
au BufWritePost *.go silent! :lua go_org_imports()
au BufNewFile,BufRead */ssh/config  setf sshconfig
au CursorHold,CursorHoldI * checktime
au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=700 }



lang en_US.UTF-8

" Plugin
call plug#begin()
Plug 'onsails/lspkind.nvim'
Plug 'ggandor/leap.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'segeljakt/vim-silicon'
Plug 'ZSaberLv0/ZFVimIM'
Plug 'ZSaberLv0/ZFVimJob'
Plug 'simrat39/symbols-outline.nvim'
Plug 'ray-x/go.nvim'
Plug 'p00f/nvim-ts-rainbow'
Plug 'ray-x/guihua.lua'
Plug 'petertriho/nvim-scrollbar'
Plug 'rhysd/clever-f.vim'
Plug 'leoluz/nvim-dap-go'
Plug 'lewis6991/impatient.nvim'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap'
Plug 'romainl/vim-cool'
Plug 'windwp/nvim-autopairs'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'ellisonleao/glow.nvim'
Plug 'RRethy/vim-illuminate'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'hrsh7th/cmp-path'
Plug 'folke/neodev.nvim'
Plug 'rafamadriz/friendly-snippets'
Plug 'RRethy/nvim-base16'
Plug 'mbbill/undotree'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'kkharji/sqlite.lua'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'bkad/CamelCaseMotion'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'folke/persistence.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'lewis6991/gitsigns.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'plasticboy/vim-markdown'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'vim-scripts/argtextobj.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'zbirenbaum/copilot.lua'
Plug 'zbirenbaum/copilot-cmp'
Plug 'keaising/im-select.nvim'
Plug 'numToStr/Comment.nvim'
call plug#end()
lua require('config')





let g:silicon={}
let g:silicon['output'] = '~/images/silicon-{time:%Y-%m-%d-%H%M%S}.png'


" alias fugitive
cnoreabbrev git Git
cnoreabbrev gp Git push

let g:plug_window = 'botright 40vnew'


let g:ZFVimIM_keymap = 0
inoremap <expr><silent> ;; ZFVimIME_keymap_toggle_i()
let s:repoPath="~/.config/ZFVimIM_pinyin_base"
function! s:dbInit()
    let repoPath = s:repoPath
    let dbFile = '/misc/pinyin.txt'
    let dbCountFile = '/misc/pinyin_count.txt'

    let db = ZFVimIM_dbInit({
                \   'name' : 'pinyin',
                \ })
    call ZFVimIM_cloudRegister({
                \   'mode' : 'local',
                \   'dbId' : db['dbId'],
                \   'repoPath' : repoPath,
                \   'dbFile' : dbFile,
                \   'dbCountFile' : dbCountFile,
                \ })
endfunction
autocmd User ZFVimIM_event_OnDbInit call s:dbInit()


" silent"



let g:clever_f_across_no_line = 1
let g:clever_f_ignore_case = 1
let g:clever_f_smart_case = 1

" resize current buffer by +/- 5

" vertical resize +5 
nnoremap <D-v> "+p
inoremap <D-v> <c-r>+
tnoremap <D-v> <C-\><C-n>"+p
cnoremap <D-v> <c-r>+

"ctrl A to  move to line start when in command mode like in iterm2
cnoremap <C-a> <Home>

"ctrl E to move to line end when in command mode like in iterm2
cnoremap <C-e> <End>

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
noremap tt :GenReturn<CR>0

vnoremap K        k

noremap  <Leader>p :Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>
noremap  <Leader>P :Telescope live_grep<CR>
noremap  <Leader>Q :lua require("persistence").save()<CR> :wa<CR>:qa<CR>

" use contrl + hjkl to move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" golang test"
noremap <Leader>rt :GoRunTestFunc<CR>
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
noremap <C-q> :Telescope oldfiles <CR>
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)


nnoremap <Leader>; <Cmd>exe v:count1 . "ToggleTerm size=10"<CR>


let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let g:NERDTreeChDirMode = 2
" width"
let g:NERDTreeWinSize = 25
" mini 
let g:NERDTreeMinimalMenu=1

noremap <Leader>l :lua NerdSmartLocated()<CR>
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

autocmd BufEnter * call Undotree_record()

" copilot
let g:copilot_enable = 1
let g:copilot_filetypes = {
    \ 'markdown': v:true,
    \ 'yaml': v:true,
    \ 'go': v:false,
    \ 'lua': v:true,
    \ 'gitcommit': v:true,
    \ "TelescopePrompt": v:false,
    \ "frecency": v:false,
      \ }

imap <silent><script><expr> <C-e> copilot#Accept('\<CR>')
let g:copilot_no_tab_map = v:true
let g:copilot_assume_mapped = v:true


echo 'neovim be good'

