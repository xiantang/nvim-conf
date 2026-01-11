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
		end,
	},
}
