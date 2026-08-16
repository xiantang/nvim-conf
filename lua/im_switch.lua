-- Input method switching.
--
-- keaising/im-select.nvim no longer works here: on Linux its setup() bails out
-- unless fcitx/ibus is installed, and on macOS it now shells out to `macism`
-- instead of `im-select`. Neither applies to this setup, where nvim runs inside
-- the OrbStack VM and reaches the host's `im-select` through the `mac` shim.
--
-- Behaviour: remember the input method on InsertLeave and fall back to US ASCII,
-- then restore the remembered one on InsertEnter. Every call is async so a
-- round-trip to the host (~60ms) never blocks the editor.

local M = {}

local DEFAULT_IM = "com.apple.keylayout.ABC"

-- Resolve how to reach `im-select`, or nil when it is not reachable at all.
local function resolve_cmd()
	if vim.fn.has("mac") == 1 then
		if vim.fn.executable("im-select") == 1 then
			return { "im-select" }
		end
		return nil
	end
	if vim.fn.executable("mac") == 1 then
		return { "mac", "im-select" }
	end
	return nil
end

local cmd = resolve_cmd()
local saved = DEFAULT_IM

local function query(on_done)
	vim.system(cmd, { text = true }, function(res)
		if res.code ~= 0 then
			return
		end
		vim.schedule(function()
			on_done(vim.trim(res.stdout))
		end)
	end)
end

local function switch(method)
	local argv = vim.list_extend(vim.list_slice(cmd, 1, #cmd), { method })
	vim.system(argv, { text = true })
end

function M.setup()
	if not cmd then
		return
	end

	local group = vim.api.nvim_create_augroup("im_switch", { clear = true })

	vim.api.nvim_create_autocmd("InsertLeave", {
		group = group,
		callback = function()
			query(function(current)
				saved = current
				if current ~= DEFAULT_IM then
					switch(DEFAULT_IM)
				end
			end)
		end,
	})

	vim.api.nvim_create_autocmd("InsertEnter", {
		group = group,
		callback = function()
			if saved ~= DEFAULT_IM then
				switch(saved)
			end
		end,
	})

	-- Coming back to a window sitting in normal mode should always be ASCII;
	-- whatever was used in the other app is not worth remembering.
	vim.api.nvim_create_autocmd("FocusGained", {
		group = group,
		callback = function()
			if vim.fn.mode():find("i") then
				return
			end
			query(function(current)
				if current ~= DEFAULT_IM then
					switch(DEFAULT_IM)
				end
			end)
		end,
	})
end

return M
