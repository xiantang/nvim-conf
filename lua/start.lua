function RecentlySeesion()
	-- check filenvim
	if vim.g.started_by_firenvim == true then
		-- set font size
		return
	end
	require("persistence").load({ last = true })
end

-- https://github.com/neovim/neovim/issues/8136#issuecomment-373082539 nested
vim.cmd("silent! autocmd VimEnter *  nested lua RecentlySeesion()")
