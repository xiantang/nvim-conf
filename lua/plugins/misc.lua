return {
	{
		"ThePrimeagen/harpoon",
		keys = {
			{
				"<leader>a",
				':lua require("harpoon.mark").add_file()<CR>',
			},
			{
				"<leader>m",
				":lua require('harpoon.ui').toggle_quick_menu()<CR>",
			},
			{
				"<leader>1",
				':lua require("harpoon.ui").nav_file(1)<CR>',
			},
			{
				"<leader>2",
				':lua require("harpoon.ui").nav_file(2)<CR>',
			},
			{
				"<leader>3",
				':lua require("harpoon.ui").nav_file(3)<CR>',
			},
			{
				"<leader>4",
				':lua require("harpoon.ui").nav_file(4)<CR>',
			},
			{
				"<leader>5",
				':lua require("harpoon.ui").nav_file(5)<CR>',
			},
		},
		config = function()
			require("harpoon").setup({
				save_on_change = true,
			})
		end,
	},
}
