Handy.presets = setmetatable({}, {})

Handy.load_file("src/presets/default_config.lua")
Handy.load_file("src/presets/examples.lua")

--

Handy.config.save_event = nil

function Handy.presets.load()
	Handy.presets.current = Handy.utils.table_merge({}, Handy.presets.default)
	local lovely_mod_presets = get_compressed("config/Handy_Presets.jkr")
	if lovely_mod_presets then
		Handy.presets.current = Handy.utils.table_merge(Handy.presets.current, STR_UNPACK(lovely_mod_presets))
	end
end
function Handy.presets.save()
	love.filesystem.createDirectory("config")
	local serialized = "return " .. Handy.utils.serialize(Handy.presets.current)
	love.filesystem.write("config/Handy_Presets.jkr", serialized)
end
function Handy.presets.request_save(delay)
	if Handy.presets.save_event and not Handy.presets.save_event.complete then
		Handy.presets.save_event.time = G.TIMERS[Handy.presets.save_event.timer]
	else
		local event = Event({
			no_delete = true,
			blocking = false,
			blockable = false,
			timer = "REAL",
			trigger = "after",
			delay = delay or 1,
			func = function()
				Handy.presets.save()
				return true
			end,
		})
		Handy.presets.save_event = event
		G.E_MANAGER:add_event(event, "other", true)
	end
	Handy.e_mitter.emit("presets_save")
end

--

function Handy.presets.apply(preset, no_save_config, no_change_selected)
	local config_to_apply = preset.config and Handy.config.actualize(preset.config) or { version = 2 }

	-- Keep mod enabled state
	config_to_apply.handy = nil
	-- Keep advanced mode
	config_to_apply.advanced_mode = nil
	-- Keep presets state and keybinds
	config_to_apply.presets = nil
	config_to_apply.presets_load_1 = nil
	config_to_apply.presets_load_2 = nil
	config_to_apply.presets_load_3 = nil
	config_to_apply.presets_load_next = nil
	-- Keep hide in menu button value
	config_to_apply.hide_in_menu = nil
	config_to_apply.hide_options_button = nil
	-- Keep notifications level
	config_to_apply.notifications_level = nil
	-- Keep current device setting
	config_to_apply.current_device = nil
	-- Displaying option cycle in settings
	config_to_apply.speed_multiplier_settings_toggle = nil
	config_to_apply.animation_skip_settings_toggle = nil
	-- Keep MP extension
	config_to_apply.mp_extension_enabled_default_value = nil
	config_to_apply.mp_extension_speed_multiplier_mode_default_value = nil
	config_to_apply.mp_extension_animation_skip_mode_default_value = nil
	config_to_apply.mp_extension_dangerous_actions_mode_default_value = nil
	-- Bad idea
	config_to_apply.__empty = nil

	preset.config = config_to_apply

	if not no_save_config then
		Handy.config.current = Handy.utils.table_merge_limit(1, {}, Handy.config.current, config_to_apply)
		Handy.cc = Handy.config.current
		Handy.config.request_save()
	end

	if not no_change_selected then
		Handy.presets.current.selected = preset.key or -1
	end
	Handy.presets.request_save()
end
function Handy.presets.apply_index(index, no_save_config)
	return Handy.presets.apply(Handy.presets.current.user[index], no_save_config)
end
function Handy.presets.apply_example(key, no_save_config)
	return Handy.presets.apply(Handy.presets.examples[key], no_save_config, true)
end

--

function Handy.presets.save_index(index, options)
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
	else
		Handy.presets.request_save()
	end
end
function Handy.presets.clear_index(index)
	local preset_to_save = Handy.presets.current.user[index]
	if not preset_to_save then
		return
	end
	preset_to_save.config = nil
	if Handy.presets.current.selected == index then
		Handy.presets.current.selected = -1
	end
	Handy.presets.request_save()
end

Handy.presets.load()
