local db = require('dashboard')

db.custom_center = {
  { icon = '** ',
    desc = 'Recently latest session                  ',
    shortcut = 'SPC s l',
    action = 'lua require("persistence").load({ last = true })' },
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
