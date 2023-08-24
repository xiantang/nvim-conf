return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local enabled = {
							"gomod",
							"gosum",
						}
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
