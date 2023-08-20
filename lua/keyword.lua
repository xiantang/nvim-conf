-- Custom nvim-cmp source for GitHub handles.

local handles = {}

local registered = false

local keywords = {
	go = {
		"if",
		"for",
	},
	lua = {
		"and",
		"break",
		"do",
		"else",
		"elseif",
		"end",
		"false",
		"for",
		"function",
		"if",
		"in",
		"local",
		"nil",
		"not",
		"or",
		"repeat",
		"return",
		"then",
		"true",
		"until",
		"while",
	},
}

handles.setup = function()
	if registered then
		return
	end
	registered = true

	local has_cmp, cmp = pcall(require, "cmp")

	if not has_cmp then
		return
	end

	local source = {}

	source.new = function()
		return setmetatable({}, { __index = source })
	end

	source.complete = function(self, request, callback)
		local filetype = vim.api.nvim_buf_get_option(0, "filetype")
		local input = string.sub(request.context.cursor_before_line, request.offset - 1)
		local prefix = string.sub(request.context.cursor_before_line, 1, request.offset - 1)

		local items = {}
		local lang = keywords[filetype]
		if lang == nil then
			return
		end
		for _, keyword in pairs(lang) do
			table.insert(items, {
				label = keyword,
				kind = cmp.lsp.CompletionItemKind.Keyword,
			})
		end
		callback({
			items = items,
			isIncomplete = true,
		})
	end

	cmp.register_source("keyword", source.new())
end

return handles
