return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VeryLazy",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.nginx_beautifier,
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.code_actions.shellcheck,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.jq,
					null_ls.builtins.diagnostics.hadolint,
				},
			})
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		event = "VeryLazy",
		dev = true,
		branch = "anticonceal",
		config = function()
			require("lsp-inlayhints").setup()
		end,
	},
	{
		"folke/neodev.nvim",
		event = "VeryLazy",
		config = function()
			require("neodev").setup({})
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
	-- {
	-- 	"VidocqH/lsp-lens.nvim",
	-- 	event = "VeryLazy",
	-- 	ft = { "go" },
	-- 	dev = true,
	-- 	config = function()
	-- 		require("lsp-lens").setup()
	-- 	end,
	-- },
	{ "williamboman/mason.nvim", event = "VeryLazy" },
	{ "williamboman/mason-lspconfig.nvim", event = "VeryLazy" },
	{ "glepnir/lspsaga.nvim", commit = "b7b4777", event = "VeryLazy" },
	{ "onsails/lspkind.nvim", event = "VeryLazy" },
	{
		event = "VeryLazy",
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"ray-x/go.nvim",
		event = "VeryLazy",
		config = function()
			require("go").setup({
				lsp_inlay_hints = { enable = false },
			})
		end,
	},
	{ "ray-x/guihua.lua", event = "VeryLazy" },
}
