Handy_Preflight = {
	DefaultConfig = {},
	Control = {},
	Stack = {},
	Dictionary = {},
}

Handy = {
	preflight = true,
}
Handy.API = {
	preflight = true,
}

local function resolve_mod(args)
	args.mod_id = args.mod_id or (SMODS and SMODS.current_mod and SMODS.current_mod.id)
end

function Handy.API.Control(args)
	resolve_mod(args)
	table.insert(Handy_Preflight.Control, args)
end
function Handy.API.Stack(args)
	resolve_mod(args)
	table.insert(Handy_Preflight.Stack, args)
end
function Handy.API.Dictionary(args)
	resolve_mod(args)
	table.insert(Handy_Preflight.Dictionary, args)
end
function Handy.API.DefaultConfig(config)
	table.insert(Handy_Preflight.DefaultConfig, config)
end
