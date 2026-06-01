local l = Handy.stack.register_layer
local c = Handy.stack.register_control

l({
	key = "hand_selection",
	operator = "free",
	stack_path = "move",
	order = 10,
})

c({
	key = "hand_selection_insta_highlight",
	stack_path = "move.hand_selection",
	order = 100,
})
