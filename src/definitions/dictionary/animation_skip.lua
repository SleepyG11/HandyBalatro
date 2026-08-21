Handy.API.Dictionary({
	key = "animation_skip",
	order = 8,

	keywords = { "animation skip", "faster remove no animations animation nopeus instant scoring game" },
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

	checkbox = true,
})

Handy.API.Dictionary({
	key = "animation_skip_current_value",
	parent = "animation_skip",
	order = 1,

	get_module = function(self)
		return Handy.cc.animation_skip_default_value
	end,
	get_deps = function(self)
		return { self.parent }
	end,
	no_mp = Handy.animation_skip.is_disabled_by_mp,

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
})
Handy.API.Dictionary({
	key = "animation_skip_default_value",
	parent = "animation_skip",
	order = 2,

	keywords = { "default value on startup game start launch" },
	get_module = function(self)
		return Handy.cc.animation_skip_default_value
	end,
	get_deps = function(self)
		return { self.parent }
	end,
	no_mp = Handy.animation_skip.is_disabled_by_mp,

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
})
Handy.API.Dictionary({
	key = "animation_skip_increase",
	parent = "animation_skip",
	order = 3,

	keywords = { "increase up speedup faster fast" },
	get_module = function(self)
		return Handy.cc.animation_skip_increase
	end,
	get_deps = function(self)
		return { self.parent }
	end,
	no_mp = Handy.animation_skip.is_disabled_by_mp,

	keybind = {
		allow_multiple = true,
	},
	checkbox = {
		advanced = true,
	},
})
Handy.API.Dictionary({
	key = "animation_skip_decrease",
	parent = "animation_skip",
	order = 4,

	keywords = { "decrease down slowdown slower slow" },
	get_module = function(self)
		return Handy.cc.animation_skip_decrease
	end,
	get_deps = function(self)
		return { self.parent }
	end,
	no_mp = Handy.animation_skip.is_disabled_by_mp,

	keybind = {
		allow_multiple = true,
	},
	checkbox = {
		advanced = true,
	},
})
Handy.API.Dictionary({
	key = "animation_skip_toggle_temp_disabled",
	parent = "animation_skip",
	order = 5,

	keywords = { "toggle", "temporary disable temp enable disable" },
	get_module = function(self)
		return Handy.cc.animation_skip_toggle_temp_disabled
	end,
	get_deps = function(self)
		return { self.parent }
	end,
	no_mp = Handy.animation_skip.is_disabled_by_mp,

	keybind = {
		allow_multiple = true,
	},
	checkbox = {
		advanced = true,
	},
})
Handy.API.Dictionary({
	key = "dangerous_actions_animation_skip_unsafe",
	parent = "animation_skip",
	order = 6,

	keywords = { "no animation", "dangerous unsafe remove all animations instant fast" },
	dangerous = true,
	loc_vars = function()
		return {
			vars = {
				Handy.L.dictionary("handy_animation_skip_levels", 5),
			},
		}
	end,
	get_module = function(self)
		return Handy.cc.dangerous_actions_animation_skip_unsafe
	end,
	get_deps = function(self)
		return { self.parent }
	end,
	no_mp = Handy.animation_skip.is_disabled_by_mp,

	checkbox = true,
})
