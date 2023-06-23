return {
	{
		"ThePrimeagen/harpoon",
		lazy = false,
		keys = {
			{
				"<leader>ha",
				':lua require("harpoon.mark").add_file()<CR>',
			},
			{
				"<leader>hr",
				':lua require("harpoon.mark").rm_file()<CR>',
			},
			{
				"<leader>m",
				":lua require('harpoon.ui').toggle_quick_menu()<CR>",
			},
			{
				"g1",
				':lua require("harpoon.ui").nav_file(1)<CR>',
			},
			{
				"g2",
				':lua require("harpoon.ui").nav_file(2)<CR>',
			},
			{
				"g3",
				':lua require("harpoon.ui").nav_file(3)<CR>',
			},
			{
				"g4",
				':lua require("harpoon.ui").nav_file(4)<CR>',
			},
			{
				"gn",
				':lua require("harpoon.ui").nav_next()<CR>',
			},
			{
				"gp",
				':lua require("harpoon.ui").nav_prev()<CR>',
			},
		},
		config = function()
			require("harpoon").setup({
				save_on_change = true,
			})
		end,
	},
}
