local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

null_ls.setup({
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
    null_ls.builtins.formatting.nginx_beautifier,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.jq,
    null_ls.builtins.diagnostics.hadolint,
  },
})

local function golines()
  -- get current file path
  local file_path = vim.api.nvim_buf_get_name(0)
  local command = string.format("!golines -m 400 -w --no-reformat-tags %s", file_path)
  -- run cmd in backgroundColor
  -- run in async
  vim.cmd(command)
end
