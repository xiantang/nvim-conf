lua require("pre_init")




let g:silicon={}
let g:silicon['output'] = '~/images/silicon-{time:%Y-%m-%d-%H%M%S}.png'


let g:plug_window = 'botright 40vnew'
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
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz
noremap n  nzzzv
noremap N  Nzzzv

noremap <silent> <C-Left> :vertical resize +5<CR>
noremap <silent> <C-Right> :vertical resize -5<CR>
noremap <silent> <C-Up> :resize +5<CR>
noremap <silent> <C-Down> :resize -5<CR>
noremap 0 ^
noremap <Leader>q :wq<CR>
noremap <Leader>gs :Git<CR>
noremap <Leader>gb :Git blame<CR>
noremap <Leader>t :NERDTreeToggle<CR>
noremap <Leader>s :sp<CR>
noremap <Leader>ss :source ~/.config/nvim/init.vim<CR>
noremap <Leader>v :vsp<CR>
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
noremap  <Leader>Q :lua require("start").Stop()<CR>


" golang test"
noremap <Leader>rt :GoRunTestFunc<CR>
noremap <Leader>rf :GoRunTestFile<CR>
noremap <Leader>de :lua require'dap'.toggle_breakpoint()<CR>
noremap <Leader>ut :UndotreeToggle<CR>


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
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv


nnoremap <Leader>; <Cmd>exe v:count1 . "ToggleTerm size=10"<CR>


let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let g:NERDTreeChDirMode = 2
" width"
let g:NERDTreeWinSize = 25
" mini 
let g:NERDTreeMinimalMenu=1

noremap <Leader>l :lua NerdSmartLocated()<CR>

let g:vim_markdown_folding_disabled = 1


let g:firenvim_config = {
      \ 'localSettings' : {
        \ '.*' : {
            \ 'filename' : '{hostname%32}_{pathname%32}_{selector%32}_{timestamp%32}.go',
          \   },
    \ }
\}


function! SetFontSizeFirenvim(timer)
  set guifont=Fira_Code:h18
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
      \ 'go': v:true,
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
    \ 'go': v:true,
    \ 'lua': v:true,
    \ 'gitcommit': v:true,
    \ "TelescopePrompt": v:false,
    \ "frecency": v:false,
      \ }

imap <silent><script><expr> <C-e> copilot#Accept('\<CR>')
let g:copilot_no_tab_map = v:true
let g:copilot_assume_mapped = v:true

