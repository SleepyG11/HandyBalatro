Handy.controls.register({
	key = "move_highlight",
	get_module = function()
		return Handy.cc.move_highlight
	end,

	contexts = {
		hold = true,
		input_press_mouse = true,
		input_press_wheel = true,
		input_press_keyboard = true,
	},

	only_in_run = true,

	triggers_count = 0,
	last_hold = 0,

	can_execute = Handy.move_highlight.can_execute_control,
	execute = Handy.move_highlight.execute_control,
})
