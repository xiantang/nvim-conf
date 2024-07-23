local M = {}
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local from_entry = require("telescope.from_entry")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local Path = require("plenary.path")

M.bookmarks = {}
M.extmarks = {}
M.namespace = vim.api.nvim_create_namespace("bookmarks")

local function get_bookmark_file()
	local project_root = vim.fn.getcwd()
	local project_name = vim.fn.fnamemodify(project_root, ":t")
	local cache_dir = vim.fn.stdpath("cache")
	return Path:new(cache_dir, "nvim_bookmarks", project_name .. "_bookmarks.json")
end

local function save_bookmarks()
	local bookmark_file = get_bookmark_file()
	bookmark_file:parent():mkdir({ parents = true, exists_ok = true })
	bookmark_file:write(vim.fn.json_encode(M.bookmarks), "w")
end

local function load_bookmarks()
	local bookmark_file = get_bookmark_file()
	if bookmark_file:exists() then
		local content = bookmark_file:read()
		M.bookmarks = vim.fn.json_decode(content)
	else
		M.bookmarks = {}
	end
end

local function set_extmark(bufnr, line, note)
	local id = vim.api.nvim_buf_set_extmark(bufnr, M.namespace, line - 1, -1, {
		virt_text = { { "🔖 " .. note, "Comment" } },
		virt_text_pos = "eol",
	})
	table.insert(M.extmarks, { id = id, bufnr = bufnr })
end

local function update_virtual_text()
	-- 清除所有旧的 extmarks
	for _, extmark in pairs(M.extmarks) do
		pcall(vim.api.nvim_buf_del_extmark, extmark.bufnr, M.namespace, extmark.id)
	end
	M.extmarks = {}

	-- 为每个打开的缓冲区添加新的 virtual text
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local file = vim.api.nvim_buf_get_name(buf)
			for _, bookmark in pairs(M.bookmarks) do
				if bookmark.file == file then
					set_extmark(buf, bookmark.line, bookmark.note)
				end
			end
		end
	end
end

function M.toggle_bookmark()
	load_bookmarks()
	local file = vim.fn.expand("%:p")
	local line = vim.fn.line(".")
	local key = file .. ":" .. line

	if M.bookmarks[key] then
		M.bookmarks[key] = nil
	else
		vim.ui.input({ prompt = "Enter bookmark note: " }, function(note)
			if note then
				M.bookmarks[key] = { file = file, line = line, note = note }
			end
		end)
	end
	save_bookmarks()
	update_virtual_text()
end

local bookmark_previewer = function(opts)
	return previewers.new_buffer_previewer({
		title = "Bookmark Preview",
		get_buffer_by_name = function(_, entry)
			return entry.filename
		end,
		define_preview = function(self, entry, status)
			local p = from_entry.path(entry, true)
			if p == nil or p == "" then
				return
			end
			conf.buffer_previewer_maker(p, self.state.bufnr, {
				bufname = self.state.bufname,
				winid = self.state.winid,
				callback = function(bufnr)
					local lineNumber = entry.lnum
					vim.api.nvim_buf_clear_namespace(bufnr, -1, 0, -1)
					vim.api.nvim_buf_add_highlight(bufnr, -1, "TelescopePreviewLine", lineNumber - 1, 0, -1)
					vim.api.nvim_win_set_cursor(self.state.winid, { lineNumber, 0 })
					vim.api.nvim_win_call(self.state.winid, function()
						vim.cmd("normal! zz")
					end)
				end,
			})
		end,
	})
end

function M.apply_buffer_virtual_text()
	for _, extmark in pairs(M.extmarks) do
		pcall(vim.api.nvim_buf_del_extmark, extmark.bufnr, M.namespace, extmark.id)
	end

	local current_file = vim.fn.expand("%:p")
	local bufnr = vim.api.nvim_get_current_buf()

	-- 获取当前缓冲区的所有 extmarks
	local existing_extmarks = vim.api.nvim_buf_get_extmarks(bufnr, M.namespace, 0, -1, { details = true })
	local extmark_lines = {}

	-- 创建一个查找表，用于快速检查行是否已有 extmark
	for _, extmark in ipairs(existing_extmarks) do
		extmark_lines[extmark[2] + 1] = true -- extmark 行号从 0 开始，所以要 +1
	end

	for _, bookmark in pairs(M.bookmarks) do
		if bookmark.file == current_file then
			-- 检查该行是否已经有 extmark
			if not extmark_lines[bookmark.line] then
				set_extmark(bufnr, bookmark.line, bookmark.note)
			end
		end
	end
end

function M.list_bookmarks()
	load_bookmarks()
	local bookmark_list = {}
	for _, bookmark in pairs(M.bookmarks) do
		table.insert(bookmark_list, {
			file = bookmark.file,
			line = bookmark.line,
			note = bookmark.note,
			display = string.format("%s - %s:%d", bookmark.note, bookmark.file, bookmark.line),
		})
	end

	pickers
		.new({}, {
			prompt_title = "Bookmarks",
			finder = finders.new_table({
				results = bookmark_list,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.display,
						ordinal = entry.display,
						filename = entry.file,
						lnum = tonumber(entry.line),
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			previewer = bookmark_previewer(),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					vim.cmd("edit " .. selection.filename)
					vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
				end)
				return true
			end,
			layout_config = {
				width = 0.9,
				height = 0.8,
				preview_width = 0.5,
			},
			layout_strategy = "horizontal",
		})
		:find()
end

function M.setup()
	load_bookmarks()
	update_virtual_text()

	--abc
	vim.cmd([[
        augroup Bookmarks
            autocmd!
            autocmd BufRead * lua require('bookmarks').apply_buffer_virtual_text()
            autocmd BufEnter * lua require('bookmarks').apply_buffer_virtual_text()
            autocmd BufWritePost * lua require('bookmarks').apply_buffer_virtual_text()
        augroup END
    ]])

	vim.api.nvim_set_keymap(
		"n",
		"<leader>mm",
		'<cmd>lua require("bookmarks").toggle_bookmark()<CR>',
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>ml",
		'<cmd>lua require("bookmarks").list_bookmarks()<CR>',
		{ noremap = true, silent = true }
	)
end

return M
