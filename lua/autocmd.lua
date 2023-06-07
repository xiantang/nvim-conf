vim.cmd([[
au BufEnter leetcode.cn_*.txt set filetype=go
au BufEnter *.conf set filetype=config
au FileType * set formatoptions-=cro
au FileType nerdtree setlocal relativenumber
au CursorHold * checktime
au BufRead,BufNewFile *.jq setfiletype jq
au BufWritePost *.go silent! :lua go_org_imports()
au BufNewFile,BufRead */ssh/config  setf sshconfig
au CursorHold,CursorHoldI * checktime
au BufWinEnter NvimTree setlocal rnu
]])
