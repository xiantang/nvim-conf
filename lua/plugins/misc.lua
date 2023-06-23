return {
	{
		"ThePrimeagen/harpoon",
		lazy = false,
		keys = {
			{
				"<C-a>",
				':lua require("harpoon.mark").add_file()<CR>',
			},
			{
				"<C-m>",
				":lua require('harpoon.ui').toggle_quick_menu()<CR>",
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
