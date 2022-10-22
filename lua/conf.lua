
local map = require("utils").map



function ToggleConfig()
  print("ToggleConfig")
  -- if already have config window, close it
  if vim.fn.bufwinnr("init.vim") ~= -1 then
    vim.cmd("q")
    return
  end
  -- edit the config file
  vim.cmd("split ~/.config/nvim/init.vim")
end


function ToggleNote()
  if vim.fn.bufwinnr("note.md") ~= -1 then
    vim.cmd("q")
    return
  end
  -- edit the config file
  vim.cmd("split ~/note.md")
end



map("n", "<leader>e", ":lua ToggleConfig()<CR>,{silent = true}")
map("n", "<leader>n", ":lua ToggleNote()<CR>,{silent = true}")


