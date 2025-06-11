local default_config = {
	handy = {
		enabled = true,
	},

	notifications_level = 3,
	keybinds_trigger_mode = 1,
	insta_actions_trigger_mode = 1,
	current_device = 1,
	hide_in_menu = false,

	hide_options_button = {
		enabled = false,
	},

	insta_highlight = {
		enabled = true,

		key_1 = "Left Mouse",
		key_2 = "None",
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
		key_1_gamepad = "None",
		key_2_gamepad = "None",
	},
	insta_use = {
		enabled = true,
		key_1 = "Ctrl",
		key_2 = "None",
		key_1_gamepad = "None",
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
	},

	speed_multiplier = {
		enabled = true,

		key_1 = "Alt",
		key_2 = "None",
		key_1_gamepad = "None",
		key_2_gamepad = "None",

		no_hold = {
			enabled = false,
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
	},
}

Handy.config = {
	default = Handy.utils.table_merge({}, default_config),
	current = {},

	get_module = function(module)
		if not module then
			return nil
		end
		local override = Handy.get_module_override(module)
		if override then
			return Handy.utils.table_merge({}, module, override)
		end
		return module
	end,
	save = function()
		if SMODS and SMODS.save_mod_config and Handy.current_mod then
			Handy.current_mod.config = Handy.config.current
			SMODS.save_mod_config(Handy.current_mod)
		else
			love.filesystem.createDirectory("config")
			local serialized = "return " .. Handy.utils.serialize(Handy.config.current)
			love.filesystem.write("config/Handy.jkr", serialized)
		end
	end,
	load = function()
		Handy.config.current = Handy.utils.table_merge({}, Handy.config.default)
		local lovely_mod_config = get_compressed("config/Handy.jkr")
		if lovely_mod_config then
			Handy.config.current = Handy.utils.table_merge(Handy.config.current, STR_UNPACK(lovely_mod_config))
		end
		Handy.cc = Handy.config.current
	end,
}

-- Shorthand for `Handy.config.current`
Handy.cc = Handy.config.current
Handy.config.load()

-- Ha-ha, funny Cryptid reference

-- Resolve module with overrides
function Handy.m(module)
	return Handy.config.get_module(module)
end

function Handy.is_mod_active()
	return Handy.cc.handy.enabled
end
function Handy.is_dangerous_actions_active()
	return Handy.cc.dangerous_actions.enabled
end
function Handy.get_module_override(module)
	return nil
end
