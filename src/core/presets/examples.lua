local examples = {
	full_default = {
		config = Handy.utils.table_merge({}, Handy.config.default),
		key = "full_default",
		ignore_blacklist = true,
		dangerous = true,
		rerender = true,
	},
	default = {
		config = Handy.utils.table_merge({}, Handy.config.default),
		key = "default",
	},
	better_mouse_and_gamepad = {
		config = {
			version = 2,

			hand_selection = {
				enabled = true,
			},
			hand_selection_mode = {
				value = 2,
			},
			hand_selection_insta_highlight = {
				enabled = true,

				keys_1 = { "Right Mouse" },
				keys_2 = { "None" },
				keys_1_gamepad = { "(B)" },
				keys_2_gamepad = { "None" },
			},
			hand_selection_deselect_hand = {
				enabled = true,

				keys_1 = { "Right Mouse" },
				keys_2 = { "None" },
				keys_1_gamepad = { "(B)" },
				keys_2_gamepad = { "None" },
			},
			hand_selection_insta_highlight_allow_deselect = {
				enabled = true,
			},
			hand_selection_combine_select_deselect = {
				enabled = true,
			},

			regular_keybinds = {
				enabled = true,
			},
			regular_keybinds_play = {
				enabled = true,

				keys_1 = { "Wheel Up" },
				keys_2 = { "None" },
			},
			regular_keybinds_discard = {
				enabled = true,

				keys_1 = { "Wheel Down" },
				keys_2 = { "None" },
			},
			regular_keybinds_sort_by_suit = {
				enabled = true,

				keys_1 = { "Mouse 4" },
				keys_2 = { "None" },
				keys_1_gamepad = { "Left Bumper" },
				keys_2_gamepad = { "None" },
			},
			regular_keybinds_sort_by_rank = {
				enabled = true,

				keys_1 = { "Mouse 5" },
				keys_2 = { "None" },
				keys_1_gamepad = { "Right Bumper" },
				keys_2_gamepad = { "None" },
			},
			regular_keybinds_options = {
				enabled = true,

				keys_1 = { "Mouse 3" },
				keys_2 = { "None" },
				keys_1_gamepad = { "Right Stick" },
				keys_2_gamepad = { "None" },
			},
		},
		key = "better_mouse_and_gamepad",
	},
}

Handy.presets.examples = examples
