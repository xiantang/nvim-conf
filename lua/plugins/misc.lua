return {
	{
		"github/copilot.vim",
		config = function()
			vim.cmd([[
	let g:copilot_filetypes = {
	\ '*': v:false,
	\ 'lua': v:true,
	\ 'markdown': v:true,
	\ 'snippets': v:true,
	\ }
	imap <silent><script><expr> <C-e> copilot#Accept("\<CR>")
        let g:copilot_no_tab_map = v:true
			]])
		end,
	},
	{
		"robitx/gp.nvim",
		config = function()
			require("gp").setup({
				providers = {
					openai = {
						endpoint = "https://api.openai.com/v1/chat/completions",
						secret = os.getenv("OPENAI_API_KEY"),
					},
					anthropic = {
						endpoint = "https://api.anthropic.com/v1/messages",
						secret = os.getenv("ANTHROPIC_API_KEY"),
					},
				},
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
					CodeReview = function(gp, params)
						local template = "I have the following code from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please analyze for code smells and suggest improvements."
						local agent = gp.get_chat_agent()
						gp.Prompt(params, gp.Target.enew("markdown"), nil, agent.model, template, agent.system_prompt)
					end,
					UnitTests = function(gp, params)
						local args = params.args
						local template = "I have the following code from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please respond by writing for the code above. by using mockey.Mock. writing a UT for this funtion "
							.. args
						local agent = gp.get_command_agent()
						gp.Prompt(params, gp.Target.enew, nil, agent.model, template, agent.system_prompt)
					end,
				},
			})
			local function keymapOptions(desc)
				return {
					noremap = true,
					silent = true,
					nowait = true,
					desc = "GPT prompt " .. desc,
				}
			end
			vim.keymap.set({ "n", "i" }, "<C-g>t", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
		end,
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
}
