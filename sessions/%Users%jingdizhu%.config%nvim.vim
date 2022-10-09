let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +13 ~/project/alb-container/sgw-distribution/web/alb.go
badd +5 ~/project/alb-container/sgw-distribution/web/allocator.go
badd +14 ~/project/alb-container/sgw-distribution/web/taskv2.go
badd +26 ~/project/alb-container/sgw-distribution/web/router.go
badd +3 ~/go/pkg/mod/git.garena.com/shopee/go-shopeelib@v0.1.116/procutils/process.go
badd +7 init.vim
badd +1 ~/project/alb-container/sgw-distribution/.gitignore
badd +2 .gitignore
argglobal
%argdel
edit .gitignore
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
wincmd =
argglobal
balt ~/project/alb-container/sgw-distribution/.gitignore
let s:l = 2 - ((1 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 2
normal! 010|
wincmd w
argglobal
if bufexists(fnamemodify("~/project/alb-container/sgw-distribution/web/allocator.go", ":p")) | buffer ~/project/alb-container/sgw-distribution/web/allocator.go | else | edit ~/project/alb-container/sgw-distribution/web/allocator.go | endif
if &buftype ==# 'terminal'
  silent file ~/project/alb-container/sgw-distribution/web/allocator.go
endif
balt .gitignore
let s:l = 5 - ((4 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 5
normal! 03|
wincmd w
2wincmd w
wincmd =
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
