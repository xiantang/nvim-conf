M = {}

function M.safeRequire(module)
	local success, loadedModule = pcall(require, module)
	if success then
		return loadedModule
	end
	return nil
end

return M
