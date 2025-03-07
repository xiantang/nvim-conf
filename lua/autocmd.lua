vim.cmd([[
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
let g:undotree_WindowLayout = 3
au BufEnter * call Undotree_record()
au TermOpen * setlocal nobuflisted
"au WinResized * wincmd =
au BufEnter leetcode.cn_*.txt set filetype=go
" https://github.com/fatih/vim-go/issues/1757
au BufEnter *.conf set filetype=config
au BufEnter * set formatoptions-=cro
au BufEnter Brewfile set filetype=ruby
au BufEnter .zpreztorc set filetype=zsh
au BufEnter nerdtree setlocal relativenumber
" au CursorHold * checktime
" au CursorHold,CursorHoldI * checktime
au BufRead,BufNewFile *.jq setfiletype jq
au BufRead,BufNewFile *.http setfiletype http
au BufNewFile,BufRead *.template setfiletype gotmpl
au BufNewFile,BufRead sshconfig setfiletype sshconfig
au BufNewFile,BufRead */ssh/config  setf sshconfig
au BufWinEnter NvimTree setlocal rnu
au VimEnter * :clearjumps
autocmd FileType dbout setlocal nofoldenable
au InsertLeave,VimEnter  * :silent exec "!sudo mac im-select com.apple.keylayout.ABC"
au User GnuPG setl textwidth=72
autocmd VimLeavePre * :redir >> ~/.config/nvim/messages.txt | silent messages | redir END
]])
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go" },
	callback = function()
		local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
		params.context = { only = { "source.organizeImports" } }

		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 50,
		})
	end,
})
