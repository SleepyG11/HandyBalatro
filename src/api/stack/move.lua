local l = Handy.stack.register_layer
local c = Handy.stack.register_control

l({
	layer = true,
	global = true,
	key = "move",
	order = 0,
	operator = "until",
})

---

l({
	key = "hand_selection",
	operator = "free",
	stack_path = "move",
	order = 1,
})

c({
	key = "hand_selection_insta_highlight",
	stack_path = "move.hand_selection",
	order = 1,
})
