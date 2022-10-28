-- neovim Script-User Defined Commands
-- 1. FastMind "FM" commands
vim.api.nvim_create_user_command("FM", function(opts)
  -- read from the arguments
  -- <q-args>
  -- print(string.upper(opts.args))
  local args = opts.args
  -- remove quote
  args = string.gsub(args, '"', "")

  local cmd = string.format("echo -e \"FastMind: %s\n$(cat ~/note.md)\" > ~/note.md", args)
  vim.fn.system(cmd)


end, {})
