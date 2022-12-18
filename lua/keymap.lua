vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n ", "nzzzv")
vim.keymap.set("n", "N ", "Nzzzv")
vim.keymap.set("n", "<C-Left>", ":vertical resize +5<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize -5<CR>")
vim.keymap.set("n", "<C-Up>", ":resize +5<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -5<CR>")
vim.keymap.set("n", "0", "^")
vim.keymap.set("n", "<Leader>q", ":wq<CR>")
vim.keymap.set("n", "<Leader>gs", ":Git<CR>")
vim.keymap.set("n", "<Leader>gb", ":Git blame<CR>")
vim.keymap.set("n", "<Leader>t", ":NERDTreeToggle<CR>")
vim.keymap.set("n", "<Leader>s", ":sp<CR>")
vim.keymap.set("n", "<Leader>ss", ":source ~/.config/nvim/init.vim<CR>")
vim.keymap.set("n", "<Leader>v", ":vsp<CR>")
vim.keymap.set("n", "<Leader>w", ":w<CR>")
vim.keymap.set("n", " <Leader>r", ":GoRename<CR>")
vim.keymap.set("n", "<Leader>1", ":1ToggleTerm<CR>")
vim.keymap.set("n", "<Leader>2", ":2ToggleTerm<CR>")
vim.keymap.set("n", "<Leader>3", ":3ToggleTerm<CR>")
vim.keymap.set("n", "<Leader>4", ":4ToggleTerm<CR>")
vim.keymap.set("n", "<Leader>5", ":5ToggleTerm<CR>")
vim.keymap.set("n", "<Leader>6", ":6ToggleTerm<CR>")
vim.keymap.set("n", "<Leader>7", ":7ToggleTerm<CR>")
vim.keymap.set("n", "<Leader>8", ":8ToggleTerm<CR>")
vim.keymap.set("n", "<Leader>9", ":9ToggleTerm<CR>")
vim.keymap.set("n", "<Leader>rt", ":GoRunTestFunc<CR>")
vim.keymap.set("n", "<Leader>rf", ":GoRunTestFile<CR>")
vim.keymap.set("n", "<Leader>de", ':lua require"dap".toggle_breakpoint()<CR>')
vim.keymap.set("n", "<Leader>ut", ":UndotreeToggle<CR>")
vim.keymap.set("n", "tt", ":GenReturn<CR>0")
vim.keymap.set("n", "K", "k")
vim.keymap.set("n", "<Leader>p", ":Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>")
vim.keymap.set("n", "<Leader>P", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<Leader>Q", ':lua require("start").Stop()<CR>')
vim.cmd([[
"ctrl A to  move to line start when in command mode like in iterm2
"ctrl E to move to line end when in command mode like in iterm2
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
inoremap <D-v> <c-r>+
cnoremap <D-v> <c-r>+
]])

vim.keymap.set("", ",", "<Plug>(clever-f-repeat-back)")
vim.keymap.set("", ";", "<Plug>(clever-f-repeat-forward)")
vim.keymap.set("", "b", "<Plug>CamelCaseMotion_b", {
	silent = true,
})
vim.keymap.set("", "e", "<Plug>CamelCaseMotion_e", { silent = true })
vim.keymap.set("", "ge", "<Plug>CamelCaseMotion_ge", { silent = true })
vim.keymap.set("", "w", "<Plug>CamelCaseMotion_w", { silent = true })
