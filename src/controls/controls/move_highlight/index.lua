Handy.load_files({
	"logic.lua",
}, "src/controls/controls/move_highlight/")

Handy.controls.register("move_highlight", {
	get_module = function()
		return Handy.cc.move_highlight
	end,

	context_types = {
		input = {
			mouse = true,
			wheel = true,
			keyboard = true,
			gamepad = false,
		},
		hold = true,
	},

	in_run = true,

	trigger = "press",

	triggers_count = 0,
	last_hold = 0,

	can_execute = Handy.move_highlight.can_execute,
	execute = function(self, args, data)
		return Handy.move_highlight.move(self, args, data)
	end,
})
