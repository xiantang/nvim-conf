return {
	{ "michaelb/sniprun", event = "VeryLazy", build = "bash ./install.sh" },
	{
		"L3MON4D3/LuaSnip",
		commit = "79f647218847b1cd204fede7dd89025e43fd00c3",
		event = "InsertEnter",
		config = function()
			require("luasnip.loaders.from_vscode").load({
				include = { "norg", "c", "go", "python", "sh", "json", "lua", "gitcommit", "sql", "markdown" },
			})
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.expand("~/.config/nvim/my_snippets") } })
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/my_snippets/lua/" })
		end,
		dependencies = {
			"xiantang/friendly-snippets",
		},
	},
}
