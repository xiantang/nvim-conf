require("plugins")
vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
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
require("lualine_setup")
require("lsp_config")
require("tele")
require("git")
require("term")
require("syntax")
require("indent")
require("nvim-autopairs").setup({})
require("dap-go").setup()
require("dap_set")
require("nerdtree")
require("fastmind")
require("go").setup()
require("txtobj")
-- require("input_method")
require("null")
require("Comment").setup()
require("symbols-outline").setup()
require("neodev").setup({})
require("fidget").setup()
core = require("core")
-- function Jump()
-- 	require("leap").leap({
-- 		target_windows = vim.tbl_filter(function(win)
-- 			return vim.api.nvim_win_get_config(win).focusable
-- 		end, vim.api.nvim_tabpage_list_wins(0)),
-- 	})
-- end
-- vim.api.nvim_set_keymap("n", "s", ":lua Jump()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "m", "mM", { silent = true })
vim.api.nvim_set_keymap("n", "M", "`M", { silent = true })
-- disable command Gbrowse in cmdline mode

vim.cmd("cnoreabbrev git Git")
vim.cmd("cnoreabbrev gp Git push")
vim.cmd("cnoreabbrev Gbrowse GBrowse")

-- override variable  as white
-- for method caller
vim.cmd([[silent! colorscheme base16-tender]])
vim.cmd([[
  hi! link TSVariable Normal
]])

vim.cmd([[
      let g:conflict_marker_highlight_group = ''
      " Include text after begin and end markers
      let g:conflict_marker_begin = '^<<<<<<< .*$'
      let g:conflict_marker_end   = '^>>>>>>> .*$'

      highlight ConflictMarkerBegin guibg=#2f7366
      highlight ConflictMarkerOurs guibg=#2e5049
      highlight ConflictMarkerTheirs guibg=#344f69
      highlight ConflictMarkerEnd guibg=#2f628e
      highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
]])

function toggle_profile()
	local prof = require("profile")
	if prof.is_recording() then
		prof.stop()
		filename = ".profile.json"
		print(filename)
		prof.export(filename)
		vim.notify(string.format("Wrote %s", filename))
	else
		prof.start("*")
	end
end

-- create cmd

vim.api.nvim_create_user_command("Profile", function()
	toggle_profile()
end, {})
