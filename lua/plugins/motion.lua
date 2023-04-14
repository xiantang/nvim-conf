return {
	{
		"jinh0/eyeliner.nvim",
		event = "VeryLazy",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
			})
		end,
	},
	{
		"phaazon/hop.nvim",
		event = "VeryLazy",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "dfgjkalwertyuizxcnm" })
		end,
	},
	{
		"ThePrimeagen/harpoon",
		keys = {
			-- { "<C-q>", ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true, silent = true } },
			-- { "<C-n>", ':lua require("harpoon.ui").nav_next()<CR>', { noremap = true, silent = true } },
			-- { "<C-p>", ':lua require("harpoon.ui").nav_prev()<CR>', { noremap = true, silent = true } },
			-- { "<Leader>a", ':lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true } },
			-- { "<C-m>", ':lua require("harpoon.ui").nav_file(1)<CR>', { noremap = true, silent = true } },
		},
		config = function()
			-- when instert start
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				pattern = { "*.md", "*.go", "*.py", "*.lua", "*.sh" },
				callback = function()
					require("harpoon.mark").add_file()
				end,
			})
			require("harpoon").setup({
				excluded_filetypes = { "harpoon", "TelescopePrompt" },
			})
			-- code
		end,
	},
}
