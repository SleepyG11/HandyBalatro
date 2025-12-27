local examples = {
	default = {
		config = Handy.utils.table_merge({}, Handy.config.default),
		key = "default",
	},
	better_mouse_and_gamepad = {
		config = {
			insta_highlight = {
				key_1 = "Right Mouse",
				key_2 = "None",
				key_1_gamepad = "(B)",
				key_2_gamepad = "None",

				allow_deselect = {
					enabled = false,
				},
			},
			regular_keybinds = {
				enabled = true,
				play = {
					key_1 = "Wheel Up",
					key_2 = "None",
				},
				discard = {
					key_1 = "Wheel Down",
					key_2 = "None",
				},
				sort_by_rank = {
					key_1 = "Mouse 5",
					key_2 = "None",
					key_1_gamepad = "Right Bumper",
					key_2_gamepad = "None",
				},
				sort_by_suit = {
					key_1 = "Mouse 4",
					key_2 = "None",
					key_1_gamepad = "Left Bumper",
					key_2_gamepad = "None",
				},
			},
			deselect_hand = {
				enabled = true,
				key_1 = "Right Mouse",
				key_2 = "None",
				key_1_gamepad = "(B)",
				key_2_gamepad = "None",
			},
		},
		key = "better_mouse_and_gamepad",
	},
}

Handy.presets.examples = examples
