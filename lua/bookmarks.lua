local M = {}
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local from_entry = require("telescope.from_entry")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local Path = require("plenary.path")

-- 存储书签的表
M.bookmarks = {}
-- 存储 extmark 的表
M.extmarks = {}
-- 创建 namespace
M.namespace = vim.api.nvim_create_namespace("bookmarks")

-- 获取当前项目的根目录
local function get_project_root()
	local current_file = vim.fn.expand("%:p")
	local current_dir = vim.fn.fnamemodify(current_file, ":h")
	local git_dir = vim.fn.finddir(".git", current_dir .. ";")
	return git_dir and vim.fn.fnamemodify(git_dir, ":h") or current_dir
end

-- 获取书签文件路径
local function get_bookmark_file()
	local project_root = get_project_root()
	local project_name = vim.fn.fnamemodify(project_root, ":t")
	local cache_dir = vim.fn.stdpath("cache")
	return Path:new(cache_dir, "nvim_bookmarks", project_name .. "_bookmarks.json")
end

-- 保存书签到文件
local function save_bookmarks()
	local bookmark_file = get_bookmark_file()
	bookmark_file:parent():mkdir({ parents = true, exists_ok = true })
	bookmark_file:write(vim.fn.json_encode(M.bookmarks), "w")
end

-- 从文件加载书签
local function load_bookmarks()
	local bookmark_file = get_bookmark_file()
	if bookmark_file:exists() then
		local content = bookmark_file:read()
		M.bookmarks = vim.fn.json_decode(content)
	else
		M.bookmarks = {}
	end
end

-- 更新 virtual text
local function update_virtual_text()
	-- 清除所有旧的 extmarks
	for _, extmark in pairs(M.extmarks) do
		vim.api.nvim_buf_del_extmark(extmark.bufnr, M.namespace, extmark.id)
	end
	M.extmarks = {}

	-- 为每个书签添加新的 virtual text
	for key, bookmark in pairs(M.bookmarks) do
		local bufnr = vim.fn.bufnr(bookmark.file)
		if bufnr ~= -1 then
			local id = vim.api.nvim_buf_set_extmark(bufnr, M.namespace, bookmark.line - 1, -1, {
				virt_text = { { "🔖 " .. bookmark.note, "Comment" } },
				virt_text_pos = "eol",
			})
			table.insert(M.extmarks, { id = id, bufnr = bufnr })
		end
	end
end

-- 添加或删除书签
function M.toggle_bookmark()
	load_bookmarks()
	local file = vim.fn.expand("%:p")
	local line = vim.fn.line(".")
	local key = file .. ":" .. line

	if M.bookmarks[key] then
		-- 如果书签存在，删除它
		M.bookmarks[key] = nil
		save_bookmarks()
		update_virtual_text()
	else
		-- 如果书签不存在，添加它
		vim.ui.input({ prompt = "Enter bookmark note: " }, function(note)
			if note then
				M.bookmarks[key] = { file = file, line = line, note = note }
				save_bookmarks()
				update_virtual_text()
			end
		end)
	end
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
					-- 读取文件内容
					local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
					-- 设置光标位置到目标行
					vim.api.nvim_win_set_cursor(self.state.winid, { lineNumber, 0 })
					-- 高亮目标行
					vim.api.nvim_buf_add_highlight(bufnr, -1, "TelescopePreviewLine", lineNumber - 1, 0, -1)
					-- 确保目标行在预览窗口的中间
					vim.api.nvim_win_call(self.state.winid, function()
						vim.cmd("normal! zz")
					end)
				end,
			})
		end,
	})
end

function M.list_bookmarks()
	load_bookmarks()
	local bookmark_list = {}
	for _, bookmark in pairs(M.bookmarks) do
		table.insert(bookmark_list, {
			file = bookmark.file,
			line = bookmark.line,
			note = bookmark.note,
			display = string.format("%s:%d - %s", bookmark.file, bookmark.line, bookmark.note),
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
						lnum = entry.line,
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

-- 初始化
function M.setup()
	load_bookmarks()
	update_virtual_text()

	-- 设置自动命令以在缓冲区更改时更新 virtual text
	vim.cmd([[
        augroup Bookmarks
            autocmd!
            autocmd BufEnter * lua require('bookmarks').update_virtual_text()
        augroup END
    ]])
end

-- 设置键映射
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

-- 导出 update_virtual_text 函数
M.update_virtual_text = update_virtual_text

return M
