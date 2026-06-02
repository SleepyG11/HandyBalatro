local l = Handy.stack.register_layer
local c = Handy.stack.register_control

l({
	layer = true,
	global = true,
	key = "input",
	order = 0,
	operator = "until",
})

---

l({
	key = "presets",
	operator = "until",
	stack_path = "input",
	order = 1,
})

c({
	key = "presets_switch_load_1",
	stack_path = "input.presets",
	order = 1,
})
c({
	key = "presets_switch_load_2",
	stack_path = "input.presets",
	order = 2,
})
c({
	key = "presets_switch_load_3",
	stack_path = "input.presets",
	order = 3,
})
c({
	key = "presets_switch_load_next",
	stack_path = "input.presets",
	order = 4,
})

---

l({
	key = "speed_n_animations",
	operator = "until",
	stack_path = "input",
	order = 10,
})

l({
	key = "temp_disable",
	operator = "any",
	stack_path = "input.speed_n_animations",
	order = 1,
})
l({
	key = "increase",
	operator = "any",
	stack_path = "input.speed_n_animations",
	order = 2,
})
l({
	key = "decrease",
	operator = "any",
	stack_path = "input.speed_n_animations",
	order = 3,
})

c({
	key = "speed_multiplier_toggle_temp_disabled",
	stack_path = "input.speed_n_animations.temp_disable",
	order = 1,
})
c({
	key = "animation_skip_toggle_temp_disabled",
	stack_path = "input.speed_n_animations.temp_disable",
	order = 2,
})
c({
	key = "speed_multiplier_increase",
	stack_path = "input.speed_n_animations.increase",
	order = 1,
})
c({
	key = "animation_skip_increase",
	stack_path = "input.speed_n_animations.increase",
	order = 2,
})
c({
	key = "speed_multiplier_decrease",
	stack_path = "input.speed_n_animations.decrease",
	order = 1,
})
c({
	key = "animation_skip_decrease",
	stack_path = "input.speed_n_animations.decrease",
	order = 2,
})

---

l({
	key = "hand_selection",
	operator = "until",
	stack_path = "input",
	order = 11,
})
c({
	key = "hand_selection_insta_highlight",
	stack_path = "input.hand_selection",
	order = 1,
})
c({
	key = "hand_selection_deselect_hand",
	stack_path = "input.hand_selection",
	order = 2,
})
c({
	key = "hand_selection_entire_f_hand",
	stack_path = "input.hand_selection",
	order = 3,
})

---

l({
	key = "insta_actions",
	operator = "until",
	stack_path = "input",
	order = 12,
})
c({
	key = "insta_actions",
	stack_path = "input.insta_actions",
	order = 1,
})

---

l({
	key = "regular_keybinds",
	operator = "until",
	stack_path = "input",
	order = 20,
})

l({
	key = "hand_sorting",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 1,
})
l({
	key = "hand_actions",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 2,
})
l({
	key = "shop_actions",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 3,
})
l({
	key = "blind_select_actions",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 4,
})
l({
	key = "menus",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 5,
})
l({
	key = "game_actions",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 6,
})

c({
	key = "regular_keybinds_change_sort_rank",
	stack_path = "input.regular_keybinds.hand_sorting",
	order = 1,
})
c({
	key = "regular_keybinds_change_sort_suit",
	stack_path = "input.regular_keybinds.hand_sorting",
	order = 2,
})
c({
	key = "regular_keybinds_toggle_sort",
	stack_path = "input.regular_keybinds.hand_sorting",
	order = 3,
})

c({
	key = "regular_keybinds_discard",
	stack_path = "input.regular_keybinds.hand_actions",
	order = 1,
})
c({
	key = "regular_keybinds_play",
	stack_path = "input.regular_keybinds.hand_actions",
	order = 2,
})
c({
	key = "regular_keybinds_not_just_yet_interaction",
	stack_path = "input.regular_keybinds.hand_actions",
	order = 3,
})

c({
	key = "regular_keybinds_cash_out",
	stack_path = "input.regular_keybinds.shop_actions",
	order = 1,
})
c({
	key = "regular_keybinds_skip_booster",
	stack_path = "input.regular_keybinds.shop_actions",
	order = 2,
})
c({
	key = "regular_keybinds_reroll_shop",
	stack_path = "input.regular_keybinds.shop_actions",
	order = 3,
})
c({
	key = "regular_keybinds_leave_shop",
	stack_path = "input.regular_keybinds.shop_actions",
	order = 4,
})

c({
	key = "regular_keybinds_reroll_boss",
	stack_path = "input.regular_keybinds.blind_select_actions",
	order = 1,
})
c({
	key = "regular_keybinds_skip_blind",
	stack_path = "input.regular_keybinds.blind_select_actions",
	order = 2,
})
c({
	key = "regular_keybinds_select_blind",
	stack_path = "input.regular_keybinds.blind_select_actions",
	order = 3,
})

c({
	key = "regular_keybinds_run_info",
	stack_path = "input.regular_keybinds.menus",
	order = 1,
})
c({
	key = "regular_keybinds_run_info_binds",
	stack_path = "input.regular_keybinds.menus",
	order = 2,
})
c({
	key = "regular_keybinds_view_deck",
	stack_path = "input.regular_keybinds.menus",
	order = 3,
})
c({
	key = "regular_keybinds_view_lobby_info",
	stack_path = "input.regular_keybinds.menus",
	order = 4,
})
c({
	key = "regular_keybinds_collection",
	stack_path = "input.regular_keybinds.menus",
	order = 5,
})
c({
	key = "regular_keybinds_options",
	stack_path = "input.regular_keybinds.menus",
	order = 6,
})
c({
	key = "regular_keybinds_mod_settings",
	stack_path = "input.regular_keybinds.menus",
	order = 7,
})

c({
	key = "regular_keybinds_start_fantoms_preview",
	stack_path = "input.regular_keybinds.game_actions",
	order = 1,
})
c({
	key = "regular_keybinds_copy_log_file",
	stack_path = "input.regular_keybinds.game_actions",
	order = 2,
})
c({
	key = "regular_keybinds_save_run",
	stack_path = "input.regular_keybinds.game_actions",
	order = 3,
})
c({
	key = "regular_keybinds_reload_run",
	stack_path = "input.regular_keybinds.game_actions",
	order = 4,
})
c({
	key = "regular_keybinds_quick_restart",
	stack_path = "input.regular_keybinds.game_actions",
	order = 5,
})

---

l({
	key = "move_highlight",
	operator = "until",
	stack_path = "input",
	order = 1,
})
c({
	key = "move_highlight",
	stack_path = "input.move_highlight",
	order = 1,
})

---

l({
	key = "dangerous_actions",
	operator = "until",
	stack_path = "input",
	order = 100,
})

c({
	key = "dangerous_actions_sell_one",
	stack_path = "input.dangerous_actions",
	order = 1,
})
c({
	key = "dangerous_actions_remove_one",
	stack_path = "input.dangerous_actions",
	order = 2,
})
c({
	key = "dangerous_actions_sell_all_same",
	stack_path = "input.dangerous_actions",
	order = 3,
})
c({
	key = "dangerous_actions_remove_all_same",
	stack_path = "input.dangerous_actions",
	order = 4,
})
c({
	key = "dangerous_actions_sell_all",
	stack_path = "input.dangerous_actions",
	order = 5,
})
c({
	key = "dangerous_actions_remove_all",
	stack_path = "input.dangerous_actions",
	order = 6,
})

--

l({
	key = "finish",
	operator = "until",
	stack_path = "input",
	order = 1000,
})
c({
	key = "regular_keybinds_restart_game",
	stack_path = "input.finish",
	order = 3,
})
c({
	key = "dangerous_actions_crash",
	stack_path = "input.finish",
	order = 1,
})
c({
	key = "dangerous_actions_stack_overflow",
	stack_path = "input.finish",
	order = 2,
})
