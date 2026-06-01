Handy.dictionary.register({
	key = "hand_selection",
	keywords = { "hand selection select cards card" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.hand_selection
	end,
})

Handy.dictionary.register({
	key = "hand_selection_mode",
	parent = "hand_selection",
	option_cycle = {
		get_values = function()
			return {
				options = {
					"Handy",
					"Better Mouse and Gamepad",
				},
			}
		end,
	},

	loc_vars = function(self)
		return {
			key = self.key .. (Handy.cc.advanced_mode.enabled and "_advanced" or ""),
			vars = {
				Handy.L.brackets(Handy.L.keys("Left Mouse")),
				Handy.L.brackets(Handy.L.name_text("Handy_ConfigDictionary", "hand_selection_deselect_hand")),
			},
		}
	end,

	get_module = function()
		return Handy.cc.hand_selection_mode
	end,
	get_deps = function(self)
		return { self.parent }
	end,
})
Handy.dictionary.register({
	key = "hand_selection_insta_highlight",
	parent = "hand_selection",
	keywords = { "swipe hover drag slide insta highlight quick" },
	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = true,

	get_module = function(self)
		return Handy.cc.hand_selection_insta_highlight
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	loc_vars = function()
		return {
			vars = {
				Handy.L.brackets(Handy.L.keys("Left Mouse")),
			},
		}
	end,

	mod_deps = {
		["BetterMouseAndGamepad"] = "conflict",
	},
})
Handy.dictionary.register({
	key = "hand_selection_insta_highlight_allow_deselect",
	parent = "hand_selection",
	keywords = { "swipe hover drag slide insta highlight quick deselect unhighlight" },
	checkbox = true,

	get_module = function(self)
		return Handy.cc.hand_selection_insta_highlight_allow_deselect
	end,
	get_deps = function(self)
		return { self.parent, Handy.D.dictionary.hand_selection_insta_highlight }
	end,

	mod_deps = {
		["BetterMouseAndGamepad"] = "conflict",
	},
})
Handy.dictionary.register({
	key = "hand_selection_combine_select_deselect",
	parent = "hand_selection",
	keywords = { "swipe hover drag slide insta highlight quick deselect unhighlight combine combined" },
	checkbox = true,

	get_module = function(self)
		return Handy.cc.hand_selection_combine_select_deselect
	end,
	get_deps = function(self)
		return { self.parent, Handy.D.dictionary.hand_selection_insta_highlight }
	end,
	mod_deps = {
		["BetterMouseAndGamepad"] = "conflict",
	},
})
Handy.dictionary.register({
	key = "hand_selection_deselect_hand",
	parent = "hand_selection",
	keywords = { "deselect hand vanilla unhighlight all cards" },

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},

	get_module = function(self)
		return Handy.cc.hand_selection_deselect_hand
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	loc_vars = function()
		return {
			vars = {
				Handy.L.brackets(Handy.L.keys("Right Mouse")),
			},
		}
	end,
})
Handy.dictionary.register({
	key = "hand_selection_entire_f_hand",
	parent = "hand_selection",
	keywords = { "select all cards hand highlight entire card" },
	keybind = {
		allow_multiple = true,
	},
	checkbox = {
		advanced = true,
	},

	get_module = function(self)
		return Handy.cc.hand_selection_entire_f_hand
	end,
	get_deps = function(self)
		return { self.parent }
	end,
})
