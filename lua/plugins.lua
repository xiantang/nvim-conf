local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()
return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("tpope/vim-fugitive")
	use({
		"shumphrey/fugitive-gitlab.vim",
		config = function()
			local secret = require("secret")
			vim.g.fugitive_gitlab_domains = { secret.GITALB_URL }
		end,
	})
	use("tpope/vim-rhubarb")
	use("dstein64/vim-startuptime")
	use({
		"uga-rosa/cmp-dictionary",
		event = { "InsertEnter" },
		opt = true,
		config = function()
			require("cmp_dictionary").setup({
				dic = {
					["*"] = { "~/.config/nvim/words", "~/.config/nvim/spell/en.utf-8.add" },
				},
				-- The following are default values.
				exact = -1,
				first_case_insensitive = false,
				document = true,
				document_command = "wn %s -over",
				async = true,
				max_items = -1,
				capacity = 5,
				debug = false,
			})
			local a = require("plenary.async")
			a.run(function()
				vim.cmd([[CmpDictionaryUpdate]])
			end)
		end,
	})
	if packer_bootstrap then
		require("packer").sync()
	end
end)
