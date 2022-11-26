vim.cmd([[packadd packer.nvim]])
local secret = require("secret")
return require("packer").startup(function(use)
	use("tpope/vim-fugitive")
	use("shumphrey/fugitive-gitlab.vim")
	vim.g.fugitive_gitlab_domains = { secret.GITALB_URL }
	use("tpope/vim-rhubarb")
end)
