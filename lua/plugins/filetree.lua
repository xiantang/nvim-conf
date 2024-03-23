return {
	{
		keys = {
			{
				"<Leader>l",
				require("filetree").location,
				desc = "smart location",
			},
			{
				"-",
				require("filetree").location,
				desc = "current",
			},
			{
				"_",
				":lua MiniFiles.open()<CR>",
				desc = "oil",
			},
		},
		"echasnovski/mini.files",
		config = function()
			require("mini.files").setup({
				mappings = {
					close = "q",
					go_in = "l",
					go_in_plus = "<CR>",
					go_out = "h",
					go_out_plus = "H",
					reset = "<BS>",
					reveal_cwd = "@",
					show_help = "g?",
					synchronize = "=",
					trim_left = "<",
					trim_right = ">",
				},
			})
			local window_handle
			local mini_files = require("mini.files")

			local group = vim.api.nvim_create_augroup("mini.files", { clear = true })
			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				desc = "define commands/keymaps for mini.files",
				group = group,
				callback = function(args)
					window_handle = vim.api.nvim_get_current_win()
					-- mini_files.open(vim.api.nvim_buf_get_name(0))
					local buf_id = args.data.buf_id
					vim.keymap.set("n", "s", function()
						local entry = mini_files.get_fs_entry()
						if not entry then
							return
						end
						vim.api.nvim_win_call(window_handle, function()
							mini_files.close()
							vim.cmd.vsplit({ args = { entry.path } })
						end)
					end, {
						buffer = buf_id,
						desc = "open from mini.files in vertical split",
					})
				end,
			})
		end,
	},
}
