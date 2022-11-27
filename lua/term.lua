require("toggleterm").setup({
	start_in_insert = false,
	on_open = function(_)
		-- check nerdtree is visible
		local name = vim.fn.bufname("NERD_tree_")
		-- get buff id
		local id = vim.fn.bufnr(name)
		-- get win by buff id
		local win = vim.fn.win_findbuf(id)
		-- length of win
		local count = 0
		for _, _ in ipairs(vim.fn.win_findbuf(id)) do
			count = count + 1
		end
		if count == 0 then
			return
		end
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
