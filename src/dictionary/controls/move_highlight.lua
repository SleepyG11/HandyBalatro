Handy.dictionary.register({
	key = "move_highlight",
	keywords = { "cards card selection highlight movement precise" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.move_highlight
	end,

	no_gamepad = true,
})

Handy.dictionary.register({
	key = "move_highlight_one_left",
	parent = "move_highlight",
	keywords = { "left" },
	keybind = {
		allow_multiple = true,
	},
	no_gamepad = true,

	checkbox = {
		advanced = true,
	},

	get_module = function(self)
		return Handy.cc.move_highlight_dx_one_left
	end,
	get_deps = function(self)
		return { self.parent }
	end,
})
Handy.dictionary.register({
	key = "move_highlight_one_right",
	parent = "move_highlight",
	keywords = { "right" },
	keybind = {
		allow_multiple = true,
	},
	no_gamepad = true,
	checkbox = {
		advanced = true,
	},
	get_module = function(self)
		return Handy.cc.move_highlight_dx_one_right
	end,
	get_deps = function(self)
		return { self.parent }
	end,
})
Handy.dictionary.register({
	key = "move_highlight_swap",
	parent = "move_highlight",
	keywords = { "swap move card" },
	keybind = {
		allow_multiple = true,
		only_holdable = true,
	},
	no_gamepad = true,
	checkbox = {
		advanced = true,
	},
	get_module = function(self)
		return Handy.cc.move_highlight_swap
	end,
	get_deps = function(self)
		return { self.parent }
	end,
})
Handy.dictionary.register({
	key = "move_highlight_to_end",
	parent = "move_highlight",
	keywords = {},
	keybind = {
		allow_multiple = true,
		only_holdable = true,
	},
	no_gamepad = true,
	checkbox = {
		advanced = true,
	},
	get_module = function(self)
		return Handy.cc.move_highlight_to_end
	end,
	get_deps = function(self)
		return { self.parent }
	end,
})
