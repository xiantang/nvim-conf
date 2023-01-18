require("start")
require("toggle")
require("tele")
require("indent")
require("fastmind")

vim.cmd("cnoreabbrev git Git")
vim.cmd("cnoreabbrev gp Git push")
vim.cmd("cnoreabbrev Gbrowse GBrowse")

-- override variable  as white
-- for method caller
function toggle_profile()
	local prof = require("profile")
	if prof.is_recording() then
		prof.stop()
		filename = ".profile.json"
		prof.export(filename)
		vim.notify(string.format("Wrote %s", filename))
	else
		prof.start("*")
	end
end

require("nerdtree")

vim.cmd([[
" buff enter"
function Undotree_record() abort
if has("persistent_undo")
   let target_path = expand('~/.undodir')
    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
endfunction

autocmd BufEnter * call Undotree_record()

]])
--

vim.api.nvim_create_user_command("Profile", function()
	toggle_profile()
end, {})
