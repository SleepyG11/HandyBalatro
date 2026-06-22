Handy.dictionary.register({
	key = "move_highlight",
	order = 9,

	keywords = { "cards card select move selection highlight movement precise" },
	get_module = function(self)
		return Handy.cc.move_highlight
	end,
	no_gamepad = true,

	checkbox = true,
})

Handy.dictionary.register({
	key = "move_highlight_one_left",
	parent = "move_highlight",
	order = 1,

	keywords = { "left" },
	no_gamepad = true,
	get_module = function(self)
		return Handy.cc.move_highlight_dx_one_left
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
Handy.dictionary.register({
	key = "move_highlight_one_right",
	parent = "move_highlight",
	order = 2,

	keywords = { "right" },
	no_gamepad = true,
	get_module = function(self)
		return Handy.cc.move_highlight_dx_one_right
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
Handy.dictionary.register({
	key = "move_highlight_swap",
	parent = "move_highlight",
	order = 3,

	keywords = { "swap move card" },
	no_gamepad = true,
	get_module = function(self)
		return Handy.cc.move_highlight_swap
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	keybind = {
		allow_multiple = true,
		only_holdable = true,
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "move_highlight_to_end",
	parent = "move_highlight",
	order = 4,

	keywords = {},
	no_gamepad = true,
	get_module = function(self)
		return Handy.cc.move_highlight_to_end
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	keybind = {
		allow_multiple = true,
		only_holdable = true,
	},
	checkbox = {
		advanced = true,
	},
})
