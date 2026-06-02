Handy.dictionary.register({
	key = "speed_multiplier",
	order = 7,

	keywords = { "speed multiplier", "fast faster more speed accelerate acceleration increase decrease" },
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

	checkbox = true,
})

Handy.dictionary.register({
	key = "speed_multiplier_current_value",
	parent = "speed_multiplier",
	order = 1,

	get_module = function(self)
		return Handy.cc.speed_multiplier
	end,
	get_deps = function(self)
		return { self.parent }
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
})
Handy.dictionary.register({
	key = "speed_multiplier_default_value",
	parent = "speed_multiplier",
	order = 2,

	keywords = { "default value on startup game start launch" },
	get_module = function(self)
		return Handy.cc.speed_multiplier_default_value
	end,
	get_deps = function(self)
		return { self.parent }
	end,
	no_mp = Handy.speed_multiplier.is_disabled_by_mp,

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
})
Handy.dictionary.register({
	key = "speed_multiplier_multiply",
	parent = "speed_multiplier",
	order = 3,

	keywords = { "increase" },
	get_module = function(self)
		return Handy.cc.speed_multiplier_multiply
	end,
	get_deps = function(self)
		return { self.parent }
	end,
	no_mp = Handy.speed_multiplier.is_disabled_by_mp,

	keybind = {
		allow_multiple = true,
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "speed_multiplier_divide",
	parent = "speed_multiplier",
	order = 4,

	keywords = { "decrease" },
	get_module = function(self)
		return Handy.cc.speed_multiplier_divide
	end,
	get_deps = function(self)
		return { self.parent }
	end,
	no_mp = Handy.speed_multiplier.is_disabled_by_mp,

	keybind = {
		allow_multiple = true,
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "speed_multiplier_toggle_temp_disabled",
	parent = "speed_multiplier",
	order = 5,

	keywords = { "toggle", "temporary disable" },
	get_module = function(self)
		return Handy.cc.speed_multiplier_toggle_temp_disabled
	end,
	get_deps = function(self)
		return { self.parent }
	end,
	no_mp = Handy.speed_multiplier.is_disabled_by_mp,

	keybind = {
		allow_multiple = true,
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "dangerous_actions_speed_multiplier_uncap",
	parent = "speed_multiplier",
	order = 6,

	keywords = { "dangerous max speed uncap unsafe" },
	dangerous = true,
	loc_vars = function()
		return {
			vars = {
				"x" .. Handy.speed_multiplier.max_speed,
			},
		}
	end,

	get_module = function(self)
		return Handy.cc.dangerous_actions_speed_multiplier_uncap
	end,
	get_deps = function(self)
		return { self.parent }
	end,
	no_mp = Handy.speed_multiplier.is_disabled_by_mp,

	checkbox = true,
})
