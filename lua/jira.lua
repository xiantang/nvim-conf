secret = require("secret")
local source = {
	config = {},
	filetypes = {},
	cache = {},
}

source.new = function(overrides)
	local self = setmetatable({}, {
		__index = source,
	})
	return self
end

function source:is_available()
	return true
end

parse_api_response = function(response)
	local ok, parsed = pcall(vim.json.decode, response)
	if not ok then
		return false, {}
	end

	if not parsed.issues then
		return false, {}
	end

	local issues = {}
	for _, issue in ipairs(parsed.issues) do
		if not issue.key then
			return false, {}
		end

		local summary_val = ""
		if issue.fields then
			if issue.fields.summary then
				summary_val = issue.fields.summary
			end
			if issue.fields.description then
				description_val = issue.fields.description
			end
		end

		table.insert(issues, {
			key = issue.key,
			summary = summary_val,
			description = description_val,
		})
	end

	return true, issues
end

local curl = require("plenary.curl")
function _G.GetItems()
	local items = {}
	out = curl.get(secret.JIRA_URL, {
		headers = {
			Authorization = secret.JIRA_AUTHORIZATION,
		},
	})
	local ok, parsed_issues = parse_api_response(out.body)
	if not ok then
		return false
	end

	for _, i in ipairs(parsed_issues) do
		table.insert(items, {
			label = i.key .. ": " .. i.summary,
			documentation = {
				kind = "markdown",
				value = i.description,
			},
			insertText = i.key,
			word = i.key,
		})
	end

	return items
end

function source:complete(_, callback)
	local items = {}
	local bufnr = vim.api.nvim_get_current_buf()
	if self.cache[bufnr] then
		callback({ items = self.cache[bufnr] })
		return true
	end
	items = _G.GetItems()
	self.cache[bufnr] = items
	callback({ items = items })
	return true
end

return source
