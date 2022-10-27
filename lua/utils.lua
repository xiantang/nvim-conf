local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.get_all_buffers_name()
  local buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf)
    if name ~= "" then
      table.insert(buffers, name)
    end
  end
  return buffers
end

function M.get_buffer_contain_name(name)
  local names = M.get_all_buffers_name()
  for _, v in pairs(names) do
    -- include name as substrings
    -- check it is name is substring of vim
    if string.match(v, name) then
      print(name)
      return v
    end
  end
end

return M
