return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dev = false,
		keys = {
			{
				"<Leader>l",
				":NvimTreeFindFile <CR>",
				desc = "smart location",
			},
			{
				"<Leader>t",
				":NvimTreeToggle <CR>",
			},
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	config = function()
		require("nvim-tree").setup({
			bookmarks = {
				persist = true,
			},
		})

		-- Enable relative line numbers in NvimTree
		vim.api.nvim_create_autocmd("BufWinEnter", {
			pattern = "NvimTree*",
			callback = function()
				vim.opt_local.relativenumber = true
			end,
		})
	end,
	},
}
