-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
vim.g.codecompanion_auto_tool_mode = true

return {
	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			restricted_keys = {
				["h"] = false,
				["j"] = false,
				["k"] = false,
				["l"] = false,
			},
		},
	},
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
		},
		-- comment the following line to ensure hub will be ready at the earliest
		cmd = "MCPHub", -- lazy load by default
		lazy = false,
		tag = "v4.2.0",
		build = "npm install -g mcp-hub@1.8.1", -- Installs required mcp-hub npm module
		-- uncomment this if you don't want mcp-hub to be available globally or can't use -g
		-- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
		config = function()
			require("mcphub").setup(
				{
					auto_approve = true,
					extensions = {
						codecompanion = {
							-- Show the mcp tool result in the chat buffer
							-- NOTE:if the result is markdown with headers, content after the headers wont be sent by codecompanion
							show_result_in_chat = true,
							make_vars = true,    -- make chat #variables from MCP server resources
							make_slash_commands = true, -- make /slash_commands from MCP server prompts
						},
					}
				}
			)
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		keys = {
			{
				"<leader>ca",
				"<cmd>CodeCompanionActions<cr>",
				mode = { "n", "v" },
				desc =
				"CodeCompanion Actions"
			},
			{
				"<LocalLeader>a",
				"<cmd>CodeCompanionChat Toggle<cr>",
				mode = { "n", "v" },
				desc =
				"Toggle CodeCompanion Chat"
			},
			{ "<leader>ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to CodeCompanion Chat" },
		},
		cmd = {
			"CodeCompanionActions",
			"CodeCompanionChat",
			"CodeCompanion",
		},
		opts = {
			--Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
			adapters = {
				claude = function()
					return require("codecompanion.adapters").extend("anthropic", {
						schema = {
							model = {
								default = "claude-3-5-sonnet-20241022",
							},
						},
					})
				end,
				claude_thinking = function()
					return require("codecompanion.adapters").extend("anthropic", {
						schema = {
							model = {
								default = "claude-3-7-sonnet-20250219",
							},
						},
					})
				end,
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						schema = {
							model = {
								default = "gemini-2.5-pro-exp-03-25",
							},
						},
					})
				end,
				deepseek = function()
					local function clean_streamed_data(data)
						if type(data) == "table" then
							return data.body
						end
						local find_json_start = string.find(data, "{") or 1
						return string.sub(data, find_json_start)
					end
					return require("codecompanion.adapters").extend("deepseek", {
						env = {
							api_key = os.getenv("API_KEY"),
						},
						url = os.getenv("DEEPSEEK_URL"),
						handlers = {
							chat_output = function(self, data)
								local output = {}

								if data and data ~= "" then
									local data_mod = clean_streamed_data(data)
									local ok, json = pcall(vim.json.decode, data_mod,
										{ luanil = { object = true } })

									if ok and json.choices and #json.choices > 0 then
										local choice = json.choices[1]
										local delta = (self.opts and self.opts.stream) and
												choice.delta or choice.message

										if delta then
											if delta.role then
												output.role = delta.role
											else
												output.role = nil
											end

											output.content = ""

											-- ADD THINKING OUTPUT
											if delta.reasoning_content then
												output.content = delta
														.reasoning_content
											end

											if delta.content then
												output.content = output
														.content .. delta
														.content
											end

											return {
												status = "success",
												output = output,
											}
										end
									end
								end
							end,
						},
						schema = {
							model = {
								default = "ep-20250213150255-bllkt", -- define llm model to be used
							},
						},
					})
				end,
			},
			display = {
				action_palette = {
					provider = "telescope",
				},
			},
			strategies = {
				--NOTE: Change the adapter as required
				chat = {
					tools = {
						["mcp"] = {
							-- Prevent mcphub from loading before needed
							callback = function()
								return require("mcphub.extensions.codecompanion")
							end,
							description = "Call tools and resources from the MCP Servers"
						}
					},
					-- adapter = "my_openai",
					adapter = "claude_thinking",
					slash_commands = {
						["buffer"] = {
							opts = {
								provider = "telescope", -- default|telescope|mini_pick|fzf_lua
							},
						},
						["file"] = {
							opts = {
								provider = "telescope", -- default|telescope|mini_pick|fzf_lua
							},
						},
						["help"] = {
							opts = {
								provider = "telescope", -- telescope|mini_pick|fzf_lua
							},
						},
						["symbols"] = {
							opts = {
								provider = "telescope", -- default|telescope|mini_pick|fzf_lua
							},
						},
					},
				},
				inline = {
					-- adapter = "my_openai"
					adapter = "deepseek",
				},
			},
			opts = {
				log_level = "DEBUG",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
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
		},
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
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
		},
	},
	{
		"jamessan/vim-gnupg",
		ft = { "gpg", "pgp", "asc" },
	},
}
