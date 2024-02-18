return {
	{
		"tzachar/cmp-tabnine",
		enabled = function()
			return vim.fn.has("mac") == true
		end,
		build = "./install.sh",
		dev = true,
		dependencies = "hrsh7th/nvim-cmp",
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(client, bufnr)
				if client.name == "gopls" and not client.server_capabilities.semanticTokensProvider then
					local semantic = client.config.capabilities.textDocument.semanticTokens
					client.server_capabilities.semanticTokensProvider = {
						full = true,
						legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
						range = true,
					}
				end
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end

				local function buf_set_option(...)
					vim.api.nvim_buf_set_option(bufnr, ...)
				end

				buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

				-- cousor hold for 3 seconds, show signature helper
				-- silent
				-- vim.api.nvim_command([[autocmd CursorHold  <buffer> lua vim.lsp.buf.hover() ]])
				-- Mappings.
				local opts = { noremap = true, silent = true }
				buf_set_keymap("n", "<Enter>", "<Nop>", opts)
				buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
				-- buf_set_keymap("n", "gv", "<cmd>Lspsaga peek_definition<CR>", opts)
				buf_set_keymap("n", "<Leader>ga", "<cmd>Lspsaga code_action<CR>", opts)
				-- -- coode action for extract function or variable
				-- buf_set_keymap("v", "ga", "cmd>lua vim.lsp.bug.code_action()<CR>", opts)
				buf_set_keymap("v", "ga", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
				buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
				buf_set_keymap("n", "<space>dt", "<cmd>lua require('dap-go').debug_test()<CR>", opts)
				buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
				buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
				buf_set_keymap(
					"n",
					"<space>wl",
					"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
					opts
				)
				buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
				buf_set_keymap("n", "<space>rn", "<cmd>Lspsaga rename<CR>", opts)
				buf_set_keymap("n", "<space>gr", "<cmd>Lspsaga lsp_finder<CR>", opts)
				buf_set_keymap("n", "<Leader>f", ":lua vim.lsp.buf.format()<CR>", opts)
				-- if current buff end with _test.go, then set keymap for error
				local buf_name = vim.api.nvim_buf_get_name(bufnr)
				buf_set_keymap("n", "<space>ge", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

				-- Set autocommands conditional on server_capabilities
			end)
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim", "hs" },
						},
						workspace = {
							checkThirdParty = false,
							-- Make the server aware of Neovim runtime files
							library = {
								-- vim.api.nvim_get_runtime_file("", true),
								"/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/",
								vim.fn.expand("~/lualib/share/lua/5.4"),
								vim.fn.expand("~/lualib/lib/luarocks/rocks-5.4"),
								"/opt/homebrew/opt/openresty/lualib",
							},
						},
						completion = {
							callSnippet = "Replace",
						},
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
					},
				},
			})
			require("lspconfig").gopls.setup({
				cmd = { "gopls" },
				-- for postfix snippets and analyzers
				flags = {
					allow_incremental_sync = false,
					debounce_text_changes = 500,
				},
				settings = {
					gopls = {
						-- PAINPOINT
						usePlaceholders = true,
						semanticTokens = true,
						experimentalPostfixCompletions = true,
						analyses = {
							unusedparams = true,
							shadow = true,
						},
						-- use gopls build by myself https://github.com/xiantang/tools
						-- staticcheck = true,
					},
				},
			})
			require("lspconfig").pyright.setup({})
			require("lspconfig").sqlls.setup({})
			require("lspconfig").jqls.setup({})
			require("lspconfig").pyright.setup({})
			require("lspconfig").bashls.setup({})
			require("lspconfig").vimls.setup({})
			require("lspconfig").tsserver.setup({})
			require("lspconfig").yamlls.setup({})
			require("lspconfig").terraformls.setup({})
			require("lspconfig").rnix.setup({})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		-- use commit
		dependencies = {
			"j-hui/fidget.nvim",
			-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
			"folke/neodev.nvim",
		},
	},
	{ "hrsh7th/cmp-nvim-lsp" },
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
					null_ls.builtins.formatting.goimports,
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
	{ "williamboman/mason-lspconfig.nvim", lazy = true },
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
