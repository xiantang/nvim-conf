-- vim.cmd([[
-- ]])
local opts = { noremap = true, silent = true }

vim.keymap.set("v", "y", "ygv<esc>", opts)

-- nnoremap <c-c> :cp<CR>
-- nnoremap <c-n> :cn<CR>
-- because hhkb layout backtick is hard to press
vim.keymap.set("n", "o", "o", opts)
vim.keymap.set("n", "c", "c", opts)
vim.keymap.set("n", "r", "r", opts)
vim.keymap.set("n", "q", "q", opts)
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-Left>", ":vertical resize +5<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize -5<CR>", opts)
vim.keymap.set("n", "<C-Up>", ":resize +5<CR>", opts)
vim.keymap.set("n", "<leader>db", "<cmd>%bd|e#<cr>", { desc = "Close all buffers but the current one" })

vim.keymap.set("n", "<C-Down>", ":resize -5<CR>", opts)
vim.keymap.set("n", "0", "^", opts)
vim.keymap.set("n", "ZZ", ":wq<CR>", opts)
vim.keymap.set("n", "z=", "1z=", opts)
vim.keymap.set("n", "<Leader>gs", ":Git<CR>", opts)
vim.keymap.set("n", "<Leader>gb", ":Git blame<CR>", opts)
vim.keymap.set("n", "<Leader>gl", ":Gllog -- %<CR>", opts)
-- we can use s and v to split
vim.keymap.set("n", "<Leader>s", ":sp<CR>", { desc = "[S]plit window" })
vim.keymap.set("n", "<Leader>v", ":vsp<CR>", { desc = "[V]ertically [S]plit window" })
vim.keymap.set("n", " <Leader>r", ":GoRename<CR>", opts)
vim.keymap.set("n", "ZZ", ":wqa<CR>", opts)
vim.keymap.set("n", "gp", "`[v`]", opts)

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
