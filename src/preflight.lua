Handy_Preflight = {
	API = {
		DefaultConfig = {},
		Control = {},
		Stack = {},
		Dictionary = {},
	},
	queues = {},
}

Handy = {
	preflight = true,

	ARGS = {},
}
Handy.API = {
	preflight = true,
}

---

local function resolve_mod(args)
	args.mod_id = args.mod_id or Handy.ARGS.mod_id_override or (SMODS and SMODS.current_mod and SMODS.current_mod.id)
end

function Handy.API.Control(args)
	resolve_mod(args)
	table.insert(Handy_Preflight.API.Control, args)
end
function Handy.API.Stack(args)
	resolve_mod(args)
	table.insert(Handy_Preflight.API.Stack, args)
end
function Handy.API.Dictionary(args)
	resolve_mod(args)
	table.insert(Handy_Preflight.API.Dictionary, args)
end
function Handy.API.DefaultConfig(config)
	table.insert(Handy_Preflight.API.DefaultConfig, config)
end

---

Handy.e_mitter = {}
Handy_Preflight.queues = {}

function Handy.e_mitter.on(type, callback, args)
	args = args or {}
	if not Handy_Preflight.queues[type] then
		Handy_Preflight.queues[type] = {}
	end
	local result = {
		callback = callback or function() end,
		key = args.key,
	}
	if args.before then
		for index, item in ipairs(Handy_Preflight.queues[type]) do
			if item.key and item.key == args.before then
				table.insert(Handy_Preflight.queues[type], index, result)
				return
			end
		end
	elseif args.after then
		for index, item in ipairs(Handy_Preflight.queues[type]) do
			if item.key and item.key == args.after then
				table.insert(Handy_Preflight.queues[type], index + 1, result)
				return
			end
		end
	elseif args.start then
		table.insert(Handy_Preflight.queues[type], 1, result)
	else
		table.insert(Handy_Preflight.queues[type], result)
	end
end
function Handy.e_mitter.emit(type, ...)
	if Handy_Preflight.queues[type] then
		for _, item in ipairs(Handy_Preflight.queues[type]) do
			if item.callback(...) then
				return true
			end
		end
	end
	return false
end
function Handy.e_mitter.off(type, key)
	if Handy_Preflight.queues[type] then
		for index, item in ipairs(Handy_Preflight.queues[type]) do
			if item.key and item.key == key then
				table.remove(Handy_Preflight.queues[type], index)
				return true
			end
		end
	end
	return false
end

---

function Handy.get_module_override(module) end
