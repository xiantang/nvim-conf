return {
	"lewis6991/impatient.nvim",
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
		config = function()
			require("lsp_config")
		end,
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
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},
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
		config = function()
			vim.cmd([[
      let g:conflict_marker_highlight_group = ''
      " Include text after begin and end markers
      let g:conflict_marker_begin = '^<<<<<<< .*$'
      let g:conflict_marker_end   = '^>>>>>>> .*$'

      highlight ConflictMarkerBegin guibg=#2f7366
      highlight ConflictMarkerOurs guibg=#2e5049
      highlight ConflictMarkerTheirs guibg=#344f69
      highlight ConflictMarkerEnd guibg=#2f628e
      highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
		]])
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		branch = "anticonceal",
		config = function()
			require("lsp-inlayhints").setup()
			vim.cmd([[
			hi LspInlayHint guifg=#d8d8d8 guibg=#3a3a3a
			]])
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
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("cmp_set")
			local source = require("jira")
			require("cmp").register_source("cmp_jira", source.new({}))
			require("go_test")
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{ "saadparwaiz1/cmp_luasnip" },
	{
		"hrsh7th/cmp-nvim-lua",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/cmp-buffer",
	},
	{
		"stevearc/profile.nvim",
	},
	{
		"ray-x/lsp_signature.nvim",
	},
	{
		"hrsh7th/cmp-path",
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
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	},
	"ray-x/go.nvim",
	"p00f/nvim-ts-rainbow",
	"ray-x/guihua.lua",
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar.handlers.gitsigns").setup()
			require("scrollbar").setup({
				set_highlights = true,
				marks = {
					GitAdd = {
						text = "│",
						priority = 5,
						color = "green",
						cterm = nil,
					},
					GitChange = {
						text = "│",
						priority = 5,
						color = "yellow",
						cterm = nil,
					},
					GitDelete = {
						text = "_",
						priority = 5,
						color = "red",
						cterm = nil,
					},
				},
			})
		end,
	},
	{
		"jinh0/eyeliner.nvim",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
			})
		end,
	},

	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup()
		end,
	},
	"rcarriga/nvim-dap-ui",
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("dap_set")
		end,
	},
	"romainl/vim-cool",
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	"lukas-reineke/indent-blankline.nvim",
	"RRethy/vim-illuminate",
	"vim-scripts/ReplaceWithRegister",
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({})
		end,
	},
	"rafamadriz/friendly-snippets",
	{
		"RRethy/nvim-base16",
		config = function()
			vim.cmd([[silent! colorscheme base16-tender]])
		end,
	},
	{
		"mbbill/undotree",
	},
	"ryanoasis/vim-devicons",
	"nvim-tree/nvim-web-devicons",
	-- use_helper({"bkad/CamelCaseMotion",lock=true})
	"tpope/vim-rhubarb",
	"dstein64/vim-startuptime",
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("syntax")
			require("txtobj")
			vim.cmd([[
				hi! link TSVariable Normal
			]])
		end,
	},
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
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("git")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		commit = "79f647218847b1cd204fede7dd89025e43fd00c3",
		config = function()
			require("luasnip.loaders.from_vscode").load({
				include = { "go", "python", "sh", "json", "lua", "gitcommit", "sql" },
			})
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/Users/jingdizhu/.config/nvim/my_snippets" } })
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/my_snippets/lua/" })
			require("go").setup({})
		end,
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
	},
	-- lock_use({ "plasticboy/vim-markdown", require = "godlygeek/tabular" })
	{
		"glacambre/firenvim",
		config = function()
			-- firenvim
			vim.cmd([[


function! SetFontSizeFirenvim(timer)
  set guifont=Fira_Code:h22
endfunction


" https://github.com/glacambre/firenvim/issues/1006#issuecomment-1126785734
if exists('g:started_by_firenvim')
  let g:firenvim_config = {
        \ 'localSettings' : {
          \ '.*' : {
              \ 'filename' : '{hostname%32}_{pathname%32}_{selector%32}_{timestamp%32}.go',
            \   },
      \ }
  \}
  let g:dashboard_disable_at_vimenter=1
  let g:NERDTreeHijackNetrw=0
  " call timer_start(3000, function("SetFontSizeFirenvim"))
  let g:copilot_enable = 0
  let g:copilot_filetypes = {
      \ 'markdown': v:true,
      \ 'yaml': v:true,
      \ 'go': v:false,
        \ }
  echo 'nvim good'
else
  set laststatus=2
endif

]])
		end,
	},
	"vim-scripts/argtextobj.vim",
	{
		"preservim/nerdtree",
		cmd = { "NERDTreeToggle", "NERDTree", "NERDTreeFind", "NerdSmartLocated" },
		opt = true,
		config = function()
			vim.cmd([[
	let NERDTreeShowBookmarks=1
	let NERDTreeShowHidden=1
	let g:NERDTreeChDirMode = 2
	" width"
	let g:NERDTreeWinSize = 25
	" mini 
	let g:NERDTreeMinimalMenu=1


	let g:vim_markdown_folding_disabled = 1
	]])
		end,
		dependencies = "Xuyuanp/nerdtree-git-plugin",
	},
	"Xuyuanp/nerdtree-git-plugin",
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"nvim-lua/plenary.nvim",
	{
		"github/copilot.vim",
		config = function()
			vim.cmd([[
				let g:copilot_enable = 1
				let g:copilot_filetypes = {
						\ '*': v:true,
						\ 'markdown':v:true,
						\ 'yaml': v:true,
						\ 'go': v:false,
						\ 'lua': v:true,
						\ 'gitcommit': v:true,
						\ "TelescopePrompt": v:false,
							\ }

				" imap <silent><script><expr> <C-e> copilot#Accept('\<CR>')
				let g:copilot_no_tab_map = v:true
				let g:copilot_assume_mapped = v:true
						]])
		end,
	},
	{ "michaelb/sniprun", build = "bash ./install.sh" },
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
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
