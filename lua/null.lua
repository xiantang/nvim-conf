local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

local golangci_lint_fix = {
  methods = null_ls.methods.FORMATTING,
  filetypes = { "go" },
  generator = helpers.generator_factory({
    command = "golangci-lint",
    to_stdin = true,
    from_stderr = false,
    ignore_stderr = true,
    args = {
      "run",
      "--fix=true",
      "--fast",
      "--out-format=json",
      "$DIRNAME",
      "--path-prefix",
      "$ROOT",
    },
    format = "json",
    check_exit_code = function(code)
      return code <= 2
    end,
  }),
}

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
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.jq,
  },
})

null_ls.register(golangci_lint_fix)
