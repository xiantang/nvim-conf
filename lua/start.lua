local db = require("dashboard")

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
end

db.custom_center = {
  {
    icon = "** ",
    desc = "Recently latest session                  ",
    shortcut = "SPC s l",
    action = "lua RecentlySeesion()",
  },
  {
    icon = "** ",
    desc = "Recently opened files                   ",
    action = "Telescope oldfiles",
    shortcut = "SPC f h",
  },
  {
    icon = "** ",
    desc = "Find  File                              ",
    action = "Telescope find_files find_command=rg,--hidden,--files",
    shortcut = "SPC f f",
  },
  {
    icon = "** ",
    desc = "Find  word                              ",
    action = "Telescope live_grep",
    shortcut = "SPC f w",
  },
}
