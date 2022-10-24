require("toggleterm").setup {
  start_in_insert = false,
  size = 20,
  on_open = function(_)
    -- check nerdtree is visible
    --   -- g:NERDTree.IsOpen()
    -- get buffwinr
    local name = vim.fn.bufname("NERD")
    local winnr = vim.fn.bufwinnr(name)
    if winnr ~= -1 then
      local pwd = vim.fn.getcwd()
      -- NerdTree
      -- async running
      vim.defer_fn(function()
        local cmd = string.format("NERDTreeToggle %s ", pwd)
        vim.cmd(cmd)
        local cmd_retoggle = string.format("NERDTreeToggle %s | 1 | wincmd p", pwd)
        vim.cmd(cmd_retoggle)
      end, 100)


    end
  end,
}
