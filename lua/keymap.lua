-- vim.cmd([[
-- set softtabstop=4
-- set tabstop=4
-- set shiftwidth=4
-- set expandtab
-- set smartindent
-- ]])
local opts = { noremap = true, silent = true }

vim.keymap.set("v", "y", "ygv<esc>", opts)

-- nnoremap <c-c> :cp<CR>
-- nnoremap <c-n> :cn<CR>
vim.keymap.set("n", "<c-p>", ":cp<CR>", opts)
vim.keymap.set("n", "<c-n>", ":cn<CR>", opts)
-- because hhkb layout backtick is hard to press
vim.keymap.set("n", "<Tab><Tab>", "``", opts)
vim.keymap.set("n", "<Tab>a", "`azz", opts)
vim.keymap.set("n", "<Tab>b", "`bzz", opts)
vim.keymap.set("n", "<Tab>m", "`mzz", opts)
vim.keymap.set("n", "o", "o", opts)
vim.keymap.set("n", "c", "c", opts)
vim.keymap.set("n", "r", "r", opts)
vim.keymap.set("n", "q", "q", opts)
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-Left>", ":vertical resize +5<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize -5<CR>", opts)
vim.keymap.set("n", "<C-Up>", ":resize +5<CR>", opts)

-- termkey
vim.keymap.set("n", "<C-;>", "<Cmd>exe v:count1 . 'ToggleTerm'<CR>", opts)
vim.keymap.set("t", "<C-;>", "<C-\\><C-n><Cmd>exe v:count1 . 'ToggleTerm'<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize -5<CR>", opts)
vim.keymap.set("n", "0", "^", opts)
vim.keymap.set("n", "ZZ", ":wq<CR>", opts)
vim.keymap.set("n", "z=", "1z=", opts)
vim.keymap.set("n", "<Leader>gs", ":Git<CR>", opts)
vim.keymap.set("n", "<Leader>gb", ":Git blame<CR>", opts)
vim.keymap.set("n", "<Leader>gl", ":Gllog -- %<CR>", opts)
vim.keymap.set("n", "<Leader>ss", ":source ~/.config/nvim/init.vim<CR>", opts)
-- we can use s and v to split
vim.keymap.set("n", "<Leader>s", ":sp<CR>", { desc = "[S]plit window" })
vim.keymap.set("n", "<Leader>v", ":vsp<CR>", { desc = "[V]ertically [S]plit window" })
vim.keymap.set("n", "<Leader>w", ":w<CR>", opts)
vim.keymap.set("n", " <Leader>r", ":GoRename<CR>", opts)
-- test
vim.keymap.set("n", "<Leader>tt", ":TestNearest -v<CR>", { desc = "TestNearest", silent = true, noremap = true })
vim.keymap.set("n", "<Leader>tf", ":GoTestFile<CR>", { desc = "GoTestFile", silent = true, noremap = true })
vim.keymap.set(
	"n",
	"<Leader>uv",
	":TestVisit<CR>",
	{ desc = "Go to last visit test file", silent = true, noremap = true }
)
vim.keymap.set("n", "<Leader>de", ':lua require"dap".toggle_breakpoint()<CR>', opts)
-- vim.keymap.set("n", "tt", ":GenReturn<CR>0", opts)
vim.keymap.set("n", "K", "k", opts)
vim.keymap.set("n", "ZZ", ":wqa<CR>", opts)

vim.cmd([[
"ctrl A to  move to line start when in command mode like in iterm2
"ctrl E to move to line end when in command mode like in iterm2
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
inoremap <D-v> <c-r>+
nnoremap <D-v> "+p
cnoremap <D-v> <c-r>+
]])

vim.cmd([[
nnoremap <leader>sv :source $MYVIMRC<CR>
tnoremap <D-v> <C-\><C-n>"+p
tnoremap <Esc> <C-\><C-n>
]])

local function t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_ctrl_e()
	local ret = vim.api.nvim_eval("copilot#GetDisplayedSuggestion()")
	if ret.text ~= "" then
		return ret.text
	else
		return t("<esc>A")
	end
end

-- vim.keymap.set("i", "<C-e>", "v:lua.smart_ctrl_e()", { expr = true, noremap = true, replace_keycodes = false })
vim.keymap.set("i", "<C-a>", "<esc>I", { noremap = true })
