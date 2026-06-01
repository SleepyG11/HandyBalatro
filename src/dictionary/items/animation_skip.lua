Handy.dictionary.register({
	key = "animation_skip",
	keywords = { "animation skip", "faster remove no animations animation nopeus instant scoring game" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.animation_skip
	end,
	loc_vars = function()
		return {
			vars = {
				Handy.L.dictionary("handy_animation_skip_levels", 1),
				Handy.L.dictionary("handy_animation_skip_levels", 2),
				Handy.L.dictionary("handy_animation_skip_levels", 3),
				Handy.L.dictionary("handy_animation_skip_levels", 4),
			},
		}
	end,

	no_mp = Handy.animation_skip.is_disabled_by_mp,

	items = {
		{
			key = "animation_skip_current_value",
			get_module = function(self)
				return Handy.cc.animation_skip_default_value, { Handy.D.dictionary.animation_skip }
			end,
			simple_option_cycle = {
				left_callback = function()
					Handy.animation_skip.change(-1)
				end,
				right_callback = function()
					Handy.animation_skip.change(1)
				end,
				get_values = function()
					return {
						ref_table = Handy.animation_skip,
						ref_value = "value_text",
						prefix = Handy.L.name_text("Handy_ConfigDictionary", "animation_skip") .. ": ",
					}
				end,
				colour = G.C.ORANGE,
			},
			no_mp = Handy.animation_skip.is_disabled_by_mp,
		},
		{
			key = "animation_skip_default_value",
			keywords = { "default value on startup game start launch" },
			get_module = function(self)
				return Handy.cc.animation_skip_default_value, { Handy.D.dictionary.animation_skip }
			end,
			checkbox = {
				advanced = true,
			},
			option_cycle = {
				get_values = function()
					return {
						options = {
							Handy.L.dictionary("handy_animation_skip_levels", 1),
							Handy.L.dictionary("handy_animation_skip_levels", 2),
							Handy.L.dictionary("handy_animation_skip_levels", 3),
							Handy.L.dictionary("handy_animation_skip_levels", 4),
						},
					}
				end,
			},
			no_mp = Handy.animation_skip.is_disabled_by_mp,
		},
		{
			key = "animation_skip_increase",
			keywords = { "increase" },
			keybind = {
				allow_multiple = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.animation_skip_increase, { Handy.D.dictionary.animation_skip }
			end,
			no_mp = Handy.animation_skip.is_disabled_by_mp,
		},
		{
			key = "animation_skip_decrease",
			keywords = { "decrease" },
			keybind = {
				allow_multiple = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.animation_skip_decrease, { Handy.D.dictionary.animation_skip }
			end,
			no_mp = Handy.animation_skip.is_disabled_by_mp,
		},
		{
			key = "animation_skip_toggle_temp_disabled",
			keywords = { "toggle", "temporary disable" },
			keybind = {
				allow_multiple = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.animation_skip_toggle_temp_disabled, { Handy.D.dictionary.animation_skip }
			end,
			no_mp = Handy.animation_skip.is_disabled_by_mp,
		},
		{
			key = "dangerous_actions_animation_skip_unsafe",
			keywords = { "no animations", "dangerous unsafe remove all animations" },
			checkbox = true,
			dangerous = true,

			loc_vars = function()
				return {
					vars = {
						Handy.L.dictionary("handy_animation_skip_levels", 5),
					},
				}
			end,

			get_module = function(self)
				return Handy.cc.dangerous_actions_animation_skip_unsafe, { Handy.D.dictionary.animation_skip }
			end,
			no_mp = Handy.animation_skip.is_disabled_by_mp,
		},
	},
})
