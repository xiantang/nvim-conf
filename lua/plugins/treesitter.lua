return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			local enabled = {
				"gomod",
				"gosum",
				"norg",
				"python",
				"yaml",
				"make",
			}
			require("nvim-treesitter.configs").setup({
				ensure_installed = enabled,
				highlight = {
					enable = true,
					disable = function(lang, buf)
						for _, enable in pairs(enabled) do
							if lang == enable then
								return false
							end
						end
						return true
					end,
				},
			})
		end,
	},
}
