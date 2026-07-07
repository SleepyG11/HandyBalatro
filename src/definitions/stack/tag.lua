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
	parent = "tag",
	order = 1,
})
Handy.stack.register({
	control = "dangerous_actions_remove_one",
	parent = "tag.hover",
	order = 100,
})

Handy.stack.register({
	key = "click",
	operator = "until",
	parent = "tag",
	order = 2,
})
Handy.stack.register({
	control = "dangerous_actions_remove_all_same",
	parent = "tag.click",
	order = 100,
})
Handy.stack.register({
	control = "dangerous_actions_remove_all",
	parent = "tag.click",
	order = 101,
})
