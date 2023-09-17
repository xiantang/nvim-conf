return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VeryLazy",
		config = function()
			local null_ls = require("null-ls")
			-- require("custom_code_actions")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.shfmt,
					null_ls.builtins.formatting.nginx_beautifier,
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.code_actions.shellcheck,
					null_ls.builtins.formatting.stylua,
					-- for python
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.diagnostics.hadolint,
				},
				debug = true,
			})
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
		"neovim/nvim-lspconfig",
		event = "BufRead",
		-- use commit
		dependencies = {
			"j-hui/fidget.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"xiantang/lspsaga.nvim",
			-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
			"folke/neodev.nvim",
		},
		config = function()
			require("lsp_config")
		end,
	},
	{ "williamboman/mason.nvim", event = "VeryLazy" },
	{ "williamboman/mason-lspconfig.nvim", event = "VeryLazy" },
	{
		"xiantang/lspsaga.nvim",
		event = "VeryLazy",
		config = function()
			local saga = require("lspsaga")
			saga.init_lsp_saga({
				code_action_lightbulb = {
					enabled = false,
					virtual_text = false,
					sign = false,
				},
				finder_icons = {
					def = "󰆧  ",
					ref = "  ",
					link = "󰆧  ",
				},
			})
		end,
	},
	{
		event = "VeryLazy",
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"ray-x/go.nvim",
		event = "VeryLazy",
		config = function()
			require("go").setup({
				-- https://github.com/ray-x/go.nvim/issues/113
				lsp_codelens = false,
			})
		end,
	},

	{ "ray-x/guihua.lua", event = "VeryLazy" },
}
