local dap = require('dap')
require("dapui").setup()
dap.defaults.fallback.terminal_win_cmd = '50vsplit new'


-- show the debug console
dap.defaults.fallback.console = 'internalConsole'

dap.listeners.after["event_initialized"]["key_map"] = function()
  -- close nerd tree
  vim.cmd("NERDTreeClose")
  require("dapui").open()
  vim.api.nvim_set_keymap('n', 'c', '<cmd>lua require"dap".continue()<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'n', '<cmd>lua require"dap".step_over()<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 's', '<cmd>lua require"dap".step_into()<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'o', '<cmd>lua require"dap".step_out()<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', 'r', '<cmd>lua require"dap".repl.open()<CR>', { noremap = true, silent = true })
  -- stop terminal
  vim.api.nvim_set_keymap('n', 'q', '<cmd>lua require"dap".disconnect()<CR>', { noremap = true, silent = true })


end

dap.listeners.after['disconnected']['key_map'] = function()
  require("dapui").close()
  vim.cmd("NERDTreeToggle | wincmd p")
  -- rollback to default keymap
  -- nvim_del_keymap
  vim.api.nvim_del_keymap('n', 'c')
  vim.api.nvim_del_keymap('n', 'n')
  vim.api.nvim_del_keymap('n', 's')
  vim.api.nvim_del_keymap('n', 'o')
  vim.api.nvim_del_keymap('n', 'r')
  vim.api.nvim_del_keymap('n', 'q')
end

-- attach stop

dap.listeners.after["event_terminated"]["key_map"] = function()
  require("dapui").close()
  vim.cmd("NERDTreeToggle | wincmd p")
  -- rollback to default keymap
  -- nvim_del_keymap
  vim.api.nvim_del_keymap( 'n', 'c')
  vim.api.nvim_del_keymap( 'n', 'n')
  vim.api.nvim_del_keymap( 'n', 's')
  vim.api.nvim_del_keymap( 'n', 'o')
  vim.api.nvim_del_keymap( 'n', 'r')
  vim.api.nvim_del_keymap( 'n', 'q')

end
