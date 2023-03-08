-- [[ Setting options ]]
-- See `:help vim.o`
-- use Bold

if vim.g.neovide then
	local alpha = function()
		return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
	end
	-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
	vim.g.neovide_transparency = 0.0
	vim.g.transparency = 0.90
	vim.g.neovide_background_color = "#0f1117" .. alpha()
	-- Put anything you want to happen only in Neovide here
end
vim.o.guifont = "JetBrains Mono:h15"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local set = vim.o
vim.opt.swapfile = false
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
vim.api.nvim_set_hl(0, "TSVariable", { link = "Normal" })
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
