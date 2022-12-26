local queries = require("nvim-treesitter.query")
function etract_value(mode)
	-- check vim file type
	local file_type = vim.bo.filetype
	if file_type == nil then
		return
	end

	-- check language supported
	local languages = {
		"go",
		"python",
		"lua",
	}
	local supported = false
	for _, language in ipairs(languages) do
		if file_type == language then
			supported = true
			break
		end
	end
	if not supported then
		ret = string.format("file type %s not supported", file_type)
		vim.api.nvim_echo({ { ret, "WarningMsg" } }, true, {})
		return
	end
	if not queries.get_query(file_type, "textobjects") then
		query = nil
		vim.api.nvim_echo({ { "no textobjects query found", "WarningMsg" } }, true, {})
		return
	end
	local var = vim.fn.input("New var: ")
	if var == "" then
		vim.api.nvim_echo({ { "empty var", "WarningMsg" } }, true, {})
		return
	end
	cmd = string.format(":lua require'nvim-treesitter.textobjects.select'.select_textobject('@parameter.inner')")

	vim.cmd(cmd)
	vim.cmd('normal! "zy')
	vim.cmd(cmd)
	--replace selected text with new var
	vim.cmd("normal! d")
	vim.cmd("normal! i" .. var)
	--
	local stored = vim.fn.getreg("z")
	if file_type == "go" then
		newinfo = string.format("%s := %s ", var, stored)
	elseif file_type == "lua" then
		newinfo = string.format("%s = %s ", var, stored)
	end
	vim.fn.setreg("z", newinfo)
	-- put new content before current line
	-- maybe include linebreak
	-- input abc and backspace 3 times
	vim.cmd("normal! O ")

	vim.cmd('normal! "zp')
end

vim.keymap.set("n", "<Leader>ev", ":lua etract_value()<CR>", { noremap = true, silent = true })
