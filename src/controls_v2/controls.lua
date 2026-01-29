Handy.controls_v2.dictionary = {}

---

function Handy.controls_v2.register(key, item)
	item.get_module = item.get_module or function() end
	item.update = item.update or function() end
	-- item.update_state_panel = item.update_state_panel or function() end

	item.key = key

	Handy.controls_v2.dictionary[key] = item
	return item
end

---

function Handy.controls_v2.is_module_keys_hold(module, args)
	if not module then
		return false, 0, nil
	end
	args = args or {}

	local key_tables = { module.keys_1 or {}, module.keys_2 or {} }
	if Handy.controller_v2.is_gamepad() then
		key_tables = {
			module.keys_1_gamepad or {},
			module.keys_2_gamepad or {},
		}
	end

	local ctx = Handy.controller_v2.non_empty_context(args.ctx)
	local include_release = args.include_release or (ctx and ctx.input and ctx.release)

	for index, keys in ipairs(key_tables) do
		local is_hold, hold_duration = Handy.controller_v2.key_states.is_keys_hold(keys, {
			real = args.real or false,
			no_aliases = false,
			include_release = include_release,
			check_key = ctx and ctx.input and ctx.key or nil,
		})
		if is_hold then
			if
				not args.require_exact
				or Handy.controller_v2.key_states.is_keys_count_match(keys, {
					include_release = include_release,
				})
			then
				return is_hold, hold_duration, index
			end
		end
	end

	return false, 0, nil
end
function Handy.controls_v2.is_module_enabled(module)
	module = Handy.m(module)
	return module and module.enabled
end

---

function Handy.controls_v2.can_execute_control(item, args)
	-- Cant execute nothing or non-executable
	if not item then
		return false, "no_item"
	end
	args = args or {}

	local module, deps = item:get_module()
	module = Handy.m(module)

	if not module then
		return false, "no_module"
	end

	local allow_disabled = args.allow_disabled or item.allow_disabled

	-- Module inactive check
	if not allow_disabled and not module.enabled then
		return false, "module_disabled"
	end
	-- Mod active check
	if not args.allow_mod_inactive and not item.allow_mod_inactive and not Handy.b_is_mod_active() then
		return false, "mod_disabled"
	end
	-- Dangerous keybind check
	if not args.allow_dangerous and item.dangerous and not Handy.b_is_dangerous_actions_active() then
		return false, "dangerous_disabled"
	end
	-- In run check
	if not args.allow_not_in_run and item.in_run and not Handy.b_is_in_run() then
		return false, "not_in_run"
	end
	-- Stop use state check
	if not args.allow_stop_use and item.no_stop_use and Handy.b_is_stop_use() then
		return false, "stop_use"
	end

	local ctx = args.ctx
	if ctx then
		if ctx:is_empty() then
			return false, "empty_context"
		end

		if item.ctx_type then
			local v = item.ctx_type[ctx.type]
			if not v then
				return false, "context_type_mismatch"
			end
			if type(v) == "table" then
				if not ctx.input_type or not v[ctx.input_type] then
					return false, "context_input_type_mismatch"
				end
			end
		end
		if ctx.input then
			-- Back button (avoid usage of it, especially preventing)
			if not item.allow_back and ctx.back then
				return false, "back_button"
			end
			-- Non-safe button
			if item.only_safe and not ctx.safe then
				return false, "non_safe_button"
			end
			-- Non-holdable button
			if item.only_holdable and not ctx.holdable then
				return false, "non_holdable_button"
			end
			-- Check for press/release/trigger
			if item.trigger and not ctx[item.trigger] then
				return false, "trigger_mismatch"
			end
		end
	end

	-- MP check
	if not args.allow_mp and item.no_mp and Handy.disabled_in_mp_check(item.no_mp) then
		return false, "mp"
	end

	-- Module keybinds check
	if
		not args.no_keybinds
		and not Handy.controls_v2.is_module_keys_hold(module, {
			ctx = ctx,
			require_exact = item.require_exact,
		})
	then
		return false, "keybinds_mismatch"
	end

	deps = deps or {}
	for _, dep in ipairs(deps) do
		-- Deps enabled check
		if not allow_disabled and not Handy.controls_v2.is_module_enabled(dep) then
			return false, "deps_disabled"
		end
		-- Deps keybinds check if needed (?)
		if
			not args.no_keybinds
			and deps.with_keybinds
			and not Handy.controls_v2.is_module_keys_hold(dep, {
				require_exact = dep.require_exact,
			})
		then
			return false, "deps_keybinds_mismatch"
		end
	end

	return true, args.data
end
function Handy.controls_v2.execute_control(key, args)
	local target = Handy.controls_v2.dictionary[key]
	local check_func = target and target.can_execute or Handy.controls_v2.can_execute_control
	local can_execute, leftover_data = check_func(target, args)
	if can_execute then
		local execute_result = target.execute and target.execute(target, args, leftover_data) or false
		return execute_result, true, "ok"
	else
		return false, false, leftover_data or "unknown"
	end
end

Handy.e_mitter.on("update", function(dt)
	for _, item in pairs(Handy.controls_v2.dictionary) do
		item:update(dt)
	end
end)
