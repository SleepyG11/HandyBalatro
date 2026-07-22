Handy.API.Stack({
	key = "card",
	operator = "until",
	global = true,
	order = 0,
})

---

Handy.API.Stack({
	key = "hover",
	operator = "until",
	parent = "card",
	order = 1,
})
Handy.API.Stack({
	control = "hand_selection_insta_highlight",
	parent = "card.hover",
	order = 1,
})
Handy.API.Stack({
	control = "dangerous_actions_sell_one",
	parent = "card.hover",
	order = 100,
})
Handy.API.Stack({
	control = "dangerous_actions_remove_one",
	parent = "card.hover",
	order = 101,
})

Handy.API.Stack({
	key = "click",
	operator = "until",
	parent = "card",
	order = 2,
})
Handy.API.Stack({
	control = "dangerous_actions_sell_all_same",
	parent = "card.click",
	order = 100,
})
Handy.API.Stack({
	control = "dangerous_actions_remove_all_same",
	parent = "card.click",
	order = 101,
})
Handy.API.Stack({
	control = "dangerous_actions_sell_all",
	parent = "card.click",
	order = 102,
})
Handy.API.Stack({
	control = "dangerous_actions_remove_all",
	parent = "card.click",
	order = 103,
})
Handy.API.Stack({
	control = "insta_actions",
	parent = "card.click",
	order = 110,
})
