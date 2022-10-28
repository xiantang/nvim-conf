require("vim.treesitter.query").set_query("go", "highlight", "")
require 'nvim-treesitter.configs'.setup {
  highlight = {
    -- disable highlight for variable and package in file
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}

-- override variable  as white
vim.cmd [[
  hi! link TSVariable Normal
]]
