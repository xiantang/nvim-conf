return {
	{
		"phaazon/hop.nvim",
		event = "VeryLazy",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "dfgjkalwertyuizxcnm" })
		end,
	},

	{
		event = "VeryLazy",
		"andymass/vim-matchup",
		config = function()
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
		event = "VeryLazy",
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
		event = "BufRead",
		-- use commit
		dependencies = {
			"j-hui/fidget.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"glepnir/lspsaga.nvim",
			"onsails/lspkind.nvim",
			-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
			"folke/neodev.nvim",
		},
		config = function()
			require("lsp_config")
		end,
	},
	{
		event = "VeryLazy",
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
		event = "VeryLazy",
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},
	{ "williamboman/mason.nvim", event = "VeryLazy" },
	{ "williamboman/mason-lspconfig.nvim", event = "VeryLazy" },
	{ "glepnir/lspsaga.nvim", commit = "b7b4777", event = "VeryLazy" },
	{ "onsails/lspkind.nvim", event = "VeryLazy" },
	{
		"numToStr/Navigator.nvim",
		event = "VeryLazy",
		-- master
		config = function()
			require("Navigator").setup({})
		end,
	},
	-- git related
	{
		"rhysd/conflict-marker.vim",
		event = "VeryLazy",
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
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
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
	{
		"stevearc/profile.nvim",
		event = "VeryLazy",
		config = function()
			-- override variable  as white
			-- for method caller
			local function toggle_profile()
				local prof = require("profile")
				if prof.is_recording() then
					prof.stop()
					local filename = ".profile.json"
					prof.export(filename)
					vim.notify(string.format("Wrote %s", filename))
				else
					prof.start("*")
				end
			end
			vim.api.nvim_create_user_command("Profile", function()
				toggle_profile()
			end, {})
		end,
	},
	{
		"segeljakt/vim-silicon",
		event = "VeryLazy",
		config = function()
			vim.cmd([[
			 let g:silicon={}
			 let g:plug_window = 'botright 40vnew'
			 let g:silicon['output'] = '~/images/silicon-{time:%Y-%m-%d-%H%M%S}.png']])
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		event = "VeryLazy",
		config = function()
			require("symbols-outline").setup()
		end,
	},
	{ "ray-x/go.nvim", event = "VeryLazy" },
	{ "mrjones2014/nvim-ts-rainbow", event = "VeryLazy" },
	{ "ray-x/guihua.lua", event = "VeryLazy" },
	{
		"petertriho/nvim-scrollbar",
		event = "VeryLazy",
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
		event = "VeryLazy",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
			})
		end,
	},
	{
		"leoluz/nvim-dap-go",
		event = "VeryLazy",
		config = function()
			require("dap-go").setup()
		end,
	},
	{ "rcarriga/nvim-dap-ui", event = "VeryLazy" },
	{
		event = "VeryLazy",
		"mfussenegger/nvim-dap",
		config = function()
			require("dap_set")
		end,
	},
	{ "romainl/vim-cool", event = "VeryLazy" },
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.opt.list = true
			vim.opt.listchars:append("eol:↲")
			require("indent_blankline").setup({
				show_end_of_line = true,
			})
		end,
		event = "VeryLazy",
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		config = function()
			require("mini.indentscope").setup({})
		end,
		event = "VeryLazy",
	},
	{ "RRethy/vim-illuminate", event = "VeryLazy" },
	{ "vim-scripts/ReplaceWithRegister", event = "VeryLazy" },
	{
		"folke/neodev.nvim",
		event = "VeryLazy",
		config = function()
			require("neodev").setup({})
		end,
	},
	{
		"mbbill/undotree",
		config = function()
			vim.cmd([[
			" buff enter"
			function Undotree_record() abort
			if has("persistent_undo")
				 let target_path = expand('~/.undodir')
					" create the directory and any parent directories
					" if the location does not exist.
					if !isdirectory(target_path)
							call mkdir(target_path, "p", 0700)
					endif

					let &undodir=target_path
					set undofile
			endif
			endfunction
			let g:undotree_WindowLayout = 3
			autocmd BufEnter * call Undotree_record()
			]])
		end,
	},
	{ "ryanoasis/vim-devicons", event = "VeryLazy" },
	{ "nvim-tree/nvim-web-devicons", event = "VeryLazy" },
	{ "tpope/vim-rhubarb", event = "VeryLazy" },
	{ "dstein64/vim-startuptime", cmd = "StartupTime" },
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VeryLazy",
		config = function()
			require("null")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		commit = "a60af980b6f0a6e7ee239ffb9d1d519aaaa1de58",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",

							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true of false
						include_surrounding_whitespace = true,
					},
				},
			})
		end,
	},
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
	{
		"L3MON4D3/LuaSnip",
		commit = "79f647218847b1cd204fede7dd89025e43fd00c3",
		event = "InsertEnter",
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
		event = "VeryLazy",
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
	{
		"preservim/nerdtree",
		cmd = { "NERDTreeToggle", "NERDTree", "NERDTreeFind", "NerdSmartLocated" },
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
	{ "Xuyuanp/nerdtree-git-plugin", event = "VeryLazy" },
	{ "junegunn/fzf", event = "VeryLazy" },
	{ "junegunn/fzf.vim", event = "VeryLazy" },
	{ "nvim-lua/plenary.nvim", event = "VeryLazy" },
	{
		"github/copilot.vim",
		event = "VeryLazy",
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
						]])
		end,
	},
	{ "michaelb/sniprun", event = "VeryLazy", build = "bash ./install.sh" },
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			require("Comment").setup()
		end,
	},
	--  "akinsho/toggleterm.nvim" ,
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = function()
			require("telescope").setup({
				extensions = {},
			})
		end,
	},
}
