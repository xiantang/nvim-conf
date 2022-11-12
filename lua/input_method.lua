require("im_select").setup()

local function all_trim(s)
  return s:match("^%s*(.-)%s*$")
end

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    local default_im_select = "com.apple.keylayout.ABC"
    local current_select = all_trim(vim.fn.system({ "im-select" }))
    if current_select ~= default_im_select then
      vim.fn.system({ "im-select", default_im_select })
    end
  end,
})
