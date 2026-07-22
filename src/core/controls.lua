Handy.controls = {}
Handy.controls.dictionary = {}
Handy.controls.list = {}

---

function Handy.controls.register(item)
	item.get_module = item.get_module or function() end
	item.get_deps = item.get_deps or function() end
	item.update = item.update or function() end

	item.can_execute = item.can_execute or Handy.controls.can_execute_control

	Handy.controls.dictionary[item.key] = item
	table.insert(Handy.controls.list, item)

	return item
end

---

function Handy.controls.is_module_keys_hold(module, args)
	if not module then
		return false, 0, nil
	end
	args = args or Handy.ARGS.global_empty_table

	local key_tables = { module.keys_1 or {}, module.keys_2 or {} }
	if Handy.controller.is_gamepad() then
		key_tables = {
			module.keys_1_gamepad or {},
			module.keys_2_gamepad or {},
		}
	end

	local ctx = Handy.controller.non_empty_context(args.ctx)
	local include_release = args.include_release or (ctx and ctx.input and ctx.release)

	for index, keys in ipairs(key_tables) do
		local is_hold, hold_duration = Handy.controller.key_states.is_keys_hold(keys, {
			real = args.real or false,
			no_aliases = false,
			include_release = include_release,
			check_key = ctx and ctx.input and ctx.key or nil,
		})
		if is_hold then
			if
				not args.require_exact
				or Handy.controller.key_states.is_keys_count_match(keys, {
					include_release = include_release,
				})
			then
				return true, hold_duration or 0, index
			end
		end
	end

	return false, 0, nil
end
function Handy.controls.is_module_enabled(module)
	module = Handy.m(module)
	return module and module.enabled
end

function Handy.controls.is_enabled_module_keys_hold(module, args)
	return Handy.controls.is_module_enabled(module) and Handy.controls.is_module_keys_hold(module, args)
end

---

function Handy.controls.is_valid_input_context(item, ctx, args)
	-- Back button
	if not item.allow_back_input and ctx.back then
		return false
	end
	-- Non-safe button
	if item.only_safe_input and not ctx.safe then
		return false
	end
	-- Non-holdable button
	if item.only_holdable_input and not ctx.holdable then
		return false
	end
	return true
end
function Handy.controls.is_valid_context(item, ctx, args)
	if not ctx then
		return false
	end
	if item.contexts then
		if ctx.hold then
			if not item.contexts.hold then
				return false
			end
		elseif ctx.move then
			if not item.contexts.move then
				return false
			end
		else
			if ctx.input and not Handy.controls.is_valid_input_context(item, ctx, args) then
				return false
			end
			local found = false
			for flag, _ in pairs(item.contexts) do
				if ctx[flag] then
					found = true
					break
				end
			end
			if not found then
				return false
			end
		end
	end
	return true
end
function Handy.controls.is_valid_state(item, ctx, args)
	args = args or Handy.ARGS.global_empty_table
	-- Mod active check
	if not args.allow_mod_inactive and not item.allow_mod_inactive and not Handy.b_is_mod_active() then
		return false
	end
	-- Dangerous keybind check
	if not args.allow_dangerous and item.dangerous and not Handy.b_is_dangerous_actions_active() then
		return false
	end
	-- In run check
	if not args.allow_not_in_run and item.only_in_run and not Handy.b_is_in_run() then
		return false
	end
	-- Stop use state check
	if not args.allow_stop_use and item.no_stop_use and Handy.b_is_stop_use() then
		return false
	end
	return true
end

---

function Handy.controls.resolve_control_context(item, ctx, args)
	return Handy.controls.is_valid_context(item, ctx, args) and ctx or nil
end

function Handy.controls.can_execute_control(item, ctx, args)
	if not item then
		return false
	end
	args = args or Handy.ARGS.global_empty_table
	ctx = ctx or args.ctx

	-- Global state check
	if not Handy.controls.is_valid_state(item, ctx, args) then
		return false
	end

	-- Module resolving
	local module = Handy.m(item:get_module())
	if not module then
		return false
	end

	-- Module inactive check
	local allow_disabled = args.allow_disabled or item.allow_disabled
	if not allow_disabled and not module.enabled then
		return false
	end

	-- Context check
	if ctx and not args.allow_any_context and not item.allow_any_context then
		ctx = Handy.controls.resolve_control_context(item, ctx, args)
		if not ctx then
			return false
		end
	end

	-- MP check
	if not args.allow_mp and item.no_mp and Handy.disabled_in_mp_check(item.no_mp) then
		return false
	end

	-- Keybinds check
	if
		not args.no_keybinds
		and not Handy.controls.is_module_keys_hold(module, {
			ctx = ctx,
			require_exact = item.require_exact_keys_input,
			include_release = args.include_release,
		})
	then
		return false
	end

	-- Deps check
	local deps = item:get_deps()
	if deps then
		for _, dep in ipairs(deps) do
			-- Deps enabled check
			if not allow_disabled and not Handy.controls.is_module_enabled(dep) then
				return false
			end
		end
	end

	return true
end
function Handy.controls.execute_control(key, ctx, args)
	ctx = Handy.controller.non_empty_context(ctx)
	if not ctx then
		return false, false
	end
	local target = Handy.controls.dictionary[key]
	local check_func = target and target.can_execute or Handy.controls.can_execute_control
	local can_execute, leftover_data = check_func(target, ctx, args or {})
	if not can_execute then
		return false, false
	end
	local execute_result = target.execute and target.execute(target, ctx, args, leftover_data) or false
	return execute_result, true
end

--

Handy.e_mitter.on("update", function(dt)
	for _, item in pairs(Handy.controls.dictionary) do
		item:update(dt)
	end
end)
