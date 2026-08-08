Handy.module_overrides = {
	list = {},
	dictionary = {},

	cache = {},
	processors = {},

	sorted = false,
}

local processors = Handy.module_overrides.processors
local cache = Handy.module_overrides.cache

--

local order_counter = 1
function Handy.module_overrides.register(item)
	if Handy.module_overrides.dictionary[item.key] then
		return Handy.module_overrides.dictionary[item.key]
	end

	if not item.order then
		item.order = order_counter
		order_counter = order_counter + 1
	else
		order_counter = math.max(item.order + 1, order_counter)
	end

	Handy.module_overrides.sorted = false

	Handy.module_overrides.dictionary[item.key] = item
	table.insert(Handy.module_overrides.list, item)

	item.get_module = item.get_module or function() end
	item.func = item.func or function() end

	return item
end

--

function Handy.module_overrides.sort()
	table.sort(Handy.module_overrides.list, function(a, b)
		return (a.order or 0) > (b.order or 0)
	end)
	Handy.module_overrides.sorted = true
end
function Handy.module_overrides.set_processors()
	if not Handy.module_overrides.sorted then
		Handy.module_overrides.sort()
	end

	EMPTY(processors)
	for _, item in ipairs(Handy.module_overrides.list) do
		local key = item:get_module()
		if key then
			local old_processor = processors[key]
			processors[key] = function(module)
				return item:func(module, old_processor or function() end)
			end
		end
	end
end

--

Handy.get_module_override = Handy.get_module_override or function(module) end

function Handy.module_overrides.process(module)
	if cache[module] then
		return cache[module]
	end

	-- TODO: deprecate Handy.get_module_override old method
	local override = processors[module] and processors[module](module) or Handy.get_module_override(module)
	if override and override ~= module then
		cache[module] = Handy.utils.table_shallow_merge({}, module, override)
		return cache[module]
	end

	cache[module] = module
	return module
end

Handy.e_mitter.on("config_load", function()
	Handy.module_overrides.set_processors()
end)
Handy.e_mitter.on("update", function(dt)
	EMPTY(cache)
end)
