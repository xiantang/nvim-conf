vim.cmd([[
au BufEnter leetcode.cn_*.txt set filetype=go
au BufEnter *.conf set filetype=config
au FileType * set formatoptions-=cro
au CursorHold * checktime
au BufWritePost *.go silent! :lua go_org_imports()
au BufNewFile,BufRead */ssh/config  setf sshconfig
au CursorHold,CursorHoldI * checktime
au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=700 }
]])
