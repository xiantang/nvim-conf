return {
	{
		"rmagatti/auto-session",
		config = function()
			vim.o.sessionoptions = "curdir,winsize"
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	},
}
