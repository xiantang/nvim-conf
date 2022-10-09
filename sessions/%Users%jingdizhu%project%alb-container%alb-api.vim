let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/project/alb-container/alb-api
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +23 internal/app/albconfig/listener_test.go
badd +4 internal/app/albconfig/directive_test.go
badd +1 ~/.config/nvim/init.vim
badd +17 ~/go/pkg/mod/git.garena.com/shopee/go-shopeelib@v0.1.116/log/grpc.go
badd +1 ~/go/pkg/mod/git.garena.com/shopee/devops/sgw-distribution-client@v0.5.0/mock/client.go
badd +41 term://~/project/alb-container/alb-api/internal/app/albconfig//62820:/usr/local/go/bin/go
badd +909 internal/app/albconfig/listener.go
badd +0 term://~/project/alb-container/alb-api/internal/app/albconfig//65713:/usr/local/go/bin/go
argglobal
%argdel
edit ~/.config/nvim/init.vim
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
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
balt internal/app/albconfig/listener_test.go
let s:l = 64 - ((8 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 64
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("internal/app/albconfig/listener_test.go", ":p")) | buffer internal/app/albconfig/listener_test.go | else | edit internal/app/albconfig/listener_test.go | endif
if &buftype ==# 'terminal'
  silent file internal/app/albconfig/listener_test.go
endif
let s:l = 23 - ((15 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 23
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("term://~/project/alb-container/alb-api/internal/app/albconfig//65855:/usr/local/go/bin/go", ":p")) | buffer term://~/project/alb-container/alb-api/internal/app/albconfig//65855:/usr/local/go/bin/go | else | edit term://~/project/alb-container/alb-api/internal/app/albconfig//65855:/usr/local/go/bin/go | endif
if &buftype ==# 'terminal'
  silent file term://~/project/alb-container/alb-api/internal/app/albconfig//65855:/usr/local/go/bin/go
endif
balt internal/app/albconfig/listener_test.go
let s:l = 1 - ((0 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
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
