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
				animation_skip = {
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
						key_1 = "Mouse 5",
						key_2 = "None",
						key_1_gamepad = "Right Bumper",
						key_2_gamepad = "None",
					},
					sort_by_suit = {
						key_1 = "Mouse 4",
						key_2 = "None",
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
		config_to_apply.hide_options_button = nil
		-- Keep notifications level
		config_to_apply.notifications_level = nil
		-- Keep current device setting
		config_to_apply.current_device = nil
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
