local l = Handy.stack.register_layer
local c = Handy.stack.register_control

l({
	key = "hover",
	operator = "until",
	stack_path = "card",
	order = 1,
})
c({
	key = "hand_selection_insta_highlight",
	stack_path = "card.hover",
	order = 1,
})
c({
	key = "dangerous_actions_sell_one",
	stack_path = "card.hover",
	order = 100,
})
c({
	key = "dangerous_actions_remove_one",
	stack_path = "card.hover",
	order = 101,
})

l({
	key = "click",
	operator = "until",
	stack_path = "card",
	order = 2,
})
c({
	key = "dangerous_actions_sell_all_same",
	stack_path = "card.click",
	order = 100,
})
c({
	key = "dangerous_actions_remove_all_same",
	stack_path = "card.click",
	order = 101,
})
c({
	key = "dangerous_actions_sell_all",
	stack_path = "card.click",
	order = 102,
})
c({
	key = "dangerous_actions_remove_all",
	stack_path = "card.click",
	order = 103,
})
c({
	key = "insta_actions",
	stack_path = "card.click",
	order = 110,
})
