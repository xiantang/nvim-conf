return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local enabled = {
				"java",
				"ruby",
				"lua",
				"vim",
				"bash",
				"go",
				"ssh_config",
				"markdown",
				"gomod",
				"gosum",
				"norg",
				"python",
				"yaml",
				"make",
				"gitignore",
				"http",
				"terraform",
				"thrift",
				"sql",
				"json",
			}
			-- local path = "/usr/local/lib/nvim/parser"
			-- vim.opt.runtimepath:append(path)

			require("nvim-treesitter.configs").setup({
				-- parser_install_dir = path,

				-- will cause panic so I disable it
				incremental_selection = {
					enable = false,
					keymaps = {
						init_selection = true,
						node_incremental = "v",
						node_decremental = "<BS>",
					},
				},
				ensure_installed = enabled,
				highlight = {
					enable = true,
				},
			})

			local ts_utils = require("nvim-treesitter.ts_utils")

			local node_list = {}
			local current_index = nil

			function start_select()
				node_list = {}
				current_index = nil
				current_index = 1
				vim.cmd("normal! v")
			end

			function find_expand_node(node)
				local start_row, start_col, end_row, end_col = node:range()
				local parent = node:parent()
				if parent == nil then
					return nil
				end
				local parent_start_row, parent_start_col, parent_end_row, parent_end_col = parent:range()
				if
					start_row == parent_start_row
					and start_col == parent_start_col
					and end_row == parent_end_row
					and end_col == parent_end_col
				then
					return find_expand_node(parent)
				end
				return parent
			end

			function select_parent_node()
				if current_index == nil then
					return
				end

				local node = node_list[current_index - 1]
				local parent = nil
				if node == nil then
					parent = ts_utils.get_node_at_cursor()
				else
					parent = find_expand_node(node)
				end
				if not parent then
					vim.cmd("normal! gv")
					return
				end

				table.insert(node_list, parent)
				current_index = current_index + 1
				local start_row, start_col, end_row, end_col = parent:range()
				vim.fn.setpos(".", { 0, start_row + 1, start_col + 1, 0 })
				vim.cmd("normal! v")
				vim.fn.setpos(".", { 0, end_row + 1, end_col, 0 })
			end

			function restore_last_selection()
				if not current_index or current_index <= 1 then
					return
				end

				current_index = current_index - 1
				local node = node_list[current_index]
				local start_row, start_col, end_row, end_col = node:range()
				vim.fn.setpos(".", { 0, start_row + 1, start_col + 1, 0 })
				vim.cmd("normal! v")
				vim.fn.setpos(".", { 0, end_row + 1, end_col, 0 })
			end

			vim.api.nvim_set_keymap("n", "v", ":lua start_select()<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("v", "v", ":lua select_parent_node()<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("v", "<BS>", ":lua restore_last_selection()<CR>", { noremap = true, silent = true })

			require("nvim-treesitter.configs").setup({
				-- parser_install_dir = "/opt/homebrew/Cellar/neovim/0.9.2/lib/nvim/parser",
				textobjects = {
					select = {
						enable = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ia"] = "@parameter.inner",
							["aa"] = "@parameter.outer",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@function.outer", desc = "Next class start" },
							--
							-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
							["]o"] = "@loop.*",
							-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
							--
							-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
							-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[["] = "@function.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
						-- Below will go to either the start or the end, whichever is closer.
						-- Use if you want more granular movements
						-- Make it even more gradual by adding multiple queries and regex.
						goto_next = {
							["]d"] = "@conditional.outer",
						},
						goto_previous = {
							["[d"] = "@conditional.outer",
						},
					},
				},
			})
			local function goto_function(direction)
				local ts = vim.treesitter
				local queries = require("nvim-treesitter.query")
				local filetype = vim.api.nvim_buf_get_option(0, "ft")
				local lang = require("nvim-treesitter.parsers").ft_to_lang(filetype)

				-- Define Treesitter query
				local go_query = [[
        (function_declaration
            name: (identifier) @function_name)
        (method_declaration
            name: (field_identifier) @function_name)
    ]]
				local query = [[
        (function_declaration
            name: (identifier) @function_name)
    ]]

				-- Get current buffer's Treesitter syntax tree
				local parser = ts.get_parser(0, lang)
				if not parser then
					return
				end

				local tree = parser:parse()[1]
				if not tree then
					return
				end

				local root = tree:root()
				if not root then
					return
				end

				-- Get query object
				if lang == "go" then
					query = go_query
				end
				local query_obj = vim.treesitter.query.parse(lang, query)
				if not query_obj then
					return
				end

				-- Execute query
				local matches = {}
				for id, node in query_obj:iter_captures(root, 0) do
					local name = query_obj.captures[id]
					if name == "function_name" and node then
						-- Check if the node has a valid range
						local ok, _ = pcall(function()
							return node:range()
						end)
						if ok then
							table.insert(matches, node)
						end
					end
				end

				-- If matches found, move cursor to function name
				if #matches > 0 then
					local closest_function = nil
					local closest_distance = nil
					local row, col = unpack(vim.api.nvim_win_get_cursor(0))
					row = row - 1 -- Convert to 0-indexed

					for _, function_name_node in ipairs(matches) do
						local ok, sr, sc = pcall(function()
							local start_row, start_col, _, _ = function_name_node:range()
							return start_row, start_col
						end)

						if ok and sr ~= nil then
							local distance = math.abs(sr - row)

							if direction == "prev" and (sr < row or (sr == row and sc < col)) then
								if closest_distance == nil or distance < closest_distance then
									closest_distance = distance
									closest_function = function_name_node
								end
							elseif direction == "next" and (sr > row or (sr == row and sc > col)) then
								if closest_distance == nil or distance < closest_distance then
									closest_distance = distance
									closest_function = function_name_node
								end
							end
						end
					end

					if closest_function then
						local ok, sr, sc = pcall(function()
							local start_row, start_col, _, _ = closest_function:range()
							return start_row, start_col
						end)

						if ok and sr ~= nil then
							vim.cmd("normal! m`")
							vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
							vim.api.nvim_feedkeys("zz", "n", false)
						end
					end
				end
			end

			local function goto_prev_function()
				goto_function("prev")
			end

			local function goto_next_function()
				goto_function("next")
			end

			-- 绑定键映射
			vim.keymap.set("n", "[f", goto_prev_function, { noremap = true, silent = true })
			vim.keymap.set("n", "]f", goto_next_function, { noremap = true, silent = true })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function() end,
	},
}
