return {
	{
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		-- optional: provides snippets for the snippet source
		-- dependencies = "rafamadriz/friendly-snippets",

		-- use a release tag to download pre-built binaries
		version = "v0.*",
		dependencies = "L3MON4D3/LuaSnip",
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			snippets = {
				expand = function(snippet)
					vim.snippet.expand(snippet)
				end,
				active = function(filter)
					if filter and filter.direction then
						return require("luasnip").jumpable(filter.direction)
					end
					return require("luasnip").in_snippet()
				end,
				jump = function(direction)
					require("luasnip").jump(direction)
				end,
			},
			-- sources = {
			-- 	default = { "lsp", "path", "buffer", "luasnip" },
			-- },
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- see the "default configuration" section below for full documentation on how to define
			-- your own keymap.
			keymap = {
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				-- ["<C-e>"] = { "hide" },
				["<C-j>"] = { "select_and_accept" },

				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},

			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, via `opts_extend`

			-- experimental auto-brackets support
			-- completion = { accept = { auto_brackets = { enabled = true } } },

			accept = {
				auto_brackets = {
					enabled = true,
				},
			},

			-- experimental signature help support
			-- signature = { enabled = true }
		},
		-- allows extending the providers array elsewhere in your config
		-- without having to redefine it
		opts_extend = { "sources.default" },
	},
	-- {
	-- 	"tzachar/cmp-tabnine",
	-- 	-- enabled = function()
	-- 	-- 	return vim.fn.has("mac") == true
	-- 	-- end,
	-- 	build = "./install.sh",
	-- 	-- dev = true,
	-- 	dependencies = "hrsh7th/nvim-cmp",
	-- },
	-- {
	-- 	"iguanacucumber/magazine.nvim",
	-- 	event = { "InsertEnter" },
	-- 	name = "nvim-cmp",
	-- 	config = function()
	-- 		-- nvim-cmp setup
	-- 		local cmp = require("cmp")
	-- 		-- https://github.com/hrsh7th/nvim-cmp/wiki/Advanced-techniques#add-parentheses-after-selecting-function-or-method-item
	-- 		-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	-- 		-- cmp.event:on("confirm_done", function(ops)
	-- 		-- 	local kind = ops.entry.cache.entries.get_completion_item.kind
	-- 		-- 	-- 9 means cmp_kind is  module
	-- 		-- 	if kind == 9 then
	-- 		-- 		local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	-- 		-- 		vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { "." })
	-- 		-- 		vim.api.nvim_win_set_cursor(0, { row, col + 1 })
	-- 		-- 	else
	-- 		-- 		if kind == 3 or kind == 2 then
	-- 		-- 			cmp_autopairs.on_confirm_done()(ops)
	-- 		-- 		end
	-- 		-- 	end
	-- 		-- end)
	--
	-- 		if cmp == nil then
	-- 			return
	-- 		end
	--
	-- 		local feedkey = function(key, mode)
	-- 			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
	-- 		end
	-- 		local luasnip = require("luasnip")
	--
	-- 		local safeRequire = require("lib").safeRequire
	-- 		local has_tabnine, tabnine = pcall(require, "cmp_tabnine.config")
	-- 		if has_tabnine then
	-- 			tabnine:setup({
	-- 				max_lines = 1000,
	-- 				max_num_results = 1,
	-- 				min_percent = 10,
	-- 				sort = true,
	-- 				run_on_every_keystroke = true,
	-- 				snippet_placeholder = "..",
	-- 				ignored_file_types = {
	-- 					-- default is not to ignore
	-- 					-- uncomment to ignore in lua:
	-- 					-- lua = true
	-- 				},
	-- 				show_prediction_strength = false,
	-- 			})
	-- 		end
	--
	-- 		local menu = {
	-- 			buffer = "[buffer]",
	-- 			keyword = "[LSP]",
	-- 			nvim_lsp = "[LSP]",
	-- 			nvim_lua = "[Lua]",
	-- 			luasnip = "[LuaSnip]",
	-- 			vsnip = "[VSnip]",
	-- 			dictionary = "[Dictionary]",
	-- 			path = "[Path]",
	-- 			cmp_tabnine = "[TabNine]",
	-- 		}
	-- 		local confirmed = cmp.mapping.confirm({
	-- 			-- https://github.com/golang/go/issues/40871
	-- 			-- https://github.com/hrsh7th/nvim-cmp/issues/706#issuecomment-1006260085
	-- 			behavior = cmp.ConfirmBehavior.Replace,
	-- 			select = true,
	-- 		})
	--
	-- 		cmp.setup({
	-- 			-- show source name in menu
	-- 			experimental = {
	-- 				ghost_text = false,
	-- 			},
	-- 			formatting = {
	-- 				format = function(entry, vim_item)
	-- 					local kind_icons = {
	-- 						Text = "",
	-- 						Method = "󰆧",
	-- 						Function = "󰊕",
	-- 						Constructor = "",
	-- 						Field = "󰇽",
	-- 						Variable = "󰂡",
	-- 						Class = "󰠱",
	-- 						Interface = "",
	-- 						Module = "",
	-- 						Property = "󰜢",
	-- 						Unit = "",
	-- 						Value = "󰎠",
	-- 						Enum = "",
	-- 						Keyword = "󰌋",
	-- 						Snippet = "",
	-- 						Color = "󰏘",
	-- 						File = "󰈙",
	-- 						Reference = "",
	-- 						Folder = "󰉋",
	-- 						EnumMember = "",
	-- 						Constant = "󰏿",
	-- 						Struct = "",
	-- 						Event = "",
	-- 						Operator = "󰆕",
	-- 						TypeParameter = "󰅲",
	-- 					}
	--
	-- 					vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
	-- 					vim_item.menu = menu[entry.source.name]
	-- 					if entry.source.name == "cmp_tabnine" then
	-- 						local detail = (entry.completion_item.labelDetails or {}).detail
	-- 						vim_item.kind = ""
	-- 						if detail and detail:find(".*%%.*") then
	-- 							vim_item.kind = vim_item.kind .. " " .. detail
	-- 						end
	--
	-- 						if (entry.completion_item.data or {}).multiline then
	-- 							vim_item.kind = vim_item.kind .. " " .. "[ML]"
	-- 						end
	-- 					end
	-- 					local maxwidth = 80
	-- 					vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
	-- 					return vim_item
	-- 				end,
	-- 			},
	-- 			matching = {
	-- 				disallow_fuzzy_matching = false,
	-- 				disallow_fullfuzzy_matching = true,
	-- 				disallow_partial_fuzzy_matching = false,
	-- 				disallow_partial_matching = false,
	-- 				disallow_prefix_unmatching = true,
	-- 			},
	-- 			sorting = {
	-- 				priority_weight = 2.0,
	-- 				comparators = {
	-- 					cmp.config.compare.locality,
	-- 					cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
	-- 					cmp.config.compare.exact,
	-- 					cmp.config.compare.recently_used,
	-- 					cmp.config.compare.kind,
	-- 					cmp.config.compare.offset,
	-- 					cmp.config.compare.order,
	-- 					-- compare.scopes, -- what?
	-- 					-- compare.sort_text,
	-- 					-- compare.length, -- useless
	-- 				},
	-- 			},
	--
	-- 			-- https://www.reddit.com/r/neovim/comments/t7jl7p/cmp_autocomplete_in_golang_does_not_autoselect/
	-- 			-- https://github.com/hrsh7th/nvim-cmp/issues/1621
	-- 			preselect = cmp.PreselectMode.None,
	-- 			completion = {
	-- 				completeopt = "menu,menuone,noinsert", -- remove default noselect
	-- 			},
	-- 			snippet = {
	-- 				expand = function(args)
	-- 					vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
	-- 				end,
	-- 			},
	-- 			mapping = cmp.mapping.preset.insert({
	-- 				-- abort
	-- 				["<C-c>"] = cmp.mapping.abort(),
	-- 				["<C-d>"] = cmp.mapping.scroll_docs(-4),
	-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
	-- 				["<C-Space>"] = cmp.mapping.complete(),
	-- 				["<C-j>"] = confirmed,
	-- 				-- ["<C-e>"] = confirmed,
	-- 				["<CR>"] = cmp.mapping(function(fallback)
	-- 					if cmp.visible() ~= true then
	-- 						fallback()
	-- 					end
	-- 				end, { "i", "s" }),
	-- 				["<Tab>"] = cmp.mapping(function(fallback)
	-- 					if cmp.visible() then
	-- 						cmp.select_next_item()
	-- 						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
	-- 						-- they way you will only jump inside the snippet region
	-- 					elseif vim.fn["vsnip#available"](1) == 1 then
	-- 						feedkey("<Plug>(vsnip-expand-or-jump)", "")
	-- 					else
	-- 						fallback()
	-- 					end
	-- 				end, { "i", "s" }),
	-- 				["<S-Tab>"] = cmp.mapping(function(fallback)
	-- 					if cmp.visible() then
	-- 						cmp.select_prev_item()
	-- 					elseif luasnip.jumpable(-1) then
	-- 						luasnip.jump(-1)
	-- 					elseif vim.fn["vsnip#jumpable"](-1) == 1 then
	-- 						feedkey("<Plug>(vsnip-jump-prev)", "")
	-- 					end
	-- 				end, { "i", "s" }),
	-- 			}),
	--
	-- 			sources = cmp.config.sources({
	-- 				{ name = "vsnip" },
	-- 				{ name = "nvim_lua" },
	-- 				{ name = "cmp_tabnine" },
	-- 				{ name = "nvim_lsp" },
	-- 			}, { { name = "neorg" } }, {}),
	-- 		})
	--
	-- 		cmp.setup.cmdline({ "/", "?" }, {
	-- 			mapping = cmp.mapping.preset.cmdline(),
	-- 			sources = {
	-- 				{ name = "buffer" },
	-- 			},
	-- 		})
	--
	-- 		cmp.setup.filetype("gitcommit", {
	-- 			sources = cmp.config.sources({
	-- 				{ name = "luasnip" },
	-- 				{ name = "buffer" },
	-- 				{ name = "dictionary", priority = 10, max_item_count = 5, keyword_length = 3 },
	-- 			}),
	-- 		})
	--
	-- 		cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
	-- 			sources = cmp.config.sources({ { name = "vim-dadbod-completion" } }),
	-- 		})
	-- 	end,
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-cmdline",
	-- 		"hrsh7th/cmp-vsnip",
	-- 		"saadparwaiz1/cmp_luasnip",
	-- 	},
	-- },
}
