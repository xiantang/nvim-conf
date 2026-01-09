return {
	{
		"mbbill/undotree",
		cmd = { "UndotreeToggle" },
		config = function()
			vim.g.undotree_WindowLayout = 3

			-- Setup persistent undo
			vim.api.nvim_create_autocmd("BufEnter", {
				callback = function()
					if vim.fn.has("persistent_undo") == 1 then
						local target_path = vim.fn.expand("~/.undodir")
						if vim.fn.isdirectory(target_path) == 0 then
							vim.fn.mkdir(target_path, "p", 448) -- 0700 in octal = 448 in decimal
						end
						vim.opt.undodir = target_path
						vim.opt.undofile = true
					end
				end,
			})
		end,
	},
}
