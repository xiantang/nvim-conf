return {
	{
		"robitx/gp.nvim",
		config = function()
			require("gp").setup({
				hooks = {
					Explain = function(gp, params)
						local template = "I have the following code from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please respond by explaining the code above."
						local agent = gp.get_chat_agent()
						gp.Prompt(params, gp.Target.popup, nil, agent.model, template, agent.system_prompt)
					end,
					Translator = function(gp, params)
						local agent = gp.get_command_agent()
						local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
						gp.cmd.ChatNew(params, agent.model, chat_system_prompt)
					end,
				},
			})

			-- or setup with your own config (see Install > Configuration in Readme)
			-- require("gp").setup(config)

			-- shortcuts might be setup here (see Usage > Shortcuts in Readme)
		end,
	},
	{
		"xiantang/nvim-macros",
		cmd = { "MacroSave", "MacroYank", "MacroSelect", "MacroDelete" },
		keys = {
			{ "<Leader>ms", ":TeTelescope macros select<CR>", {} },
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
		enabled = false,
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
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		--   "BufReadPre path/to/my-vault/**.md",
		--   "BufNewFile path/to/my-vault/**.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		-- wiki_link_func = "use_alias_only",
		wiki_link_func = "use_alias_only",
		markdown_link_func = "use_alias_only",
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/vault",
				},
			},

			-- see below for full list of options 👇
		},
	},
}
