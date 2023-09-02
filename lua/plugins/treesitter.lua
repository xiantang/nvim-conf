return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			local enabled = {
				"vim",
				"gomod",
				"gosum",
				"norg",
				"python",
				"yaml",
				"make",
				"gitignore",
				"terraform",
				"sql",
				"json",
			}
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
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
