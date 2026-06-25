Handy.API = {}

local function resolve_mod(args)
	args.mod_id = args.mod_id or (SMODS and SMODS.current_mod and SMODS.current_mod.id)
end

function Handy.API.DefaultConfig(config)
	Handy.utils.table_merge(Handy.config.default, config)
end

function Handy.API.Control(args)
	resolve_mod(args)
	return Handy.controls.register(args)
end
function Handy.API.Stack(args)
	resolve_mod(args)
	return Handy.stack.register(args)
end
function Handy.API.Dictionary(args)
	resolve_mod(args)
	return Handy.dictionary.register(args)
end

for k, inputs in pairs(Handy_Preflight) do
	for _, input in ipairs(inputs) do
		Handy.API[k](input)
	end
end

Handy_Preflight = nil
