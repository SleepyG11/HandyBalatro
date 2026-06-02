local l = Handy.stack.register_layer
local c = Handy.stack.register_control

l({
	layer = true,
	global = true,
	key = "hold",
	order = 0,
	operator = "until",
})

---

l({
	key = "regular_keybinds",
	operator = "free",
	stack_path = "hold",
	order = 1,
})

l({
	key = "hand_actions",
	operator = "free",
	stack_path = "hold.regular_keybinds",
	order = 1,
})
l({
	key = "shop_actions",
	operator = "free",
	stack_path = "hold.regular_keybinds",
	order = 2,
})
l({
	key = "game_actions",
	operator = "free",
	stack_path = "hold.regular_keybinds",
	order = 3,
})

c({
	key = "regular_keybinds_not_just_yet_interaction",
	stack_path = "hold.regular_keybinds.hand_actions",
	order = 10,
})

c({
	key = "regular_keybinds_cash_out",
	stack_path = "hold.regular_keybinds.shop_actions",
	order = 10,
})
c({
	key = "regular_keybinds_skip_booster",
	stack_path = "hold.regular_keybinds.shop_actions",
	order = 11,
})

c({
	key = "regular_keybinds_restart",
	stack_path = "hold.regular_keybinds.game_actions",
	order = 1000,
})

---

l({
	key = "move_highlight",
	operator = "free",
	stack_path = "hold",
	order = 10,
})
c({
	key = "move_highlight",
	stack_path = "hold.move_highlight",
	order = 1,
})
