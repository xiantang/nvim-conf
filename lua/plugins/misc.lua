return {
	-- {
	-- 	"TabbyML/vim-tabby",
	-- 	config = function()
	-- 		vim.cmd([[
	-- 		let g:tabby_keybinding_accept = '<C-e>'
	-- 		]])
	-- 	end,
	-- },
	-- {
	-- 	"stevearc/quicker.nvim",
	-- 	event = "FileType qf",
	-- 	---@module "quicker"
	-- 	---@type quicker.SetupOptions
	-- 	opts = {
	-- 		-- max_filename_width = function()
	-- 		-- return math.floor(math.min(95, vim.o.columns / 2))
	-- 	},
	-- },
	{
		"robitx/gp.nvim",
		config = function()
			require("gp").setup({
				proviers = {
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
					UnitTestsAPI = function(gp, params)
						local function read_root_gp_md_files_as_string()
							local root_dir = vim.fn.getcwd()
							local files = vim.fn.readdir(root_dir)
							local file_contents = {}
							for _, file in ipairs(files) do
								if file:match("%.gp%.md$") then
									local file_path = root_dir .. "/" .. file
									local file_handle = io.open(file_path, "r")
									if file_handle then
										local content = file_handle:read("*a")
										file_handle:close()
										table.insert(file_contents, content)
									end
								end
							end

							return table.concat(file_contents, "\n")
						end
						local template = "I have the following code from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please follow this template "
							.. read_root_gp_md_files_as_string()
							.. " to respond by writing tests for the code above."
						-- read file from .gp.md
						local agent = gp.get_command_agent()
						gp.Prompt(params, gp.Target.vnew, agent, template)
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
}
