Handy.dictionary.register({
	key = "appearance",
	order = 3,
	keywords = { "appearance buttons button toggle toggles checkboxes checkbox" },
})

Handy.dictionary.register({
	key = "notifications_level",
	parent = "appearance",
	order = 1,

	keywords = { "notifications popup" },
	get_module = function(self)
		return Handy.cc.notifications_level
	end,
	info_func = "handy_show_example_state_panel",

	option_cycle = {
		get_values = function()
			return {
				options = {
					Handy.L.dictionary("handy_notification_level_none"),
					Handy.L.dictionary("handy_notification_level_dangerous"),
					Handy.L.dictionary("handy_notification_level_essential"),
					Handy.L.dictionary("handy_notification_level_all"),
				},
			}
		end,
		callback = function()
			Handy.UI.state_panel.render(true)
		end,
	},
})
Handy.dictionary.register({
	key = "hide_options_button",
	parent = "appearance",
	order = 2,

	keywords = { "settings config mod blue button" },
	get_module = function(self)
		return Handy.cc.hide_options_button
	end,
	mod_deps = {
		["Steamodded"] = "required",
	},

	checkbox = true,
})
Handy.dictionary.register({
	key = "show_custom_pip",
	parent = "appearance",
	order = 3,

	keywords = {},
	get_module = function()
		return Handy.cc.show_custom_pip
	end,

	option_cycle = {
		get_values = function()
			return {
				options = {
					Handy.L.dictionary("handy_show_custom_pip_mode", 1),
					Handy.L.dictionary("handy_show_custom_pip_mode", 2),
					Handy.L.dictionary("handy_show_custom_pip_mode", 3),
				},
			}
		end,
	},
})
Handy.dictionary.register({
	key = "speed_multiplier_settings_toggle",
	parent = "appearance",
	order = 4,

	keywords = { "settings config speed multiplier more speed toggle checkbox cycle" },
	get_module = function(self)
		return Handy.cc.speed_multiplier_settings_toggle
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.speed_multiplier }
	end,
	no_mp = Handy.speed_multiplier.is_disabled_by_mp,

	checkbox = true,
})
Handy.dictionary.register({
	key = "animation_skip_settings_toggle",
	parent = "appearance",
	order = 5,

	keywords = { "settings config animation skip remove animations toggle checkbox cycle" },
	get_module = function(self)
		return Handy.cc.animation_skip_settings_toggle
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.animation_skip }
	end,
	no_mp = Handy.animation_skip.is_disabled_by_mp,

	checkbox = true,
})
