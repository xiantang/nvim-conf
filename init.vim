lua require("pre_init")
nnoremap <D-v> "+p
inoremap <D-v> <c-r>+
tnoremap <D-v> <C-\><C-n>"+p
cnoremap <D-v> <c-r>+

"ctrl A to  move to line start when in command mode like in iterm2
cnoremap <C-a> <Home>

"ctrl E to move to line end when in command mode like in iterm2
cnoremap <C-e> <End>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <Leader>[  <C-O>
nnoremap <Leader>]  <C-I>
noremap tt :GenReturn<CR>0
vnoremap K        k
noremap  <Leader>p :Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>
noremap  <Leader>P :Telescope live_grep<CR>
noremap  <Leader>Q :lua require("start").Stop()<CR>




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

