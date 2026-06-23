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
	stack_path = "input",
	order = 1,
})

Handy.stack.register({
	key = "presets_switch_load_1",
	stack_path = "input.presets",
	order = 1,
	control = true,
})
Handy.stack.register({
	key = "presets_switch_load_2",
	stack_path = "input.presets",
	order = 2,
	control = true,
})
Handy.stack.register({
	key = "presets_switch_load_3",
	stack_path = "input.presets",
	order = 3,
	control = true,
})
Handy.stack.register({
	key = "presets_switch_load_next",
	stack_path = "input.presets",
	order = 4,
	control = true,
})

---

Handy.stack.register({
	key = "move_highlight",
	operator = "until",
	stack_path = "input",
	order = 5,
})
Handy.stack.register({
	key = "move_highlight",
	stack_path = "input.move_highlight",
	order = 1,
	control = true,
})

---

Handy.stack.register({
	key = "speed_n_animations",
	operator = "until",
	stack_path = "input",
	order = 10,
})

Handy.stack.register({
	key = "temp_disable",
	operator = "any",
	stack_path = "input.speed_n_animations",
	order = 1,
})
Handy.stack.register({
	key = "increase",
	operator = "any",
	stack_path = "input.speed_n_animations",
	order = 2,
})
Handy.stack.register({
	key = "decrease",
	operator = "any",
	stack_path = "input.speed_n_animations",
	order = 3,
})

Handy.stack.register({
	key = "speed_multiplier_toggle_temp_disabled",
	stack_path = "input.speed_n_animations.temp_disable",
	order = 1,
	control = true,
})
Handy.stack.register({
	key = "animation_skip_toggle_temp_disabled",
	stack_path = "input.speed_n_animations.temp_disable",
	order = 2,
	control = true,
})
Handy.stack.register({
	key = "speed_multiplier_increase",
	stack_path = "input.speed_n_animations.increase",
	order = 1,
	control = true,
})
Handy.stack.register({
	key = "animation_skip_increase",
	stack_path = "input.speed_n_animations.increase",
	order = 2,
	control = true,
})
Handy.stack.register({
	key = "speed_multiplier_decrease",
	stack_path = "input.speed_n_animations.decrease",
	order = 1,
	control = true,
})
Handy.stack.register({
	key = "animation_skip_decrease",
	stack_path = "input.speed_n_animations.decrease",
	order = 2,
	control = true,
})

---

Handy.stack.register({
	key = "hand_selection",
	operator = "until",
	stack_path = "input",
	order = 11,
})
Handy.stack.register({
	key = "hand_selection_insta_highlight",
	stack_path = "input.hand_selection",
	order = 1,
	control = true,
})
Handy.stack.register({
	key = "hand_selection_deselect_hand",
	stack_path = "input.hand_selection",
	order = 2,
	control = true,
})
Handy.stack.register({
	key = "hand_selection_entire_f_hand",
	stack_path = "input.hand_selection",
	order = 3,
	control = true,
})

---

Handy.stack.register({
	key = "insta_actions",
	operator = "until",
	stack_path = "input",
	order = 12,
})
Handy.stack.register({
	key = "insta_actions",
	stack_path = "input.insta_actions",
	order = 1,
	control = true,
})

---

Handy.stack.register({
	key = "regular_keybinds",
	operator = "until",
	stack_path = "input",
	order = 20,
})

Handy.stack.register({
	key = "hand_sorting",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 1,
})
Handy.stack.register({
	key = "hand_actions",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 2,
})
Handy.stack.register({
	key = "shop_actions",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 3,
})
Handy.stack.register({
	key = "blind_select_actions",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 4,
})
Handy.stack.register({
	key = "menus",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 5,
})
Handy.stack.register({
	key = "game_actions",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 6,
})

Handy.stack.register({
	key = "regular_keybinds_change_sort_rank",
	stack_path = "input.regular_keybinds.hand_sorting",
	order = 1,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_change_sort_suit",
	stack_path = "input.regular_keybinds.hand_sorting",
	order = 2,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_toggle_sort",
	stack_path = "input.regular_keybinds.hand_sorting",
	order = 3,
	control = true,
})

Handy.stack.register({
	key = "regular_keybinds_discard",
	stack_path = "input.regular_keybinds.hand_actions",
	order = 1,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_play",
	stack_path = "input.regular_keybinds.hand_actions",
	order = 2,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_not_just_yet_interaction",
	stack_path = "input.regular_keybinds.hand_actions",
	order = 3,
	control = true,
})

Handy.stack.register({
	key = "regular_keybinds_cash_out",
	stack_path = "input.regular_keybinds.shop_actions",
	order = 1,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_skip_booster",
	stack_path = "input.regular_keybinds.shop_actions",
	order = 2,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_reroll_shop",
	stack_path = "input.regular_keybinds.shop_actions",
	order = 3,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_leave_shop",
	stack_path = "input.regular_keybinds.shop_actions",
	order = 4,
	control = true,
})

Handy.stack.register({
	key = "regular_keybinds_reroll_boss",
	stack_path = "input.regular_keybinds.blind_select_actions",
	order = 1,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_skip_blind",
	stack_path = "input.regular_keybinds.blind_select_actions",
	order = 2,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_select_blind",
	stack_path = "input.regular_keybinds.blind_select_actions",
	order = 3,
	control = true,
})

Handy.stack.register({
	key = "regular_keybinds_run_info",
	stack_path = "input.regular_keybinds.menus",
	order = 1,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_run_info_binds",
	stack_path = "input.regular_keybinds.menus",
	order = 2,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_view_deck",
	stack_path = "input.regular_keybinds.menus",
	order = 3,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_view_lobby_info",
	stack_path = "input.regular_keybinds.menus",
	order = 4,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_collection",
	stack_path = "input.regular_keybinds.menus",
	order = 5,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_options",
	stack_path = "input.regular_keybinds.menus",
	order = 6,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_mod_settings",
	stack_path = "input.regular_keybinds.menus",
	order = 7,
	control = true,
})

Handy.stack.register({
	key = "regular_keybinds_start_fantoms_preview",
	stack_path = "input.regular_keybinds.game_actions",
	order = 1,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_copy_log_file",
	stack_path = "input.regular_keybinds.game_actions",
	order = 2,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_save_run",
	stack_path = "input.regular_keybinds.game_actions",
	order = 3,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_reload_run",
	stack_path = "input.regular_keybinds.game_actions",
	order = 4,
	control = true,
})
Handy.stack.register({
	key = "regular_keybinds_quick_restart",
	stack_path = "input.regular_keybinds.game_actions",
	order = 5,
	control = true,
})

---

Handy.stack.register({
	key = "dangerous_actions",
	operator = "until",
	stack_path = "input",
	order = 100,
})

Handy.stack.register({
	key = "dangerous_actions_sell_one",
	stack_path = "input.dangerous_actions",
	order = 1,
	control = true,
})
Handy.stack.register({
	key = "dangerous_actions_remove_one",
	stack_path = "input.dangerous_actions",
	order = 2,
	control = true,
})
Handy.stack.register({
	key = "dangerous_actions_sell_all_same",
	stack_path = "input.dangerous_actions",
	order = 3,
	control = true,
})
Handy.stack.register({
	key = "dangerous_actions_remove_all_same",
	stack_path = "input.dangerous_actions",
	order = 4,
	control = true,
})
Handy.stack.register({
	key = "dangerous_actions_sell_all",
	stack_path = "input.dangerous_actions",
	order = 5,
	control = true,
})
Handy.stack.register({
	key = "dangerous_actions_remove_all",
	stack_path = "input.dangerous_actions",
	order = 6,
	control = true,
})

--

Handy.stack.register({
	key = "finish",
	operator = "until",
	stack_path = "input",
	order = 1000,
})
Handy.stack.register({
	key = "regular_keybinds_restart_game",
	stack_path = "input.finish",
	order = 3,
	control = true,
})
Handy.stack.register({
	key = "dangerous_actions_crash",
	stack_path = "input.finish",
	order = 1,
	control = true,
})
Handy.stack.register({
	key = "dangerous_actions_stack_overflow",
	stack_path = "input.finish",
	order = 2,
	control = true,
})
