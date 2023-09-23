return {
	{
		enabled = function()
			local file = vim.fn["expand"]("~/.wakatime.cfg")
			return vim.fn["filereadable"](file) == 1
		end,
		event = "VeryLazy",
		"wakatime/vim-wakatime",
	},
}
