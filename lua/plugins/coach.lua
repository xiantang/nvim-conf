return {
	{
		"xiantang/coach.nvim",
		dev = true,
		build = "bash ./install.sh",
		config = function()
			require("coach").setup()
		end,
	},
}
