Handy.API.Dictionary({
	key = "dangerous_actions",
	order = 100,

	keywords = { "dangerous unsafe" },
	get_module = function(self)
		return Handy.cc.dangerous_actions
	end,

	checkbox = true,
	dangerous = true,
})

Handy.API.Dictionary({
	key = "dangerous_actions_sell_one",
	parent = "dangerous_actions",
	order = 1,

	keywords = { "quick instant mass sell in bulk" },
	dangerous = true,
	get_module = function(self)
		return Handy.cc.dangerous_actions_sell_one
	end,
	no_mp = Handy.dangerous_actions.is_sell_disabled_in_mp,

	checkbox = true,
	keybind = {
		allow_multiple = true,
	},
})
Handy.API.Dictionary({
	key = "dangerous_actions_remove_one",
	parent = "dangerous_actions",
	order = 2,

	keywords = { "quick instant mass remove in bulk card cards skip tags" },
	dangerous = true,
	get_module = function(self)
		return Handy.cc.dangerous_actions_remove_one
	end,
	no_mp = Handy.dangerous_actions.is_remove_disabled_in_mp,

	checkbox = true,
	keybind = {
		allow_multiple = true,
	},
})
Handy.API.Dictionary({
	key = "dangerous_actions_mass_sell_remove_mode",
	parent = "dangerous_actions",
	order = 3,

	get_module = function()
		return Handy.cc.dangerous_actions_mass_sell_remove_mode
	end,
	dangerous = true,
	loc_vars = function()
		return {
			vars = {
				Handy.L.brackets(Handy.L.name_text("Handy_ConfigDictionary", "dangerous_actions_sell_all_same")),
				Handy.L.brackets(Handy.L.name_text("Handy_ConfigDictionary", "dangerous_actions_remove_all_same")),
				Handy.L.brackets(Handy.L.name_text("Handy_ConfigDictionary", "dangerous_actions_sell_all")),
				Handy.L.brackets(Handy.L.name_text("Handy_ConfigDictionary", "dangerous_actions_remove_all")),
			},
		}
	end,

	option_cycle = {
		get_values = function()
			return {
				options = {
					Handy.L.dictionary("handy_dangerous_actions_mass_sell_remove_mode", 1),
					Handy.L.dictionary("handy_dangerous_actions_mass_sell_remove_mode", 2),
				},
			}
		end,
	},
})
Handy.API.Dictionary({
	key = "dangerous_actions_sell_all_same",
	parent = "dangerous_actions",
	order = 4,

	keywords = { "quick instant mass sell in bulk all same copies card cards" },
	dangerous = true,
	get_module = function(self)
		return Handy.cc.dangerous_actions_sell_all_same
	end,
	no_mp = Handy.dangerous_actions.is_sell_disabled_in_mp,

	checkbox = true,
	keybind = {
		allow_multiple = true,
	},
})
Handy.API.Dictionary({
	key = "dangerous_actions_remove_all_same",
	parent = "dangerous_actions",
	order = 5,

	keywords = { "quick instant mass remove in bulk all same copies card cards skip tags" },
	dangerous = true,
	get_module = function(self)
		return Handy.cc.dangerous_actions_remove_all_same
	end,
	no_mp = Handy.dangerous_actions.is_remove_disabled_in_mp,

	checkbox = true,
	keybind = {
		allow_multiple = true,
	},
})
Handy.API.Dictionary({
	key = "dangerous_actions_sell_all",
	parent = "dangerous_actions",
	order = 6,

	keywords = { "quick instant mass sell in bulk all card cards" },
	dangerous = true,
	get_module = function(self)
		return Handy.cc.dangerous_actions_sell_all
	end,
	no_mp = Handy.dangerous_actions.is_sell_disabled_in_mp,

	checkbox = true,
	keybind = {
		allow_multiple = true,
	},
})
Handy.API.Dictionary({
	key = "dangerous_actions_remove_all",
	parent = "dangerous_actions",
	order = 7,

	keywords = { "quick instant mass remove in bulk all card cards skip tags" },
	dangerous = true,
	get_module = function(self)
		return Handy.cc.dangerous_actions_remove_all
	end,
	no_mp = Handy.dangerous_actions.is_remove_disabled_in_mp,

	checkbox = true,
	keybind = {
		allow_multiple = true,
	},
})
Handy.API.Dictionary({
	key = "dangerous_actions_crash",
	parent = "dangerous_actions",
	order = 8,

	keywords = { "crash game fuck you" },
	dangerous = true,
	get_module = function(self)
		return Handy.cc.dangerous_actions_crash
	end,
	no_mp = true,

	checkbox = true,
	keybind = {
		allow_multiple = true,
		only_safe = true,
	},
})
Handy.API.Dictionary({
	key = "dangerous_actions_stack_overflow",
	parent = "dangerous_actions",
	order = 9,

	keywords = { "crash game fuck you stack overflow" },
	dangerous = true,
	get_module = function(self)
		return Handy.cc.dangerous_actions_stack_overflow
	end,
	no_mp = true,

	checkbox = true,
	keybind = {
		allow_multiple = true,
		only_safe = true,
	},
})
