return {
	{
		event = { "InsertEnter", "BufEnter" },
		"keaising/im-select.nvim",
		config = function()
			require("im_select").setup({
				-- IM will be set to `default_im_select` in `normal` mode(`EnterVim` or `InsertLeave`)
				-- For Windows/WSL, default: "1033", aka: English US Keyboard
				-- For macOS, default: "com.apple.keylayout.ABC", aka: US
				-- You can use `im-select` in cli to get the IM name of you preferred
				default_im_select = "com.apple.keylayout.ABC",
				-- Set to 1 if you don't want restore IM status when `InsertEnter`
				keep_quiet_on_no_binary = true,
				disable_auto_restore = 0,
			})
			-- check is macos
			if vim.fn.has("mac") == 1 then
				local function all_trim(s)
					return s:match("^%s*(.-)%s*$")
				end
				vim.api.nvim_create_autocmd({ "InsertEnter", "FocusGained" }, {
					callback = function()
						local default_im_select = "com.apple.keylayout.ABC"
						local current_select = all_trim(vim.fn.system({ "im-select" }))
						if current_select ~= default_im_select then
							vim.fn.system({ "im-select", default_im_select })
						end
					end,
				})
			else
				local function all_trim(s)
					return s:match("^%s*(.-)%s*$")
				end
				local function run_shell_command(command)
					local handle = io.popen(command)
					local result = handle:read("*a")
					handle:close()
					return result
				end
				vim.api.nvim_create_autocmd({ "InsertEnter", "FocusGained" }, {
					callback = function()
						local default_im_select = "com.apple.keylayout.ABC"
						local current_select = all_trim(run_shell_command("sudo mac im-select"))
						if current_select ~= default_im_select then
							run_shell_command("sudo mac im-select " .. default_im_select)
						end
					end,
				})
			end
		end,
	},
}
