Handy.API.Stack({
	key = "move",
	operator = "until",
	global = true,
	order = 0,
})

---

Handy.API.Stack({
	key = "hand_selection",
	operator = "free",
	parent = "move",
	order = 1,
})

Handy.API.Stack({
	control = "hand_selection_insta_highlight",
	parent = "move.hand_selection",
	order = 1,
})
