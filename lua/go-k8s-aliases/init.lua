local source = {}

local aliases = {
	{ label = "corev1", import_path = "k8s.io/api/core/v1" },
	{ label = "appsv1", import_path = "k8s.io/api/apps/v1" },
	{ label = "batchv1", import_path = "k8s.io/api/batch/v1" },
	{ label = "networkingv1", import_path = "k8s.io/api/networking/v1" },
	{ label = "rbacv1", import_path = "k8s.io/api/rbac/v1" },
	{ label = "storagev1", import_path = "k8s.io/api/storage/v1" },
	{ label = "policyv1", import_path = "k8s.io/api/policy/v1" },
	{ label = "metav1", import_path = "k8s.io/apimachinery/pkg/apis/meta/v1" },
	{ label = "apierrors", import_path = "k8s.io/apimachinery/pkg/api/errors" },
	{ label = "apiresource", import_path = "k8s.io/apimachinery/pkg/api/resource" },
	{ label = "apilabels", import_path = "k8s.io/apimachinery/pkg/labels" },
	{ label = "ctrl", import_path = "sigs.k8s.io/controller-runtime" },
	{ label = "ctrlclient", import_path = "sigs.k8s.io/controller-runtime/pkg/client" },
	{ label = "ctrllog", import_path = "sigs.k8s.io/controller-runtime/pkg/log" },
	{ label = "ctrlutil", import_path = "sigs.k8s.io/controller-runtime/pkg/controller/controllerutil" },
	{ label = "logf", import_path = "sigs.k8s.io/controller-runtime/pkg/log" },
}

--- Scan the current buffer to find the import block and existing imports.
--- Returns:
---   import_start: 0-indexed line of `import (`
---   import_end:   0-indexed line of closing `)`
---   existing:     set of import paths already present { ["path"] = true }
---   nil if no grouped import block found
local function find_import_block(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local import_start = nil
	local import_end = nil
	local existing = {}

	for i, line in ipairs(lines) do
		local idx = i - 1 -- 0-indexed
		if not import_start then
			-- match `import (` possibly with whitespace
			if line:match("^%s*import%s*%(") then
				import_start = idx
			end
		else
			-- inside import block, look for closing )
			if line:match("^%s*%)") then
				import_end = idx
				break
			end
			-- extract existing import path (with or without alias)
			-- patterns: `"path"` or `alias "path"`
			local path = line:match('%s*[%w_]*%s*"([^"]+)"')
			if path then
				existing[path] = true
			end
		end
	end

	if import_start and import_end then
		return import_start, import_end, existing
	end

	-- check for single-line import: `import "path"` or `import alias "path"`
	for i, line in ipairs(lines) do
		local path = line:match('^%s*import%s+[%w_]*%s*"([^"]+)"')
		if path then
			return i - 1, nil, { [path] = true }
		end
	end

	return nil, nil, {}
end

--- Find the line after `package xxx` declaration (0-indexed).
local function find_package_line(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 30, false)
	for i, line in ipairs(lines) do
		if line:match("^%s*package%s+") then
			return i - 1 -- 0-indexed
		end
	end
	return 0
end

--- Build the additionalTextEdits for a given alias entry.
--- Uses LSP TextEdit format (0-indexed line/character positions).
local function make_import_edit(bufnr, entry)
	local import_start, import_end, existing = find_import_block(bufnr)
	local import_line = string.format('\t%s "%s"', entry.label, entry.import_path)

	-- already imported
	if existing[entry.import_path] then
		return nil
	end

	-- case 1: grouped import block exists → insert before closing `)`
	if import_start and import_end then
		return {
			{
				newText = import_line .. "\n",
				range = {
					start = { line = import_end, character = 0 },
					["end"] = { line = import_end, character = 0 },
				},
			},
		}
	end

	-- case 2: single-line import → replace it with a grouped block
	if import_start and not import_end then
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		local old_line = lines[import_start + 1]
		local old_alias = old_line:match('^%s*import%s+([%w_]+)%s+"')
		local old_path = old_line:match('"([^"]+)"')
		local old_import
		if old_alias and old_alias ~= "" then
			old_import = string.format('\t%s "%s"', old_alias, old_path)
		else
			old_import = string.format('\t"%s"', old_path)
		end
		local new_text = "import (\n" .. old_import .. "\n" .. import_line .. "\n)\n"
		return {
			{
				newText = new_text,
				range = {
					start = { line = import_start, character = 0 },
					["end"] = { line = import_start + 1, character = 0 },
				},
			},
		}
	end

	-- case 3: no import at all → insert after package line
	local pkg_line = find_package_line(bufnr)
	local new_text = "\nimport (\n" .. import_line .. "\n)\n"
	return {
		{
			newText = new_text,
			range = {
				start = { line = pkg_line + 1, character = 0 },
				["end"] = { line = pkg_line + 1, character = 0 },
			},
		},
	}
end

function source.new(opts)
	local self = setmetatable({}, { __index = source })
	local extra = (opts or {}).aliases or {}
	self.aliases = vim.list_extend(vim.deepcopy(aliases), extra)
	return self
end

function source:enabled()
	return vim.bo.filetype == "go"
end

function source:get_completions(ctx, callback)
	local bufnr = ctx.bufnr or vim.api.nvim_get_current_buf()
	local items = {}

	for _, entry in ipairs(self.aliases) do
		local edits = make_import_edit(bufnr, entry)
		table.insert(items, {
			label = entry.label,
			kind = require("blink.cmp.types").CompletionItemKind.Module,
			insertText = entry.label,
			detail = entry.import_path,
			documentation = {
				kind = "markdown",
				value = string.format('```go\nimport %s "%s"\n```', entry.label, entry.import_path),
			},
			sortText = "0_" .. entry.label,
			additionalTextEdits = edits,
		})
	end

	callback({
		items = items,
		is_incomplete_backward = false,
		is_incomplete_forward = false,
	})
end

return source
