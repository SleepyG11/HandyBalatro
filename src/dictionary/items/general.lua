Handy.dictionary.register({
	key = "general",

	keywords = { "general global common" },
	loc_vars = function()
		return {
			vars = { Handy.version, "SleepyG11" },
		}
	end,

	items = {
		{
			key = "handy",

			keywords = { "mod enable disable toggle all" },

			get_module = function(self)
				return Handy.cc.handy
			end,
			checkbox = true,
		},
		{
			key = "keybinds_trigger_mode",
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
		},
		{
			key = "current_device",
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
		},
		{
			key = "prevent_if_debugplus",
			keywords = { "debug plus prevent intersections keybinds" },
			get_module = function(self)
				return Handy.cc.prevent_if_debugplus
			end,
			loc_vars = function()
				return { vars = { Handy.L.brackets(Handy.L.keys("Ctrl")) } }
			end,
			checkbox = true,
		},
	},
})
