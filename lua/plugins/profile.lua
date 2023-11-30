return {
	{ "dstein64/vim-startuptime", cmd = "StartupTime" },
	{
		"stevearc/profile.nvim",
		cmd = "Profile",
		config = function()
			-- override variable  as white
			-- for method caller
			local function toggle_profile()
				local prof = require("profile")
				if prof.is_recording() then
					prof.stop()
					local filename = ".profile.json"
					prof.export(filename)
					vim.notify(string.format("Wrote %s", filename))
				else
					prof.start("*")
				end
			end
			vim.api.nvim_create_user_command("Profile", function()
				toggle_profile()
			end, {})
		end,
	},
}
