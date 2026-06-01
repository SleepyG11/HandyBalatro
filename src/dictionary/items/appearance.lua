Handy.dictionary.register({
	key = "appearance",
	keywords = { "appearance buttons button toggle toggles checkboxes checkbox" },

	items = {
		{
			key = "notifications_level",
			keywords = { "notifications popup" },
			get_module = function(self)
				return Handy.cc.notifications_level
			end,
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
			info_func = "handy_show_example_state_panel",
		},
		{
			key = "hide_options_button",
			keywords = { "settings config mod blue button" },
			get_module = function(self)
				return Handy.cc.hide_options_button
			end,
			checkbox = true,
			mods_deps = {
				["Steamodded"] = "required",
			},
		},
		{
			key = "show_custom_pip",
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
		},
		{
			key = "speed_multiplier_settings_toggle",
			keywords = { "settings config speed multiplier more speed toggle checkbox cycle" },
			get_module = function(self)
				return Handy.cc.speed_multiplier_settings_toggle, { Handy.D.dictionary.speed_multiplier }
			end,
			checkbox = true,
			no_mp = Handy.speed_multiplier.is_disabled_by_mp,
		},
		{
			key = "animation_skip_settings_toggle",
			keywords = { "settings config animation skip remove animations toggle checkbox cycle" },
			get_module = function(self)
				return Handy.cc.animation_skip_settings_toggle, { Handy.D.dictionary.animation_skip }
			end,
			checkbox = true,
			no_mp = Handy.animation_skip.is_disabled_by_mp,
		},
	},
})
