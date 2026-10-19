return {
	{
		-- Sets filetype=helm for chart templates so yamlls stops reporting
		-- errors on `{{ ... }}` actions, and highlights Go template syntax.
		"towolf/vim-helm",
		ft = { "helm", "yaml" },
	},
}
