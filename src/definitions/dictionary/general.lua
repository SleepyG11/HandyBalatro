Handy.dictionary.register({
	key = "general",
	order = 1,

	keywords = { "general global common" },
	loc_vars = function()
		return {
			vars = { Handy.version, "SleepyG11" },
		}
	end,
})

Handy.dictionary.register({
	key = "handy",
	parent = "general",
	order = 1,

	keywords = { "mod enable disable toggle all" },
	get_module = function(self)
		return Handy.cc.handy
	end,

	checkbox = true,
})
Handy.dictionary.register({
	key = "keybinds_trigger_mode",
	parent = "general",
	order = 2,

	keywords = { "trigger mode on press on release key button" },
	get_module = function(self)
		return Handy.cc.keybinds_trigger_mode
	end,

	option_cycle = {
		get_values = function()
			return {
				options = {
					Handy.L.dictionary("handy_keybinds_trigger_mode_press"),
					Handy.L.dictionary("handy_keybinds_trigger_mode_release"),
				},
			}
		end,
	},
})
Handy.dictionary.register({
	key = "current_device",
	parent = "general",
	order = 3,

	keywords = { "current input device gamepad controller mouse keyboard auto" },
	get_module = function(self)
		return Handy.cc.current_device
	end,
	loc_vars = function()
		return { vars = { Handy.L.dictionary("handy_current_device_auto") } }
	end,

	option_cycle = {
		get_values = function()
			return {
				options = {
					Handy.L.dictionary("handy_current_device_auto"),
					Handy.L.dictionary("handy_current_device_keyboard"),
					Handy.L.dictionary("handy_current_device_gamepad"),
				},
			}
		end,
		callback = function()
			Handy.controller.device.update_type()
		end,
	},
})
Handy.dictionary.register({
	key = "prevent_if_debugplus",
	parent = "general",
	order = 4,

	keywords = { "debug plus prevent intersections keybinds" },
	get_module = function(self)
		return Handy.cc.prevent_if_debugplus
	end,
	loc_vars = function()
		return { vars = { Handy.L.brackets(Handy.L.keys("Ctrl")) } }
	end,

	checkbox = true,
})
