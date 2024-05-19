return {
	--- more stable than gitsign.nvim
	{ "airblade/vim-gitgutter" },

	{ "tpope/vim-rhubarb" },
	{
		"tpope/vim-fugitive",
	},
	{
		"shumphrey/fugitive-gitlab.vim",
		-- event = { "BufReadPost", "BufNewFile", "BufWritePre" },

		config = function()
			-- check operation system
			local ok, secret = pcall(require, "secret")
			if ok then
				vim.g.fugitive_gitlab_domains = { secret.GITALB_URL }
			end
		end,
	},
	-- git related
	{
		"rhysd/conflict-marker.vim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
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
		end,
	},
}
