vim.cmd([[packadd packer.nvim]])
return require("packer").startup(function(use)
	use("https://gitlab.com/msvechla/cmp-jira.git")
end)
