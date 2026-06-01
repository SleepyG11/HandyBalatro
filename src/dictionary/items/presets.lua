Handy.dictionary.register({
	key = "presets",
	keywords = { "presets config layouts settings" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.presets
	end,

	items = {
		{
			key = "presets_load_1",
			keywords = { "load 1" },
			keybind = {
				allow_multiple = "advanced",
				rerender = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.presets_load_1, { Handy.D.dictionary.presets }
			end,
		},
		{
			key = "presets_load_2",
			keywords = { "load 2" },
			keybind = {
				allow_multiple = "advanced",
				rerender = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.presets_load_2, { Handy.D.dictionary.presets }
			end,
		},
		{
			key = "presets_load_3",
			keywords = { "load 3" },
			keybind = {
				allow_multiple = "advanced",
				rerender = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.presets_load_3, { Handy.D.dictionary.presets }
			end,
		},
		{
			key = "presets_load_next",
			keywords = { "load next" },
			keybind = {
				allow_multiple = "advanced",
				rerender = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.presets_load_next, { Handy.D.dictionary.presets }
			end,
		},
	},
})
