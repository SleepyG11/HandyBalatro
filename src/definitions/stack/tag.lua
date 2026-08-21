Handy.API.Stack({
	key = "tag",
	operator = "until",
	global = true,
	order = 0,
})

---

Handy.API.Stack({
	key = "hover",
	operator = "until",
	parent = "tag",
	order = 1,
})
Handy.API.Stack({
	control = "dangerous_actions_remove_one",
	parent = "tag.hover",
	order = 100,
})

Handy.API.Stack({
	key = "click",
	operator = "until",
	parent = "tag",
	order = 2,
})
Handy.API.Stack({
	control = "dangerous_actions_remove_all_same",
	parent = "tag.click",
	order = 100,
})
Handy.API.Stack({
	control = "dangerous_actions_remove_all",
	parent = "tag.click",
	order = 101,
})
