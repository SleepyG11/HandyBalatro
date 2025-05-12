Handy.presets = {
	examples = {
		default = {
			config = Handy.utils.table_merge({}, Handy.config.default),
			key = "default",
		},
		better_mouse_and_gamepad = {
			config = {
				insta_highlight = {
					key_1 = "Right Mouse",
					key_2 = "None",
					key_1_gamepad = "(B)",
					key_2_gamepad = "None",

					allow_deselect = {
						enabled = false,
					},
				},
				speed_multiplier = {
					enabled = false,
					multiply = {
						key_1 = "None",
						key_2 = "None",
					},
					divide = {
						key_1 = "None",
						key_2 = "None",
					},
				},
				nopeus_interaction = {
					enabled = false,
					increase = {
						key_1 = "None",
						key_2 = "None",
					},
					decrease = {
						key_1 = "None",
						key_2 = "None",
					},
				},
				regular_keybinds = {
					enabled = true,
					play = {
						key_1 = "Wheel Up",
						key_2 = "None",
					},
					discard = {
						key_1 = "Wheel Down",
						key_2 = "None",
					},
					sort_by_rank = {
						key_1_gamepad = "Right Bumper",
						key_2_gamepad = "None",
					},
					sort_by_suit = {
						key_1_gamepad = "Left Bumper",
						key_2_gamepad = "None",
					},
				},
				deselect_hand = {
					enabled = true,
					key_1 = "Right Mouse",
					key_2 = "None",
					key_1_gamepad = "(B)",
					key_2_gamepad = "None",
				},
			},
			key = "better_mouse_and_gamepad",
		},
	},

	default = {
		user = {
			[1] = {
				config = nil,
				key = 1,
				name = "Preset 1",
				enabled = true,
			},
			[2] = {
				config = nil,
				key = 2,
				name = "Preset 2",
				enabled = true,
			},
			[3] = {
				config = nil,
				key = 3,
				name = "Preset 3",
				enabled = true,
			},
		},
		selected = -1,
	},
	current = {},

	save = function()
		love.filesystem.createDirectory("config")
		local serialized = "return " .. Handy.utils.serialize(Handy.presets.current)
		love.filesystem.write("config/Handy_Presets.jkr", serialized)
	end,
	load = function()
		Handy.presets.current = Handy.utils.table_merge({}, Handy.presets.default)
		local lovely_mod_presets = get_compressed("config/Handy_Presets.jkr")
		if lovely_mod_presets then
			Handy.presets.current = Handy.utils.table_merge(Handy.presets.current, STR_UNPACK(lovely_mod_presets))
		end
	end,

	save_index = function(index, options)
		local preset_to_save = Handy.presets.current.user[index]
		if not preset_to_save then
			return
		end

		options = options or {}
		if options.enabled ~= nil then
			preset_to_save.enabled = not not options.enabled
		end
		if options.name ~= nil then
			preset_to_save.name = options.name or ""
		end
		if options.apply then
			preset_to_save.config = Handy.utils.table_merge({}, Handy.config.current)
			Handy.presets.apply(preset_to_save, true)
		end
	end,
	clear_index = function(index)
		local preset_to_save = Handy.presets.current.user[index]
		if not preset_to_save then
			return
		end
		preset_to_save.config = nil
		if Handy.presets.current.selected == index then
			Handy.presets.current.selected = -1
		end
		Handy.presets.save()
	end,
	apply_index = function(index, no_save_config)
		return Handy.presets.apply(Handy.presets.current.user[index], no_save_config)
	end,
	apply_example = function(key, no_save_config)
		return Handy.presets.apply(Handy.presets.examples[key], no_save_config, true)
	end,
	apply = function(preset, no_save_config, no_change_selected)
		local config_to_apply = Handy.utils.table_merge({}, preset.config or {})

		-- Keep mod enabled state
		config_to_apply.handy = nil
		-- Keep presets state and keybinds
		config_to_apply.presets = nil
		-- Keep hide in menu button value
		config_to_apply.hide_in_menu = nil
		-- Keep notifications level
		config_to_apply.notifications_level = nil
		-- Bad idea
		config_to_apply.__empty = nil

		if not no_save_config then
			Handy.config.current =
				Handy.utils.table_merge({}, Handy.config.default, Handy.config.current, config_to_apply)
			Handy.cc = Handy.config.current
			Handy.config.save()
		end

		if not no_change_selected then
			Handy.presets.current.selected = preset.key or -1
		end
		Handy.presets.save()
	end,
}

Handy.presets.load()

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
		if not Handy.presets_switch.can_execute(key) then
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
					vars = { current_index, preset.name or "" },
				})
			elseif not preset.enabled then
				result_string = localize({
					type = "variable",
					key = "Handy_preset_disabled",
					vars = { current_index, preset.name or "" },
				})
			elseif not preset.config then
				result_string = localize({
					type = "variable",
					key = "Handy_preset_empty",
					vars = { current_index, preset.name or "" },
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
