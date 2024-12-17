return {
	{
		"hrsh7th/vim-vsnip-integ",
		event = "InsertEnter",
	},
	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip.loaders.from_vscode").load({
				include = { "norg", "c", "go", "python", "sh", "json", "lua", "gitcommit", "sql", "markdown" },
			})
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.expand("~/.config/nvim/my_snippets") } })
			require("luasnip.loaders.from_snipmate").lazy_load({
				paths = { vim.fn.expand("~/.config/nvim/my_snippets") },
			})

			local ls = require("luasnip")
			vim.keymap.set({ "i", "s" }, "<C-L>", function()
				ls.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-H>", function()
				ls.jump(-1)
			end, { silent = true })
			local ls = require("luasnip")
			vim.api.nvim_create_autocmd("CursorMovedI", {
				pattern = "*",
				callback = function(ev)
					if not ls.session or not ls.session.current_nodes[ev.buf] or ls.session.jump_active then
						return
					end

					local current_node = ls.session.current_nodes[ev.buf]
					local current_start, current_end = current_node:get_buf_position()
					current_start[1] = current_start[1] + 1 -- (1, 0) indexed
					current_end[1] = current_end[1] + 1 -- (1, 0) indexed
					local cursor = vim.api.nvim_win_get_cursor(0)

					if
						cursor[1] < current_start[1]
						or cursor[1] > current_end[1]
						or cursor[2] < current_start[2]
						or cursor[2] > current_end[2]
					then
						ls.unlink_current()
					end
				end,
			})
		end,

		event = "InsertEnter",
	},
}
