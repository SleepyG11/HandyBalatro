Handy.dictionary.register({
	key = "insta_actions",
	keywords = { "insta quick actions quick buy sell use" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.insta_actions
	end,
})

Handy.dictionary.register({
	key = "insta_actions_trigger_mode",
	parent = "insta_actions",
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
	keywords = { "buy or sell card cards" },
	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = true,

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
})
Handy.dictionary.register({
	key = "insta_actions_buy_n_sell",
	parent = "insta_actions",
	keywords = { "buy and sell buy n sell card cards" },
	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = true,

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
})
Handy.dictionary.register({
	key = "insta_actions_use",
	parent = "insta_actions",
	keywords = { "use consumables consumeables card cards" },
	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = true,

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
})
