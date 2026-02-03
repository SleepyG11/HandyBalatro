local l = Handy.controls.register_layer
local c = Handy.controls.register_control

l({
	key = "presets",
	operator = "first",
	stack_path = "input",
})

c({
	key = "presets_switch_load_1",
	stack_path = "input.presets",
})
c({
	key = "presets_switch_load_2",
	stack_path = "input.presets",
})
c({
	key = "presets_switch_load_3",
	stack_path = "input.presets",
})
c({
	key = "presets_switch_load_next",
	stack_path = "input.presets",
})

---

l({
	key = "speed_n_animations",
	operator = "first",
	stack_path = "input",
})

l({
	key = "temp_disable",
	operator = "any",
	stack_path = "input.speed_n_animations",
})
l({
	key = "increase",
	operator = "any",
	stack_path = "input.speed_n_animations",
})
l({
	key = "decrease",
	operator = "any",
	stack_path = "input.speed_n_animations",
})

c({
	key = "speed_multiplier_toggle_temp_disabled",
	stack_path = "input.speed_n_animations.temp_disable",
})
c({
	key = "animation_skip_toggle_temp_disabled",
	stack_path = "input.speed_n_animations.temp_disable",
})
c({
	key = "speed_multiplier_increase",
	stack_path = "input.speed_n_animations.increase",
})
c({
	key = "animation_skip_increase",
	stack_path = "input.speed_n_animations.increase",
})
c({
	key = "speed_multiplier_decrease",
	stack_path = "input.speed_n_animations.decrease",
})
c({
	key = "animation_skip_decrease",
	stack_path = "input.speed_n_animations.decrease",
})

---

l({
	key = "hand_selection",
	operator = "first",
	stack_path = "input",
})
c({
	key = "hand_selection_insta_highlight",
	stack_path = "input.hand_selection",
})
c({
	key = "hand_selection_deselect_hand",
	stack_path = "input.hand_selection",
})
c({
	key = "hand_selection_entire_f_hand",
	stack_path = "input.hand_selection",
})

---

l({
	key = "insta_actions",
	operator = "first",
	stack_path = "input",
})
c({
	key = "insta_actions",
	stack_path = "input.insta_actions",
})

---

l({
	key = "regular_keybinds",
	operator = "first",
	stack_path = "input",
})

l({
	key = "hand_sorting",
	operator = "first",
	stack_path = "input.regular_keybinds",
})
l({
	key = "hand_actions",
	operator = "first",
	stack_path = "input.regular_keybinds",
})
l({
	key = "shop_actions",
	operator = "first",
	stack_path = "input.regular_keybinds",
})
l({
	key = "blind_select_actions",
	operator = "first",
	stack_path = "input.regular_keybinds",
})
l({
	key = "menus",
	operator = "first",
	stack_path = "input.regular_keybinds",
})
l({
	key = "game_actions",
	operator = "first",
	stack_path = "input.regular_keybinds",
})

c({
	key = "regular_keybinds_change_sort_rank",
	stack_path = "input.regular_keybinds.hand_sorting",
})
c({
	key = "regular_keybinds_change_sort_suit",
	stack_path = "input.regular_keybinds.hand_sorting",
})
c({
	key = "regular_keybinds_toggle_sort",
	stack_path = "input.regular_keybinds.hand_sorting",
})

c({
	key = "regular_keybinds_discard",
	stack_path = "input.regular_keybinds.hand_actions",
})
c({
	key = "regular_keybinds_play",
	stack_path = "input.regular_keybinds.hand_actions",
})
c({
	key = "regular_keybinds_not_just_yet_interaction",
	stack_path = "input.regular_keybinds.hand_actions",
})

c({
	key = "regular_keybinds_cash_out",
	stack_path = "input.regular_keybinds.shop_actions",
})
c({
	key = "regular_keybinds_skip_booster",
	stack_path = "input.regular_keybinds.shop_actions",
})
c({
	key = "regular_keybinds_reroll_shop",
	stack_path = "input.regular_keybinds.shop_actions",
})
c({
	key = "regular_keybinds_leave_shop",
	stack_path = "input.regular_keybinds.shop_actions",
})

c({
	key = "regular_keybinds_reroll_boss",
	stack_path = "input.regular_keybinds.blind_select_actions",
})
c({
	key = "regular_keybinds_skip_blind",
	stack_path = "input.regular_keybinds.blind_select_actions",
})
c({
	key = "regular_keybinds_select_blind",
	stack_path = "input.regular_keybinds.blind_select_actions",
})

c({
	key = "regular_keybinds_run_info",
	stack_path = "input.regular_keybinds.menus",
})
c({
	key = "regular_keybinds_run_info_binds",
	stack_path = "input.regular_keybinds.menus",
})
c({
	key = "regular_keybinds_view_deck",
	stack_path = "input.regular_keybinds.menus",
})
c({
	key = "regular_keybinds_view_lobby_info",
	stack_path = "input.regular_keybinds.menus",
})
c({
	key = "regular_keybinds_mod_settings",
	stack_path = "input.regular_keybinds.menus",
})

c({
	key = "regular_keybinds_quick_restart",
	stack_path = "input.regular_keybinds.game_actions",
})
c({
	key = "regular_keybinds_save_run",
	stack_path = "input.regular_keybinds.game_actions",
})
c({
	key = "regular_keybinds_reload_run",
	stack_path = "input.regular_keybinds.game_actions",
})
c({
	key = "regular_keybinds_start_fantoms_preview",
	stack_path = "input.regular_keybinds.game_actions",
})

---

l({
	key = "move_highlight",
	operator = "first",
	stack_path = "input",
})
c({
	key = "move_highlight",
	stack_path = "input.move_highlight",
})

---

l({
	key = "dangerous_actions",
	operator = "first",
	stack_path = "input",
})

c({
	key = "dangerous_actions_crash",
	stack_path = "input.dangerous_actions",
})
c({
	key = "dangerous_actions_sell_one",
	stack_path = "input.dangerous_actions",
})
c({
	key = "dangerous_actions_remove_one",
	stack_path = "input.dangerous_actions",
})
c({
	key = "dangerous_actions_sell_all_same",
	stack_path = "input.dangerous_actions",
})
c({
	key = "dangerous_actions_remove_all_same",
	stack_path = "input.dangerous_actions",
})
c({
	key = "dangerous_actions_sell_all",
	stack_path = "input.dangerous_actions",
})
c({
	key = "dangerous_actions_remove_all",
	stack_path = "input.dangerous_actions",
})
