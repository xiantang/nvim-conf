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
	local function lock_use(setup)
		-- defaule is lock = true
		setup.lock = true
		use(setup)
	end
	lock_use({ "lewis6991/impatient.nvim" })
	--  'ggandor/leap.nvim',
	lock_use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "dfgjkalwertyuizxcnm" })
		end,
	})
	lock_use({
		"/Users/jingdizhu/project/extract-value.nvim",
		config = function()
			require("extract_variable").setup()
		end,
		require = { "nvim-treesitter/nvim-treesitter-textobjects" },
	})
	lock_use({
		"folke/persistence.nvim",
		module = "persistence",
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("config") .. "/sessions/"), -- directory where session files are saved
				options = { "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
			})
		end,
	})
	lock_use({
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
	lock_use({ "j-hui/fidget.nvim" })
	lock_use({ "williamboman/mason.nvim" })
	lock_use({ "williamboman/mason-lspconfig.nvim" })
	lock_use({ "glepnir/lspsaga.nvim" })
	lock_use({ "onsails/lspkind.nvim" })
	lock_use({
		"numToStr/Navigator.nvim",
		-- master
		config = function()
			require("Navigator").setup({})
		end,
	})
	-- git related
	lock_use({
		"rhysd/conflict-marker.vim",
	})
	lock_use({
		"lvimuser/lsp-inlayhints.nvim",
		branch = "anticonceal",
		config = function()
			require("lsp-inlayhints").setup()
		end,
	})
	lock_use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})
	lock_use({
		"/Users/jingdizhu/project/obsidian.nvim",
		after = "nvim-cmp",
		config = function()
			require("obsidian").setup({
				dir = "/Users/jingdizhu/Documents/my-vault",
				completion = {
					nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
				},
			})
		end,
	})
	lock_use({
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		cmd = "ObsidianToday",
		config = function()
			vim.cmd([[ PackerLoad cmp-buffer ]]) -- this loads cmp-buffer
			vim.cmd([[ PackerLoad cmp-cmdline ]])
			vim.cmd([[PackerLoad cmp-path ]])
			vim.cmd([[ PackerLoad cmp_luasnip ]])
			vim.cmd([[ PackerLoad cmp-dictionary ]])
			require("luasnip.loaders.from_vscode").load({
				include = { "go", "python", "sh", "json", "lua", "gitcommit" },
			})
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
	lock_use({
		"hrsh7th/cmp-nvim-lsp",
	})
	lock_use({
		"hrsh7th/cmp-buffer",
		opt = true,
	})
	lock_use({
		"stevearc/profile.nvim",
	})
	lock_use({
		"hrsh7th/cmp-cmdline",
		opt = true,
	})
	lock_use({
		"ray-x/lsp_signature.nvim",
	})
	lock_use({
		"hrsh7th/cmp-path",
		opt = true,
	})
	lock_use({
		"saadparwaiz1/cmp_luasnip",
		opt = true,
	})
	lock_use({ "wbthomason/packer.nvim" })
	lock_use({ "tpope/vim-fugitive" })
	lock_use({
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
	lock_use({
		"segeljakt/vim-silicon",
		config = function()
			vim.cmd([[
       let g:silicon={}
       let g:plug_window = 'botright 40vnew'
			 let g:silicon['output'] = '~/images/silicon-{time:%Y-%m-%d-%H%M%S}.png']])
		end,
	})
	lock_use({ "simrat39/symbols-outline.nvim" })
	lock_use({ "ray-x/go.nvim" })
	lock_use({ "p00f/nvim-ts-rainbow" })
	lock_use({ "ray-x/guihua.lua" })
	lock_use({ "petertriho/nvim-scrollbar" })
	lock_use({
		"rhysd/clever-f.vim",
		config = function()
			vim.g.clever_f_across_no_line = 1
			vim.g.clever_f_ignore_case = 1
			vim.g.clever_f_smart_case = 1
		end,
	})
	lock_use({ "leoluz/nvim-dap-go" })
	lock_use({ "rcarriga/nvim-dap-ui" })
	lock_use({ "mfussenegger/nvim-dap" })
	lock_use({ "romainl/vim-cool" })
	lock_use({ "windwp/nvim-autopairs" })
	lock_use({ "lukas-reineke/indent-blankline.nvim" })
	lock_use({ "RRethy/vim-illuminate" })
	lock_use({ "vim-scripts/ReplaceWithRegister" })
	lock_use({ "folke/neodev.nvim" })
	lock_use({ "rafamadriz/friendly-snippets" })
	lock_use({ "RRethy/nvim-base16" })
	lock_use({ "mbbill/undotree" })
	lock_use({ "nvim-lualine/lualine.nvim" })
	lock_use({ "ryanoasis/vim-devicons" })
	lock_use({ "nvim-tree/nvim-web-devicons" })
	-- use_helper({"bkad/CamelCaseMotion",lock=true})
	lock_use({ "tpope/vim-rhubarb" })
	lock_use({ "dstein64/vim-startuptime" })
	lock_use({ "jose-elias-alvarez/null-ls.nvim" })
	lock_use({ "nvim-treesitter/nvim-treesitter" })
	lock_use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		commit = "a60af980b6f0a6e7ee239ffb9d1d519aaaa1de58",
	})
	lock_use({ "nvim-treesitter/playground" })
	lock_use({
		"keaising/im-select.nvim",
		config = function()
			-- check is macos
			local is_mac = vim.fn.has("mac") == 1
			if is_mac then
				require("im_select").setup({
					-- IM will be set to `default_im_select` in `normal` mode(`EnterVim` or `InsertLeave`)
					-- For Windows/WSL, default: "1033", aka: English US Keyboard
					-- For macOS, default: "com.apple.keylayout.ABC", aka: US
					-- You can use `im-select` in cli to get the IM name of you preferred
					default_im_select = "com.apple.keylayout.ABC",
					-- Set to 1 if you don't want restore IM status when `InsertEnter`
					disable_auto_restore = 0,
				})
			end
		end,
	})
	lock_use({ "lewis6991/gitsigns.nvim" })
	lock_use({ "L3MON4D3/LuaSnip", commit = "79f647218847b1cd204fede7dd89025e43fd00c3" })
	lock_use({ "plasticboy/vim-markdown", require = "godlygeek/tabular" })
	lock_use({ "glacambre/firenvim" })
	lock_use({ "vim-scripts/argtextobj.vim" })
	lock_use({
		"preservim/nerdtree",
		cmd = { "NERDTreeToggle", "NERDTree", "NERDTreeFind" },
		opt = true,
		config = function() end,
		requires = "Xuyuanp/nerdtree-git-plugin",
	})
	lock_use({ "Xuyuanp/nerdtree-git-plugin" })
	lock_use({ "junegunn/fzf" })
	lock_use({ "junegunn/fzf.vim" })
	lock_use({ "nvim-lua/plenary.nvim" })
	lock_use({
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({})
		end,
	})
	lock_use({ "michaelb/sniprun", run = "bash ./install.sh" })
	lock_use({ "numToStr/Comment.nvim" })
	lock_use({ "akinsho/toggleterm.nvim" })
	lock_use({ "nvim-telescope/telescope.nvim" })
	lock_use({
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
