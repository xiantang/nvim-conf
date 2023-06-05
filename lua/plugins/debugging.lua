return {
	{
		"jbyuki/one-small-step-for-vimkind",
		event = "VeryLazy",
	},
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
			require("nvim-dap-virtual-text").setup()
			require("dap_set")
		end,
	},
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
	},
	{
		"theHamsta/nvim-dap-virtual-text",
	},
}
