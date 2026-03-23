-- Auto-organize imports on save for Go files
vim.api.nvim_create_autocmd("BufWritePre", {
	buffer = 0,
	callback = function()
		if vim.bo.filetype ~= "go" then
			return
		end

		local supports_code_action = false
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
			if client:supports_method("textDocument/codeAction") then
				supports_code_action = true
				break
			end
		end

		if not supports_code_action then
			return
		end

		local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding(0))
		params.context = { only = { "source.organizeImports" } }

		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1200)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					pcall(vim.lsp.util.apply_workspace_edit, r.edit, vim.lsp.util._get_offset_encoding(0))
				else
					pcall(vim.lsp.buf.execute_command, r.command)
				end
			end
		end
	end,
})
