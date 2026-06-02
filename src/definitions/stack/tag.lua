local l = Handy.stack.register_layer
local c = Handy.stack.register_control

Handy.stack.register({
	key = "tag",
	operator = "until",
	global = true,
	order = 0,
})

---

Handy.stack.register({
	key = "hover",
	operator = "until",
	stack_path = "tag",
	order = 1,
})
Handy.stack.register({
	key = "dangerous_actions_remove_one",
	stack_path = "tag.hover",
	order = 100,
	control = true,
})

Handy.stack.register({
	key = "click",
	operator = "until",
	stack_path = "tag",
	order = 2,
})
Handy.stack.register({
	key = "dangerous_actions_remove_all_same",
	stack_path = "tag.click",
	order = 100,
	control = true,
})
Handy.stack.register({
	key = "dangerous_actions_remove_all",
	stack_path = "tag.click",
	order = 101,
	control = true,
})
