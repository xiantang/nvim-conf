return {
	{
		"xiantang/nvim-macros",
		dev = true,
		keys = {
			{ "<Leader>ms", ":Telescope macros select<CR>", {} },
		},
		cmd = { "MacroSave", "MacroYank", "MacroSelect", "MacroDelete" },
		keys = {
			{ "<Leader>ms", ":Telescope macros select<CR>", {} },
		},
		dev = true,
		opts = {
			json_file_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/macros.json"), -- Location where the macros will be stored
			default_macro_register = "a", -- Use as default register for :MacroYank and :MacroSave and :MacroSelect Raw functions
			json_formatter = "jq", -- can be "none" | "jq" | "yq" used to pretty print the json file (jq or yq must be installed!)
		},
		dependencies = { "nvim-telescope/telescope.nvim" },
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
				duration = 50,
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
