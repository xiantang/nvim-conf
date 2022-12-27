require("plugins")
require("start")
require("neodev").setup()
require("impatient")
require("scrollbar.handlers.gitsigns").setup()
require("scrollbar").setup({
	set_highlights = true,
	marks = {
		GitAdd = {
			text = "│",
			priority = 5,
			color = "green",
			cterm = nil,
		},
		GitChange = {
			text = "│",
			priority = 5,
			color = "yellow",
			cterm = nil,
		},
		GitDelete = {
			text = "_",
			priority = 5,
			color = "red",
			cterm = nil,
		},
	},
})
require("toggle")
require("lualine_setup")
require("lsp_config")
require("tele")
require("git")
require("term")
require("syntax")
require("indent")
require("nvim-autopairs").setup({})
require("dap-go").setup()
require("dap_set")
require("nerdtree")
vim.cmd([[

let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let g:NERDTreeChDirMode = 2
" width"
let g:NERDTreeWinSize = 25
" mini 
let g:NERDTreeMinimalMenu=1


let g:vim_markdown_folding_disabled = 1
]])

require("fastmind")
require("go").setup()
require("txtobj")
require("null")
require("Comment").setup()
require("symbols-outline").setup()
require("neodev").setup({})
require("fidget").setup()
core = require("core")

vim.cmd("cnoreabbrev git Git")
vim.cmd("cnoreabbrev gp Git push")
vim.cmd("cnoreabbrev Gbrowse GBrowse")

-- override variable  as white
-- for method caller
vim.cmd([[silent! colorscheme base16-tender]])
vim.cmd([[
  hi! link TSVariable Normal
]])

vim.cmd([[
      let g:conflict_marker_highlight_group = ''
      " Include text after begin and end markers
      let g:conflict_marker_begin = '^<<<<<<< .*$'
      let g:conflict_marker_end   = '^>>>>>>> .*$'

      highlight ConflictMarkerBegin guibg=#2f7366
      highlight ConflictMarkerOurs guibg=#2e5049
      highlight ConflictMarkerTheirs guibg=#344f69
      highlight ConflictMarkerEnd guibg=#2f628e
      highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
]])

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

-- undotree
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

vim.cmd([[
let g:copilot_enable = 1
let g:copilot_filetypes = {
    \ 'markdown': v:true,
    \ 'yaml': v:true,
    \ 'go': v:false,
    \ 'lua': v:true,
    \ 'gitcommit': v:true,
    \ "TelescopePrompt": v:false,
      \ }

imap <silent><script><expr> <C-e> copilot#Accept('\<CR>')
let g:copilot_no_tab_map = v:true
let g:copilot_assume_mapped = v:true
    ]])

-- firenvim
vim.cmd([[


function! SetFontSizeFirenvim(timer)
  set guifont=Fira_Code:h18
endfunction


" https://github.com/glacambre/firenvim/issues/1006#issuecomment-1126785734
if exists('g:started_by_firenvim')
  let g:firenvim_config = {
        \ 'localSettings' : {
          \ '.*' : {
              \ 'filename' : '{hostname%32}_{pathname%32}_{selector%32}_{timestamp%32}.go',
            \   },
      \ }
  \}
  let g:dashboard_disable_at_vimenter=1
  let g:NERDTreeHijackNetrw=0
  call timer_start(3000, function("SetFontSizeFirenvim"))
  let g:copilot_enable = 0
  let g:copilot_filetypes = {
      \ 'markdown': v:true,
      \ 'yaml': v:true,
      \ 'go': v:false,
        \ }
  echo 'nvim good'
else
  set laststatus=2
endif


]])

-- create cmd

vim.api.nvim_create_user_command("Profile", function()
	toggle_profile()
end, {})
