Handy.API.Dictionary({
	key = "hand_selection",
	order = 6,

	keywords = { "hand selection select cards card" },
	get_module = function(self)
		return Handy.cc.hand_selection
	end,

	checkbox = true,
})

Handy.API.Dictionary({
	key = "hand_selection_mode",
	parent = "hand_selection",
	order = 1,

	keywords = { "better mouse and gamepad bmag" },
	loc_vars = function(self)
		return {
			-- key = self.key .. (Handy.cc.advanced_mode.enabled and "_advanced" or ""),
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
})
Handy.API.Dictionary({
	key = "hand_selection_insta_highlight",
	parent = "hand_selection",
	order = 2,

	keywords = { "select swipe hover drag slide insta highlight quick hand card cards" },
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

	keybind = {
		allow_multiple = true,
	},
	checkbox = true,
})
Handy.API.Dictionary({
	key = "hand_selection_insta_highlight_allow_deselect",
	parent = "hand_selection",
	order = 3,

	keywords = { "swipe hover drag slide insta highlight quick deselect unhighlight hand card cards" },
	get_module = function(self)
		return Handy.cc.hand_selection_insta_highlight_allow_deselect
	end,
	get_deps = function(self)
		return { self.parent, Handy.D.dictionary.hand_selection_insta_highlight }
	end,

	mod_deps = {
		["BetterMouseAndGamepad"] = "conflict",
	},

	checkbox = true,
})
Handy.API.Dictionary({
	key = "hand_selection_combine_select_deselect",
	parent = "hand_selection",
	order = 4,

	keywords = {
		"select swipe hover drag slide insta highlight quick deselect unhighlight combine combined hand card cards",
	},
	get_module = function(self)
		return Handy.cc.hand_selection_combine_select_deselect
	end,
	get_deps = function(self)
		return { self.parent, Handy.D.dictionary.hand_selection_insta_highlight }
	end,
	mod_deps = {
		["BetterMouseAndGamepad"] = "conflict",
	},

	checkbox = true,
})
Handy.API.Dictionary({
	key = "hand_selection_deselect_hand",
	parent = "hand_selection",
	order = 5,

	keywords = { "deselect unhighlight all hand card cards" },
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

	keybind = {
		allow_multiple = true,
	},
	checkbox = {
		advanced = true,
	},
})
Handy.API.Dictionary({
	key = "hand_selection_entire_f_hand",
	parent = "hand_selection",
	order = 6,

	keywords = { "select all cards hand highlight entire card" },
	get_module = function(self)
		return Handy.cc.hand_selection_entire_f_hand
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	keybind = {
		allow_multiple = true,
	},
	checkbox = {
		advanced = true,
	},
})
