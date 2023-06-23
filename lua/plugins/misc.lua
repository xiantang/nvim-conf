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
				"<C-n>",
				':lua require("harpoon.ui").nav_next()<CR>',
				{ noremap = true, silent = true },
			},
			{
				"<C-p>",
				':lua require("harpoon.ui").nav_prev()<CR>',
				{ noremap = true, silent = true },
			},
		},
		config = function()
			require("harpoon").setup({
				save_on_change = true,
			})
		end,
	},
}
