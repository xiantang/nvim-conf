
-- win number
local g_win = -1

-- swp_split swp cuurent file.
function  mark_cur_window()
  -- get current window number
  -- winnr()
  g_win =  vim.api.nvim_get_current_win()
end

function move_win_right()
  mark_cur_window()



end
