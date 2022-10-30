require('toggle')
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          vim.lsp.buf.format()
        end,
      })
    end
  end,
  sources = {
    require("null-ls").builtins.formatting.goimports,
    require("null-ls").builtins.formatting.gofumpt,
    require("null-ls").builtins.formatting.golines
  },
})
require('glow').setup()
require("lualine_setup")
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/Users/jingdizhu/.config/nvim/my_snippets" } })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/my_snippets/lua/" })
require("lsp_config")
require("go_test")
require("start")
require('tele')
require("telescope").load_extension("frecency")
require('git')
require('term')
require('syntex')
require('session')
require('indent')
require("nvim-autopairs").setup {}
require('dap-go').setup()
require("dap_set")
require("nerdtree")
require("fastmind")
