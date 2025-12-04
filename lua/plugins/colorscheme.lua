return {
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		enabled = false,
		opts = {},
	},
	{
		"xiantang/darcula-dark.nvim",
		config = function()
			-- setup must be called before loading
			require("darcula").setup({
				---@diagnostic disable-next-line: assign-type-mismatch
				opt = {
					integrations = {
						telescope = false,
						lualine = true,
						lsp_semantics_token = true,
						nvim_cmp = true,
						dap_nvim = true,
					},
				},
			})
		end,
	},
}
