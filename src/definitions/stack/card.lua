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
	stack_path = "card",
	order = 1,
})
Handy.stack.register({
	key = "hand_selection_insta_highlight",
	stack_path = "card.hover",
	order = 1,
	control = true,
})
Handy.stack.register({
	key = "dangerous_actions_sell_one",
	stack_path = "card.hover",
	order = 100,
	control = true,
})
Handy.stack.register({
	key = "dangerous_actions_remove_one",
	stack_path = "card.hover",
	order = 101,
	control = true,
})

Handy.stack.register({
	key = "click",
	operator = "until",
	stack_path = "card",
	order = 2,
})
Handy.stack.register({
	key = "dangerous_actions_sell_all_same",
	stack_path = "card.click",
	order = 100,
	control = true,
})
Handy.stack.register({
	key = "dangerous_actions_remove_all_same",
	stack_path = "card.click",
	order = 101,
	control = true,
})
Handy.stack.register({
	key = "dangerous_actions_sell_all",
	stack_path = "card.click",
	order = 102,
	control = true,
})
Handy.stack.register({
	key = "dangerous_actions_remove_all",
	stack_path = "card.click",
	order = 103,
	control = true,
})
Handy.stack.register({
	key = "insta_actions",
	stack_path = "card.click",
	order = 110,
	control = true,
})
