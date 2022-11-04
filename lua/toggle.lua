local map = require("utils").map

function ToggleConfig()
  if vim.fn.bufwinnr("init.vim") ~= -1 then
    vim.cmd("q")
    return
  end
  -- edit the config file
  vim.cmd("split ~/.config/nvim/init.vim")
end

function ToggleNote()
  -- edit the config file
  vim.cmd("split ~/.config/note.md")
end

map("n", "<leader>e", ":lua ToggleConfig()<CR>,{silent = true}")
map("n", "<leader>n", ":lua ToggleNote()<CR>,{silent = true}")
