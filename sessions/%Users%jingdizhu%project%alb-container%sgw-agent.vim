let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/project/alb-container/sgw-agent
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 ~/project/alb-container/sgw-distribution/web/alb.go
badd +24 ~/project/alb-container/sgw-distribution/web/taskv2.go
badd +144 ~/.config/nvim/init.vim
badd +8 ~/project/alb-container/sgw-distribution/internal/configcenter/config_version.go
badd +3 ~/project/alb-container/sgw-distribution/web/allocator.go
badd +32 ~/go/pkg/mod/git.garena.com/shopee/devops/sgw-distribution-client@v0.5.0/client/client.go
badd +23 ~/go/pkg/mod/git.garena.com/shopee/devops/sgw-distribution-client@v0.5.0/client/client_interface.go
badd +10 ~/project/alb-container/sgw-distribution/internal/configcenter/node_config_version.go
badd +5 ~/project/alb-container/sgw-distribution/web/cluster.go
badd +1 ~/project/alb-container/alb-cluster/.git
badd +3 ~/project/alb-container/dockerfiles/Dockerfile.alb-api
badd +44 ~/project/alb-container/docker-compose.yml
badd +5 ~/project/alb-container/alb-api/internal/app/albconfig/cors.go
badd +1 ~/project/alb-container/alb-api/internal/app/albconfig/downgrade.go
badd +3 ~/project/alb-container/alb-api/internal/app/albconfig/directive.go
badd +4 ~/project/alb-container/alb-cluster/internal/helper/alb.go
badd +1 ~/project/alb-container/sgw-distribution/internal/db/init.go
badd +1 internal/filesystem/filesystem.go
badd +1 internal/filesystem/helper.go
argglobal
%argdel
edit internal/filesystem/filesystem.go
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
balt internal/filesystem/helper.go
let s:l = 1 - ((0 * winheight(0) + 26) / 53)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
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
