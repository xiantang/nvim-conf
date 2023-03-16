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
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
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
		"jinh0/eyeliner.nvim",
		event = "VeryLazy",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
			})
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
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			require("Comment").setup()
		end,
	},
}
