require("persistence").setup({
  dir = vim.fn.expand(vim.fn.stdpath("config") .. "/sessions/"), -- directory where session files are saved
  options = { "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
})
