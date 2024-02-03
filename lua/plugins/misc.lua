return {
	{
		"xiantang/nvim-macros",
		cmd = { "MacroSave", "MacroYank", "MacroSelect", "MacroDelete" },
		opts = {

			json_file_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/macros.json"), -- Location where the macros will be stored
			default_macro_register = "q", -- Use as default register for :MacroYank and :MacroSave and :MacroSelect Raw functions
			json_formatter = "none", -- can be "none" | "jq" | "yq" used to pretty print the json file (jq or yq must be installed!)
		},
	},
	{
		"jamessan/vim-gnupg",
		ft = { "gpg", "pgp", "asc" },
	},
	{
		"tzachar/highlight-undo.nvim",
		keys = {
			"u",
			"<C-r>",
		},
		config = function()
			require("highlight-undo").setup({
				duration = 300,
				undo = {
					hlgroup = "HighlightUndo",
					mode = "n",
					lhs = "u",
					map = "undo",
					opts = {},
				},
				redo = {
					hlgroup = "HighlightUndo",
					mode = "n",
					lhs = "<C-r>",
					map = "redo",
					opts = {},
				},
				highlight_for_count = true,
			})
		end,
	},
}
