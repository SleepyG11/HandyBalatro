Handy.presets_switch = {
	get_action = function(key)
		if Handy.controller.is_module_key(Handy.cc.presets.load_1, key) then
			return true, 1
		elseif Handy.controller.is_module_key(Handy.cc.presets.load_2, key) then
			return true, 2
		elseif Handy.controller.is_module_key(Handy.cc.presets.load_3, key) then
			return true, 3
		elseif Handy.controller.is_module_key(Handy.cc.presets.load_next, key) then
			return true, "next"
		else
			return false, nil
		end
	end,
	get_next_preset_index = function(key)
		local action, load_index = Handy.presets_switch.get_action(key)
		if not action or not load_index then
			return false, nil, false
		end
		if type(load_index) == "number" then
			local preset = Handy.presets.current.user[load_index]
			return true, load_index, preset.config and preset.enabled or false
		end
		if load_index == "next" then
			local available = {}
			for i = 1, 3 do
				local preset = Handy.presets.current.user[i]
				if preset.enabled and preset.config then
					table.insert(available, i)
				end
			end
			if #available == 0 then
				return false, nil, false
			elseif #available == 1 then
				return true, available[1], true
			else
				local current_index = Handy.presets.current.selected
				-- search for first index which is bigger than current
				for _, next_index in ipairs(available) do
					if next_index > current_index then
						return true, next_index, true
					end
				end
				-- If not, use lowest one
				return true, available[1], true
			end
		end
		return false, nil, false
	end,

	can_execute = function(key)
		return not G.SETTINGS.paused and not G.OVERLAY_MENU and Handy.controller.is_module_enabled(Handy.cc.presets)
	end,
	execute = function(key)
		local is_found, preset_index, available = Handy.presets_switch.get_next_preset_index(key)
		if not is_found or not available then
			return false
		end
		Handy.presets.apply_index(preset_index)
		return true
	end,

	use = function(key)
		return Handy.presets_switch.can_execute(key) and Handy.presets_switch.execute(key) or false
	end,

	update_state_panel = function(state, key, released)
		if released or Handy.cc.notifications_level < 3 then
			return false
		end
		local action, load_index = Handy.presets_switch.get_action(key)
		if not action or not load_index then
			return false
		end
		if type(load_index) == "number" then
			local preset = Handy.presets.current.user[load_index]
			local is_applied = preset.config and preset.enabled
			local result_string = ""
			if is_applied then
				result_string = localize({
					type = "variable",
					key = "Handy_preset_loaded",
					vars = { load_index, preset.name or "" },
				})
			elseif not preset.enabled then
				result_string = localize({
					type = "variable",
					key = "Handy_preset_disabled",
					vars = { load_index, preset.name or "" },
				})
			elseif not preset.config then
				result_string = localize({
					type = "variable",
					key = "Handy_preset_empty",
					vars = { load_index, preset.name or "" },
				})
			end
			state.items.presets_change = {
				text = result_string,
				hold = false,
				order = 15,
			}
			return true
		elseif load_index == "next" then
			local is_applied = false
			for i = 1, 3 do
				local preset = Handy.presets.current.user[i]
				if preset.enabled and preset.config then
					is_applied = true
					break
				end
			end
			local result_string
			if is_applied then
				local current_index = Handy.presets.current.selected
				local preset = Handy.presets.current.user[current_index]
				result_string = localize({
					type = "variable",
					key = "Handy_preset_loaded",
					vars = { current_index, preset.name or "" },
				})
			else
				result_string = localize({
					type = "variable",
					key = "Handy_preset_nothing_to_load",
					vars = {},
				})
			end
			state.items.presets_change = {
				text = result_string,
				hold = false,
				order = 15,
			}
			return true
		end
		return false
	end,
}

Handy.register_module("presets_switch", Handy.presets_switch)
