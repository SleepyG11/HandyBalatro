local l = Handy.controls_v2.register_layer
local c = Handy.controls_v2.register_control

l({
	key = "regular_keybinds",
	operator = "first",
	stack_path = "hold",
})

l({
	key = "hand_actions",
	operator = "first",
	stack_path = "hold.regular_keybinds",
})
l({
	key = "shop_actions",
	operator = "first",
	stack_path = "hold.regular_keybinds",
})
l({
	key = "game_actions",
	operator = "first",
	stack_path = "hold.regular_keybinds",
})

---

c({
	key = "regular_keybinds_not_just_yet_interaction",
	stack_path = "hold.regular_keybinds.hand_actions",
})

c({
	key = "regular_keybinds_cash_out",
	stack_path = "hold.regular_keybinds.shop_actions",
})
c({
	key = "regular_keybinds_skip_booster",
	stack_path = "hold.regular_keybinds.shop_actions",
})

c({
	key = "regular_keybinds_restart",
	stack_path = "hold.regular_keybinds.game_actions",
})
