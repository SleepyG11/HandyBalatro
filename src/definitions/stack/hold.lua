Handy.API.Stack({
	key = "hold",
	operator = "until",
	global = true,
	order = 0,
})

---

Handy.API.Stack({
	key = "regular_keybinds",
	operator = "free",
	parent = "hold",
	order = 1,
})

Handy.API.Stack({
	key = "hand_actions",
	operator = "free",
	parent = "hold.regular_keybinds",
	order = 1,
})
Handy.API.Stack({
	key = "shop_actions",
	operator = "free",
	parent = "hold.regular_keybinds",
	order = 2,
})
Handy.API.Stack({
	key = "game_actions",
	operator = "free",
	parent = "hold.regular_keybinds",
	order = 3,
})

Handy.API.Stack({
	control = "regular_keybinds_not_just_yet_interaction",
	parent = "hold.regular_keybinds.hand_actions",
	order = 10,
})

Handy.API.Stack({
	control = "regular_keybinds_cash_out",
	parent = "hold.regular_keybinds.shop_actions",
	order = 10,
})
Handy.API.Stack({
	control = "regular_keybinds_skip_booster",
	parent = "hold.regular_keybinds.shop_actions",
	order = 11,
})

Handy.API.Stack({
	control = "regular_keybinds_restart",
	parent = "hold.regular_keybinds.game_actions",
	order = 1000,
})

---

Handy.API.Stack({
	key = "move_highlight",
	operator = "free",
	parent = "hold",
	order = 10,
})
Handy.API.Stack({
	control = "move_highlight",
	parent = "hold.move_highlight",
	order = 1,
})
