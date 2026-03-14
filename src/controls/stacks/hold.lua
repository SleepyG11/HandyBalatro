local l = Handy.controls.register_layer
local c = Handy.controls.register_control

l({
	key = "regular_keybinds",
	operator = "free",
	stack_path = "hold",
	order = 20,
})

l({
	key = "hand_actions",
	operator = "free",
	stack_path = "hold.regular_keybinds",
	order = 100,
})
l({
	key = "shop_actions",
	operator = "free",
	stack_path = "hold.regular_keybinds",
	order = 200,
})
l({
	key = "game_actions",
	operator = "free",
	stack_path = "hold.regular_keybinds",
	order = 300,
})

c({
	key = "regular_keybinds_not_just_yet_interaction",
	stack_path = "hold.regular_keybinds.hand_actions",
	order = 10000,
})

c({
	key = "regular_keybinds_cash_out",
	stack_path = "hold.regular_keybinds.shop_actions",
	order = 10000,
})
c({
	key = "regular_keybinds_skip_booster",
	stack_path = "hold.regular_keybinds.shop_actions",
	order = 20000,
})

c({
	key = "regular_keybinds_restart",
	stack_path = "hold.regular_keybinds.game_actions",
	order = 10000,
})

---

l({
	key = "move_highlight",
	operator = "free",
	stack_path = "hold",
	order = 40,
})
c({
	key = "move_highlight",
	stack_path = "hold.move_highlight",
	order = 100,
})
