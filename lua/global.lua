-- [[ Setting options ]]
-- See `:help vim.o`
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.cmd("set noswapfile")
local set = vim.o
set.spell = true
set.spelllang = "en,cjk"
set.spellsuggest = "best,9"
-- set guifont:DejaVuSansMono\ Nerd\ Font:h17
set.guifont = "DejaVuSansMono Nerd Font:h17"
set.number = true
set.relativenumber = true
set.autoread = true
set.mouse = "a"
set.guicursor = "a:blinkon1,i:ver25"
set.updatetime = 3000
set.encoding = "utf8"
set.termguicolors = true
set.nu = 1
set.ru = 1
set.et = 1
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
