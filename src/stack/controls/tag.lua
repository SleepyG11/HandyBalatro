local l = Handy.stack.register_layer
local c = Handy.stack.register_control

l({
	key = "hover",
	operator = "until",
	stack_path = "tag",
	order = 1,
})
c({
	key = "dangerous_actions_remove_one",
	stack_path = "tag.hover",
	order = 100,
})

l({
	key = "click",
	operator = "until",
	stack_path = "tag",
	order = 2,
})
c({
	key = "dangerous_actions_remove_all_same",
	stack_path = "tag.click",
	order = 100,
})
c({
	key = "dangerous_actions_remove_all",
	stack_path = "tag.click",
	order = 101,
})
