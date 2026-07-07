Handy.stack.register({
	key = "input",
	operator = "until",
	global = true,
	order = 0,
})

---

Handy.stack.register({
	key = "presets",
	operator = "until",
	parent = "input",
	order = 1,
})

Handy.stack.register({
	control = "presets_switch_load_1",
	parent = "input.presets",
	order = 1,
})
Handy.stack.register({
	control = "presets_switch_load_2",
	parent = "input.presets",
	order = 2,
})
Handy.stack.register({
	control = "presets_switch_load_3",
	parent = "input.presets",
	order = 3,
})
Handy.stack.register({
	control = "presets_switch_load_next",
	parent = "input.presets",
	order = 4,
})

---

Handy.stack.register({
	key = "move_highlight",
	operator = "until",
	parent = "input",
	order = 5,
})
Handy.stack.register({
	control = "move_highlight",
	parent = "input.move_highlight",
	order = 1,
})

---

Handy.stack.register({
	key = "speed_n_animations",
	operator = "until",
	parent = "input",
	order = 10,
})

Handy.stack.register({
	key = "temp_disable",
	operator = "any",
	parent = "input.speed_n_animations",
	order = 1,
})
Handy.stack.register({
	key = "increase",
	operator = "any",
	parent = "input.speed_n_animations",
	order = 2,
})
Handy.stack.register({
	key = "decrease",
	operator = "any",
	parent = "input.speed_n_animations",
	order = 3,
})

Handy.stack.register({
	control = "speed_multiplier_toggle_temp_disabled",
	parent = "input.speed_n_animations.temp_disable",
	order = 1,
})
Handy.stack.register({
	control = "animation_skip_toggle_temp_disabled",
	parent = "input.speed_n_animations.temp_disable",
	order = 2,
})
Handy.stack.register({
	control = "speed_multiplier_increase",
	parent = "input.speed_n_animations.increase",
	order = 1,
})
Handy.stack.register({
	control = "animation_skip_increase",
	parent = "input.speed_n_animations.increase",
	order = 2,
})
Handy.stack.register({
	control = "speed_multiplier_decrease",
	parent = "input.speed_n_animations.decrease",
	order = 1,
})
Handy.stack.register({
	control = "animation_skip_decrease",
	parent = "input.speed_n_animations.decrease",
	order = 2,
})

---

Handy.stack.register({
	key = "hand_selection",
	operator = "until",
	parent = "input",
	order = 11,
})
Handy.stack.register({
	control = "hand_selection_insta_highlight",
	parent = "input.hand_selection",
	order = 1,
})
Handy.stack.register({
	control = "hand_selection_deselect_hand",
	parent = "input.hand_selection",
	order = 2,
})
Handy.stack.register({
	control = "hand_selection_entire_f_hand",
	parent = "input.hand_selection",
	order = 3,
})

---

Handy.stack.register({
	key = "insta_actions",
	operator = "until",
	parent = "input",
	order = 12,
})
Handy.stack.register({
	control = "insta_actions",
	parent = "input.insta_actions",
	order = 1,
})

---

Handy.stack.register({
	key = "regular_keybinds",
	operator = "until",
	parent = "input",
	order = 20,
})

Handy.stack.register({
	key = "hand_sorting",
	operator = "until",
	parent = "input.regular_keybinds",
	order = 1,
})
Handy.stack.register({
	key = "hand_actions",
	operator = "until",
	parent = "input.regular_keybinds",
	order = 2,
})
Handy.stack.register({
	key = "shop_actions",
	operator = "until",
	parent = "input.regular_keybinds",
	order = 3,
})
Handy.stack.register({
	key = "blind_select_actions",
	operator = "until",
	parent = "input.regular_keybinds",
	order = 4,
})
Handy.stack.register({
	key = "menus",
	operator = "until",
	parent = "input.regular_keybinds",
	order = 5,
})
Handy.stack.register({
	key = "game_actions",
	operator = "until",
	parent = "input.regular_keybinds",
	order = 6,
})

Handy.stack.register({
	control = "regular_keybinds_change_sort_rank",
	parent = "input.regular_keybinds.hand_sorting",
	order = 1,
})
Handy.stack.register({
	control = "regular_keybinds_change_sort_suit",
	parent = "input.regular_keybinds.hand_sorting",
	order = 2,
})
Handy.stack.register({
	control = "regular_keybinds_toggle_sort",
	parent = "input.regular_keybinds.hand_sorting",
	order = 3,
})

Handy.stack.register({
	control = "regular_keybinds_discard",
	parent = "input.regular_keybinds.hand_actions",
	order = 1,
})
Handy.stack.register({
	control = "regular_keybinds_play",
	parent = "input.regular_keybinds.hand_actions",
	order = 2,
})
Handy.stack.register({
	control = "regular_keybinds_not_just_yet_interaction",
	parent = "input.regular_keybinds.hand_actions",
	order = 3,
})

Handy.stack.register({
	control = "regular_keybinds_cash_out",
	parent = "input.regular_keybinds.shop_actions",
	order = 1,
})
Handy.stack.register({
	control = "regular_keybinds_skip_booster",
	parent = "input.regular_keybinds.shop_actions",
	order = 2,
})
Handy.stack.register({
	control = "regular_keybinds_reroll_shop",
	parent = "input.regular_keybinds.shop_actions",
	order = 3,
})
Handy.stack.register({
	control = "regular_keybinds_leave_shop",
	parent = "input.regular_keybinds.shop_actions",
	order = 4,
})

Handy.stack.register({
	control = "regular_keybinds_reroll_boss",
	parent = "input.regular_keybinds.blind_select_actions",
	order = 1,
})
Handy.stack.register({
	control = "regular_keybinds_skip_blind",
	parent = "input.regular_keybinds.blind_select_actions",
	order = 2,
})
Handy.stack.register({
	control = "regular_keybinds_select_blind",
	parent = "input.regular_keybinds.blind_select_actions",
	order = 3,
})

Handy.stack.register({
	control = "regular_keybinds_run_info",
	parent = "input.regular_keybinds.menus",
	order = 1,
})
Handy.stack.register({
	control = "regular_keybinds_run_info_binds",
	parent = "input.regular_keybinds.menus",
	order = 2,
})
Handy.stack.register({
	control = "regular_keybinds_view_deck",
	parent = "input.regular_keybinds.menus",
	order = 3,
})
Handy.stack.register({
	control = "regular_keybinds_view_lobby_info",
	parent = "input.regular_keybinds.menus",
	order = 4,
})
Handy.stack.register({
	control = "regular_keybinds_collection",
	parent = "input.regular_keybinds.menus",
	order = 5,
})
Handy.stack.register({
	control = "regular_keybinds_options",
	parent = "input.regular_keybinds.menus",
	order = 6,
})
Handy.stack.register({
	control = "regular_keybinds_mod_settings",
	parent = "input.regular_keybinds.menus",
	order = 7,
})

Handy.stack.register({
	control = "regular_keybinds_start_fantoms_preview",
	parent = "input.regular_keybinds.game_actions",
	order = 1,
})
Handy.stack.register({
	control = "regular_keybinds_copy_log_file",
	parent = "input.regular_keybinds.game_actions",
	order = 2,
})
Handy.stack.register({
	control = "regular_keybinds_save_run",
	parent = "input.regular_keybinds.game_actions",
	order = 3,
})
Handy.stack.register({
	control = "regular_keybinds_reload_run",
	parent = "input.regular_keybinds.game_actions",
	order = 4,
})
Handy.stack.register({
	control = "regular_keybinds_quick_restart",
	parent = "input.regular_keybinds.game_actions",
	order = 5,
})

---

Handy.stack.register({
	key = "dangerous_actions",
	operator = "until",
	parent = "input",
	order = 100,
})

Handy.stack.register({
	control = "dangerous_actions_sell_one",
	parent = "input.dangerous_actions",
	order = 1,
})
Handy.stack.register({
	control = "dangerous_actions_remove_one",
	parent = "input.dangerous_actions",
	order = 2,
})
Handy.stack.register({
	control = "dangerous_actions_sell_all_same",
	parent = "input.dangerous_actions",
	order = 3,
})
Handy.stack.register({
	control = "dangerous_actions_remove_all_same",
	parent = "input.dangerous_actions",
	order = 4,
})
Handy.stack.register({
	control = "dangerous_actions_sell_all",
	parent = "input.dangerous_actions",
	order = 5,
})
Handy.stack.register({
	control = "dangerous_actions_remove_all",
	parent = "input.dangerous_actions",
	order = 6,
})

--

Handy.stack.register({
	key = "finish",
	operator = "until",
	parent = "input",
	order = 1000,
})
Handy.stack.register({
	control = "regular_keybinds_restart_game",
	parent = "input.finish",
	order = 3,
})
Handy.stack.register({
	control = "dangerous_actions_crash",
	parent = "input.finish",
	order = 1,
})
Handy.stack.register({
	control = "dangerous_actions_stack_overflow",
	parent = "input.finish",
	order = 2,
})
