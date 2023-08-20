-- Custom nvim-cmp source for GitHub handles.

local handles = {}

local registered = false

keywords = {
	go = {
		"package",
		"import",
		"func",
		"var",
		"const",
		"type",
		"struct",
		"interface",
		"defer",
		"go",
		"select",
		"if",
		"else",
		"switch",
		"case",
		"default",
		"for",
		"range",
		"break",
		"continue",
		"return",
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
		for _, address in pairs(keywords[filetype]) do
			table.insert(items, {
				label = address,
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
