return {
	{
		event = "VeryLazy",
		"tpope/vim-fugitive",
		config = function() end,
		-- cmd = "Git",
	},
	{
		"shumphrey/fugitive-gitlab.vim",
		event = "VeryLazy",
		config = function()
			-- check operation system
			local is_mac = vim.fn.has("mac") == 1
			if is_mac then
				local secret = require("secret")
				vim.g.fugitive_gitlab_domains = { secret.GITALB_URL }
			end
		end,
	},
	{
		event = "VeryLazy",
		"f-person/git-blame.nvim",
		config = function()
			vim.g.gitblame_ignored_filetypes = { "gitcommit", "c" }
			vim.g.gitblame_message_template = "<author> • <summary> • <date>"
		end,
	},
}
