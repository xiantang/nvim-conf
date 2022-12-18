lua require("pre_init")
nnoremap <D-v> "+p
nnoremap <Leader>; <Cmd>exe v:count1 . "ToggleTerm size=10"<CR>
nnoremap <Leader>[  <C-O>
nnoremap <Leader>]  <C-I>
nnoremap <leader>sv :source $MYVIMRC<CR>
noremap <C-e> :Telescope frecency <CR>
noremap <C-q> :Telescope oldfiles <CR>
noremap <Leader>l :lua NerdSmartLocated()<CR>
omap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
omap <silent> iw <Plug>CamelCaseMotion_iw
sunmap b
sunmap e
sunmap ge
sunmap w
tnoremap <D-v> <C-\><C-n>"+p
tnoremap <Esc> <C-\><C-n>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
xmap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> iw <Plug>CamelCaseMotion_iw


let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let g:NERDTreeChDirMode = 2
" width"
let g:NERDTreeWinSize = 25
" mini 
let g:NERDTreeMinimalMenu=1


let g:vim_markdown_folding_disabled = 1


let g:firenvim_config = {
      \ 'localSettings' : {
        \ '.*' : {
            \ 'filename' : '{hostname%32}_{pathname%32}_{selector%32}_{timestamp%32}.go',
          \   },
    \ }
\}

