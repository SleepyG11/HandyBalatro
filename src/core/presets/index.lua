Handy.presets = {}
Handy.load_files({
	"default_config.lua",
	"examples.lua",
}, "src/core/presets/")
Handy.presets.current = Handy.utils.table_merge({}, Handy.presets.default)

--

Handy.presets.save_event = nil
Handy.presets.save_blocker = nil

function Handy.presets.save()
	Handy.presets.save_blocker = true
	love.filesystem.createDirectory("config")
	local serialized = "return " .. Handy.utils.serialize(Handy.presets.current)
	love.filesystem.write("config/Handy_Presets.jkr", serialized)
end
function Handy.presets.load()
	Handy.presets.current = Handy.utils.table_merge({}, Handy.presets.default)
	local lovely_mod_presets = get_compressed("config/Handy_Presets.jkr")
	if lovely_mod_presets then
		Handy.presets.current = Handy.utils.table_merge(Handy.presets.current, STR_UNPACK(lovely_mod_presets))
	end
end
function Handy.presets.request_save(delay)
	Handy.presets.save_blocker = nil
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
			pause_force = true,
			func = function()
				if not Handy.presets.save_blocker then
					Handy.presets.save()
				end
				return true
			end,
		})
		Handy.presets.save_event = event
		G.E_MANAGER:add_event(event, "other", true)
	end
	Handy.e_mitter.emit("presets_save")
end

--

Handy.presets.configs_blacklist = {
	-- mod global toggle
	"handy",
	-- appearance
	"hide_in_menu",
	"hide_options_button",
	"notifications_level",
	"speed_multiplier_settings_toggle",
	"animation_skip_settings_toggle",
	-- me
	"me_in_mod_config",
	"me_in_game_win",
	"me_in_game_over",
	"me_in_handy_tag",
	"me_in_screenswipe",
	-- general configs
	"current_device",
	"advanced_mode",
	-- presets
	"presets",
	"presets_load_1",
	"presets_load_2",
	"presets_load_3",
	"presets_load_next",
	-- mp extension
	"mp_extension_enabled_default_value",
	"mp_extension_speed_multiplier_mode_default_value",
	"mp_extension_animation_skip_mode_default_value",
	"mp_extension_dangerous_actions_mode_default_value",
	-- updater
	"updater",
	"updater_release_type",
	"updater_notify_about_new_update",
	"updater_auto_install_new_update",
	"updater_auto_restart_game_after_update",
	-- other
	"__empty",
}

function Handy.presets.apply(preset, no_save_config, no_change_selected)
	local config_to_apply = preset.config and Handy.config.actualize(preset.config) or { version = 2 }

	if not preset.ignore_blacklist then
		for _, key in ipairs(Handy.presets.configs_blacklist) do
			config_to_apply[key] = nil
		end
	end

	preset.config = config_to_apply

	if not no_save_config then
		Handy.config.current = Handy.utils.table_merge_limit(1, {}, Handy.config.current, config_to_apply)
		Handy.cc = Handy.config.current
		Handy.config.request_save()
	end

	if not no_change_selected then
		Handy.presets.current.selected = preset.key or -1
	end
	if preset.rerender then
		Handy.UI.rerender(true)
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

--

Handy.e_mitter.on("load", function()
	Handy.presets.load()
end)
