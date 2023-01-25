-- [[ Setting options ]]
-- See `:help vim.o`
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local set = vim.o
vim.cmd([[set noswapfile]])
-- so slow
-- set.spell = true
-- set.spelllang = "en,cjk"
-- set.spellsuggest = "best,9"
-- set guifont:DejaVuSansMono\ Nerd\ Font:h17
-- set.guifont = "DejaVuSansMono Nerd Font:h17"
set.number = true
set.relativenumber = true
set.autoread = true
set.mouse = "a"
-- set.guicursor = "a:blinkon1,i:ver25"
set.encoding = "utf8"
set.updatetime = 3000
set.termguicolors = true
set.ts = 2
set.sts = 2
set.sw = 2
set.hlsearch = true
set.autoindent = true
set.smartindent = true
set.mouse = "a"
set.clipboard = "unnamed"
set.modifiable = true
set.smartcase = true
set.ignorecase = true
set.sessionoptions = "blank"
set.hidden = true
set.autoindent = true

require("autocmd")
require("keymap")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "plugins" },
})

vim.cmd.colorscheme("base16-tender")
require("start")
require("nerdtree")
vim.cmd.cnoreabbrev([[git Git]])
vim.cmd.cnoreabbrev([[gp Git push]])
vim.cmd.cnoreabbrev([[Gbrowse GBrowse]])
vim.cmd.cnoreabbrev([[lazy Lazy]])
vim.cmd([[
				hi! link TSVariable Normal
]])
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
