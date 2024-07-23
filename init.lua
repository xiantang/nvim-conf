local safeRequire = require("lib").safeRequire
-- [[ Setting options ]]
-- See `:help vim.o`
-- use Bold
-- source vim script
-- vimrc can be reusued
vim.cmd("source ~/.config/nvim/.vimrc")

if vim.g.neovide then
	-- Put anything you want to happen only in Neovide here
	vim.o.guifont = "FiraCode Nerd Font Mono:h15"
end
vim.g.hardtime_default_on = 1
vim.g.hardtime_maxcount = 2
vim.g.hardtime_timeout = 700
vim.g.list_of_normal_keys = { "h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" }
vim.g.list_of_visual_keys = { "h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" }
vim.g.list_of_insert_keys = { "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" }
vim.g.list_of_disabled_keys = {}
vim.opt.conceallevel = 2
local set = vim.o
set.ts = 2
set.termguicolors = true
set.sts = 2
set.sw = 2

safeRequire("autocmd")
safeRequire("keymap")
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

safeRequire("lazy").setup("plugins", {
	dev = {
		path = "~/sidepro/",
		patterns = {}, -- For example {"folke"}
		fallback = true, -- Fallback to git when local plugin doesn't exist
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = false,
		notify = true, -- get a notification when changes are found
	},
})

-- local function status_line()
-- 	-- file full path
-- 	-- file directory
-- 	local get_filename = function(path)
-- 		local filename_with_relative_path = vim.fn.substitute(path, vim.fn.getcwd() .. "/", "", "")
-- 		local filename = filename_with_relative_path:match("([^/]+)$")
--
-- 		local is_empty = function(str)
-- 			return str == nil or str == ""
-- 		end
-- 		if is_empty(filename) then
-- 			return " %f"
-- 		end
--
-- 		return filename
-- 	end
--
-- 	local filename = get_filename(vim.fn.expand("%"))
-- 	local file_type = " %y"
--
-- 	return string.format("%s %s", file_type, filename)
-- end

-- vim.opt.statusline = status_line()
-- vim.opt.winbar = status_line()

vim.cmd.colorscheme("darcula-dark")
vim.cmd.cnoreabbrev([[git Git]])
vim.cmd.cnoreabbrev([[gp Git push]])
vim.cmd.cnoreabbrev([[w' w]])
vim.cmd.cnoreabbrev([[Gbrowse GBrowse]])
vim.cmd([[
nnoremap $ g$
nnoremap 0 g0
nnoremap <expr> j v:count > 1 ? "j" : "gj"
nnoremap <expr> k v:count > 1 ? "k" : "gk"
]])
local function fix_it_when_its_wrong(wrong, right)
	-- syntax keyword WordError wrong
	vim.cmd.abbreviate(wrong, right)
	local cmd = string.format("syntax keyword SpellBad %s", wrong)
	vim.cmd(cmd)
end

-- use map to for loop

local dict = {
	stirng = "string",
	ture = "true",
	fucntion = "function",
	reutrn = "return",
	ehco = "echo",
}

for k, v in pairs(dict) do
	fix_it_when_its_wrong(k, v)
end
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

require("bookmarks")
