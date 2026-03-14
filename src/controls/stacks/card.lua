local l = Handy.controls.register_layer
local c = Handy.controls.register_control

l({
	key = "hover",
	operator = "first",
	stack_path = "card",
	order = 10,
})
c({
	key = "hand_selection_insta_highlight",
	stack_path = "card.hover",
	order = 100,
})
c({
	key = "dangerous_actions_sell_one",
	stack_path = "card.hover",
	order = 200,
})
c({
	key = "dangerous_actions_remove_one",
	stack_path = "card.hover",
	order = 300,
})

l({
	key = "click",
	operator = "first",
	stack_path = "card",
	order = 20,
})
c({
	key = "dangerous_actions_sell_all_same",
	stack_path = "card.click",
	order = 100,
})
c({
	key = "dangerous_actions_remove_all_same",
	stack_path = "card.click",
	order = 200,
})
c({
	key = "dangerous_actions_sell_all",
	stack_path = "card.click",
	order = 300,
})
c({
	key = "dangerous_actions_remove_all",
	stack_path = "card.click",
	order = 400,
})
c({
	key = "insta_actions",
	stack_path = "card.click",
	order = 500,
})
