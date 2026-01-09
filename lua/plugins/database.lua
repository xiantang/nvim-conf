return {
	{
		"kristijanhusak/vim-dadbod-ui",
		keys = {
			{ "<leader>db", ":DBUIToggle<CR>", desc = "DBUIToggle" },
		},
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_execute_on_save = 0
			vim.g.db_ui_auto_execute_table_helpers = 1
			vim.g.db_ui_table_helpers = {
				mysql = {
					["Show Create table"] = "show create table {table} \\G",
				},
			}
		end,
		config = function()
			-- Disable folding in dbout buffers
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "dbout",
				callback = function()
					vim.opt_local.foldenable = false
				end,
			})
		end,
	},
}
