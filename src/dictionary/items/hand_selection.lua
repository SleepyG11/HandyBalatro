Handy.dictionary.register({
	key = "hand_selection",
	keywords = { "hand selection select cards card" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.hand_selection
	end,

	items = {
		{
			key = "hand_selection_mode",
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
		},
		{
			key = "hand_selection_insta_highlight",
			keywords = { "swipe hover drag slide insta highlight quick" },
			keybind = {
				allow_multiple = "advanced",
			},
			checkbox = true,

			get_module = function(self)
				return Handy.cc.hand_selection_insta_highlight, { Handy.D.dictionary.hand_selection }
			end,

			loc_vars = function()
				return {
					vars = {
						Handy.L.brackets(Handy.L.keys("Left Mouse")),
					},
				}
			end,

			mods_deps = {
				["BetterMouseAndGamepad"] = "conflict",
			},
		},
		{
			key = "hand_selection_insta_highlight_allow_deselect",
			keywords = { "swipe hover drag slide insta highlight quick deselect unhighlight" },
			checkbox = true,

			get_module = function(self)
				return Handy.cc.hand_selection_insta_highlight_allow_deselect,
					{ Handy.D.dictionary.hand_selection, Handy.D.dictionary.hand_selection_insta_highlight }
			end,
			mods_deps = {
				["BetterMouseAndGamepad"] = "conflict",
			},
		},
		{
			key = "hand_selection_combine_select_deselect",
			keywords = { "swipe hover drag slide insta highlight quick deselect unhighlight combine combined" },
			checkbox = true,

			get_module = function(self)
				return Handy.cc.hand_selection_combine_select_deselect,
					{ Handy.D.dictionary.hand_selection, Handy.D.dictionary.hand_selection_insta_highlight }
			end,
			mods_deps = {
				["BetterMouseAndGamepad"] = "conflict",
			},
		},
		{
			key = "hand_selection_deselect_hand",
			keywords = { "deselect hand vanilla unhighlight all cards" },

			keybind = {
				allow_multiple = "advanced",
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.hand_selection_deselect_hand, { Handy.D.dictionary.hand_selection }
			end,

			loc_vars = function()
				return {
					vars = {
						Handy.L.brackets(Handy.L.keys("Right Mouse")),
					},
				}
			end,
		},
		{
			key = "hand_selection_entire_f_hand",
			keywords = { "select all cards hand highlight entire card" },
			keybind = {
				allow_multiple = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.hand_selection_entire_f_hand, { Handy.D.dictionary.hand_selection }
			end,
		},
	},
})
