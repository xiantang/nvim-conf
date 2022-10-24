local db = require('dashboard')


function RecentlySeesion()
  require("persistence").load({ last = true })
  -- get current cursor position_self
  local cursor = vim.api.nvim_win_get_cursor(0)
  -- NerdTree
  vim.cmd("NERDTreeToggle | wincmd p")
  -- move cursor to last position_self
  vim.api.nvim_win_set_cursor(0, cursor)
end

db.custom_center = {
  { icon = '** ',
    desc = 'Recently latest session                  ',
    shortcut = 'SPC s l',
    action = 'lua RecentlySeesion()' },
  { icon = '** ',
    desc = 'Recently opened files                   ',
    action = 'Telescope oldfiles',
    shortcut = 'SPC f h' },
  { icon = '** ',
    desc = 'Find  File                              ',
    action = 'Telescope find_files find_command=rg,--hidden,--files',
    shortcut = 'SPC f f' },
  { icon = '** ',
    desc = 'Find  word                              ',
    action = 'Telescope live_grep',
    shortcut = 'SPC f w' },
}
