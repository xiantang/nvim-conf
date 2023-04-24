return {
	event = "VeryLazy",
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "ofseed/lualine-copilot" },
	},
	config = function()
		local colors = {
			white = "#abb2bf",
			bg = "#202328",
			fg = "#bbc2cf",
			yellow = "#ECBE7B",
			cyan = "#008080",
			darkblue = "#081633",
			green = "#98be65",
			orange = "#FF8800",
			violet = "#a9a1e1",
			magenta = "#c678dd",
			blue = "#51afef",
			red = "#ec5f67",
			grey = "#3e4452",
		}
		local ok, lazy_status = pcall(require, "lazy.status")
		if not ok then
			vim.notify("Could not load lazy.status")
			return
		end
		local function indent()
			if vim.o.expandtab then
				return "SW:" .. vim.o.shiftwidth
			else
				return "TS:" .. vim.o.tabstop
			end
		end
		local function lsp()
			local clients = vim.lsp.buf_get_clients()
			if #clients == 0 then
				return ""
			end
			local names = {}
			local ignored = { "null-ls", "copilot" }
			for _, client in ipairs(clients) do
				if not vim.tbl_contains(ignored, client.name) then
					table.insert(names, client.name)
				end
			end
			local msg = table.concat(names, ", ")
			if msg == "" then
				return ""
			else
				return " " .. msg
			end
		end
		require("lualine").setup({
			sections = {
				lualine_c = {
					lsp,
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					"copilot",
					"filetype",
					indent,
					"encoding",
					"fileformat",
				},
			},
			options = {
				theme = {
					normal = {
						a = { fg = "#F8F8F2", bg = "#6272A4", gui = "bold" },
						b = { fg = "#F8F8F2", bg = "#6272A4" },
						c = { fg = "#F8F8F2", bg = "#6272A4" },
					},
					insert = {
						a = { fg = "#F8F8F2", bg = "#6272A4", gui = "bold" },
						b = { fg = "#F8F8F2", bg = "#6272A4" },
						c = { fg = "#F8F8F2", bg = "#6272A4" },
					},
					visual = {
						a = { fg = "#F8F8F2", bg = "#6272A4", gui = "bold" },
						b = { fg = "#F8F8F2", bg = "#6272A4" },
						c = { fg = "#F8F8F2", bg = "#6272A4" },
					},
					replace = {
						a = { fg = "#F8F8F2", bg = "#6272A4", gui = "bold" },
						b = { fg = "#F8F8F2", bg = "#6272A4" },
						c = { fg = "#F8F8F2", bg = "#6272A4" },
					},
					command = {
						a = { fg = "#F8F8F2", bg = "#6272A4", gui = "bold" },
						b = { fg = "#F8F8F2", bg = "#6272A4" },
						c = { fg = "#F8F8F2", bg = "#6272A4" },
					},
					inactive = {
						a = { fg = "#F8F8F2", bg = "#44475A", gui = "bold" },
						b = { fg = "#F8F8F2", bg = "#44475A" },
						c = { fg = "#F8F8F2", bg = "#44475A" },
					},
				},
			},
		})
	end,
}
