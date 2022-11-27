-- speed up
-- require('config')
require("plugins")
require("start")
require("impatient")
require("scrollbar.handlers.gitsigns").setup()
require("scrollbar").setup({
	set_highlights = true,
	marks = {
		GitAdd = {
			text = "│",
			priority = 5,
			color = "green",
			cterm = nil,
		},
		GitChange = {
			text = "│",
			priority = 5,
			color = "yellow",
			cterm = nil,
		},
		GitDelete = {
			text = "_",
			priority = 5,
			color = "red",
			cterm = nil,
		},
	},
})
require("toggle")
require("glow").setup()
require("lualine_setup")
require("lsp_config")
require("tele")
require("git")
require("term")
require("syntax")
require("session")
require("indent")
require("nvim-autopairs").setup({})
require("dap-go").setup()
require("dap_set")
require("nerdtree")
require("fastmind")
require("go").setup()
require("txtobj")
require("input_method")
require("null")
require("Comment").setup()
require("symbols-outline").setup()
require("neodev").setup({})
core = require("core")
function Jump()
	require("leap").leap({
		target_windows = vim.tbl_filter(function(win)
			return vim.api.nvim_win_get_config(win).focusable
		end, vim.api.nvim_tabpage_list_wins(0)),
	})
end
vim.api.nvim_set_keymap("n", "s", ":lua Jump()<CR>", { silent = true })

-- override variable  as white
-- for method caller
vim.cmd([[silent! colorscheme base16-tender]])
vim.cmd([[
  hi! link TSVariable Normal
]])
