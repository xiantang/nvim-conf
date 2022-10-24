local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}
require('lualine').setup({
  options = {
    theme = {
      normal = {
        a = { fg = '#000000', bg = colors.green, gui = 'bold' },
        b = { fg = '#000000', bg = colors.green },
        c = { fg = '#000000', bg = colors.green },
      },
      insert = {
        a = { fg = '#000000', bg = colors.green, gui = 'bold' },
        b = { fg = '#000000', bg = colors.green },
        c = { fg = '#000000', bg = colors.green },
      },
      visual = {
        a = { fg = '#000000', bg = colors.green, gui = 'bold' },
        b = { fg = '#000000', bg = colors.green },
        c = { fg = '#000000', bg = colors.green },
      },
      replace = {
        a = { fg = '#000000', bg = colors.green, gui = 'bold' },
        b = { fg = '#000000', bg = colors.green },
        c = { fg = '#000000', bg = colors.green },
      },
      command = {
        a = { fg = '#000000', bg = colors.green, gui = 'bold' },
        b = { fg = '#000000', bg = colors.green },
        c = { fg = '#000000', bg = colors.green },
      },
      inactive = {
        a = { fg = '#000000', bg = '#ffffff', gui = 'bold' },
        b = { fg = '#000000', bg = '#ffffff' },
        c = { fg = '#000000', bg = '#ffffff' },
      },
    },
  },
})
