local dap = require('dap')
require("dapui").setup()
dap.defaults.fallback.terminal_win_cmd = '50vsplit new'


-- show the debug console
dap.defaults.fallback.console = 'internalConsole'

dap.listeners.after["event_initialized"]["key_map"] = function()
  require("dapui").open()
  vim.api.nvim_buf_set_keymap(0, 'n', 'c', '<cmd>lua require"dap".continue()<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(0, 'n', 'n', '<cmd>lua require"dap".step_over()<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(0, 'n', 's', '<cmd>lua require"dap".step_into()<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(0, 'n', 'o', '<cmd>lua require"dap".step_out()<CR>', { noremap = true, silent = true })
  -- r
  vim.api.nvim_buf_set_keymap(0, 'n', 'r', '<cmd>lua require"dap".repl.open()<CR>', { noremap = true, silent = true })


end


-- attach stop

dap.listeners.after["event_terminated"]["key_map"] = function()
  require("dapui").close()
  -- rollback to default keymap
  -- nvim_buf_del_keymap
  vim.api.nvim_buf_del_keymap(0, 'n', 'c')
  vim.api.nvim_buf_del_keymap(0, 'n', 'n')
  vim.api.nvim_buf_del_keymap(0, 'n', 's')
  vim.api.nvim_buf_del_keymap(0, 'n', 'o')
  vim.api.nvim_buf_del_keymap(0, 'n', 'r')

end
