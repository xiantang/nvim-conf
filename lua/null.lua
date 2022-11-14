local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.nginx_beautifier,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.code_actions.shellcheck,
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
