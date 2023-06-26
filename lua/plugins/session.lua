return {
	-- {
	-- 	event = "VeryLazy",
	-- 	"folke/persistence.nvim",
	-- 	config = function()
	-- 		require("persistence").setup({
	-- 			dir = vim.fn.expand(vim.fn.stdpath("config") .. "/sessions/"), -- directory where session files are saved
	-- 			options = { "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
	-- 		})
	-- 	end,
	-- },
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	},
}
