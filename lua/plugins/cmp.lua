return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			local luasnip = require("luasnip")

			-- nvim-cmp setup
			local cmp = require("cmp")
			-- https://github.com/hrsh7th/nvim-cmp/wiki/Advanced-techniques#add-parentheses-after-selecting-function-or-method-item
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			if cmp == nil then
				return
			end
			local lspkind = require("lspkind")

			cmp.setup({
				-- show source name in menu
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						menu = {
							treesitter = "[Treesitter]",
							nvim_lsp = "[LSP]",
							luasnip = "[LuaSnip]",
							nvim_lua = "[Lua]",
							dictionary = "[Dictionary]",
							path = "[Path]",
							cmp_tabnine = "[TabNine]",
							cmp_jira = "[Jira]",
						},
					}),
				},
				matching = {
					disallow_fuzzy_matching = true,
					disallow_fullfuzzy_matching = true,
					disallow_partial_fuzzy_matching = false,
					disallow_partial_matching = false,
					disallow_prefix_unmatching = true,
				},
				sorting = {
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,

						-- copied from cmp-under, but I don't think I need the plugin for this.
						-- I might add some more of my own.
						function(entry1, entry2)
							local _, entry1_under = entry1.completion_item.label:find("^_+")
							local _, entry2_under = entry2.completion_item.label:find("^_+")
							entry1_under = entry1_under or 0
							entry2_under = entry2_under or 0
							if entry1_under > entry2_under then
								return false
							elseif entry1_under < entry2_under then
								return true
							end
						end,

						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},

				-- https://www.reddit.com/r/neovim/comments/t7jl7p/cmp_autocomplete_in_golang_does_not_autoselect/
				preselect = cmp.PreselectMode.None,
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- abort
					["<C-c>"] = cmp.mapping.abort(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({
						-- https://github.com/golang/go/issues/40871
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lua" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, { { name = "neorg" } }, {
					{ name = "treesitter", max_item_count = 3, keyword_length = 3 },
					{ name = "path", max_item_count = 3, keyword_length = 3 },
				}),
			})

			cmp.setup.cmdline(":", {
				view = {
					entries = { name = "wildmenu", separator = " " },
				},
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline", max_item_count = 30 },
				}),
			})
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "treesitter" },
				},
			})
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_jira", max_item_count = 5, keyword_length = 2 },
					{ name = "luasnip", priority = 100 },
					{ name = "treesitter", keyword_length = 3 },
					{ name = "dictionary", priority = 10, max_item_count = 5, keyword_length = 3 },
				}),
			})

			cmp.setup.filetype("markdown", {
				sources = cmp.config.sources({
					{ name = "cmp_jira", max_item_count = 5, keyword_length = 2 },
					{ name = "luasnip", priority = 100 },
					{ name = "treesitter", keyword_length = 3 },
					{ name = "dictionary", priority = 10, max_item_count = 5, keyword_length = 3 },
				}),
			})
			local source = require("jira")
			-- require("cmp").register_source("cmp_jira", source.new({}))
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"ray-x/cmp-treesitter",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
	},
}
