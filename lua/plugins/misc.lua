return {
	{
		"ThePrimeagen/harpoon",
		lazy = false,
		keys = {
			{
				"<C-s>",
				':lua require("harpoon.mark").add_file()<CR>',
			},
			{
				"<left>",
				':lua require("harpoon.ui").nav_file(1)<CR>',
			},
			{
				"<right>",
				':lua require("harpoon.ui").nav_file(2)<CR>',
			},
			{
				"<up>",
				':lua require("harpoon.ui").nav_file(3)<CR>',
			},
			{
				"<down>",
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
