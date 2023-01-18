return {
	{
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient")
		end,
	},
	--  'ggandor/leap.nvim',
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "dfgjkalwertyuizxcnm" })
		end,
	},

	{
		"andymass/vim-matchup",
		setup = function()
			-- may set any options here
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	-- {
	-- 	"/Users/jingdizhu/project/comby.nvim",
	-- 	config = function()
	-- 		require("plugin_name").setup()
	-- 	end,
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- },
	-- {
	-- 	"/Users/jingdizhu/project/extract-value.nvim",
	-- 	config = function()
	-- 		require("extract_variable").setup()
	-- 	end,
	-- 	require = { "nvim-treesitter/nvim-treesitter-textobjects" },
	-- },
	{
		"folke/persistence.nvim",
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("config") .. "/sessions/"), -- directory where session files are saved
				options = { "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
			})
		end,
	},
	{
		"xiantang/nvim-lspconfig",
		-- use commit
		dependencies = {
			"j-hui/fidget.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"glepnir/lspsaga.nvim",
			"onsails/lspkind.nvim",
		},
	},
	{
		"edluffy/specs.nvim",
		config = function()
			require("specs").setup({
				{
					show_jumps = true,
					min_jump = 30,
					popup = {
						delay_ms = 0, -- delay before popup displays
						inc_ms = 10, -- time increments used for fade/resize effects
						blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
						width = 5,
						winhl = "PMenu",
						fader = require("specs").linear_fader,
						resizer = require("specs").shrink_resizer,
					},
					ignore_filetypes = {},
					ignore_buftypes = {
						nofile = true,
					},
				},
			})
		end,
	},
	"j-hui/fidget.nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{ "glepnir/lspsaga.nvim", commit = "b7b4777" },
	"onsails/lspkind.nvim",
	{
		"numToStr/Navigator.nvim",
		-- master
		config = function()
			require("Navigator").setup({})
		end,
	},
	-- git related
	{
		"rhysd/conflict-marker.vim",
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		branch = "anticonceal",
		config = function()
			require("lsp-inlayhints").setup()
		end,
	},
	{
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	-- {
	-- 	"/Users/jingdizhu/project/obsidian.nvim",
	-- 	after = "nvim-cmp",
	-- 	config = function()
	-- 		require("obsidian").setup({
	-- 			dir = "/Users/jingdizhu/Documents/my-vault",
	-- 			completion = {
	-- 				nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		cmd = "ObsidianToday",
		config = function()
			-- vim.cmd([[ PackerLoad cmp-buffer ]]) -- this loads cmp-buffer
			-- vim.cmd([[ PackerLoad cmp-cmdline ]])
			-- vim.cmd([[PackerLoad cmp-path ]])
			-- vim.cmd([[ PackerLoad cmp_luasnip ]])
			-- vim.cmd([[ PackerLoad cmp-dictionary ]])
			-- vim.cmd([[ PackerLoad cmp-nvim-lua ]])
			require("luasnip.loaders.from_vscode").load({
				include = { "go", "python", "sh", "json", "lua", "gitcommit", "sql" },
			})
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/Users/jingdizhu/.config/nvim/my_snippets" } })
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/my_snippets/lua/" })
			local source = require("jira")
			require("cmp").register_source("cmp_jira", source.new({}))
			require("cmp_set")
			require("go_test")
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
	},
	{
		"hrsh7th/cmp-nvim-lua",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/cmp-buffer",
		opt = true,
	},
	{
		"stevearc/profile.nvim",
	},
	{
		"hrsh7th/cmp-cmdline",
		opt = true,
	},
	{
		"ray-x/lsp_signature.nvim",
	},
	{
		"hrsh7th/cmp-path",
		opt = true,
	},
	{
		"saadparwaiz1/cmp_luasnip",
		opt = true,
	},
	"wbthomason/packer.nvim",
	"tpope/vim-fugitive",
	{
		"shumphrey/fugitive-gitlab.vim",
		config = function()
			-- check operation system
			local is_mac = vim.fn.has("mac") == 1
			if is_mac then
				local secret = require("secret")
				vim.g.fugitive_gitlab_domains = { secret.GITALB_URL }
			end
		end,
	},
	{
		"segeljakt/vim-silicon",
		config = function()
			vim.cmd([[
			 let g:silicon={}
			 let g:plug_window = 'botright 40vnew'
			 let g:silicon['output'] = '~/images/silicon-{time:%Y-%m-%d-%H%M%S}.png']])
		end,
	},
	"simrat39/symbols-outline.nvim",
	"ray-x/go.nvim",
	"p00f/nvim-ts-rainbow",
	"ray-x/guihua.lua",
	"petertriho/nvim-scrollbar",
	{
		"jinh0/eyeliner.nvim",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
			})
		end,
	},

	"leoluz/nvim-dap-go",
	"rcarriga/nvim-dap-ui",
	"mfussenegger/nvim-dap",
	"romainl/vim-cool",
	"windwp/nvim-autopairs",
	"lukas-reineke/indent-blankline.nvim",
	"RRethy/vim-illuminate",
	"vim-scripts/ReplaceWithRegister",
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup()
		end,
	},
	"rafamadriz/friendly-snippets",
	"RRethy/nvim-base16",
	"mbbill/undotree",
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine_setup")
		end,
	},
	"ryanoasis/vim-devicons",
	"nvim-tree/nvim-web-devicons",
	-- use_helper({"bkad/CamelCaseMotion",lock=true})
	"tpope/vim-rhubarb",
	"dstein64/vim-startuptime",
	"jose-elias-alvarez/null-ls.nvim",
	"nvim-treesitter/nvim-treesitter",
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		commit = "a60af980b6f0a6e7ee239ffb9d1d519aaaa1de58",
	},
	"nvim-treesitter/playground",
	{
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
	},
	"lewis6991/gitsigns.nvim",
	{ "L3MON4D3/LuaSnip", commit = "79f647218847b1cd204fede7dd89025e43fd00c3" },
	-- lock_use({ "plasticboy/vim-markdown", require = "godlygeek/tabular" })
	"glacambre/firenvim",
	"vim-scripts/argtextobj.vim",
	{
		"preservim/nerdtree",
		cmd = { "NERDTreeToggle", "NERDTree", "NERDTreeFind" },
		opt = true,
		config = function() end,
		dependencies = "Xuyuanp/nerdtree-git-plugin",
	},
	"Xuyuanp/nerdtree-git-plugin",
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"nvim-lua/plenary.nvim",
	{
		"github/copilot.vim",
	},
	{ "michaelb/sniprun", build = "bash ./install.sh" },
	"numToStr/Comment.nvim",
	--  "akinsho/toggleterm.nvim" ,
	"nvim-telescope/telescope.nvim",
	{
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
	},
}
