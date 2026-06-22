Handy.dictionary.register({
	key = "insta_actions",
	order = 10,

	keywords = { "instant fast insta quick actions buy sell use" },
	get_module = function(self)
		return Handy.cc.insta_actions
	end,

	checkbox = true,
})

Handy.dictionary.register({
	key = "insta_actions_trigger_mode",
	parent = "insta_actions",
	order = 1,

	keywords = { "trigger mode" },
	get_module = function(self)
		return Handy.cc.insta_actions_trigger_mode
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	option_cycle = {
		save = true,
		get_values = function()
			return {
				options = {
					Handy.L.dictionary("handy_buy_sell_use_mode_hold_n_click"),
					Handy.L.dictionary("handy_buy_sell_use_mode_hover_n_press"),
				},
			}
		end,
	},
})
Handy.dictionary.register({
	key = "insta_actions_buy_or_sell",
	parent = "insta_actions",
	order = 2,

	keywords = { "buy or sell card cards" },
	get_module = function(self)
		return Handy.cc.insta_actions_buy_or_sell
	end,
	get_deps = function(self)
		return { self.parent }
	end,
	loc_vars = function()
		return {
			vars = { Handy.L.name_text("Handy_ConfigDictionary", "insta_actions_trigger_mode") },
			key = Handy.cc.insta_actions_trigger_mode.value == 2 and "insta_actions_buy_or_sell_alt" or nil,
		}
	end,

	checkbox = true,
	keybind = {
		allow_multiple = "advanced",
	},
})
Handy.dictionary.register({
	key = "insta_actions_buy_n_sell",
	parent = "insta_actions",
	order = 3,

	keywords = { "buy and sell buy n sell card cards" },
	get_module = function(self)
		return Handy.cc.insta_actions_buy_n_sell
	end,
	get_deps = function(self)
		return { self.parent }
	end,
	loc_vars = function()
		return {
			vars = { Handy.L.name_text("Handy_ConfigDictionary", "insta_actions_trigger_mode") },
			key = Handy.cc.insta_actions_trigger_mode.value == 2 and "insta_actions_buy_n_sell_alt" or nil,
		}
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = true,
})
Handy.dictionary.register({
	key = "insta_actions_use",
	parent = "insta_actions",
	order = 4,

	keywords = { "use consumable consumables consumeable consumeables card cards" },
	get_module = function(self)
		return Handy.cc.insta_actions_use
	end,
	get_deps = function(self)
		return { self.parent }
	end,
	loc_vars = function()
		return {
			vars = { Handy.L.name_text("Handy_ConfigDictionary", "insta_actions_trigger_mode") },
			key = Handy.cc.insta_actions_trigger_mode.value == 2 and "insta_actions_use_alt" or nil,
		}
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = true,
})
