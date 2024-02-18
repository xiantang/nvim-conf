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

local common_servers = {
	-- "ocamllsp",
	-- "awk_ls",
	"sqlls",
	"jqls",
	"pyright",
	"bashls",
	"vimls",
	"tsserver",
	"yamlls",
	"terraformls",
	"rnix",
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = safeRequire("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
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
