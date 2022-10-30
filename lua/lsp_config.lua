local nvim_lsp = require("lspconfig")

local golang_capabilities = vim.lsp.protocol.make_client_capabilities()
golang_capabilities.textDocument.completion.completionItem.snippetSupport = true

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

--- debug current function for golang
function _G.debug_cur_test_func()
  local func_name = _G.get_cur_go_func_name()
  if not func_name then
    return
  end
  -- run vim command GoDebugTest
  --  DuplicateTabpane
  vim.cmd("DuplicateTabpane")
  -- sprintf -test.run TestOnRsyncAndWatch
  local cmd = string.format("GoDebugTest -test.run %s$", func_name)
  print("run command: " .. cmd)
  vim.cmd(cmd)
  -- waiting for debug start
  vim.defer_fn(function()
    -- run vim command GoDebugContinue
    vim.cmd("GoDebugContinue")
  end, 3000)
end

local on_attach = function(client, bufnr)
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
  buf_set_keymap("n", "gd", "<Cmd>Telescope lsp_definitions<CR>", opts)
  buf_set_keymap("n", "ga", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- coode action for extract function or variable
  buf_set_keymap("v", "ga", "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)

  buf_set_keymap("n", "<space>gi", "<cmd>Telescope lsp_implementations<CR>", opts)
  buf_set_keymap("n", "<space>dt", "<cmd>lua require('dap-go').debug_test()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>gr", "<cmd>Telescope lsp_references<CR>", opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  -- if current buff end with _test.go, then set keymap for error
  local buf_name = vim.api.nvim_buf_get_name(bufnr)
  if string.find(buf_name, "_test.go$") then
    buf_set_keymap(
      "n",
      "ge",
      "<cmd>lua vim.diagnostic.goto_next({severity = { min = vim.diagnostic.severity.WARN}})<CR>",
      opts
    )
  else
    buf_set_keymap("n", "ge", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  end

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
    ]] ,
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

-- local auto_format_regrexs = {
--   "*.lua",
--   "*.json",
--   "*.dockerfile",
-- }

-- for _, regrex in ipairs(auto_format_regrexs) do
--   vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = regrex,
--     command = "lua vim.lsp.buf.format { async = false} ",
--   })
-- end

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
  ensure_installed = { "sumneko_lua" },
})

local common_servers = {
  "sqlls",
  "jsonls",
  "pyright",
  "dockerls",
  "bashls",
  "prosemd_lsp",
  "vimls",
  "yamlls",
  "grammarly",
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, server in pairs(common_servers) do
  nvim_lsp[server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

nvim_lsp.sumneko_lua.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
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
  capabilities = golang_capabilities,
  settings = {
    gopls = {
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

local luasnip = require("luasnip")

-- nvim-cmp setup
local cmp = require("cmp")

if cmp == nil then
  return
end

cmp.setup({
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
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "path" },
  },
})
