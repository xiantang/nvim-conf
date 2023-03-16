-- vim.cmd([[
-- set softtabstop=4
-- set tabstop=4
-- set shiftwidth=4
-- set expandtab
-- set smartindent
-- ]])
local opt = { noremap = true, silent = true }
vim.keymap.set("n", "j", "gj", opt)
vim.keymap.set("n", "k", "gk", opt)
vim.keymap.set("n", "o", "o", opt)
-- You can even bind it to search jumping and more, example:
vim.api.nvim_set_keymap("n", "n", 'n:lua require("specs").show_specs()<CR>', opt)
vim.api.nvim_set_keymap("n", "N", 'N:lua require("specs").show_specs()<CR>', opt)
vim.keymap.set("n", "c", "c", opt)
vim.keymap.set("n", "r", "r", opt)
vim.keymap.set("n", "q", "q", opt)
-- vim.keymap.set("n", "n ", "nzzzv")
-- vim.keymap.set("n", "N ", "Nzzzv")
if vim.g.neovide then
	vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>", opt)
	vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>", opt)
	vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>", opt)
	vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>", opt)
	vim.keymap.set("n", "<C-d>", "<C-d>zz", opt)
	vim.keymap.set("n", "<C-u>", "<C-u>zz", opt)
else
	vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>:lua require('specs').show_specs()<CR>", opt)
	vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>:lua require('specs').show_specs()<CR>", opt)
	vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>:lua require('specs').show_specs()<CR>", opt)
	vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>:lua require('specs').show_specs()<CR>", opt)
	vim.keymap.set("n", "<C-d>", "<C-d>zz:lua require('specs').show_specs()<CR>", opt)
	vim.keymap.set("n", "<C-u>", "<C-u>zz:lua require('specs').show_specs()<CR>", opt)
end
-- vim.api.nvim_set_keymap("n", "m", "mM", { silent = true })
-- vim.api.nvim_set_keymap("n", "M", "`M", { silent = true })
vim.keymap.set("n", "<C-Left>", ":vertical resize +5<CR>", {})
vim.keymap.set("n", "<C-Right>", ":vertical resize -5<CR>", {})
vim.keymap.set("n", "<C-Up>", ":resize +5<CR>", {})

-- termkey
vim.keymap.set("n", "<C-;>", "<Cmd>exe v:count1 . 'ToggleTerm'<CR>", opt)
vim.keymap.set("t", "<C-;>", "<C-\\><C-n><Cmd>exe v:count1 . 'ToggleTerm'<CR>", opt)
vim.keymap.set("n", "<C-Down>", ":resize -5<CR>", {})
vim.keymap.set("n", "0", "^", {})
vim.keymap.set("n", "<Leader>q", ":wq<CR>", {})
vim.keymap.set("n", "<Leader>gs", ":Git<CR>", {})
vim.keymap.set("n", "<Leader>gb", ":Git blame<CR>", {})
vim.keymap.set("n", "<Leader>ss", ":source ~/.config/nvim/init.vim<CR>", {})
vim.keymap.set("n", "<Leader>s", ":sp<CR>", { desc = "[S]plit window" })
vim.keymap.set("n", "<Leader>v", ":vsp<CR>", { desc = "[V]ertically [S]plit window" })
vim.keymap.set("n", "<Leader>w", ":w<CR>", {})
vim.keymap.set("n", " <Leader>r", ":GoRename<CR>", {})
vim.keymap.set("n", "<Leader>rt", ":GoRunTestFunc<CR>", {})
vim.keymap.set("n", "<Leader>rf", ":GoRunTestFile<CR>", {})
vim.keymap.set("n", "<Leader>de", ':lua require"dap".toggle_breakpoint()<CR>', {})
vim.keymap.set("n", "<Leader>ut", ":UndotreeToggle<CR>", {})
vim.keymap.set("n", "tt", ":GenReturn<CR>0", {})
vim.keymap.set("n", "K", "k", {})
vim.keymap.set("n", "<Leader>p", ":Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>", {})
vim.api.nvim_set_keymap("n", "<space>fb", ":Telescope file_browser<CR>", opt)
vim.keymap.set("n", "<Leader>P", ":Telescope live_grep<CR>", {})
vim.keymap.set("n", "<Leader>Q", ':lua require("start").Stop()<CR>', {})
vim.keymap.set("", "s", [[<Cmd>lua require('hop').hint_words()<CR>]], {})
vim.keymap.set("n", "gs", ":HopWordMW<CR>", {})

vim.cmd([[
"ctrl A to  move to line start when in command mode like in iterm2
"ctrl E to move to line end when in command mode like in iterm2
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
inoremap <D-v> <c-r>+
nnoremap <D-v> "+p
cnoremap <D-v> <c-r>+
]])

vim.keymap.set("n", "<C-q>", ":Telescope oldfiles<CR>", {})
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

project_picker = function(opts)
	local bookmarks = vim.fn.readfile(vim.env.HOME .. "/.NERDTreeBookmarks")
	local choices = {}

	for i, bookmark in ipairs(bookmarks) do
		local path = vim.split(bookmark, " ")[2]
		if path ~= nil then
			table.insert(choices, path)
		end
	end
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "Jump Between Projects",
			finder = finders.new_table({
				results = choices,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					-- print(vim.inspect(selection))
					require("telescope.builtin").find_files({
						-- exclude png files
						file_ignore_patterns = { "*.png", "*.ttf", ".git" },
						search_dirs = { selection.value },
						-- show hidden files
						hidden = true,
						attach_mappings = function(prompt_bufnr, map)
							actions.select_default:replace(function()
								actions.close(prompt_bufnr)
								local selection = action_state.get_selected_entry()
								-- print(vim.inspect(selection))
								vim.cmd("e " .. selection.value)
								vim.cmd("NerdSmartLocated")
								vim.cmd("wincmd p")
							end)
							return true
						end,
					})
				end)
				return true
			end,
		})
		:find()
end

-- to execute the function
-- bind to a key
vim.keymap.set("n", "<C-e>", ":lua project_picker(require('telescope.themes').get_dropdown{})<CR>", { silent = true })
vim.cmd([[
nnoremap <Leader>[  <C-O>
nnoremap <Leader>]  <C-I>
nnoremap <leader>sv :source $MYVIMRC<CR>
tnoremap <D-v> <C-\><C-n>"+p
tnoremap <Esc> <C-\><C-n>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
]])

vim.keymap.set("n", "gd", function()
	if require("obsidian").util.cursor_on_markdown_link() then
		return "<cmd>ObsidianFollowLink<CR>"
	else
		return "gd"
	end
end, opt)

vim.keymap.set("n", "<Leader>gr", function()
	if require("obsidian").util.cursor_on_markdown_link() then
		return "<cmd>ObsidianCursorBacklinks<CR>"
	else
		return "<cmd>ObsidianBacklinks<CR>"
	end
end, { noremap = false, expr = true })

local function t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_ctrl_e()
	local ret = vim.api.nvim_eval("copilot#GetDisplayedSuggestion()")
	if ret.text ~= "" then
		return ret.text
	else
		return t("<esc>A")
	end
end

vim.keymap.set("i", "<C-e>", "v:lua.smart_ctrl_e()", { expr = true, noremap = true, replace_keycodes = false })
vim.keymap.set("i", "<C-a>", "<esc>I", { noremap = true })
