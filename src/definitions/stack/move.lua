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
	parent = "move",
	order = 1,
})

Handy.stack.register({
	control = "hand_selection_insta_highlight",
	parent = "move.hand_selection",
	order = 1,
})
