-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
vim.g.codecompanion_auto_tool_mode = true

return {
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for `snacks` provider.
			---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				provider = {
					enabled = "tmux",
				},
				-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
			}

			-- Required for `opts.events.reload`.
			vim.o.autoread = true

			-- Opencode keymaps (grouped under <leader>c to avoid conflicts with Vim defaults)
			vim.keymap.set({ "n", "x" }, "<leader>ca", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode" })
			vim.keymap.set({ "n", "x" }, "<leader>cx", function()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })
			vim.keymap.set({ "n", "t" }, "<leader>ct", function()
				require("opencode").toggle()
			end, { desc = "Toggle opencode" })

			vim.keymap.set({ "n", "x" }, "<leader>co", function()
				return require("opencode").operator("@this ")
			end, { expr = true, desc = "Add range to opencode" })
			vim.keymap.set("n", "<leader>coo", function()
				return require("opencode").operator("@this ") .. "_"
			end, { expr = true, desc = "Add line to opencode" })

			vim.keymap.set("n", "<S-C-u>", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "opencode half page up" })
			vim.keymap.set("n", "<S-C-d>", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "opencode half page down" })
		end,
	},
	{
		"esmuellert/vscode-diff.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		keys = {
			{ "<Leader>d", ":CodeDiff<CR>" },
		},
		cmd = "CodeDiff",
		config = function()
			require("vscode-diff").setup({
				-- Highlight configuration
				highlights = {
					line_insert = "#334043",
					line_delete = "#473145",
					char_insert = "#465d60",
					char_delete = "#473144",
					char_brightness = 1.4,
				},

				-- Diff view behavior
				diff = {
					disable_inlay_hints = true, -- Disable inlay hints in diff windows for cleaner view
					max_computation_time_ms = 5000, -- Maximum time for diff computation (VSCode default)
				},

				-- Keymaps in diff view
				keymaps = {
					view = {
						quit = "q", -- Close diff tab
						toggle_explorer = "<leader>b", -- Toggle explorer visibility (explorer mode only)
						next_hunk = "]c", -- Jump to next change
						prev_hunk = "[c", -- Jump to previous change
						next_file = "]f", -- Next file in explorer mode
						prev_file = "[f", -- Previous file in explorer mode
					},
					explorer = {
						select = "<CR>", -- Open diff for selected file
						hover = "K", -- Show file diff preview
						refresh = "R", -- Refresh git status
					},
				},
			})
		end,
	},
	{ "nvim-lua/plenary.nvim" },
	{
		"abecodes/tabout.nvim",
		lazy = false,
		config = function()
			require("tabout").setup({
				tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
				backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
				act_as_tab = true, -- shift content if tab out is not possible
				act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
				default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
				default_shift_tab = "<C-d>", -- reverse shift default action,
				enable_backwards = true, -- well ...
				completion = false, -- if the tabkey is used in a completion pum
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
		opt = true, -- Set this to true if the plugin is optional
		event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
		priority = 1000,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		init = function()
			local function setup_gbrowse()
				-- Override Fugitive's GBrowse to funnel through snacks.gitbrowse
				vim.api.nvim_create_user_command("GBrowse", function(cmd)
					local opts = {
						what = cmd.args ~= "" and cmd.args or "permalink",
						line_start = cmd.range ~= 0 and cmd.line1 or nil,
						line_end = cmd.range ~= 0 and cmd.line2 or nil,
					}

					if cmd.bang then
						opts.open = function(url)
							vim.fn.setreg("+", url)
							vim.notify("Copied Git URL to clipboard", vim.log.levels.INFO)
						end
					end

					Snacks.gitbrowse(opts)
				end, { range = true, nargs = "?", bang = true, desc = "Git Browse (permalink)", force = true })
			end

			setup_gbrowse()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = setup_gbrowse,
			})

			-- LSP progress notifications via Snacks' notifier
			local progress = vim.defaulttable()
			vim.api.nvim_create_autocmd("LspProgress", {
				---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					local value = ev.data.params.value
					if not client or type(value) ~= "table" then
						return
					end
					local p = progress[client.id]

					for i = 1, #p + 1 do
						if i == #p + 1 or p[i].token == ev.data.params.token then
							p[i] = {
								token = ev.data.params.token,
								msg = ("[%3d%%] %s%s"):format(
									value.kind == "end" and 100 or value.percentage or 100,
									value.title or "",
									value.message and (" **%s**"):format(value.message) or ""
								),
								done = value.kind == "end",
							}
							break
						end
					end

					local msg = {} ---@type string[]
					progress[client.id] = vim.tbl_filter(function(v)
						return table.insert(msg, v.msg) or not v.done
					end, p)

					local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
					vim.notify(table.concat(msg, "\n"), "info", {
						id = "lsp_progress",
						title = client.name,
						opts = function(notif)
							notif.icon = #progress[client.id] == 0 and " "
								or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
						end,
					})
				end,
			})
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
					local mode = vim.fn.mode()
					local is_visual = mode == "v" or mode == "V" or mode == "\22"
					local opts = { what = "permalink" }

					if is_visual then
						opts.line_start = vim.fn.line("'<")
						opts.line_end = vim.fn.line("'>")
						opts.open = function(url)
							vim.fn.setreg("+", url)
							vim.notify("Copied Git URL to clipboard", vim.log.levels.INFO)
						end
					end

					Snacks.gitbrowse(opts)
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
				url_patterns = (function()
					local ok, secret = pcall(require, "secret")
					local domain = ok and secret.GITALB_URL
					local patterns = {
						[domain] = {
							branch = "/tree/{branch}?ref_type=commits",
							file = "/blob/{branch}/{file}?ref_type=commits#L{line_start}-{line_end}",
							permalink = "/blob/{commit}/{file}?ref_type=commits#L{line_start}-{line_end}",
							commit = "/commit/{commit}?ref_type=commits",
						},
					}

					return patterns
				end)(),
			},
			notifier = {
				enabled = true,
			},
		},
	},
	{
		"jamessan/vim-gnupg",
		ft = { "gpg", "pgp", "asc" },
	},
}
