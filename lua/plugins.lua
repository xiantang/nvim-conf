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
	use({
		"folke/persistence.nvim",
		module = "persistence",
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("config") .. "/sessions/"), -- directory where session files are saved
				options = { "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
			})
		end,
	})
	-- git related
	use({
		"rhysd/conflict-marker.vim",
	})
	use({
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			vim.cmd([[ PackerLoad cmp-buffer ]]) -- this loads cmp-buffer
			vim.cmd([[ PackerLoad cmp-cmdline ]])
			vim.cmd([[ PackerLoad cmp-path ]])
			vim.cmd([[ PackerLoad cmp_luasnip ]])
			vim.cmd([[ PackerLoad cmp-dictionary ]])
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/Users/jingdizhu/.config/nvim/my_snippets" } })
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/my_snippets/lua/" })
			local source = require("jira")
			require("cmp").register_source("cmp_jira", source.new({}))
			require("cmp_set")
			require("go_test")
		end,
	})

	use({
		"hrsh7th/cmp-buffer",
		opt = true,
	})

	use({
		"hrsh7th/cmp-cmdline",
		opt = true,
	})

	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup()
		end,
	})

	use({
		"hrsh7th/cmp-path",
		opt = true,
	})

	use({
		"saadparwaiz1/cmp_luasnip",
		opt = true,
	})

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
		opt = true,
		config = function()
			require("cmp_dictionary").setup({
				dic = {
					["*"] = { "~/.config/nvim/words", "~/.config/nvim/spell/en.utf-8.add" },
				},
				-- The following are default values.
				exact = -1,
				document = false,
				first_case_insensitive = false,
				async = true,
				max_items = -1,
				capacity = 5,
				debug = false,
			})
		end,
	})
	if packer_bootstrap then
		require("packer").sync()
	end
end)
