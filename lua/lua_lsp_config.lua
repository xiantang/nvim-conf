-- on_attach
local nvim_lsp = require('lspconfig')
local on_attach = function (client,bufnr)
end

local servers = {"sumneko_lua"}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
  }
end

require('nvim-lsp-installer').on_server_ready(
  function(server)
    local config = {
      on_attach = on_attach,
      autostart = true,
      settings = {
        Lua = {
          diagnostics = { globals = {'vim'} }
        }
      }
    }
    server:setup(config)
  end
)

require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
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
}

