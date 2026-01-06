local default_config = {
	version = 2,

	-- Appearance and main things
	handy = {
		enabled = true,
	},
	hide_options_button = {
		enabled = false,
	},
	notifications_level = {
		value = 3,
	},
	keybinds_trigger_mode = {
		value = 1,
	},
	current_device = {
		value = 1,
	},
	advanced_mode = {
		enabled = false,
	},

	presets = {
		enabled = true,
	},
	presets_load_1 = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	presets_load_2 = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	presets_load_3 = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	presets_load_next = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},

	-- Controller
	swap_controller_cursor_stick = {
		enabled = false,
	},
	controller_sensitivity = {
		enabled = true,
		value = 1,
	},

	-- DebugPlus
	prevent_if_debugplus = {
		enabled = false,
	},

	-- Speed and Animations
	speed_multiplier = {
		enabled = true,
	},
	speed_multiplier_default_value = {
		enabled = true,
		value = 1,
	},
	speed_multiplier_settings_toggle = {
		enabled = true,
	},
	speed_multiplier_multiply = {
		enabled = true,
		keys_1 = { "Alt", "Wheel Up" },
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	speed_multiplier_divide = {
		enabled = true,
		keys_1 = { "Alt", "Wheel Down" },
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	speed_multiplier_toggle_temp_disabled = {
		enabled = true,
		keys_1 = { "Alt", "Right Bracket" },
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},

	animation_skip = {
		enabled = true,
	},
	animation_skip_default_value = {
		enabled = true,
		value = 1,
	},
	animation_skip_settings_toggle = {
		enabled = true,
	},
	animation_skip_increase = {
		enabled = true,
		keys_1 = { "Left Bracket", "Wheel Up" },
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	animation_skip_decrease = {
		enabled = true,
		keys_1 = { "Left Bracket", "Wheel Down" },
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	animation_skip_toggle_temp_disabled = {
		enabled = true,
		keys_1 = { "Left Bracket", "Right Bracket" },
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},

	scoring_hold = {
		enabled = true,
	},
	scoring_hold_any_moment = {
		enabled = false,
	},

	-- Cards selection
	hand_selection = {
		enabled = true,
	},
	hand_selection_insta_highlight = {
		enabled = true,

		keys_1 = { "Left Mouse" },
		keys_2 = { "Right Mouse" },
		keys_1_gamepad = { "Left Stick" },
		keys_2_gamepad = { "Left Mouse" },
	},
	hand_selection_insta_highlight_allow_deselect = {
		enabled = false,
	},
	hand_selection_entire_f_hand = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	hand_selection_deselect_hand = {
		enabled = true,

		keys_1 = { "Right Mouse" },
		keys_2 = {},
		keys_1_gamepad = { "Right Stick" },
		keys_2_gamepad = {},
	},

	move_highlight = {
		enabled = true,
	},
	move_highlight_swap = {
		enabled = true,
		keys_1 = { "Shift" },
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	move_highlight_to_end = {
		enabled = true,
		keys_1 = { "Ctrl" },
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	move_highlight_dx_one_left = {
		enabled = true,
		keys_1 = { "Left" },
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	move_highlight_dx_one_right = {
		enabled = true,
		keys_1 = { "Right" },
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},

	regular_keybinds = {
		enabled = true,
	},
	regular_keybinds_restart = {
		enabled = true,
		keys_1 = { "R" },
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	regular_keybinds_quick_restart = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	regular_keybinds_save_run = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},

	regular_keybinds_play = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = { "(X)" },
		keys_2_gamepad = {},
	},
	regular_keybinds_discard = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = { "(Y)" },
		keys_2_gamepad = {},
	},
	regular_keybinds_sort_by_rank = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = { "Right Bumper" },
		keys_2_gamepad = {},
	},
	regular_keybinds_sort_by_suit = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = { "Left Bumper" },
		keys_2_gamepad = {},
	},
	regular_keybinds_toggle_sort = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	regular_keybinds_start_fantoms_preview = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},

	regular_keybinds_skip_booster = {
		enabled = true,
		keys_1 = { "Enter" },
		keys_2 = {},
		keys_1_gamepad = { "(Y)" },
		keys_2_gamepad = {},
	},
	regular_keybinds_reroll_shop = {
		enabled = true,
		keys_1 = { "Q" },
		keys_2 = {},
		keys_1_gamepad = { "(X)" },
		keys_2_gamepad = {},
	},
	regular_keybinds_leave_shop = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = { "(Y)" },
		keys_2_gamepad = {},
	},

	regular_keybinds_select_blind = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = { "(Y)" },
		keys_2_gamepad = {},
	},
	regular_keybinds_skip_blind = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = { "(X)" },
		keys_2_gamepad = {},
	},
	regular_keybinds_reroll_boss = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = { "(Guide)" },
		keys_2_gamepad = {},
	},

	regular_keybinds_run_info = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	regular_keybinds_run_info_blinds = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	regular_keybinds_view_deck = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = { "Right Trigger" },
		keys_2_gamepad = {},
	},
	regular_keybinds_lobby_info = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	regular_keybinds_show_deck_preview = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = { "Left Trigger" },
		keys_2_gamepad = {},
	},
	regular_keybinds_mod_settings = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},

	regular_keybinds_not_just_yet_interaction = {
		enabled = true,
		keys_1 = { "Enter" },
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	regular_keybinds_cash_out = {
		enabled = true,
		keys_1 = { "Enter" },
		keys_2 = {},
		keys_1_gamepad = { "(Y)" },
		keys_2_gamepad = {},
	},

	insta_actions = {
		enabled = true,
	},
	insta_actions_trigger_mode = {
		value = 1,
	},
	insta_actions_buy_or_sell = {
		enabled = true,
		keys_1 = { "Shift" },
		keys_2 = {},
		keys_1_gamepad = { "Left Bumper" },
		keys_2_gamepad = {},
	},
	insta_actions_buy_n_sell = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	insta_actions_use = {
		enabled = true,
		keys_1 = { "Ctrl" },
		keys_2 = {},
		keys_1_gamepad = { "Right Bumper" },
		keys_2_gamepad = {},
	},
	insta_actions_cryptid_code_use_last_interaction = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},

	dangerous_actions = {
		enabled = false,
	},
	dangerous_actions_sell_one = {
		enabled = false,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	dangerous_actions_remove_one = {
		enabled = false,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	dangerous_actions_sell_all_same = {
		enabled = false,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	dangerous_actions_remove_all_same = {
		enabled = false,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	dangerous_actions_sell_all = {
		enabled = false,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	dangerous_actions_remove_all = {
		enabled = false,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
	dangerous_actions_animation_skip_unsafe = {
		enabled = false,
	},
	dangerous_actions_speed_multiplier_uncap = {
		enabled = false,
	},
	dangerous_actions_crash = {
		enabled = true,
		keys_1 = {},
		keys_2 = {},
		keys_1_gamepad = {},
		keys_2_gamepad = {},
	},
}

local old_default_v1 = {
	handy = {
		enabled = true,
	},

	notifications_level = 3,
	keybinds_trigger_mode = 1,
	insta_actions_trigger_mode = 1,
	current_device = 1,
	hide_in_menu = false,

	swap_controller_cursor_stick = {
		enabled = false,
	},
	controller_sensivity = {
		enabled = true,
		mult = 1,
	},

	hide_options_button = {
		enabled = false,
	},
	prevent_if_debugplus = {
		enabled = false,
	},

	insta_highlight = {
		enabled = true,

		key_1 = "Left Mouse",
		key_2 = "Right Mouse",
		key_1_gamepad = "Left Stick",
		key_2_gamepad = "Left Mouse", -- Touchscreen

		allow_deselect = {
			enabled = false,
		},
	},
	insta_highlight_entire_f_hand = {
		enabled = true,
		key_1 = "None",
		key_2 = "None",
		key_1_gamepad = "None",
		key_2_gamepad = "None",
	},
	insta_buy_n_sell = {
		enabled = true,
		key_1 = "None",
		key_2 = "None",
		key_1_gamepad = "None",
		key_2_gamepad = "None",
	},
	insta_buy_or_sell = {
		enabled = true,
		key_1 = "Shift",
		key_2 = "None",
		key_1_gamepad = "Left Bumper",
		key_2_gamepad = "None",
	},
	insta_use = {
		enabled = true,
		key_1 = "Ctrl",
		key_2 = "None",
		key_1_gamepad = "Right Bumper",
		key_2_gamepad = "None",
	},
	move_highlight = {
		enabled = true,

		swap = {
			enabled = true,
			key_1 = "Shift",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
		to_end = {
			enabled = true,
			key_1 = "Ctrl",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},

		dx = {
			one_left = {
				enabled = true,
				key_1 = "Left",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},
			one_right = {
				enabled = true,
				key_1 = "Right",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},
		},
	},

	insta_cash_out = {
		enabled = true,
		key_1 = "Enter",
		key_2 = "None",
		key_1_gamepad = "(Y)",
		key_2_gamepad = "None",
	},
	insta_booster_skip = {
		enabled = true,
		key_1 = "Enter",
		key_2 = "None",
		key_1_gamepad = "(Y)",
		key_2_gamepad = "None",
	},
	show_deck_preview = {
		enabled = true,
		key_1 = "None",
		key_2 = "None",
		key_1_gamepad = "Left Trigger",
		key_2_gamepad = "None",
	},

	dangerous_actions = {
		enabled = false,

		-- Use it as basic modifier for all dangerous controls
		-- Maybe I should change this but idk, backwards compatibility
		immediate_buy_and_sell = {
			enabled = false,
			key_1 = "Middle Mouse",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",

			queue = {
				enabled = false,
			},
		},

		sell_all_same = {
			enabled = false,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},

		sell_all = {
			enabled = false,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},

		card_remove = {
			enabled = false,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},

		nopeus_unsafe = {
			enabled = false,
		},
		animation_skip_unsafe = {
			enabled = false,
		},
		speed_multiplier_uncap = {
			enabled = false,
		},
	},

	speed_multiplier = {
		enabled = true,

		key_1 = "Alt",
		key_2 = "None",
		key_1_gamepad = "None",
		key_2_gamepad = "None",

		default_value = 1,

		no_hold = {
			enabled = false,
		},
		settings_toggle = {
			enabled = true,
		},

		multiply = {
			enabled = true,
			key_1 = "Wheel Up",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
		divide = {
			enabled = true,
			key_1 = "Wheel Down",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
	},

	deselect_hand = {
		enabled = true,
		key_1 = "Right Mouse",
		key_2 = "None",
		key_1_gamepad = "Right Stick",
		key_2_gamepad = "None",
	},

	regular_keybinds = {
		enabled = true,

		play = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "(X)",
			key_2_gamepad = "None",
		},
		discard = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "(Y)",
			key_2_gamepad = "None",
		},
		sort_by_rank = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "Right Bumper",
			key_2_gamepad = "None",
		},
		sort_by_suit = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "Left Bumper",
			key_2_gamepad = "None",
		},
		toggle_sort = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},

		reroll_shop = {
			enabled = true,
			key_1 = "Q",
			key_2 = "None",
			key_1_gamepad = "(X)",
			key_2_gamepad = "None",
		},
		leave_shop = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "(Y)",
			key_2_gamepad = "None",
		},

		skip_blind = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "(X)",
			key_2_gamepad = "None",
		},
		select_blind = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "(Y)",
			key_2_gamepad = "None",
		},
		reroll_boss = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},

		run_info = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "(Guide)",
			key_2_gamepad = "None",
		},
		run_info_blinds = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},

		view_deck = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "Right Trigger",
			key_2_gamepad = "None",
		},

		lobby_info = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
	},

	nopeus_interaction = {
		enabled = true,

		key_1 = "]",
		key_2 = "None",
		key_1_gamepad = "None",
		key_2_gamepad = "None",

		no_hold = {
			enabled = false,
		},

		increase = {
			enabled = true,
			key_1 = "Wheel Up",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
		decrease = {
			enabled = true,
			key_1 = "Wheel Down",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
	},

	not_just_yet_interaction = {
		enabled = true,
		key_1 = "Enter",
		key_2 = "None",
		key_1_gamepad = "None",
		key_2_gamepad = "None",
	},

	cryptid_code_use_last_interaction = {
		enabled = true,
		key_1 = "None",
		key_2 = "None",
		key_1_gamepad = "None",
		key_2_gamepad = "None",
	},

	animation_skip = {
		enabled = true,

		key_1 = "Left Bracket",
		key_2 = "None",
		key_1_gamepad = "None",
		key_2_gamepad = "None",

		default_value = 1,

		no_hold = {
			enabled = false,
		},
		settings_toggle = {
			enabled = true,
		},

		increase = {
			enabled = true,
			key_1 = "Wheel Up",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
		decrease = {
			enabled = true,
			key_1 = "Wheel Down",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
	},

	scoring_hold = {
		enabled = true,
		key_1 = "None",
		key_2 = "None",
		key_1_gamepad = "None",
		key_2_gamepad = "None",

		any_moment = {
			enabled = false,
		},
	},

	presets = {
		enabled = true,

		load_1 = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
		load_2 = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
		load_3 = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
		load_next = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
	},

	misc = {
		enabled = true,

		crash = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
		open_mod_settings = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
		save_run = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
		quick_restart = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
		start_fantoms_preview = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
	},
}

Handy.config.default = default_config
Handy.config.old_defaults = {
	[1] = old_default_v1,
}
