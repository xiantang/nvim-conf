return {
	{
		"leoluz/nvim-dap-go",
		config = function()
			local function get_arguments()
				return coroutine.create(function(dap_run_co)
					local args = {}
					vim.ui.input({ prompt = "Args: " }, function(input)
						args = vim.split(input or "", " ")
						coroutine.resume(dap_run_co, args)
					end)
				end)
			end
			require("dap-go").setup({
				-- Additional dap configurations can be added.
				-- dap_configurations accepts a list of tables where each entry
				-- represents a dap configuration. For more details do:
				-- :help dap-configuration
				dap_configurations = {
					{
						type = "go",
						name = "Debug Package (with args)",
						request = "launch",
						program = "${workspaceFolder}",
						args = get_arguments,
					},
				},
				-- delve configurations
				delve = {
					-- the path to the executable dlv which will be used for debugging.
					-- by default, this is the "dlv" executable on your PATH.
					path = "dlv",
					-- time to wait for delve to initialize the debug session.
					-- default to 20 seconds
					initialize_timeout_sec = 20,
					-- a string that defines the port to start delve debugger.
					-- default to string "${port}" which instructs nvim-dap
					-- to start the process in a random available port
					port = "${port}",
					-- additional args to pass to dlv
					args = {},
					-- the build flags that are passed to delve.
					-- defaults to empty string, but can be used to provide flags
					-- such as "-tags=unit" to make sure the test suite is
					-- compiled during debugging, for example.
					-- passing build flags using args is ineffective, as those are
					-- ignored by delve in dap mode.
					build_flags = "-tags=util,integration,core",
				},
			})
		end,
	},
	{ "rcarriga/nvim-dap-ui", lazy = true },
	{
		keys = {
			{ "<Leader>de", ':lua require"dap".toggle_breakpoint()<CR>' },
		},
		"mfussenegger/nvim-dap",
		config = function()
			require("nvim-dap-virtual-text").setup()
			require("dap_set")
		end,
	},
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
	},
}
