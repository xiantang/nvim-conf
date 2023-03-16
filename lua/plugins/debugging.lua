return {
	{
		"leoluz/nvim-dap-go",
		event = "VeryLazy",
		config = function()
			require("dap-go").setup()
		end,
	},
	{ "rcarriga/nvim-dap-ui", event = "VeryLazy" },
	{
		event = "VeryLazy",
		"mfussenegger/nvim-dap",
		config = function()
			require("dap_set")
		end,
	},
}
