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
	--  'ggandor/leap.nvim',
	use({
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	})

	use("lewis6991/impatient.nvim")
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
	use({
		"xiantang/nvim-lspconfig",
		-- use commit
		requires = {
			"j-hui/fidget.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"glepnir/lspsaga.nvim",
			"onsails/lspkind.nvim",
		},
	})
	use({
		"xiantang/extract-value.nvim",
		config = function()
			require("extract_value").setup()
		end,
		require = { "nvim-treesitter/nvim-treesitter-textobjects" },
	})

	use({
		"numToStr/Navigator.nvim",
		-- master
		config = function()
			require("Navigator").setup()
		end,
	})
	-- git related
	use({
		"rhysd/conflict-marker.vim",
	})

	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
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
		requires = {
			"hrsh7th/cmp-nvim-lsp",
		},
	})

	use({
		"hrsh7th/cmp-buffer",
		opt = true,
	})
	use({
		"stevearc/profile.nvim",
	})

	use({
		"hrsh7th/cmp-cmdline",
		opt = true,
	})

	use({
		"ray-x/lsp_signature.nvim",
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
			-- check operation system
			local is_mac = vim.fn.has("mac") == 1
			if is_mac then
				local secret = require("secret")
				vim.g.fugitive_gitlab_domains = { secret.GITALB_URL }
			end
		end,
	})
	use({
		"segeljakt/vim-silicon",
		config = function()
			vim.cmd([[
       let g:silicon={}
       let g:plug_window = 'botright 40vnew'
			 let g:silicon['output'] = '~/images/silicon-{time:%Y-%m-%d-%H%M%S}.png']])
		end,
	})
	use("simrat39/symbols-outline.nvim")
	use({ "ray-x/go.nvim" })
	use("p00f/nvim-ts-rainbow")
	use("ray-x/guihua.lua")
	use("petertriho/nvim-scrollbar")
	use({
		"rhysd/clever-f.vim",
		config = function()
			vim.g.clever_f_across_no_line = 1
			vim.g.clever_f_ignore_case = 1
			vim.g.clever_f_smart_case = 1
		end,
	})
	use("leoluz/nvim-dap-go")
	use("rcarriga/nvim-dap-ui")
	use("mfussenegger/nvim-dap")
	use("romainl/vim-cool")
	use("windwp/nvim-autopairs")
	use("lukas-reineke/indent-blankline.nvim")
	use("RRethy/vim-illuminate")
	use("vim-scripts/ReplaceWithRegister")
	use("folke/neodev.nvim")
	use("rafamadriz/friendly-snippets")
	use("RRethy/nvim-base16")
	use("mbbill/undotree")
	use("nvim-lualine/lualine.nvim")
	use("kkharji/sqlite.lua")
	use("ryanoasis/vim-devicons")
	use("nvim-tree/nvim-web-devicons")
	-- use("bkad/CamelCaseMotion")
	use("tpope/vim-rhubarb")
	use("dstein64/vim-startuptime")
	use("jose-elias-alvarez/null-ls.nvim")
	use("nvim-treesitter/nvim-treesitter")
	use({ "nvim-treesitter/nvim-treesitter-textobjects", commit = "a60af980b6f0a6e7ee239ffb9d1d519aaaa1de58" })
	use("nvim-treesitter/playground")
	use("lewis6991/gitsigns.nvim")
	use({ "L3MON4D3/LuaSnip", commit = "79f647218847b1cd204fede7dd89025e43fd00c3" })
	use("plasticboy/vim-markdown")
	use("glacambre/firenvim")
	use("vim-scripts/argtextobj.vim")
	use({ "preservim/nerdtree", config = function() end })
	use("Xuyuanp/nerdtree-git-plugin")
	use("junegunn/fzf")
	use("junegunn/fzf.vim")
	use("nvim-lua/plenary.nvim")
	use({
		"zbirenbaum/copilot.lua",
		config = function() end,
	})
	use("keaising/im-select.nvim")
	use("numToStr/Comment.nvim")
	use("akinsho/toggleterm.nvim")
	use({ "nvim-telescope/telescope.nvim" })
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
