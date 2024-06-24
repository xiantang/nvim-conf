return {
	{ "kevinhwang91/nvim-bqf", ft = "qf" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local function buffer_count()
				local count = 0
				for b = 1, vim.fn.bufnr("$") do
					if vim.fn.buflisted(b) ~= 0 and vim.api.nvim_buf_get_option(b, "buftype") ~= "quickfix" then
						count = count + 1
					end
				end

				return "bufs: " .. count
			end
			require("lualine").setup({
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { { "filename", path = 1 }, buffer_count },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			require("scrollbar").setup({
				handlers = {
					cursor = true,
					diagnostic = false,
					gitsigns = false, -- Requires gitsigns
					handle = true,
					search = false, -- Requires hlslens
					ale = false, -- Requires ALE
				},
				set_highlights = true,
			})
		end,
	},
}
