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
	vim.api.nvim_del_keymap("n", "c")
	vim.api.nvim_del_keymap("n", "n")
	vim.api.nvim_del_keymap("n", "s")
	vim.api.nvim_del_keymap("n", "o")
	vim.api.nvim_del_keymap("n", "r")
	vim.api.nvim_del_keymap("n", "q")
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
