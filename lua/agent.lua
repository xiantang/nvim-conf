-- Bridge to a coding agent (claude / codex) running in a tmux pane next to nvim.
--
-- Sends `@path:line` references into the agent's prompt without pressing Enter,
-- then focuses that pane so the request can be finished there. Also reloads
-- buffers the agent changed on disk when coming back to nvim.
--
-- The agent pane is looked up in nvim's own tmux window: first a pane tagged
-- with `@agent` (set by project_layout in ~/.config/lib/tmux.sh), otherwise a
-- pane running claude or codex. Claude reports its version as the pane's
-- current command, and tmux-resurrect drops pane options, hence the fallback.

local M = {}

local AGENT_COMMANDS = { claude = true, codex = true }

local function tmux(args)
	local res = vim.system(vim.list_extend({ "tmux" }, args), { text = true }):wait()
	if res.code ~= 0 then
		return nil
	end
	return vim.trim(res.stdout)
end

local function runs_agent(tty)
	local res = vim.system({ "ps", "-o", "comm=", "-t", tty }, { text = true }):wait()
	for comm in (res.stdout or ""):gmatch("[^\n]+") do
		if AGENT_COMMANDS[vim.fs.basename(vim.trim(comm))] then
			return true
		end
	end
	return false
end

local function find_agent_pane()
	local self = vim.env.TMUX_PANE
	if not self then
		return nil
	end
	local out = tmux({ "list-panes", "-t", self, "-F", "#{pane_id}|#{@agent}|#{pane_tty}" })
	if not out then
		return nil
	end

	local candidates = {}
	for line in out:gmatch("[^\n]+") do
		local id, tagged, tty = line:match("^([^|]+)|([^|]*)|(.+)$")
		if id and id ~= self then
			if tagged == "1" then
				return id
			end
			table.insert(candidates, { id = id, tty = tty })
		end
	end
	for _, pane in ipairs(candidates) do
		if runs_agent(pane.tty) then
			return pane.id
		end
	end
	return nil
end

local function relpath(buf)
	local name = vim.api.nvim_buf_get_name(buf)
	local root = vim.fs.root(buf, ".git") or vim.fn.getcwd()
	return vim.fs.relpath(root, name) or vim.fn.fnamemodify(name, ":~:.")
end

-- Type `text` into the agent prompt and focus the agent pane.
function M.send(text)
	local pane = find_agent_pane()
	if not pane then
		vim.notify("agent: no claude/codex pane in this tmux window", vim.log.levels.WARN)
		return
	end
	tmux({ "send-keys", "-t", pane, "-l", text })
	tmux({ "select-pane", "-t", pane })
end

function M.focus()
	local pane = find_agent_pane()
	if not pane then
		vim.notify("agent: no claude/codex pane in this tmux window", vim.log.levels.WARN)
		return
	end
	tmux({ "select-pane", "-t", pane })
end

function M.send_position()
	local mode = vim.fn.mode()
	local path = relpath(0)
	if mode == "v" or mode == "V" or mode == "\22" then
		local first, last = vim.fn.line("v"), vim.fn.line(".")
		if first > last then
			first, last = last, first
		end
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
		M.send(("@%s:%d-%d "):format(path, first, last))
	else
		M.send(("@%s:%d "):format(path, vim.fn.line(".")))
	end
end

function M.send_file()
	M.send(("@%s "):format(relpath(0)))
end

function M.send_diagnostics()
	local lnum = vim.fn.line(".")
	local messages = vim.tbl_map(function(d)
		return (d.message:gsub("%s+", " "))
	end, vim.diagnostic.get(0, { lnum = lnum - 1 }))
	local text = ("@%s:%d "):format(relpath(0), lnum)
	if #messages > 0 then
		text = text .. "diagnostics: " .. table.concat(messages, " | ") .. " "
	end
	M.send(text)
end

function M.setup()
	vim.keymap.set({ "n", "x" }, "<leader>aa", M.send_position, { desc = "Send position/selection to agent" })
	vim.keymap.set("n", "<leader>af", M.send_file, { desc = "Send file to agent" })
	vim.keymap.set("n", "<leader>ad", M.send_diagnostics, { desc = "Send line diagnostics to agent" })
	vim.keymap.set("n", "<leader>at", M.focus, { desc = "Focus agent pane" })

	-- Pick up files the agent changed while we were in another pane.
	vim.o.autoread = true
	vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
		group = vim.api.nvim_create_augroup("agent_autoread", { clear = true }),
		callback = function()
			if vim.fn.getcmdwintype() == "" and vim.bo.buftype == "" then
				vim.cmd("checktime")
			end
		end,
	})
end

return M
