return {
	{
		enabled = function()
			-- local file = vim.fn["expand"]("~/.wakatime.cfg")
			-- return vim.fn["filereadable"](file) == 1
			return false
		end,
		"wakatime/vim-wakatime",
	},
}
