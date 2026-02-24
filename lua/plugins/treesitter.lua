return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
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

			-- New API: setup only accepts install_dir
			require("nvim-treesitter").setup({})

			-- Auto-install parsers (async, no blocking)
			require("nvim-treesitter").install(enabled)

			-- Enable treesitter highlighting for all enabled languages
			vim.api.nvim_create_autocmd("FileType", {
				pattern = enabled,
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})

			-- Custom incremental selection (uses vim.treesitter API directly)
			local function get_node_at_cursor()
				if vim.treesitter.get_node then
					return vim.treesitter.get_node()
				end
				if vim.treesitter.get_node_at_cursor then
					return vim.treesitter.get_node_at_cursor()
				end
				return nil
			end

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
					parent = get_node_at_cursor()
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

			-- Custom goto function navigation
			local function goto_function(direction)
				local ts = vim.treesitter
				local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
				local lang = vim.treesitter.language.get_lang(filetype) or filetype

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
		branch = "main",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
				},
				move = {
					set_jumps = true,
				},
			})

			-- Select keymaps
			vim.keymap.set({ "x", "o" }, "af", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
			end, { desc = "Select outer function" })
			vim.keymap.set({ "x", "o" }, "if", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
			end, { desc = "Select inner function" })
			vim.keymap.set({ "x", "o" }, "ia", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
			end, { desc = "Select inner parameter" })
			vim.keymap.set({ "x", "o" }, "aa", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
			end, { desc = "Select outer parameter" })

			-- Move keymaps: goto next start
			vim.keymap.set({ "n", "x", "o" }, "]m", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
			end, { desc = "Next function start" })
			vim.keymap.set({ "n", "x", "o" }, "]]", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
			end, { desc = "Next function start" })
			vim.keymap.set({ "n", "x", "o" }, "]o", function()
				require("nvim-treesitter-textobjects.move").goto_next_start(
					{ "@loop.inner", "@loop.outer" },
					"textobjects"
				)
			end, { desc = "Next loop" })
			vim.keymap.set({ "n", "x", "o" }, "]s", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
			end, { desc = "Next scope" })
			vim.keymap.set({ "n", "x", "o" }, "]z", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
			end, { desc = "Next fold" })

			-- Move keymaps: goto next end
			vim.keymap.set({ "n", "x", "o" }, "]M", function()
				require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
			end, { desc = "Next function end" })
			vim.keymap.set({ "n", "x", "o" }, "][", function()
				require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
			end, { desc = "Next class end" })

			-- Move keymaps: goto previous start
			vim.keymap.set({ "n", "x", "o" }, "[[", function()
				require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
			end, { desc = "Previous function start" })

			-- Move keymaps: goto previous end
			vim.keymap.set({ "n", "x", "o" }, "[M", function()
				require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
			end, { desc = "Previous function end" })
			vim.keymap.set({ "n", "x", "o" }, "[]", function()
				require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
			end, { desc = "Previous class end" })

			-- Move keymaps: goto next/previous (closest start or end)
			vim.keymap.set({ "n", "x", "o" }, "]d", function()
				require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
			end, { desc = "Next conditional" })
			vim.keymap.set({ "n", "x", "o" }, "[d", function()
				require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
			end, { desc = "Previous conditional" })
		end,
	},
}
