local safeRequire = require("lib").safeRequire
local nvim_lsp = safeRequire("lspconfig")

vim.lsp.set_log_level("off")

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
	return string.match(line_str, "func%s+([%w_]+)")
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
	vim.cmd("syntax on")
	if client.name == "gopls" and not client.server_capabilities.semanticTokensProvider then
		local semantic = client.config.capabilities.textDocument.semanticTokens
		client.server_capabilities.semanticTokensProvider = {
			full = true,
			legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
			range = true,
		}
	end
	-- if client.supports_method("textDocument/formatting") then
	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup,
		buffer = bufnr,
		callback = function()
			lsp_formatting(bufnr)
		end,
	})
	-- end
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
	buf_set_keymap("n", "ga", "<cmd>Lspsaga code_action<CR>", opts)
	-- -- coode action for extract function or variable
	-- buf_set_keymap("v", "ga", "cmd>lua vim.lsp.bug.code_action()<CR>", opts)
	buf_set_keymap("v", "ga", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	function impl()
		local filters = {
			".*/circle/.*", -- 示
		}
		local function on_list(options)
			local filtered_itmers = {}

			for _, item in ipairs(options.items) do
				local skip = false
				for _, filter in ipairs(filters) do
					if vim.fn.match(item.filename, filter) ~= -1 then
						skip = true
						break
					end
				end
				if not skip then
					table.insert(filtered_itmers, item)
				end
			end
			vim.fn.setqflist({}, " ", {
				items = filtered_itmers,
			})
			vim.cmd("botright copen")
		end
		vim.lsp.buf.implementation({ on_list = on_list })
	end
	buf_set_keymap("n", "<space>gi", ":lua impl()<CR>", opts)
	buf_set_keymap("n", "<space>dt", "<cmd>lua require('dap-go').debug_test()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>Lspsaga rename<CR>", opts)
	buf_set_keymap("n", "<space>gr", "<cmd>Lspsaga lsp_finder<CR>", opts)
	buf_set_keymap("n", "<Leader>fr", ":lua vim.lsp.buf.references()<CR>", opts)
	-- buf_set_keymap('n', '<space>f', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
	-- if current buff end with _test.go, then set keymap for error
	local buf_name = vim.api.nvim_buf_get_name(bufnr)
	buf_set_keymap("n", "<space>ge", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

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

function gofumpt(timeoutms)
	-- get current file path
	local file_path = vim.api.nvim_buf_get_name(0)
	local command = string.format("!gofumpt -w %s", file_path)
	-- run cmd in background
	vim.cmd(command)
end

local lsp_configs = safeRequire("lspconfig/configs")

-- set up lspconfig
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
		"awk_ls",
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

local common_servers = {
	-- "ocamllsp",
	"awk_ls",
	"sqlls",
	"jqls",
	"jsonls",
	"pyright",
	"dockerls",
	"bashls",
	"vimls",
	"tsserver",
	"yamlls",
	"terraformls",
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = safeRequire("cmp_nvim_lsp").default_capabilities(capabilities)
local clangdCap = vim.lsp.protocol.make_client_capabilities()
clangdCap.offsetEncoding = { "utf-16" }
safeRequire("lspconfig").clangd.setup({ capabilities = clangdCap, on_attach = on_attach })
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

nvim_lsp.lua_ls.setup({
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
	on_attach = on_attach,
})

vim.api.nvim_create_user_command("LspCapabilities", function()
	local curBuf = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_active_clients({ bufnr = curBuf })

	for _, client in pairs(clients) do
		if client.name ~= "null-ls" then
			local capAsList = {}
			for key, value in pairs(client.server_capabilities) do
				if value and key:find("Provider") then
					local capability = key:gsub("Provider$", "")
					table.insert(capAsList, "- " .. capability)
				end
			end
			table.sort(capAsList) -- sorts alphabetically
			local msg = "# " .. client.name .. "\n" .. table.concat(capAsList, "\n")
			vim.notify(msg, "trace", {
				on_open = function(win)
					local buf = vim.api.nvim_win_get_buf(win)
					vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
				end,
				timeout = 14000,
			})
			fn.setreg("+", "Capabilities = " .. vim.inspect(client.server_capabilities))
		end
	end
end, {})
