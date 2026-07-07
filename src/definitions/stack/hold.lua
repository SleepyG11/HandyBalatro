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
	parent = "hold",
	order = 1,
})

Handy.stack.register({
	key = "hand_actions",
	operator = "free",
	parent = "hold.regular_keybinds",
	order = 1,
})
Handy.stack.register({
	key = "shop_actions",
	operator = "free",
	parent = "hold.regular_keybinds",
	order = 2,
})
Handy.stack.register({
	key = "game_actions",
	operator = "free",
	parent = "hold.regular_keybinds",
	order = 3,
})

Handy.stack.register({
	control = "regular_keybinds_not_just_yet_interaction",
	parent = "hold.regular_keybinds.hand_actions",
	order = 10,
})

Handy.stack.register({
	control = "regular_keybinds_cash_out",
	parent = "hold.regular_keybinds.shop_actions",
	order = 10,
})
Handy.stack.register({
	control = "regular_keybinds_skip_booster",
	parent = "hold.regular_keybinds.shop_actions",
	order = 11,
})

Handy.stack.register({
	control = "regular_keybinds_restart",
	parent = "hold.regular_keybinds.game_actions",
	order = 1000,
})

---

Handy.stack.register({
	key = "move_highlight",
	operator = "free",
	parent = "hold",
	order = 10,
})
Handy.stack.register({
	control = "move_highlight",
	parent = "hold.move_highlight",
	order = 1,
})
