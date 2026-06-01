Handy.dictionary.register({
	key = "general",

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

	keywords = { "mod enable disable toggle all" },

	get_module = function(self)
		return Handy.cc.handy
	end,
	checkbox = true,
})
Handy.dictionary.register({
	key = "keybinds_trigger_mode",
	parent = "general",
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
	keywords = { "current input device gamepad controller mouse keyboard auto" },
	get_module = function(self)
		return Handy.cc.current_device
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
	loc_vars = function()
		return { vars = { Handy.L.dictionary("handy_current_device_auto") } }
	end,
})
Handy.dictionary.register({
	key = "prevent_if_debugplus",
	parent = "general",
	keywords = { "debug plus prevent intersections keybinds" },
	get_module = function(self)
		return Handy.cc.prevent_if_debugplus
	end,
	loc_vars = function()
		return { vars = { Handy.L.brackets(Handy.L.keys("Ctrl")) } }
	end,
	checkbox = true,
})
