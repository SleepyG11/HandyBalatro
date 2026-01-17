Handy.controls = setmetatable({
	dictionary = {},
	stacks = {},
}, {})

--

function Handy.controls.is_module_keys_activated(module, args)
	args = args or {}

	local blacklist = args.blacklist or {}
	local check_context = args.check_context
	local context = args.context or Handy.controller.get_input_context()
	local exact_keys = args.exact_keys
	local pre_release = args.pre_release
	local hold_duration = args.hold_duration

	local tables = { module.keys_1 or {}, module.keys_2 or {} }
	if Handy.controller.is_gamepad() then
		tables = {
			module.keys_1_gamepad or {},
			module.keys_2_gamepad or {},
		}
	end

	local _t = pre_release and Handy.controller.held_keys_pre or Handy.controller.held_keys

	for _, t in ipairs(tables) do
		local is_present = false
		local is_triggered = true
		local keys_to_trigger = 0
		for _, key in ipairs(t) do
			if key and key ~= "None" then
				keys_to_trigger = keys_to_trigger + 1
				if not check_context or (context.released and pre_release) or key == context.key then
					is_present = true
				end
				if blacklist[key] or not _t[key] or (hold_duration and hold_duration > _t[key]) then
					is_triggered = false
					break
				end
			end
		end
		if is_triggered and is_present then
			if exact_keys then
				if pre_release == "both" then
					if
						keys_to_trigger ~= Handy.utils.table_keys_count(Handy.controller.held_keys_pre)
						and keys_to_trigger ~= Handy.utils.table_keys_count(Handy.controller.held_keys)
					then
						return false
					end
				else
					if keys_to_trigger ~= Handy.utils.table_keys_count(_t) then
						return false
					end
				end
			end
			return true
		end
	end

	return false
end

function Handy.controls.is_module_enabled(module)
	module = Handy.m(module)
	return module and module.enabled
end

--

function Handy.controls.default_can_execute(item, context, args)
	args = args or {}
	context = context or Handy.controller.get_input_context()

	-- Context type check
	if item.context_types then
		local r = item.context_types[context.context_type]
		if type(r) == "table" then
			r = r[context.type]
		end
		if not r then
			return false
		end
	end
	-- Mod active check
	if not args.allow_mod_inactive and not item.allow_mod_inactive and not Handy.b_is_mod_active() then
		return false
	end
	if not args.allow_not_in_run and item.in_run and not Handy.b_is_in_run() then
		return false
	end
	-- Stop use state check
	if not args.allow_stop_use and item.no_stop_use and Handy.b_is_stop_use() then
		return false
	end
	-- MP check
	if not args.allow_mp and item.no_mp and Handy.mp_check(item.no_mp) then
		return false
	end
	-- Dangerous keybind check
	if not args.allow_dangerous and item.dangerous and not Handy.b_is_dangerous_actions_active() then
		return false
	end
	if context.input_context then
		-- Back button (avoid usage of it, especially preventing)
		if not item.allow_back and context.back then
			return false
		end
		-- Keybind type
		if not ((not item.only_safe or context.safe) and (not item.only_holdable or context.holdable)) then
			return false
		end
	end

	local module, deps = item:get_module()
	module = Handy.m(module)

	if module then
		-- Enabled state
		if not args.allow_disabled and not item.allow_disabled then
			if not module.enabled then
				return false
			end
			deps = deps or {}
			for _, dep in ipairs(deps) do
				if not Handy.controls.is_module_enabled(dep) then
					return false
				end
				if
					not args.no_keybinds
					and deps.with_keybinds
					and not Handy.controls.is_module_keys_activated(dep, {
						check_context = false,
						context = context,
						blacklist = item.keys_blacklist,
					})
				then
					return false
				end
			end
		end
		if context.input_context then
			-- Proper trigger mode
			if item.trigger then
				if
					(item.trigger == "press" and context.released)
					or (item.trigger == "release" and not context.released)
					or (item.trigger == "trigger" and not context.triggered)
				then
					return false
				end
			end
		end
		if
			not args.no_keybinds
			and not Handy.controls.is_module_keys_activated(module, {
				check_context = context.input_context,
				context = context,
				blacklist = item.keys_blacklist,
				exact_keys = item.require_exact_keys,
				pre_release = item.pre_release_keys,
			})
		then
			return false
		end
	else
		return false
	end
	return true
end

function Handy.controls.execute(item, context)
	if not item then
		return false
	end
	item.executed = false
	local r = false
	if item.execute then
		local can_function = item.can_execute or Handy.controls.default_can_execute
		if can_function(item, context) then
			item.executed = true
			r = item.execute(item, context) or false
		end
	end
	return r
end

--

function Handy.controls.get_stack(context)
	if context.input_context then
		return Handy.controls.stacks[context.type] or {}
	end
	if context.card_context then
		return Handy.controls.stacks["card_" .. context.type] or {}
	end
	if context.tag_context then
		return Handy.controls.stacks["tag_" .. context.type] or {}
	end
end

function Handy.controls.call_stack(context, stack)
	stack = stack or Handy.controls.get_stack(context)
	if not stack then
		return false
	end
	local operator = stack.op or "all"
	local should_stop = false

	for _, item in ipairs(stack) do
		if operator == "first" and should_stop then
			return true
		end
		if type(item) == "table" then
			should_stop = Handy.controls.call_stack(context, item) or false
		elseif type(item) == "string" then
			should_stop = Handy.controls.execute(Handy.controls.dictionary[item], context) or false
		end
	end
	if operator == "all" then
		return false
	else
		return should_stop or false
	end
end

--

function Handy.controls.process_context(context)
	Handy.controls.call_stack(context)
end

Handy.e_mitter.on("update", function(dt)
	for key, item in pairs(Handy.controls.dictionary) do
		item:update(dt)
	end
end)

--

function Handy.controls.register(key, item)
	item.get_module = item.get_module or function() end
	item.update = item.update or function() end

	item.key = key

	Handy.controls.dictionary[key] = item
	return item
end

Handy.load_file("src/controls/stack.lua")
