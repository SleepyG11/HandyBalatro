Handy.dictionary.register({
	key = "presets",
	keywords = { "presets config layouts settings" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.presets
	end,
})

Handy.dictionary.register({
	key = "presets_load_1",
	parent = "presets",
	keywords = { "load 1" },
	keybind = {
		allow_multiple = "advanced",
		rerender = true,
	},
	checkbox = {
		advanced = true,
	},

	get_module = function(self)
		return Handy.cc.presets_load_1
	end,
	get_deps = function(self)
		return { self.parent }
	end,
})
Handy.dictionary.register({
	key = "presets_load_2",
	parent = "presets",
	keywords = { "load 2" },
	keybind = {
		allow_multiple = "advanced",
		rerender = true,
	},
	checkbox = {
		advanced = true,
	},

	get_module = function(self)
		return Handy.cc.presets_load_2
	end,
	get_deps = function(self)
		return { self.parent }
	end,
})
Handy.dictionary.register({
	key = "presets_load_3",
	parent = "presets",
	keywords = { "load 3" },
	keybind = {
		allow_multiple = "advanced",
		rerender = true,
	},
	checkbox = {
		advanced = true,
	},

	get_module = function(self)
		return Handy.cc.presets_load_3
	end,
	get_deps = function(self)
		return { self.parent }
	end,
})
Handy.dictionary.register({
	key = "presets_load_next",
	parent = "presets",
	keywords = { "load next" },
	keybind = {
		allow_multiple = "advanced",
		rerender = true,
	},
	checkbox = {
		advanced = true,
	},

	get_module = function(self)
		return Handy.cc.presets_load_next
	end,
	get_deps = function(self)
		return { self.parent }
	end,
})
