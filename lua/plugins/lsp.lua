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
					-- null_ls.builtins.formatting.nginx_beautifier,
					null_ls.builtins.formatting.gofmt,
					null_ls.builtins.formatting.goimports,
					-- null_ls.builtins.code_actions.shellcheck,
					-- null_ls.builtins.formatting.stylua,
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
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {
			floating_window = false, -- virtual hint enable
			hint_prefix = " ",
			hint_scheme = "TSConstructor",
			floating_window_above_cur_line = true,
		},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		-- use commit
		dependencies = {
			"j-hui/fidget.nvim",
			-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
			-- "folke/neodev.nvim",
		},
		config = function()
			require("lsp_config")
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall" },
		config = function()
			local safeRequire = require("lib").safeRequire
			local is_mac = vim.fn.has("mac") == 1
			if is_mac == 0 then
				local mason_registry = require("mason-registry")
				mason_registry:on("package:install:success", function(pkg)
					pkg:get_receipt():if_present(function(receipt)
						for _, rel_path in pairs(receipt.links.bin) do
							local bin_abs_path = pkg:get_install_path() .. "/extension/server/bin/" .. rel_path
							os.execute(
								'patchelf --set-interpreter "$(patchelf --print-interpreter $(grep -oE \\/nix\\/store\\/[a-z0-9]+-neovim-unwrapped-[0-9]+\\.[0-9]+\\.[0-9]+\\/bin\\/nvim $(which nvim)))" '
									.. bin_abs_path
							)
						end
					end)
				end)
			end
			safeRequire("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
					},
				},
			})
			safeRequire("mason-lspconfig").setup({
				ensure_installed = {
					-- "awk_ls",
					-- "lua_ls",
					"sqlls",
					"jsonls",
					"pyright",
					"dockerls",
					"bashls",
					"vimls",
					"yamlls",
				},
			})
		end,
	},
	{ "williamboman/mason-lspconfig.nvim", lazy = true },
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				symbol_in_winbar = {
					enable = false,
				},
				beacon = {
					enable = false,
					frequency = 20,
				},
				code_action_lightbulb = {
					enabled = false,
					virtual_text = false,
					sign = false,
				},
				finder = {
					max_height = 0.6,
					keys = {
						toggle_or_open = "<CR>",
					},
				},
				lightbulb = {
					enable = false,
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"ray-x/go.nvim",
		enabled = false,
		ft = "go",
		config = function()
			require("go").setup({
				-- https://github.com/ray-x/go.nvim/issues/113
				lsp_codelens = false,
			})
		end,
	},

	{ "ray-x/guihua.lua", event = "VeryLazy", enabled = false },
}
