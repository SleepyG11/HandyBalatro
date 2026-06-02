Handy.dictionary.register({
	key = "presets",
	order = 11,

	keywords = { "presets config layouts settings" },
	get_module = function(self)
		return Handy.cc.presets
	end,

	checkbox = true,
})

Handy.dictionary.register({
	key = "presets_load_1",
	parent = "presets",
	order = 1,

	keywords = { "load 1" },
	get_module = function(self)
		return Handy.cc.presets_load_1
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	keybind = {
		allow_multiple = "advanced",
		rerender = true,
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "presets_load_2",
	parent = "presets",
	order = 2,

	keywords = { "load 2" },
	get_module = function(self)
		return Handy.cc.presets_load_2
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	keybind = {
		allow_multiple = "advanced",
		rerender = true,
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "presets_load_3",
	parent = "presets",
	order = 3,

	keywords = { "load 3" },
	get_module = function(self)
		return Handy.cc.presets_load_3
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	keybind = {
		allow_multiple = "advanced",
		rerender = true,
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "presets_load_next",
	parent = "presets",
	order = 4,

	keywords = { "load next" },
	get_module = function(self)
		return Handy.cc.presets_load_next
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	keybind = {
		allow_multiple = "advanced",
		rerender = true,
	},
	checkbox = {
		advanced = true,
	},
})
