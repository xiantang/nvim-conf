require("toggleterm").setup({
	start_in_insert = false,
	on_open = function(_)
		-- check nerdtree is visible
		local name = vim.fn.bufname("NERD_tree_")
		if name == "" then
			return
		end
		-- get buff id
		local id = vim.fn.bufnr(name)
		if id ~= -1 then
			local pwd = vim.fn.getcwd()
			vim.defer_fn(function()
				local cmd = string.format("NERDTreeToggle %s ", pwd)
				vim.cmd(cmd)
				local cmd_retoggle = string.format("NERDTreeToggle %s | 1 | wincmd p", pwd)
				vim.cmd(cmd_retoggle)
			end, 100)
		end
	end,
})
