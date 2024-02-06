return {
	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup()
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
