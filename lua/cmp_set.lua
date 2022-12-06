local luasnip = require("luasnip")

-- nvim-cmp setup
local cmp = require("cmp")

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
				buffer = "[Buffer]",
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

	-- https://www.reddit.com/r/neovim/comments/t7jl7p/cmp_autocomplete_in_golang_does_not_autoselect/
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
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
	sources = {
		{ name = "luasnip", priority = 100 },
		{ name = "nvim_lsp", priority = 99, max_item_count = 10 },
		{ name = "cmp_tabnine", priority = 98, max_item_count = 2, keyword_length = 3 },
		{ name = "buffer", priority = 80, max_item_count = 3, keyword_length = 3 },
		{ name = "path", priority = 80, max_item_count = 3, keyword_length = 3 },
		-- disable fuzzy
		{ name = "dictionary", priority = 10, max_item_count = 5, keyword_length = 3 },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_jira", max_item_count = 5, keyword_length = 2 },
		{ name = "luasnip", priority = 100 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "dictionary", priority = 10, max_item_count = 5, keyword_length = 3 },
	}),
})

cmp.setup.filetype("markdown", {
	sources = cmp.config.sources({
		{ name = "cmp_jira", max_item_count = 5, keyword_length = 2 },
		{ name = "luasnip", priority = 100 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "dictionary", priority = 10, max_item_count = 5, keyword_length = 3 },
	}),
})
