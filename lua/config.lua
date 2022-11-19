-- speed up
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
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/Users/jingdizhu/.config/nvim/my_snippets" } })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/my_snippets/lua/" })
require("lsp_config")
require("cmp_set")
require("go_test")
require("tele")
require("telescope").load_extension("frecency")
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
core = require("core")
function Jump()
  require('leap').leap { target_windows = vim.tbl_filter(
    function (win) return vim.api.nvim_win_get_config(win).focusable end,
    vim.api.nvim_tabpage_list_wins(0)
  )}
end
vim.api.nvim_set_keymap("n", "s", ":lua Jump()<CR>", { silent = true })
