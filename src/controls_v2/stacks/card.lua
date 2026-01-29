local l = Handy.controls_v2.register_layer
local c = Handy.controls_v2.register_control

l({
	key = "hover",
	operator = "first",
	stack_path = "card",
})
c({
	key = "hand_selection_insta_highlight",
	stack_path = "card.hover",
})
c({
	key = "dangerous_actions_sell_one",
	stack_path = "card.hover",
})
c({
	key = "dangerous_actions_remove_one",
	stack_path = "card.hover",
})

l({
	key = "click",
	operator = "first",
	stack_path = "card",
})
c({
	key = "dangerous_actions_sell_all_same",
	stack_path = "card.click",
})
c({
	key = "dangerous_actions_remove_all_same",
	stack_path = "card.click",
})
c({
	key = "dangerous_actions_sell_all",
	stack_path = "card.click",
})
c({
	key = "dangerous_actions_remove_all",
	stack_path = "card.click",
})
c({
	key = "insta_actions",
	stack_path = "card.click",
})
