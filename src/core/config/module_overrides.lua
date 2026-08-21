Handy.module_overrides = {
	cache = {},
}
local cache = Handy.module_overrides.cache

--

function Handy.get_module_override(module) end

function Handy.module_overrides.process(module)
	if cache[module] then
		return cache[module]
	end

	local override = Handy.get_module_override(module)
	if override and override ~= module then
		cache[module] = Handy.utils.table_shallow_merge({}, module, override)
		cache[module].overrided = true
		return cache[module]
	end

	cache[module] = module
	return module
end

--

Handy.e_mitter.on("update", function(dt)
	EMPTY(cache)
end)
