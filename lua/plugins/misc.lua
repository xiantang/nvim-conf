-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
vim.g.codecompanion_auto_tool_mode = true

return {
	{ "nvim-lua/plenary.nvim" },
	{
		"abecodes/tabout.nvim",
		lazy = false,
		config = function()
			require("tabout").setup({
				tabkey = "<Tab>",         -- key to trigger tabout, set to an empty string to disable
				backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
				act_as_tab = true,        -- shift content if tab out is not possible
				act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
				default_tab = "<C-t>",    -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
				default_shift_tab = "<C-d>", -- reverse shift default action,
				enable_backwards = true,  -- well ...
				completion = false,       -- if the tabkey is used in a completion pum
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = "`", close = "`" },
					{ open = "(", close = ")" },
					{ open = "[", close = "]" },
					{ open = "{", close = "}" },
				},
				ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
				exclude = {}, -- tabout will ignore these filetypes
			})
		end,
		dependencies = { -- These are optional
			"nvim-treesitter/nvim-treesitter",
			"L3MON4D3/LuaSnip",
		},
		opt = true,            -- Set this to true if the plugin is optional
		event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
		priority = 1000,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		init = function()
			-- Override Fugitive's GBrowse to funnel through snacks.gitbrowse
			vim.api.nvim_create_user_command("GBrowse", function(cmd)
				Snacks.gitbrowse({
					what = cmd.args ~= "" and cmd.args or "permalink",
					line_start = cmd.range ~= 0 and cmd.line1 or nil,
					line_end = cmd.range ~= 0 and cmd.line2 or nil,
				})
			end, { range = true, nargs = "?", desc = "Git Browse (permalink)", force = true })
		end,
		keys = {
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>z",
				function()
					Snacks.zen()
				end,
				desc = "zen mode",
			},
			{
				"<leader>b",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Switch Buffer",
			},
			{
				"<leader>fh",
				function()
					Snacks.picker.help()
				end,
				desc = "Help tags",
			},
			{
				"<leader>tb",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Git branches",
			},
			{
				"<Leader>p",
				function()
					Snacks.picker.files()
				end,
				desc = "Find files",
			},
			{
				"<Leader>rs",
				function()
					Snacks.picker.resume()
				end,
				desc = "Resume picker",
			},
			{
				"<Leader>o",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "Document symbols",
			},
			{
				"<Leader>P",
				function()
					Snacks.picker.grep()
				end,
				desc = "Live grep",
			},
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse({ what = "permalink" })
				end,
				mode = { "n", "v" },
				desc = "Git Browse (permalink)",
			},
		},
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			picker = {
				sources = {
					files = {
						hidden = true,
						ignored = false,
						exclude = { ".git/*", "node_modules/*", ".venv/*" },
					},
					grep = {
						hidden = true,
						ignored = false,
						exclude = { ".git/*", "node_modules/*", ".venv/*" },
					},
					buffers = {
						hidden = true,
						unloaded = true,
						current = false,
						sort_lastused = true,
					},
				},
			},
			indent = {
				-- your indent configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				enabled = false,
			},
			bigfile = { enabled = true },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = false },
			gitbrowse = {
				what = "permalink",
			},
		},
	},
	{
		"jamessan/vim-gnupg",
		ft = { "gpg", "pgp", "asc" },
	},
}
