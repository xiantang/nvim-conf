local dap = require("dap")
require("dapui").setup({
	icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	-- Expand lines larger than the window
	-- Requires >= 0.7
	expand_lines = vim.fn.has("nvim-0.7") == 1,
	-- Layouts define sections of the screen to place windows.
	-- The position can be "left", "right", "top" or "bottom".
	-- The size specifies the height/width depending on position. It can be an Int
	-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
	-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
	-- Elements are the elements shown in the layout (in order).
	-- Layouts are opened in order so that earlier layouts take priority in window sizing.
	layouts = {
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				{ id = "scopes", size = 0.25 },
				"watches",
			},
			size = 40, -- 40 columns
			position = "left",
		},
		{
			elements = {
				"repl",
			},
			size = 0.25, -- 25% of total lines
			position = "bottom",
		},
	},
	controls = {
		-- Requires Neovim nightly (or 0.8 when released)
		enabled = true,
		-- Display controls in this element
		element = "repl",
		icons = {
			pause = "",
			play = "",
			step_into = "",
			step_over = "",
			step_out = "",
			step_back = "",
			run_last = "↻",
			terminate = "□",
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
		max_value_lines = 100, -- Can be integer or nil.
	},
})
dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

-- show the debug console
dap.defaults.fallback.console = "internalConsole"

dap.listeners.after["event_initialized"]["key_map"] = function()
	-- close nerd tree
	vim.cmd("NERDTreeClose")
	require("dapui").open()
	vim.api.nvim_set_keymap("n", "c", '<cmd>lua require"dap".continue()<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "n", '<cmd>lua require"dap".step_over()<CR> | zz', { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "s", '<cmd>lua require"dap".step_into()<CR> | zz', { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "o", '<cmd>lua require"dap".step_out()<CR> | zz', { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "r", '<cmd>lua require"dap".repl.open()<CR>', { noremap = true, silent = true })
	-- stop terminal
	vim.api.nvim_set_keymap("n", "q", '<cmd>lua require"dap".disconnect()<CR>', { noremap = true, silent = true })
end

function defer()
	require("dapui").close()
	vim.cmd("NERDTreeToggle | wincmd p")
	-- rollback to default keymap
	-- nvim_del_keymap
	-- source keymap.lua
	vim.cmd("source ~/.config/nvim/lua/keymap.lua")
end

dap.listeners.after["disconnected"]["key_map"] = function()
	defer()
end

dap.listeners.before["event_exited"]["key_map"] = function()
	defer()
end

-- attach stop

dap.listeners.after["event_terminated"]["key_map"] = function()
	defer()
end

local function log_to_file()
	-- https://github.com/microsoft/debugpy/wiki/Enable-debugger-logs
	vim.env.DEBUGPY_LOG_DIR = vim.fn.stdpath("cache") .. "/debugpy"
	return true
end

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		logToFile = log_to_file,
		pythonPath = function()
			return "/opt/homebrew/bin/python3"
		end,
	},
	{
		type = "python",
		request = "attach",
		name = "Attach remote",
		connect = function()
			local host = vim.fn.input("Host [127.0.0.1]: ")
			host = host ~= "" and host or "127.0.0.1"
			local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
			return { host = host, port = port }
		end,
	},
}
dap.adapters.python = function(cb, config)
	if config.request == "attach" then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	else
		cb({
			type = "executable",
			command = "python",
			args = { "-m", "debugpy.adapter" },
			options = {
				source_filetype = "python",
			},
		})
	end
end

local prev_function_node = nil
local prev_function_name = ""

-- < Retrieve the name of the function the cursor is in.
function _G.function_surrounding_cursor()
	local ts_utils = require("nvim-treesitter.ts_utils")
	local current_node = ts_utils.get_node_at_cursor()

	if not current_node then
		return ""
	end

	local func = current_node

	while func do
		if func:type() == "function_definition" or func:type() == "function_declaration" then
			break
		end

		func = func:parent()
	end

	if not func then
		prev_function_node = nil
		prev_function_name = ""
		return ""
	end

	if func == prev_function_node then
		return prev_function_name
	end

	prev_function_node = func

	local find_name
	find_name = function(node)
		for i = 0, node:named_child_count() - 1, 1 do
			local child = node:named_child(i)
			local type = child:type()

			if type == "identifier" or type == "operator_name" then
				return (ts_utils.get_node_text(child))[1]
			else
				local name = find_name(child)

				if name then
					return name
				end
			end
		end

		return nil
	end

	prev_function_name = find_name(func)
	return prev_function_name
end

local prev_class_node = nil
local prev_class_name = ""

function _G.class_surrounding_cursor()
	local ts_utils = require("nvim-treesitter.ts_utils")
	local current_node = ts_utils.get_node_at_cursor()

	if not current_node then
		return ""
	end

	local func = current_node

	while func do
		if func:type() == "class_definition" or func:type() == "class_declaration" then
			break
		end

		func = func:parent()
	end

	if not func then
		prev_class_node = nil
		prev_class_name = ""
		return ""
	end

	if func == prev_class_node then
		return prev_class_name
	end

	prev_class_node = func

	local find_name
	find_name = function(node)
		for i = 0, node:named_child_count() - 1, 1 do
			local child = node:named_child(i)
			local type = child:type()

			if type == "identifier" or type == "operator_name" then
				return (ts_utils.get_node_text(child))[1]
			else
				local name = find_name(child)

				if name then
					return name
				end
			end
		end

		return nil
	end

	prev_class_name = find_name(func)
	return prev_class_name
end
