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
	-- {
	-- 	"ThePrimeagen/harpoon",
	-- 	lazy = true,
	-- 	config = function()
	-- 		-- when instert start
	-- 		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	-- 			pattern = { "*.md", "*.go", "*.py", "*.lua", "*.sh" },
	-- 			callback = function()
	-- 				require("harpoon.mark").add_file()
	-- 			end,
	-- 		})
	-- 		require("harpoon").setup({
	-- 			excluded_filetypes = { "harpoon", "TelescopePrompt" },
	-- 		})
	-- 		-- code
	-- 	end,
	-- },
}
