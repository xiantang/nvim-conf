return {
	{
		"rmagatti/auto-session",
		config = function()
			vim.o.sessionoptions = "buffers,curdir,winsize,localoptions"
			require("auto-session").setup({
				session_lens = {
					load_on_setup = false,
				},
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	},
}
