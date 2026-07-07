Handy.stack.register({
	key = "card",
	operator = "until",
	global = true,
	order = 0,
})

---

Handy.stack.register({
	key = "hover",
	operator = "until",
	parent = "card",
	order = 1,
})
Handy.stack.register({
	control = "hand_selection_insta_highlight",
	parent = "card.hover",
	order = 1,
})
Handy.stack.register({
	control = "dangerous_actions_sell_one",
	parent = "card.hover",
	order = 100,
})
Handy.stack.register({
	control = "dangerous_actions_remove_one",
	parent = "card.hover",
	order = 101,
})

Handy.stack.register({
	key = "click",
	operator = "until",
	parent = "card",
	order = 2,
})
Handy.stack.register({
	control = "dangerous_actions_sell_all_same",
	parent = "card.click",
	order = 100,
})
Handy.stack.register({
	control = "dangerous_actions_remove_all_same",
	parent = "card.click",
	order = 101,
})
Handy.stack.register({
	control = "dangerous_actions_sell_all",
	parent = "card.click",
	order = 102,
})
Handy.stack.register({
	control = "dangerous_actions_remove_all",
	parent = "card.click",
	order = 103,
})
Handy.stack.register({
	control = "insta_actions",
	parent = "card.click",
	order = 110,
})
