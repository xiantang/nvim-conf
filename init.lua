-- [[ Setting options ]]
-- See `:help vim.o`
-- use Bold
-- source vim script
-- vimrc can be reusued
vim.cmd("source ~/.config/nvim/.vimrc")

if vim.g.neovide then
	local alpha = function()
		return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
	end
	-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
	vim.g.neovide_transparency = 0.0
	vim.g.transparency = 0.90
	vim.g.neovide_background_color = "#0f1117" .. alpha()
	-- Put anything you want to happen only in Neovide here
end
vim.o.guifont = "JetBrains Mono:h15"
vim.g.hardtime_default_on = 1
vim.g.hardtime_maxcount = 2
vim.g.hardtime_timeout = 700
vim.g.list_of_normal_keys = { "h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" }
vim.g.list_of_visual_keys = { "h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" }
vim.g.list_of_insert_keys = { "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" }
vim.g.list_of_disabled_keys = {}
local set = vim.o
set.ts = 2
set.termguicolors = true
set.sts = 2
set.sw = 2

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

require("lazy").setup("plugins", {
	dev = {
		path = "~/project/nvimplugin/",
		patterns = {}, -- For example {"folke"}
		fallback = true, -- Fallback to git when local plugin doesn't exist
	},
})

vim.cmd.colorscheme("base16-tender")
require("start")
vim.cmd.cnoreabbrev([[git Git]])
vim.cmd.abbreviate("ture", "true")
vim.cmd.cnoreabbrev([[gp Git push]])
vim.cmd.cnoreabbrev([[Gbrowse GBrowse]])
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
