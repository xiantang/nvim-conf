local lru_lib = require("lru")
local lru = lru_lib.new(10, _, function(key, value)
	local name = vim.api.nvim_buf_get_name(key)
	vim.api.nvim_buf_delete(key, { force = false, unload = false })
end)
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	pattern = { "*" },
	callback = function()
		-- get all buffer
		local openBuffers = vim.fn.getbufinfo({ buflisted = 1 })
		table.sort(openBuffers, function(x, y)
			return x.bufnr > y.bufnr
		end)
		for _, buf in pairs(openBuffers) do
			lru.set(_, buf.bufnr, 1, _)
		end
	end,
})
vim.api.nvim_create_autocmd({ "BufAdd" }, {
	pattern = { "*" },
	callback = function(params)
		lru.set(_, params.buf, 1, _)
	end,
})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*" },
	callback = function(params)
		_ = lru.get(_, params.buf)
	end,
})
