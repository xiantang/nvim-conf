return {
	{
		keys = {
			{
				"<Leader>l",
				":lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>:lua MiniFiles.reveal_cwd()<CR>",
				desc = "smart location",
			},
			{
				"-",
				":lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>:lua MiniFiles.reveal_cwd()<CR>",
				desc = "current",
			},
			{
				"_",
				":lua MiniFiles.open()<CR>",
				desc = "oil",
			},
		},
		"echasnovski/mini.files",
		version = "*",
		config = function()
			require("mini.files").setup({
				mappings = {
					close = "q",
					go_in = "l",
					go_in_plus = "<CR>",
					go_out = "h",
					go_out_plus = "H",
					reset = "<BS>",
					reveal_cwd = "@",
					show_help = "g?",
					synchronize = "=",
					trim_left = "<",
					trim_right = ">",
				},
			})
		end,
	},
}
