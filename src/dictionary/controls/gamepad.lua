Handy.dictionary.register({
	key = "gamepad",
	keywords = { "gamepad controller" },

	items = {
		{
			key = "controller_sensitivity",
			keywords = { "cursor sensitivity speed" },
			get_module = function(self)
				return Handy.cc.controller_sensitivity
			end,
			checkbox = {
				callback = function()
					Handy.controller_sensitivity.apply()
				end,
			},
			slider = {
				min = 0.5,
				max = 2,
				decimal_places = 2,
				save = true,
				get_values = function()
					return {}
				end,
				callback = function()
					Handy.controller_sensitivity.apply()
				end,
			},
		},
		{
			key = "swap_controller_cursor_stick",
			keywords = { "stick sticks swap change" },
			get_module = function(self)
				return Handy.cc.swap_controller_cursor_stick
			end,
			loc_vars = function()
				return {
					vars = {
						Handy.L.brackets(Handy.L.keys("Right Stick")),
						Handy.L.brackets(Handy.L.keys("Left Stick")),
					},
				}
			end,
			checkbox = true,
		},
	},
})
