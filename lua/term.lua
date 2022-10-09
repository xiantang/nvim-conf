-- export function
local M = {}

function M.setup()
  vim.o.hidden = true
  -- start insert mode in terminal
  require('nvim-terminal').setup({
      window = {
          -- Do `:h :botright` for more information
          -- NOTE: width or height may not be applied in some "pos"
          position = 'botright',

          -- Do `:h split` for more information
          split = 'sp',

          -- Width of the terminal
          width = 50,

          -- Height of the terminal
          height = 10,
      },

      -- keymap to disable all the default keymaps
      disable_default_keymaps = false,

      -- keymap to toggle open and close terminal window
      toggle_keymap = '<leader>;',

      -- increase the window height by when you hit the keymap
      window_height_change_amount = 2,

      -- increase the window width by when you hit the keymap
      window_width_change_amount = 2,

      -- keymap to increase the window width
      increase_width_keymap = '<leader><leader>+',

      -- keymap to decrease the window width
      decrease_width_keymap = '<leader><leader>-',

      -- keymap to increase the window height
      increase_height_keymap = '<leader>+',

      -- keymap to decrease the window height
      decrease_height_keymap = '<leader>-',


      terminals = {
          -- keymaps to open nth terminal
          {keymap = '<leader>1'},
          {keymap = '<leader>2'},
          {keymap = '<leader>3'},
          {keymap = '<leader>4'},
          {keymap = '<leader>5'},
      },
  })

end


-- export
return M
