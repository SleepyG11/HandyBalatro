Handy.stack.register({
	key = "hold",
	operator = "until",
	global = true,
	order = 0,
})

---

Handy.stack.register({
	key = "regular_keybinds",
	operator = "free",
	stack_path = "hold",
	order = 1,
})

Handy.stack.register({
	key = "hand_actions",
	operator = "free",
	stack_path = "hold.regular_keybinds",
	order = 1,
})
Handy.stack.register({
	key = "shop_actions",
	operator = "free",
	stack_path = "hold.regular_keybinds",
	order = 2,
})
Handy.stack.register({
	key = "game_actions",
	operator = "free",
	stack_path = "hold.regular_keybinds",
	order = 3,
})

Handy.stack.register({
	key = "regular_keybinds_not_just_yet_interaction",
	stack_path = "hold.regular_keybinds.hand_actions",
	order = 10,
	control = true,
})

Handy.stack.register({
	key = "regular_keybinds_cash_out",
	stack_path = "hold.regular_keybinds.shop_actions",
	order = 10,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_skip_booster",
	stack_path = "hold.regular_keybinds.shop_actions",
	order = 11,
	control = true,
})

Handy.stack.register({
	key = "regular_keybinds_restart",
	stack_path = "hold.regular_keybinds.game_actions",
	order = 1000,
	control = true,
})

---

Handy.stack.register({
	key = "move_highlight",
	operator = "free",
	stack_path = "hold",
	order = 10,
})
Handy.stack.register({
	key = "move_highlight",
	stack_path = "hold.move_highlight",
	order = 1,
	control = true,
})
