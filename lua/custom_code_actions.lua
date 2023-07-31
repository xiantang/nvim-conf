local null_ls = require("null-ls")
local vim = vim

local parsers = require("nvim-treesitter.parsers")

-- use treesitter to find the start of the current function
local ts_utils = require("nvim-treesitter.ts_utils")

function get_function_start()
	local current_node = ts_utils.get_node_at_cursor()
	if not current_node then
		return ""
	end
	local expr = current_node

	while expr do
		if expr:type() == "function_definition" or expr:type() == "function_declaration" then
			break
		end
		expr = expr:parent()
	end

	if not expr then
		return ""
	end

	local start_row, _, _ = expr:range()
	return start_row
end

local fix_undefine_function = {
	method = null_ls.methods.CODE_ACTION,
	filetypes = { "go" },
	generator = {
		fn = function(context)
			local content = context.content
			if not content then
				return
			end
			if context.lsp_params.context.only ~= nil then
				return
			end

			local row = vim.api.nvim_win_get_cursor(0)[1]
			local line = content[row]

			-- match function signature
			local func_name, func_params = line:match("(%w+)%s*%((.*)%)")
			if func_name and func_params then
				-- prepare new function template
				local new_func =
					string.format("func %s(%s) {\n\t// TODO: implement this function\n}", func_name, func_params)

				local new_func_lines = {}
				for s in new_func:gmatch("[^\r\n]+") do
					table.insert(new_func_lines, s)
				end

				-- return code action
				return {
					{
						title = string.format("Implement function '%s'", func_name),
						action = function()
							-- use tree-sitter to find function start
							-- put before current function
							local func_start = get_function_start(row)
							vim.api.nvim_buf_set_lines(0, func_start, func_start, false, new_func_lines)
						end,
					},
				}
			end
		end,
	},
}

null_ls.register(fix_undefine_function)
