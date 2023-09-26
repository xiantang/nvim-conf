M = {}

function M.safeRequire(module)
	local success, loadedModule = pcall(require, module)
	if success then
		return loadedModule
	end
	vim.cmd.echo("Error loading " .. module)
end
return M
