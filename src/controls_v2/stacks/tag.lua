local l = Handy.controls_v2.register_layer
local c = Handy.controls_v2.register_control

l({
	key = "hover",
	operator = "first",
	stack_path = "tag",
})
c({
	key = "dangerous_actions_remove_one",
	stack_path = "tag.hover",
})

l({
	key = "click",
	operator = "first",
	stack_path = "tag",
})
c({
	key = "dangerous_actions_remove_all_same",
	stack_path = "tag.click",
})
c({
	key = "dangerous_actions_remove_all",
	stack_path = "tag.click",
})
