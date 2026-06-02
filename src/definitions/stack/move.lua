Handy.stack.register({
	key = "move",
	operator = "until",
	global = true,
	order = 0,
})

---

Handy.stack.register({
	key = "hand_selection",
	operator = "free",
	stack_path = "move",
	order = 1,
})

Handy.stack.register({
	key = "hand_selection_insta_highlight",
	stack_path = "move.hand_selection",
	order = 1,
	control = true,
})
