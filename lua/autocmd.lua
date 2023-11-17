vim.cmd([[
au TermOpen * setlocal nobuflisted
au VimResized * wincmd =
au BufEnter leetcode.cn_*.txt set filetype=go
" https://github.com/fatih/vim-go/issues/1757
au filetype qf wincmd J
au BufEnter *.conf set filetype=config
au BufEnter * set formatoptions-=cro
au BufEnter Brewfile set filetype=ruby
au BufEnter .zpreztorc set filetype=zsh
au BufEnter nerdtree setlocal relativenumber
au CursorHold * checktime
au BufRead,BufNewFile *.jq setfiletype jq
au BufRead,BufNewFile *.http setfiletype http
au BufNewFile,BufRead *.template setfiletype gotmpl
au BufNewFile,BufRead */ssh/config  setf sshconfig
au CursorHold,CursorHoldI * checktime
au BufWinEnter NvimTree setlocal rnu
au VimEnter * :clearjumps
autocmd FileType dbout setlocal nofoldenable
au InsertLeave,VimEnter  * :silent exec "!sudo mac im-select com.apple.keylayout.ABC"
au BufWritePre *.tfvars lua vim.lsp.buf.format()
au BufWritePre *.tf lua vim.lsp.buf.format()
au User GnuPG setl textwidth=72
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

-- auto refresh nvim tree when commit and push code
vim.api.nvim_create_autocmd({
	"BufWritePost",
}, {
	pattern = { "fugitive" },
	callback = function()
		vim.cmd("silent! :NvimTreeRefresh")
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
	end,
})
