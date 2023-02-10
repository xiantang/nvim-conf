local nvim_lsp = require("lspconfig")

-- get function name in body of golang function
function _G.get_cur_go_func_name()
	-- get current line number
	local line = vim.api.nvim_win_get_cursor(0)[1]
	-- get current line
	local line_str = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]
	-- get function name if not find, try to find in previous line
	-- for loop
	while not string.find(line_str, "func%s+([%w_]+)") do
		line = line - 1
		line_str = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]
		if not line_str then
			return nil
		end
	end
	local func_name = string.match(line_str, "func%s+([%w_]+)")
	return func_name
end

-- Avoiding LSP formatting conflicts https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			if client.name == "null-ls" or client.name == "awk_ls" then
				return true
			end
			return false
		end,
		bufnr = bufnr,
	})
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- change hold time
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "single",
		focusable = false,
		max_width = 80,
		max_height = 20,
	})
	-- cousor hold for 3 seconds, show signature helper
	-- silent
	-- vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.hover() ]]
	-- Mappings.
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	-- buf_set_keymap("n", "gv", "<cmd>Lspsaga peek_definition<CR>", opts)
	buf_set_keymap("n", "ga", "<cmd>Lspsaga code_action<CR>", opts)
	-- -- coode action for extract function or variable
	-- buf_set_keymap("v", "ga", "cmd>lua vim.lsp.bug.code_action()<CR>", opts)
	buf_set_keymap("v", "ga", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	buf_set_keymap("n", "<space>gi", "<cmd>Telescope lsp_implementations<CR>", opts)
	buf_set_keymap("n", "<space>dt", "<cmd>lua require('dap-go').debug_test()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>Lspsaga rename<CR>", opts)
	buf_set_keymap("n", "<space>gr", "<cmd>Lspsaga lsp_finder<CR>", opts)
	buf_set_keymap("n", "<space>o", "<cmd>SymbolsOutline<CR>", opts)
	-- buf_set_keymap('n', '<space>f', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
	-- if current buff end with _test.go, then set keymap for error
	local buf_name = vim.api.nvim_buf_get_name(bufnr)
	buf_set_keymap("n", "ge", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

	-- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

	-- Set some keybinds conditional on server capabilities
	if client.server_capabilities.document_formatting then
		buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.server_capabilities.document_range_formatting then
		buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end

	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      hi LspReferenceRead cterm=bold ctermbg=DarkMagenta guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=DarkMagenta guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=DarkMagenta guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

-- auto cmd

function go_org_imports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for cid, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
				vim.lsp.util.apply_workspace_edit(r.edit, enc)
			end
		end
	end
end

function gofumpt(timeoutms)
	-- get current file path
	local file_path = vim.api.nvim_buf_get_name(0)
	local command = string.format("!gofumpt -w %s", file_path)
	-- run cmd in background
	vim.cmd(command)
end

local lsp_configs = require("lspconfig/configs")

if not lsp_configs.golangcilsp then
	lsp_configs.golangcilsp = {
		default_config = {
			cmd = { "golangci-lint-langserver" },
			root_dir = nvim_lsp.util.root_pattern(".git", "go.mod"),
			init_options = {
				command = {
					"golangci-lint",
					"run",
					"--enable-all",
					"--disable",
					"lll",
					"--out-format",
					"json",
					"--issues-exit-code=1",
				},
			},
		},
	}
end

nvim_lsp.golangci_lint_ls.setup({
	filetypes = { "go", "gomod" },
})
-- set up lspconfig
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
		},
	},
})
require("mason-lspconfig").setup({
	ensure_installed = {
		"awk_ls",
		"sumneko_lua",
		"sqlls",
		"jsonls",
		"pyright",
		"dockerls",
		"bashls",
		"vimls",
		"yamlls",
	},
})

local common_servers = {
	"awk_ls",
	"sqlls",
	"jqls",
	"jsonls",
	"pyright",
	"dockerls",
	"bashls",
	"vimls",
	"yamlls",
	"terraformls",
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for _, server in pairs(common_servers) do
	-- https://www.reddit.com/r/neovim/comments/mm1h0t/lsp_diagnostics_remain_stuck_can_someone_please/
	nvim_lsp[server].setup({
		flags = {
			allow_incremental_sync = false,
			debounce_text_changes = 500,
		},
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

nvim_lsp.sumneko_lua.setup({
	capabilities = capabilities,
	on_attach = on_attach,
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
					vim.api.nvim_get_runtime_file("", true),
					"/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/",
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

nvim_lsp.gopls.setup({
	cmd = { "gopls" },
	-- for postfix snippets and analyzers
	flags = {
		allow_incremental_sync = false,
		debounce_text_changes = 500,
	},
	capabilities = capabilities,
	settings = {
		gopls = {
			-- fix my pain point
			usePlaceholders = true,
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
	on_attach = on_attach,
})
