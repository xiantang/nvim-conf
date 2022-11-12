function RecentlySeesion()
  -- pwd
  require("persistence").load({ last = true })
  local pwd = vim.fn.getcwd()
  -- get current cursor position_self
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cmd = string.format("NERDTreeToggle %s | wincmd p", pwd)
  -- NerdTree
  vim.cmd(cmd)
  -- move cursor to last position_self
  vim.api.nvim_win_set_cursor(0, cursor)
  vim.cmd("MinimapToggle")
  -- buffer enter events
  -- if it's Minimap buffer, wincmd p to move to last buffer
  vim.cmd("autocmd BufEnter * if bufname('%') =~ 'Minimap' | wincmd p | endif")
  -- file type
end

-- https://github.com/neovim/neovim/issues/8136#issuecomment-373082539 nested
vim.cmd("autocmd VimEnter * nested lua RecentlySeesion()")
