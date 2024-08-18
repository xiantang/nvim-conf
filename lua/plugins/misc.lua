return {
	{
		"github/copilot.vim",
		config = function()
			vim.cmd([[
	let g:copilot_filetypes = {
	\ '*': v:true,
	\ 'lua': v:true,
	\ 'go': v:true,
	\ 'markdown': v:true,
	\ 'snippets': v:true,
	\ }
	imap <silent><script><expr> <C-e> copilot#Accept("\<CR>")
        let g:copilot_no_tab_map = v:true
			]])
		end,
	},
	-- {
	-- 	"robitx/gp.nvim",
	-- 	config = function()
	-- 		require("gp").setup({
	-- 			providers = {
	-- 				openai = {
	-- 					endpoint = "https://api.openai.com/v1/chat/completions",
	-- 					secret = os.getenv("OPENAI_API_KEY"),
	-- 				},
	-- 				anthropic = {
	-- 					endpoint = "https://api.anthropic.com/v1/messages",
	-- 					secret = os.getenv("ANTHROPIC_API_KEY"),
	-- 				},
	-- 			},
	-- 			hooks = {
	-- 				Explain = function(gp, params)
	-- 					local template = "I have the following code from {{filename}}:\n\n"
	-- 						.. "```{{filetype}}\n{{selection}}\n```\n\n"
	-- 						.. "Please respond by explaining the code above."
	-- 					local agent = gp.get_chat_agent()
	-- 					gp.Prompt(params, gp.Target.popup, nil, agent.model, template, agent.system_prompt)
	-- 				end,
	-- 				Translator = function(gp, params)
	-- 					local agent = gp.get_command_agent()
	-- 					local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
	-- 					gp.cmd.ChatNew(params, agent.model, chat_system_prompt)
	-- 				end,
	-- 				CodeReview = function(gp, params)
	-- 					local template = "I have the following code from {{filename}}:\n\n"
	-- 						.. "```{{filetype}}\n{{selection}}\n```\n\n"
	-- 						.. "Please analyze for code smells and suggest improvements."
	-- 					local agent = gp.get_chat_agent()
	-- 					gp.Prompt(params, gp.Target.enew("markdown"), nil, agent.model, template, agent.system_prompt)
	-- 				end,
	-- 				UnitTests = function(gp, params)
	-- 					local args = params.args
	-- 					-- local template = "I have the following code from {{filename}}:\n\n"
	-- 					-- 	.. "```{{filetype}}\n{{selection}}\n```\n\n"
	-- 					-- 	.. "Please respond by writing for the code above. by using mockey.Mock. writing a UT for this funtion "
	-- 					-- 	.. args
	-- 					local template = [[
	-- 						请为一个名为 ]] .. args .. [[ 的Go函数在 {{filename}} {{selection}}编写单元测试。这个函数是一个HTTP处理器，用于 [简短描述函数功能]。请遵循以下guidelines:
	-- 						1. 使用gin框架作为HTTP路由器。
	-- 						2. 使用github.com/bytedance/mockey进行mock测试。
	-- 						3. 使用github.com/stretchr/testify/assert进行断言。
	--
	-- 						对于上述函数，请遵循以下原则：
	-- 						- 如果函数已经在项目中定义并可以直接调用，请不要mock这个函数。
	-- 						- 如果函数是外部依赖或者不适合在单元测试中直接调用（例如数据库操作、网络请求等），请mock这个函数。
	--
	-- 						请编写一个测试函数，涵盖以下方面：
	-- 						1. 为每个需要mock的函数创建mock，并设置适当的返回值。
	-- 						2. 构造HTTP请求，包含必要的参数或请求体。
	-- 						3. 验证HTTP响应状态码。
	-- 						4. 验证响应体的结构和内容。
	-- 						5. 使用mockey.Assert验证被mock的函数是否被正确调用。
	--
	-- 						请提供完整的Go测试代码，包括必要的导入语句和测试函数定义。同时，请解释测试中的关键部分。
	--
	-- 						注意：
	-- 						- 如果某些细节不清楚，请做出合理的假设并在注释中说明。
	-- 						- 测试应该覆盖正常情况和至少一种错误情况。
	-- 						- 如果有特定的项目结构或命名约定，请在生成的代码中遵循这些约定。
	-- 						]]
	-- 					local agent = gp.get_command_agent()
	-- 					gp.Prompt(params, gp.Target.vnew, agent, template)
	-- 				end,
	-- 			},
	-- 		})
	-- 		local function keymapOptions(desc)
	-- 			return {
	-- 				noremap = true,
	-- 				silent = true,
	-- 				nowait = true,
	-- 				desc = "GPT prompt " .. desc,
	-- 			}
	-- 		end
	-- 		vim.keymap.set({ "n", "i" }, "<C-g>t", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
	-- 	end,
	-- },

	{
		"frankroeder/parrot.nvim",
		tag = "v0.5.0",
		dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
		-- optionally include "rcarriga/nvim-notify" for beautiful notifications
		config = function()
			require("parrot").setup({
				-- Providers must be explicitly added to make them available.
				providers = {
					pplx = {
						api_key = os.getenv("PERPLEXITY_API_KEY"),
						-- OPTIONAL
						-- gpg command
						-- api_key = { "gpg", "--decrypt", vim.fn.expand("$HOME") .. "/pplx_api_key.txt.gpg"  },
						-- macOS security tool
						-- api_key = { "/usr/bin/security", "find-generic-password", "-s pplx-api-key", "-w" },
					},
					openai = {
						api_key = os.getenv("OPENAI_API_KEY"),
					},
					anthropic = {
						api_key = os.getenv("ANTHROPIC_API_KEY"),
						params = {
							-- chat = { max_tokens = 9182 },
							-- command = { max_tokens = 9182 },
						},
					},
					mistral = {
						api_key = os.getenv("MISTRAL_API_KEY"),
					},
					gemini = {
						api_key = os.getenv("GEMINI_API_KEY"),
					},
					groq = {
						api_key = os.getenv("GROQ_API_KEY"),
					},
				},
				hooks = {
					UnitTests = function(prt, params)
						local template = [[
        I have the following code from {{filename}}:

        ```{{filetype}}
        {{selection}}
        ```

        Please respond by writing table driven unit tests for the code above.
        ]]
						local model_obj = prt.get_model("command")
						prt.logger.info("Creating unit tests for selection with model: " .. model_obj.name)
						prt.Prompt(params, prt.ui.Target.enew, model_obj, nil, template)
					end,
				},
			})
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
