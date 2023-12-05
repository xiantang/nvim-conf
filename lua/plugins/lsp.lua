return {
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
					null_ls.builtins.formatting.nixfmt,
				},
				debug = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		-- use commit
		dependencies = {
			"j-hui/fidget.nvim",
			-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
			"folke/neodev.nvim",
		},
		config = function()
			require("lsp_config")
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall" },
		config = function() end,
	},
	{ "williamboman/mason-lspconfig.nvim", cmd = { "Mason", "MasonInstall" } },
	{
		"xiantang/lspsaga.nvim",
		cmd = "Lspsaga",
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
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"ray-x/go.nvim",
		ft = "go",
		config = function()
			require("go").setup({
				-- https://github.com/ray-x/go.nvim/issues/113
				lsp_codelens = false,
			})
		end,
	},

	{ "ray-x/guihua.lua", event = "VeryLazy" },
}
