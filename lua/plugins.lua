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
	use({ "lewis6991/impatient.nvim", lock = true })
	--  'ggandor/leap.nvim',
	use({
		lock = true,
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "dfgjkalwertyuizxcnm" })
		end,
	})

	use({
		lock = true,
		"/Users/jingdizhu/project/extract-value.nvim",
		config = function()
			require("extract_variable").setup()
		end,
		require = { "nvim-treesitter/nvim-treesitter-textobjects" },
	})

	use({
		lock = true,
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
		lock = true,
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
	use({ "j-hui/fidget.nvim", lock = true })
	use({ "williamboman/mason.nvim", lock = true })
	use({ "williamboman/mason-lspconfig.nvim", lock = true })
	use({ "glepnir/lspsaga.nvim", lock = true })
	use({ "onsails/lspkind.nvim", lock = true })

	use({
		lock = true,
		"numToStr/Navigator.nvim",
		-- master
		config = function()
			require("Navigator").setup()
		end,
	})
	-- git related
	use({
		lock = true,
		"rhysd/conflict-marker.vim",
	})

	use({
		lock = true,
		"lvimuser/lsp-inlayhints.nvim",
		branch = "anticonceal",
		config = function()
			require("lsp-inlayhints").setup()
		end,
	})
	use({
		lock = true,
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})

	use({
		lock = true,
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
	use({
		lock = true,
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

	use({
		lock = true,
		"hrsh7th/cmp-buffer",
		opt = true,
	})
	use({
		lock = true,
		"stevearc/profile.nvim",
	})

	use({
		lock = true,
		"hrsh7th/cmp-cmdline",
		opt = true,
	})

	use({
		lock = true,
		"ray-x/lsp_signature.nvim",
	})

	use({
		lock = true,
		"hrsh7th/cmp-path",
		opt = true,
	})

	use({
		lock = true,
		"saadparwaiz1/cmp_luasnip",
		opt = true,
	})

	use({ "wbthomason/packer.nvim", lock = true })
	use({ "tpope/vim-fugitive", lock = true })
	use({
		lock = true,
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
		lock = true,
		"segeljakt/vim-silicon",
		config = function()
			vim.cmd([[
       let g:silicon={}
       let g:plug_window = 'botright 40vnew'
			 let g:silicon['output'] = '~/images/silicon-{time:%Y-%m-%d-%H%M%S}.png']])
		end,
	})
	use({ "simrat39/symbols-outline.nvim", lock = true })
	use({ "ray-x/go.nvim" })
	use({ "p00f/nvim-ts-rainbow", lock = true })
	use({ "ray-x/guihua.lua", lock = true })
	use({ "petertriho/nvim-scrollbar", lock = true })
	use({
		lock = true,
		"rhysd/clever-f.vim",
		config = function()
			vim.g.clever_f_across_no_line = 1
			vim.g.clever_f_ignore_case = 1
			vim.g.clever_f_smart_case = 1
		end,
	})
	use({ "leoluz/nvim-dap-go", lock = true })
	use({ "rcarriga/nvim-dap-ui", lock = true })
	use({ "mfussenegger/nvim-dap", lock = true })
	use({ "romainl/vim-cool", lock = true })
	use({ "windwp/nvim-autopairs", lock = true })
	use({ "lukas-reineke/indent-blankline.nvim", lock = true })
	use({ "RRethy/vim-illuminate", lock = true })
	use({ "vim-scripts/ReplaceWithRegister", lock = true })
	use({ "folke/neodev.nvim", lock = true })
	use({ "rafamadriz/friendly-snippets", lock = true })
	use({ "RRethy/nvim-base16", lock = true })
	use({ "mbbill/undotree", lock = true })
	use({ "nvim-lualine/lualine.nvim", lock = true })
	use({ "ryanoasis/vim-devicons", lock = true })
	use({ "nvim-tree/nvim-web-devicons", lock = true })
	-- use({"bkad/CamelCaseMotion",lock=true})
	use({ "tpope/vim-rhubarb", lock = true })
	use({ "dstein64/vim-startuptime", lock = true })
	use({ "jose-elias-alvarez/null-ls.nvim", lock = true })
	use({ "nvim-treesitter/nvim-treesitter", lock = true })
	use({ "nvim-treesitter/nvim-treesitter-textobjects", commit = "a60af980b6f0a6e7ee239ffb9d1d519aaaa1de58" })
	use({ "nvim-treesitter/playground", lock = true })
	use({
		lock = true,
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

	use({ "lewis6991/gitsigns.nvim", lock = true })
	use({ "L3MON4D3/LuaSnip", commit = "79f647218847b1cd204fede7dd89025e43fd00c3", lock = true })
	use({ "plasticboy/vim-markdown", require = "godlygeek/tabular", lock = true })
	use({ "glacambre/firenvim", lock = true })
	use({ "vim-scripts/argtextobj.vim", lock = true })
	use({
		lock = true,
		"preservim/nerdtree",
		cmd = { "NERDTreeToggle", "NERDTree", "NERDTreeFind" },
		opt = true,
		config = function() end,
		requires = "Xuyuanp/nerdtree-git-plugin",
	})
	use({ "Xuyuanp/nerdtree-git-plugin", lock = true })
	use({ "junegunn/fzf", lock = true })
	use({ "junegunn/fzf.vim", lock = true })
	use({ "nvim-lua/plenary.nvim", lock = true })
	use({
		lock = true,
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({})
		end,
	})
	use({ "michaelb/sniprun", run = "bash ./install.sh" })
	use({ "numToStr/Comment.nvim", lock = true })
	use({
		lock = true,
		"ianding1/leetcode.vim",
		commit = "11d9a4b36faa0996ddeee2f7994021ca3c4656ca",
		config = function()
			vim.g.leetcode_browser = "chrome"
			vim.g.leetcode_solution_filetype = "golang"
		end,
	})
	use({ "akinsho/toggleterm.nvim", lock = true })
	use({ "nvim-telescope/telescope.nvim" })
	use({
		lock = true,
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
