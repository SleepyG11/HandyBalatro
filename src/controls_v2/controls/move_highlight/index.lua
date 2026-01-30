Handy.load_file("src/controls_v2/controls/move_highlight/logic.lua")

Handy.controls_v2.register("move_highlight_one_left", {
	get_module = function()
		return Handy.cc.move_highlight_dx_one_left, { Handy.cc.move_highlight }
	end,

	context_types = {
		input = {
			mouse = true,
			wheel = true,
			keyboard = true,
			gamepad = false,
		},
	},

	in_run = true,

	trigger = "trigger",

	can_execute = Handy.move_highlight.can_execute,
	execute = function(self, args)
		Handy.move_highlight.move(self, args, -1)
		return true
	end,
})
Handy.controls_v2.register("move_highlight_one_right", {
	get_module = function()
		return Handy.cc.move_highlight_dx_one_right, { Handy.cc.move_highlight }
	end,

	context_types = {
		input = {
			mouse = true,
			wheel = true,
			keyboard = true,
			gamepad = false,
		},
	},

	in_run = true,

	trigger = "trigger",

	can_execute = Handy.move_highlight.can_execute,
	execute = function(self, args)
		Handy.move_highlight.move(self, args, 1)
		return true
	end,
})
