return {
	{
		"ThePrimeagen/harpoon",
		keys = {
			{
				"<leader>m",
				":lua require('harpoon.ui').toggle_quick_menu()<CR>",
			},
		},
		config = function()
			require("harpoon").setup({
				save_on_change = true,
			})
		end,
	},
}
