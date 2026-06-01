local l = Handy.stack.register_layer
local c = Handy.stack.register_control

l({
	key = "presets",
	operator = "until",
	stack_path = "input",
	order = 10,
})

c({
	key = "presets_switch_load_1",
	stack_path = "input.presets",
	order = 100,
})
c({
	key = "presets_switch_load_2",
	stack_path = "input.presets",
	order = 200,
})
c({
	key = "presets_switch_load_3",
	stack_path = "input.presets",
	order = 300,
})
c({
	key = "presets_switch_load_next",
	stack_path = "input.presets",
	order = 400,
})

---

l({
	key = "speed_n_animations",
	operator = "until",
	stack_path = "input",
	order = 20,
})

l({
	key = "temp_disable",
	operator = "any",
	stack_path = "input.speed_n_animations",
	order = 100,
})
l({
	key = "increase",
	operator = "any",
	stack_path = "input.speed_n_animations",
	order = 200,
})
l({
	key = "decrease",
	operator = "any",
	stack_path = "input.speed_n_animations",
	order = 300,
})

c({
	key = "speed_multiplier_toggle_temp_disabled",
	stack_path = "input.speed_n_animations.temp_disable",
	order = 10000,
})
c({
	key = "animation_skip_toggle_temp_disabled",
	stack_path = "input.speed_n_animations.temp_disable",
	order = 20000,
})
c({
	key = "speed_multiplier_increase",
	stack_path = "input.speed_n_animations.increase",
	order = 10000,
})
c({
	key = "animation_skip_increase",
	stack_path = "input.speed_n_animations.increase",
	order = 20000,
})
c({
	key = "speed_multiplier_decrease",
	stack_path = "input.speed_n_animations.decrease",
	order = 10000,
})
c({
	key = "animation_skip_decrease",
	stack_path = "input.speed_n_animations.decrease",
	order = 20000,
})

---

l({
	key = "hand_selection",
	operator = "until",
	stack_path = "input",
	order = 30,
})
c({
	key = "hand_selection_insta_highlight",
	stack_path = "input.hand_selection",
	order = 100,
})
c({
	key = "hand_selection_deselect_hand",
	stack_path = "input.hand_selection",
	order = 200,
})
c({
	key = "hand_selection_entire_f_hand",
	stack_path = "input.hand_selection",
	order = 300,
})

---

l({
	key = "insta_actions",
	operator = "until",
	stack_path = "input",
	order = 40,
})
c({
	key = "insta_actions",
	stack_path = "input.insta_actions",
	order = 100,
})

---

l({
	key = "regular_keybinds",
	operator = "until",
	stack_path = "input",
	order = 50,
})

l({
	key = "hand_sorting",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 100,
})
l({
	key = "hand_actions",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 200,
})
l({
	key = "shop_actions",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 300,
})
l({
	key = "blind_select_actions",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 400,
})
l({
	key = "menus",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 500,
})
l({
	key = "game_actions",
	operator = "until",
	stack_path = "input.regular_keybinds",
	order = 600,
})

c({
	key = "regular_keybinds_change_sort_rank",
	stack_path = "input.regular_keybinds.hand_sorting",
	order = 10000,
})
c({
	key = "regular_keybinds_change_sort_suit",
	stack_path = "input.regular_keybinds.hand_sorting",
	order = 20000,
})
c({
	key = "regular_keybinds_toggle_sort",
	stack_path = "input.regular_keybinds.hand_sorting",
	order = 30000,
})

c({
	key = "regular_keybinds_discard",
	stack_path = "input.regular_keybinds.hand_actions",
	order = 10000,
})
c({
	key = "regular_keybinds_play",
	stack_path = "input.regular_keybinds.hand_actions",
	order = 20000,
})
c({
	key = "regular_keybinds_not_just_yet_interaction",
	stack_path = "input.regular_keybinds.hand_actions",
	order = 30000,
})

c({
	key = "regular_keybinds_cash_out",
	stack_path = "input.regular_keybinds.shop_actions",
	order = 10000,
})
c({
	key = "regular_keybinds_skip_booster",
	stack_path = "input.regular_keybinds.shop_actions",
	order = 20000,
})
c({
	key = "regular_keybinds_reroll_shop",
	stack_path = "input.regular_keybinds.shop_actions",
	order = 30000,
})
c({
	key = "regular_keybinds_leave_shop",
	stack_path = "input.regular_keybinds.shop_actions",
	order = 40000,
})

c({
	key = "regular_keybinds_reroll_boss",
	stack_path = "input.regular_keybinds.blind_select_actions",
	order = 10000,
})
c({
	key = "regular_keybinds_skip_blind",
	stack_path = "input.regular_keybinds.blind_select_actions",
	order = 20000,
})
c({
	key = "regular_keybinds_select_blind",
	stack_path = "input.regular_keybinds.blind_select_actions",
	order = 30000,
})

c({
	key = "regular_keybinds_run_info",
	stack_path = "input.regular_keybinds.menus",
	order = 10000,
})
c({
	key = "regular_keybinds_run_info_binds",
	stack_path = "input.regular_keybinds.menus",
	order = 20000,
})
c({
	key = "regular_keybinds_view_deck",
	stack_path = "input.regular_keybinds.menus",
	order = 30000,
})
c({
	key = "regular_keybinds_view_lobby_info",
	stack_path = "input.regular_keybinds.menus",
	order = 40000,
})
c({
	key = "regular_keybinds_mod_settings",
	stack_path = "input.regular_keybinds.menus",
	order = 50000,
})
c({
	key = "regular_keybinds_options",
	stack_path = "input.regular_keybinds.menus",
	order = 60000,
})
c({
	key = "regular_keybinds_collection",
	stack_path = "input.regular_keybinds.menus",
	order = 70000,
})

c({
	key = "regular_keybinds_quick_restart",
	stack_path = "input.regular_keybinds.game_actions",
	order = 10000,
})
c({
	key = "regular_keybinds_save_run",
	stack_path = "input.regular_keybinds.game_actions",
	order = 20000,
})
c({
	key = "regular_keybinds_reload_run",
	stack_path = "input.regular_keybinds.game_actions",
	order = 30000,
})
c({
	key = "regular_keybinds_start_fantoms_preview",
	stack_path = "input.regular_keybinds.game_actions",
	order = 40000,
})
c({
	key = "regular_keybinds_copy_log_file",
	stack_path = "input.regular_keybinds.game_actions",
	order = 50000,
})

---

l({
	key = "move_highlight",
	operator = "until",
	stack_path = "input",
	order = 60,
})
c({
	key = "move_highlight",
	stack_path = "input.move_highlight",
	order = 100,
})

---

l({
	key = "dangerous_actions",
	operator = "until",
	stack_path = "input",
	order = 80,
})

c({
	key = "dangerous_actions_sell_one",
	stack_path = "input.dangerous_actions",
	order = 100,
})
c({
	key = "dangerous_actions_remove_one",
	stack_path = "input.dangerous_actions",
	order = 200,
})
c({
	key = "dangerous_actions_sell_all_same",
	stack_path = "input.dangerous_actions",
	order = 300,
})
c({
	key = "dangerous_actions_remove_all_same",
	stack_path = "input.dangerous_actions",
	order = 400,
})
c({
	key = "dangerous_actions_sell_all",
	stack_path = "input.dangerous_actions",
	order = 500,
})
c({
	key = "dangerous_actions_remove_all",
	stack_path = "input.dangerous_actions",
	order = 600,
})

--

l({
	key = "finish",
	operator = "until",
	stack_path = "input",
	order = 95,
})
c({
	key = "dangerous_actions_crash",
	stack_path = "input.finish",
	order = 100,
})
c({
	key = "dangerous_actions_stack_overflow",
	stack_path = "input.finish",
	order = 200,
})
c({
	key = "regular_keybinds_restart_game",
	stack_path = "input.finish",
	order = 300,
})
