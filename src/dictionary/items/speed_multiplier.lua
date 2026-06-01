Handy.dictionary.register({
	key = "speed_multiplier",
	keywords = { "speed multiplier", "fast faster more speed accelerate acceleration increase decrease" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.speed_multiplier
	end,

	loc_vars = function(self)
		return {
			key = self.key .. (Handy.cc.advanced_mode.enabled and "_advanced" or ""),
			vars = { "x128" },
		}
	end,

	no_mp = Handy.speed_multiplier.is_disabled_by_mp,

	items = {
		{
			key = "speed_multiplier_current_value",
			get_module = function(self)
				return Handy.cc.speed_multiplier
			end,

			no_mp = Handy.speed_multiplier.is_disabled_by_mp,

			simple_option_cycle = {
				left_callback = function()
					Handy.speed_multiplier.change(-1)
				end,
				right_callback = function()
					Handy.speed_multiplier.change(1)
				end,
				get_values = function()
					return {
						ref_table = Handy.speed_multiplier,
						ref_value = "value_text",
						prefix = Handy.L.name_text("Handy_ConfigDictionary", "speed_multiplier") .. ": ",
					}
				end,
				colour = G.C.CHIPS,
			},
		},
		{
			key = "speed_multiplier_default_value",
			keywords = { "default value on startup game start launch" },
			get_module = function(self)
				return Handy.cc.speed_multiplier_default_value, { Handy.D.dictionary.speed_multiplier }
			end,
			checkbox = {
				advanced = true,
			},
			option_cycle = {
				get_values = function()
					return {
						options = {
							"1x",
							"1.5x",
							"2x",
							"4x",
							"8x",
							"16x",
							"32x",
							"64x",
							"128x",
							"256x",
							"512x",
						},
					}
				end,
			},
			no_mp = Handy.speed_multiplier.is_disabled_by_mp,
		},
		{
			key = "speed_multiplier_multiply",
			keywords = { "increase" },
			keybind = {
				allow_multiple = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.speed_multiplier_multiply, { Handy.D.dictionary.speed_multiplier }
			end,
			no_mp = Handy.speed_multiplier.is_disabled_by_mp,
		},
		{
			key = "speed_multiplier_divide",
			keywords = { "decrease" },
			keybind = {
				allow_multiple = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.speed_multiplier_divide, { Handy.D.dictionary.speed_multiplier }
			end,
			no_mp = Handy.speed_multiplier.is_disabled_by_mp,
		},
		{
			key = "speed_multiplier_toggle_temp_disabled",
			keywords = { "toggle", "temporary disable" },
			keybind = {
				allow_multiple = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.speed_multiplier_toggle_temp_disabled, { Handy.D.dictionary.speed_multiplier }
			end,
			no_mp = Handy.speed_multiplier.is_disabled_by_mp,
		},
		{
			key = "dangerous_actions_speed_multiplier_uncap",
			keywords = { "dangerous max speed uncap unsafe" },
			dangerous = true,
			checkbox = true,

			loc_vars = function()
				return {
					vars = {
						"x" .. Handy.speed_multiplier.max_speed,
					},
				}
			end,

			get_module = function(self)
				return Handy.cc.dangerous_actions_speed_multiplier_uncap, { Handy.D.dictionary.speed_multiplier }
			end,
			no_mp = Handy.speed_multiplier.is_disabled_by_mp,
		},
	},
})
