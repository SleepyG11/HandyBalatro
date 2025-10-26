local keyw = {
	toggle = "enable disable toggle",
	configs = "features configs settings",
	fast_hand_select = "fast quick swipe drag mobile like hover hand cards selection selecting highlightning",
	fast_hand_deselect = "fast quick swipe drag mobile like hover hand cards deselection deselecting unhighlightning",
	regular_keybinds = "regular vanilla game common keybinds buttons actions",
	play_hand = "play hand",
	discard_hand = "discard hand",
	sort_hand = "sorting sorted hand cards by",
	reroll_shop = "reroll shop one more",
	leave_shop = "leave shop go next",
	skip_blind = "skip blind select skip tag",
	select_blind = "select blind new round",
	reroll_boss = "reroll boss",
	run_info = "run info menus screen",
	view_deck = "view deck menus screen",
	deck_preview = "view show display deck preview menus screen panel popup",
	cash_out = "cash out cashout get me out round shop",
	skip_booster = "booster pack boosterpack skip",
	move_highlight = "move shuffle reorder highlights selected selection cards consumables jokers",
	buy = "buy cards vouchers consumables consumeables tarots planets spectrals boosters packs shop",
	sell = "sell cards vouchers consumables consumeables tarots planets spectrals boosters packs",
	use = "use open redeem cards vouchers consumables consumeables tarots planets spectrals boosters packs",
	speed_multiplier = "game speed multiplier increase decrease change adjust acceleration accelerate more faster speed up",
	animation_skip = "game animations skip instant scoring max speed no again faster accelerate",
	nopeus_interaction = "interaction nopeus fast forward fast-forward",
	scoring_hold = "scoring hold game speed animations pause hold after scoring wait before end of round",
	presets = "presets settings configs profiles load set apply",
	unsafe_control = "dangerous unsafe",
}

local dictionary = {
	handy = {
		loc_key = "handy",
		keywords = {
			keyw.toggle,
			"all mod everything handy",
			keyw.configs,
		},
		order = 1,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.handy,
				"handy",
				{ Handy.version, "SleepyG11" },
				nil,
				options
			)
		end,
	},

	hide_options_button = {
		loc_key = "hide_options_button",
		keywords = {
			keyw.toggle,
			"options configs settings",
			"hide show menu button",
		},
		order = 1.01,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.hide_options_button,
				"hide_options_button",
				nil,
				nil,
				options
			)
		end,
	},
	info_popups_level = {
		keywords = { "messages info notification notify", "popup panel", "black red" },
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_option_cycle(
				localize("b_handy_info_popups_level_select"),
				localize("handy_info_popups_level_opt"),
				Handy.cc.notifications_level,
				"handy_change_notifications_level",
				options
			)
		end,
	},
	keybinds_trigger_mode = {
		keywords = { "keybinds buttons controls", "trigger mode", "pressed released" },
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_option_cycle(
				localize("b_handy_keybinds_trigger_mode_select"),
				localize("handy_keybinds_trigger_mode_opt"),
				Handy.cc.keybinds_trigger_mode,
				"handy_change_keybinds_trigger_mode",
				options
			)
		end,
	},
	device_select = {
		keywords = { "controller gamepad desktop touchpad touch pad auto", "choose select device input" },
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_option_cycle(
				localize("b_handy_device_select"),
				localize("handy_device_opt"),
				Handy.cc.current_device,
				"handy_change_current_device",
				options
			)
		end,
	},
	buy_sell_use_mode = {
		keywords = { "buy sell use mode", "hold click press hover", "cards buttons keybinds controls" },
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_option_cycle(
				localize("b_handy_buy_sell_use_mode_select"),
				localize("handy_buy_sell_use_mode_opt"),
				Handy.cc.insta_actions_trigger_mode,
				"handy_change_insta_actions_trigger_mode",
				options
			)
		end,
	},

	insta_highlight = {
		loc_key = "insta_highlight",
		keywords = { keyw.fast_hand_select },
		order = 2,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.insta_highlight,
				(
					Handy.controller.resolve_first_module_key(Handy.cc.insta_highlight, true) == "mouse1"
						and "insta_highlight_OUTSIDE"
					or "insta_highlight"
				),
				{
					Handy.UI.PARTS.localize_keybind("Left Mouse", true),
				},
				{
					only_first = true,
				},
				options
			)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.insta_highlight,
				"quick_highlight",
				{ only_holdable = true },
				options
			)
		end,
	},
	insta_unhighlight = {
		loc_key = "insta_unhighlight",
		keywords = { keyw.fast_hand_deselect },
		order = 2.01,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.insta_highlight.allow_deselect,
				"insta_unhighlight",
				{ Handy.UI.PARTS.localize_keybind_label("quick_highlight") },
				nil,
				options
			)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.CD.insta_highlight.keybind(options)
		end,
		keybind_group = "insta_highlight",
	},
	insta_highlight_entire_f_hand = {
		loc_key = "insta_highlight_entire_f_hand",
		keywords = { "full entire hand all", "hand cards selection selecting highlightning" },
		order = 2.02,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.insta_highlight_entire_f_hand,
				"insta_highlight_entire_f_hand",
				nil,
				nil,
				options
			)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.insta_highlight_entire_f_hand,
				"highlight_entire_f_hand",
				nil,
				options
			)
		end,
	},
	deselect_hand = {
		loc_key = "deselect_hand",
		keywords = {
			keyw.regular_keybinds,
			"full entire hand all",
			"hand cards deselection deselecting unhighlightning",
		},
		order = 2.03,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.deselect_hand, "deselect_hand", {
				Handy.UI.PARTS.localize_keybind("Right Mouse", true),
			}, nil, options)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.deselect_hand, "deselect_hand", nil, options)
		end,
	},

	regular_keybinds = {
		loc_key = "regular_keybinds",
		keywords = {
			keyw.regular_keybinds,
			keyw.play_hand,
			keyw.discard_hand,
			keyw.sort_hand,
			"suist ranks toggle switch",
			keyw.reroll_shop,
			keyw.leave_shop,
			keyw.skip_blind,
			keyw.select_blind,
			keyw.reroll_boss,
			keyw.run_info,
			"pokerhands poker hands hand levels blinds ante",
			keyw.view_deck,
		},
		order = 3,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.regular_keybinds,
				"regular_keybinds",
				nil,
				nil,
				options
			)
		end,
		keybind = function(options)
			options = options or {}
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.keybinds_trigger_mode.option_cycle(options)
		end,
		option_cycle_group = "keybinds_trigger_mode",
	},
	regular_keybinds_play_hand = {
		loc_key = "play_hand",
		keywords = { keyw.regular_keybinds, keyw.play_hand },
		order = 3.01,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.regular_keybinds.checkbox(options)
		end,
		checkbox_group = "regular_keybinds",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.play, "play_hand", nil, options)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.keybinds_trigger_mode.option_cycle(options)
		end,
		option_cycle_group = "keybinds_trigger_mode",
	},
	regular_keybinds_discard = {
		loc_key = "discard",
		keywords = { keyw.regular_keybinds, keyw.discard_hand },
		order = 3.02,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.regular_keybinds.checkbox(options)
		end,
		checkbox_group = "regular_keybinds",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.discard, "discard", nil, options)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.keybinds_trigger_mode.option_cycle(options)
		end,
		option_cycle_group = "keybinds_trigger_mode",
	},
	regular_keybinds_sort_by_rank = {
		loc_key = "sort_by_rank",
		keywords = { keyw.regular_keybinds, keyw.sort_hand, "ranks" },
		order = 3.03,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.regular_keybinds.checkbox(options)
		end,
		checkbox_group = "regular_keybinds",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.regular_keybinds.sort_by_rank,
				"sort_by_rank",
				nil,
				options
			)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.keybinds_trigger_mode.option_cycle(options)
		end,
		option_cycle_group = "keybinds_trigger_mode",
	},
	regular_keybinds_sort_by_suit = {
		loc_key = "sort_by_suit",
		keywords = { keyw.regular_keybinds, keyw.sort_hand, "suits" },
		order = 3.04,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.regular_keybinds.checkbox(options)
		end,
		checkbox_group = "regular_keybinds",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.regular_keybinds.sort_by_suit,
				"sort_by_suit",
				nil,
				options
			)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.keybinds_trigger_mode.option_cycle(options)
		end,
		option_cycle_group = "keybinds_trigger_mode",
	},
	regular_keybinds_toggle_sort = {
		loc_key = "toggle_sort",
		keywords = { keyw.regular_keybinds, keyw.sort_hand, "ranks suits toggle switch" },
		order = 3.05,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.regular_keybinds.checkbox(options)
		end,
		checkbox_group = "regular_keybinds",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.regular_keybinds.toggle_sort,
				"toggle_sort",
				nil,
				options
			)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.keybinds_trigger_mode.option_cycle(options)
		end,
		option_cycle_group = "keybinds_trigger_mode",
	},
	regular_keybinds_run_info_hands = {
		loc_key = "run_info_hands",
		keywords = { keyw.regular_keybinds, keyw.run_info, "poker hands pokerhands" },
		order = 3.06,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.regular_keybinds.checkbox(options)
		end,
		checkbox_group = "regular_keybinds",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.regular_keybinds.run_info,
				"run_info_hands",
				nil,
				options
			)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.keybinds_trigger_mode.option_cycle(options)
		end,
		option_cycle_group = "keybinds_trigger_mode",
	},
	regular_keybinds_run_info_blinds = {
		loc_key = "run_info_blinds",
		keywords = { keyw.regular_keybinds, keyw.run_info, "blinds bosses ante" },
		order = 3.07,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.regular_keybinds.checkbox(options)
		end,
		checkbox_group = "regular_keybinds",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.regular_keybinds.run_info_blinds,
				"run_info_blinds",
				nil,
				options
			)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.keybinds_trigger_mode.option_cycle(options)
		end,
		option_cycle_group = "keybinds_trigger_mode",
	},
	regular_keybinds_view_deck = {
		loc_key = "view_deck",
		keywords = { keyw.regular_keybinds, keyw.view_deck },
		order = 3.08,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.regular_keybinds.checkbox(options)
		end,
		checkbox_group = "regular_keybinds",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.view_deck, "view_deck", nil, options)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.keybinds_trigger_mode.option_cycle(options)
		end,
		option_cycle_group = "keybinds_trigger_mode",
	},
	show_deck_preview = {
		loc_key = "show_deck_preview",
		keywords = { keyw.regular_keybinds, keyw.deck_preview },
		order = 3.085,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.show_deck_preview,
				"show_deck_preview",
				nil,
				nil,
				options
			)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.show_deck_preview,
				"deck_preview",
				{ only_holdable = true },
				options
			)
		end,
	},
	regular_keybinds_skip_blind = {
		loc_key = "skip_blind",
		keywords = { keyw.regular_keybinds, keyw.skip_blind },
		order = 3.1,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.regular_keybinds.checkbox(options)
		end,
		checkbox_group = "regular_keybinds",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.regular_keybinds.skip_blind,
				"skip_blind",
				nil,
				options
			)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.keybinds_trigger_mode.option_cycle(options)
		end,
		option_cycle_group = "keybinds_trigger_mode",
	},
	regular_keybinds_select_blind = {
		loc_key = "select_blind",
		keywords = { keyw.regular_keybinds, keyw.select_blind },
		order = 3.11,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.regular_keybinds.checkbox(options)
		end,
		checkbox_group = "regular_keybinds",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.regular_keybinds.select_blind,
				"select_blind",
				nil,
				options
			)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.keybinds_trigger_mode.option_cycle(options)
		end,
		option_cycle_group = "keybinds_trigger_mode",
	},
	regular_keybinds_reroll_boss = {
		loc_key = "reroll_boss",
		keywords = { keyw.regular_keybinds, keyw.reroll_boss },
		order = 3.115,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.regular_keybinds.checkbox(options)
		end,
		checkbox_group = "regular_keybinds",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.regular_keybinds.reroll_boss,
				"reroll_boss",
				nil,
				options
			)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.keybinds_trigger_mode.option_cycle(options)
		end,
		option_cycle_group = "keybinds_trigger_mode",
	},
	insta_cash_out = {
		loc_key = "insta_cash_out",
		keywords = { keyw.regular_keybinds, keyw.cash_out },
		order = 3.12,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.insta_cash_out,
				"insta_cash_out",
				nil,
				nil,
				options
			)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.insta_cash_out,
				"cash_out",
				{ only_holdable = true },
				options
			)
		end,
	},
	regular_keybinds_reroll_shop = {
		loc_key = "reroll_shop",
		keywords = { keyw.regular_keybinds, keyw.reroll_shop },
		order = 3.13,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.regular_keybinds.checkbox(options)
		end,
		checkbox_group = "regular_keybinds",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.regular_keybinds.reroll_shop,
				"reroll_shop",
				nil,
				options
			)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.keybinds_trigger_mode.option_cycle(options)
		end,
		option_cycle_group = "keybinds_trigger_mode",
	},
	regular_keybinds_leave_shop = {
		loc_key = "leave_shop",
		keywords = { keyw.regular_keybinds, keyw.leave_shop },
		order = 3.14,
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.regular_keybinds.checkbox(options)
		end,
		checkbox_group = "regular_keybinds",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.regular_keybinds.leave_shop,
				"leave_shop",
				nil,
				options
			)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.keybinds_trigger_mode.option_cycle(options)
		end,
		option_cycle_group = "keybinds_trigger_mode",
	},

	insta_booster_skip = {
		loc_key = "insta_booster_skip",
		keywords = { keyw.regular_keybinds, keyw.skip_booster },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.insta_booster_skip,
				"insta_booster_skip",
				nil,
				nil,
				options
			)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.insta_booster_skip,
				"skip_booster",
				{ only_holdable = true },
				options
			)
		end,
	},
	not_just_yet_interaction = {
		keywords = { "round end finish", "not just yet notjustyet" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.not_just_yet_interaction,
				"not_just_yet_interaction",
				nil,
				nil,
				options
			)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.not_just_yet_interaction,
				"not_just_yet_end_round",
				{ only_holdable = true },
				options
			)
		end,
	},

	move_highlight = {
		loc_key = "move_highlight",
		keywords = { keyw.move_highlight },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.move_highlight, "move_highlight", {
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.dx.one_left, true),
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.dx.one_right, true),
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.swap, true),
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.to_end, true),
			}, nil, options)
		end,
	},
	move_highlight_one_left = {
		loc_key = "move_highlight_one_left",
		keywords = { keyw.move_highlight, "one left" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.move_highlight.checkbox(options)
		end,
		checkbox_group = "move_highlight",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.move_highlight.dx.one_left,
				"move_highlight_one_left",
				{ disabled = Handy.controller.is_gamepad() },
				options
			)
		end,
	},
	move_highlight_one_right = {
		loc_key = "move_highlight_one_right",
		keywords = { keyw.move_highlight, "one right" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.move_highlight.checkbox(options)
		end,
		checkbox_group = "move_highlight",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.move_highlight.dx.one_right,
				"move_highlight_one_right",
				{ disabled = Handy.controller.is_gamepad() },
				options
			)
		end,
	},
	move_highlight_move_card = {
		loc_key = "move_highlight_move_card",
		keywords = { keyw.move_highlight, "move shuffle cards" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.move_highlight.checkbox(options)
		end,
		checkbox_group = "move_highlight",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.move_highlight.swap,
				"move_highlight_move_card",
				{ disabled = Handy.controller.is_gamepad(), only_holdable = true },
				options
			)
		end,
	},
	move_highlight_to_end = {
		loc_key = "move_highlight_to_end",
		keywords = { keyw.move_highlight, "to end" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.move_highlight.checkbox(options)
		end,
		checkbox_group = "move_highlight",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.move_highlight.to_end,
				"move_highlight_to_end",
				{ disabled = Handy.controller.is_gamepad(), only_holdable = true },
				options
			)
		end,
	},

	insta_buy_or_sell = {
		loc_key = "insta_buy_or_sell",
		keywords = { keyw.buy, keyw.sell, "or" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.insta_buy_or_sell, "insta_buy_or_sell", {
				localize("b_handy_buy_sell_use_mode_select"),
				Handy.UI.PARTS.localize_keybind("Left Bumper", true),
			}, nil, options)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_buy_or_sell, "quick_buy_or_sell", nil, options)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.buy_sell_use_mode.option_cycle(options)
		end,
		option_cycle_group = "buy_sell_use_mode",
	},
	insta_buy_n_sell = {
		loc_key = "insta_buy_n_sell",
		keywords = { keyw.buy, keyw.sell, "or and", "buy'n'sell buy and sell" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.insta_buy_n_sell, "insta_buy_n_sell", {
				localize("b_handy_buy_sell_use_mode_select"),
			}, nil, options)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_buy_n_sell, "quick_buy_n_sell", nil, options)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.buy_sell_use_mode.option_cycle(options)
		end,
		option_cycle_group = "buy_sell_use_mode",
	},
	insta_use = {
		loc_key = "insta_use",
		keywords = { keyw.use },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.insta_use, "insta_use", {
				localize("b_handy_buy_sell_use_mode_select"),
				Handy.UI.PARTS.localize_keybind("Right Bumper", true),
			}, nil, options)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_use, "quick_use", nil, options)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.buy_sell_use_mode.option_cycle(options)
		end,
		option_cycle_group = "buy_sell_use_mode",
	},
	cryptid_code_use_last_interaction = {
		loc_key = "cryptid_code_use_last_interaction",
		keywords = { "use code cards cryptid last input previous value pointer class exploit variable" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.cryptid_code_use_last_interaction,
				"cryptid_code_use_last_interaction",
				{
					localize("b_handy_buy_sell_use_mode_select"),
				},
				nil,
				options
			)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.cryptid_code_use_last_interaction,
				"cryptid_code_use_last_interaction",
				nil,
				options
			)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.CD.buy_sell_use_mode.option_cycle(options)
		end,
		option_cycle_group = "buy_sell_use_mode",
	},

	speed_multiplier = {
		loc_key = "speed_multiplier",
		keywords = { keyw.speed_multiplier },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.speed_multiplier, "speed_multiplier", {
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.speed_multiplier.multiply, true),
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.speed_multiplier.divide, true),
				"x1/512",
				"x512",
			}, nil, options)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.speed_multiplier,
				"speed_multiplier",
				{ only_holdable = true },
				options
			)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_option_cycle_simple(
				localize("speed_multiplier", "handy_keybind_labels"),
				Handy.speed_multiplier,
				"value_text",
				function()
					Handy.speed_multiplier.divide()
				end,
				function()
					Handy.speed_multiplier.multiply()
				end,
				options
			)
		end,
		settings_option_cycle = function()
			if
				Handy.controller.is_module_enabled(Handy.cc.speed_multiplier)
				and Handy.controller.is_module_enabled(Handy.cc.speed_multiplier.settings_toggle)
			then
				return {
					n = G.UIT.R,
					config = { align = "cm" },
					nodes = {
						Handy.UI.CD.speed_multiplier.option_cycle({ compress = true, w = 6, colour = G.C.CHIPS }),
					},
				}
			end
		end,
	},
	speed_multiplier_multiply = {
		loc_key = { "speed_multiplier", "speed_multiplier_multiply" },
		keywords = { keyw.speed_multiplier, "multiply increase" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.speed_multiplier.checkbox(options)
		end,
		checkbox_group = "speed_multiplier",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.speed_multiplier.multiply,
				"speed_multiplier_multiply",
				nil,
				options
			)
		end,
	},
	speed_multiplier_divide = {
		loc_key = { "speed_multiplier", "speed_multiplier_divide" },
		keywords = { keyw.speed_multiplier, "divide decrease" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.speed_multiplier.checkbox(options)
		end,
		checkbox_group = "speed_multiplier",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.speed_multiplier.divide,
				"speed_multiplier_divide",
				nil,
				options
			)
		end,
	},
	speed_multiplier_no_hold = {
		loc_key = { "speed_multiplier", "speed_multiplier_no_hold" },
		keywords = { keyw.speed_multiplier, "no hold" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.speed_multiplier.no_hold,
				"speed_multiplier_no_hold",
				{
					Handy.UI.PARTS.localize_keybind_label("speed_multiplier"),
				},
				nil,
				options
			)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.CD.speed_multiplier.keybind(options)
		end,
		keybind_group = "speed_multiplier",
	},
	speed_multiplier_default_value = {
		loc_key = { "speed_multiplier" },
		keywords = { keyw.speed_multiplier, "default" },
		checkbox = function(options)
			return Handy.UI.CD.speed_multiplier.checkbox(options)
		end,
		checkbox_group = "speed_multiplier",
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_option_cycle(
				localize({
					type = "variable",
					key = "Handy_default_value",
					vars = { Handy.UI.PARTS.localize_keybind_label("speed_multiplier", true) },
				}),
				{ "1x", "2x", "4x", "8x", "16x", "32x", "64x", "128x", "256x", "512x" },
				Handy.cc.speed_multiplier.default_value,
				"handy_change_default_speed_multiplier",
				options
			)
		end,
	},

	animation_skip = {
		loc_key = "animation_skip",
		keywords = { keyw.animation_skip },
		checkbox = function(options)
			options = options or {}
			local levels = localize("handy_animation_skip_levels")
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.animation_skip, "animation_skip", {
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.animation_skip.increase, true),
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.animation_skip.decrease, true),
				levels[1],
				levels[2],
				levels[3],
				levels[4],
				levels[5],
				localize("Dangerous", "handy_tabs"),
			}, nil, options)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.animation_skip,
				"animation_skip",
				{ only_holdable = true },
				options
			)
		end,
		option_cycle = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_option_cycle_simple(
				localize("animation_skip", "handy_keybind_labels"),
				Handy.animation_skip,
				"value_text",
				function()
					Handy.animation_skip.decrease()
				end,
				function()
					Handy.animation_skip.increase()
				end,
				options
			)
		end,
		settings_option_cycle = function()
			if
				Handy.controller.is_module_enabled(Handy.cc.animation_skip)
				and Handy.controller.is_module_enabled(Handy.cc.animation_skip.settings_toggle)
			then
				return {
					n = G.UIT.R,
					config = { align = "cm" },
					nodes = {
						Handy.UI.CD.animation_skip.option_cycle({
							compress = true,
							w = 6,
							colour = G.C.ORANGE,
						}),
					},
				}
			end
		end,
	},
	animation_skip_increase = {
		loc_key = { "animation_skip", "animation_skip_increase" },
		keywords = { keyw.animation_skip, "increase multiply" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.animation_skip.checkbox(options)
		end,
		checkbox_group = "animation_skip",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.animation_skip.increase,
				"animation_skip_increase",
				nil,
				options
			)
		end,
	},
	animation_skip_decrease = {
		loc_key = { "animation_skip", "animation_skip_decrease" },
		keywords = { keyw.animation_skip, "decrease divide" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.animation_skip.checkbox(options)
		end,
		checkbox_group = "animation_skip",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.animation_skip.decrease,
				"animation_skip_decrease",
				nil,
				options
			)
		end,
	},
	animation_skip_no_hold = {
		loc_key = { "animation_skip", "animation_skip_no_hold" },
		keywords = { keyw.animation_skip, "no hold" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.animation_skip.no_hold,
				"animation_skip_no_hold",
				{
					Handy.UI.PARTS.localize_keybind_label("animation_skip"),
				},
				nil,
				options
			)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.CD.animation_skip.keybind(options)
		end,
		keybind_group = "animation_skip",
	},
	animation_skip_default_value = {
		loc_key = { "animation_skip" },
		keywords = { keyw.animation_skip, "default" },
		checkbox = function(options)
			return Handy.UI.CD.animation_skip.checkbox(options)
		end,
		checkbox_group = "animation_skip",
		option_cycle = function(options)
			options = options or {}
			local available_options = Handy.utils.table_merge({}, localize("handy_animation_skip_levels"))
			table.remove(available_options, #available_options)
			return Handy.UI.PARTS.create_option_cycle(
				localize({
					type = "variable",
					key = "Handy_default_value",
					vars = { Handy.UI.PARTS.localize_keybind_label("animation_skip", true) },
				}),
				available_options,
				Handy.cc.animation_skip.default_value,
				"handy_change_default_animation_skip",
				options
			)
		end,
	},

	nopeus_interaction = {
		loc_key = "nopeus_interaction",
		keywords = { keyw.animation_skip, keyw.nopeus_interaction },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.nopeus_interaction, "nopeus_interaction", {
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.nopeus_interaction.increase, true),
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.nopeus_interaction.decrease, true),
				localize("Dangerous", "handy_tabs"),
			}, nil, options)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.nopeus_interaction,
				"nopeus_interaction",
				{ only_holdable = true },
				options
			)
		end,
	},
	nopeus_interaction_increase = {
		loc_key = { "nopeus_interaction", "nopeus_interaction_increase" },
		keywords = { keyw.animation_skip, keyw.nopeus_interaction, "multiply increase" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.nopeus_interaction.checkbox(options)
		end,
		checkbox_group = "nopeus_interaction",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.nopeus_interaction.increase,
				"nopeus_interaction_increase",
				nil,
				options
			)
		end,
	},
	nopeus_interaction_decrease = {
		loc_key = { "nopeus_interaction", "nopeus_interaction_decrease" },
		keywords = { keyw.animation_skip, keyw.nopeus_interaction, "divide decrease" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.CD.nopeus_interaction.checkbox(options)
		end,
		checkbox_group = "nopeus_interaction",
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.nopeus_interaction.decrease,
				"nopeus_interaction_decrease",
				nil,
				options
			)
		end,
	},
	nopeus_interaction_no_hold = {
		loc_key = { "nopeus_interaction", "nopeus_interaction_no_hold" },
		keywords = { keyw.animation_skip, keyw.nopeus_interaction, "no hold" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.nopeus_interaction.no_hold,
				"nopeus_interaction_no_hold",
				{
					Handy.UI.PARTS.localize_keybind_label("nopeus_interaction"),
				},
				nil,
				options
			)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.CD.nopeus_interaction.keybind(options)
		end,
		keybind_group = "nopeus_interaction",
	},

	scoring_hold = {
		loc_key = "scoring_hold",
		keywords = { keyw.scoring_hold },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.scoring_hold, "scoring_hold", nil, nil, options)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.scoring_hold,
				"scoring_hold",
				{ only_holdable = true },
				options
			)
		end,
	},
	scoring_hold_any_moment = {
		loc_key = { "scoring_hold", "scoring_hold_any_moment" },
		keywords = { keyw.scoring_hold, "anytime in any moment" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.scoring_hold.any_moment,
				"scoring_hold_any_moment",
				{
					Handy.UI.PARTS.localize_keybind_label("scoring_hold"),
				},
				nil,
				options
			)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.CD.scoring_hold.keybind(options)
		end,
		keybind_group = "scoring_hold",
	},

	presets_load_1 = {
		loc_key = "presets_load_1",
		keywords = { keyw.presets, "1" },
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_1, "presets_load_1", nil, options)
		end,
	},
	presets_load_2 = {
		loc_key = "presets_load_2",
		keywords = { keyw.presets, "2" },
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_2, "presets_load_2", nil, options)
		end,
	},
	presets_load_3 = {
		loc_key = "presets_load_3",
		keywords = { keyw.presets, "3" },
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_3, "presets_load_3", nil, options)
		end,
	},
	presets_load_next = {
		loc_key = "presets_load_next",
		keywords = { keyw.presets, "next" },
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_next, "presets_load_next", nil, options)
		end,
	},

	dangerous_actions = {
		loc_key = "dangerous_actions",
		keywords = { keyw.unsafe_control },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.dangerous_actions,
				"dangerous_actions",
				nil,
				{ dangerous = true },
				options
			)
		end,
	},
	dangerous_nopeus_unsafe = {
		loc_key = { "nopeus_interaction", "nopeus_unsafe" },
		keywords = { keyw.unsafe_control, keyw.nopeus_interaction },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.dangerous_actions.nopeus_unsafe,
				"nopeus_unsafe",
				nil,
				{ dangerous = true },
				options
			)
		end,
	},
	dangerous_animation_skip_unsafe = {
		loc_key = { "animation_skip", "animation_skip_unsafe" },
		keywords = { keyw.unsafe_control, keyw.animation_skip },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.dangerous_actions.animation_skip_unsafe,
				"animation_skip_unsafe",
				{
					localize("handy_animation_skip_levels")[5],
				},
				{
					dangerous = true,
				},
				options
			)
		end,
	},
	dangerous_speed_multiplier_uncap = {
		loc_key = { "speed_multiplier", "speed_multiplier_uncap" },
		keywords = { keyw.unsafe_control, keyw.speed_multiplier, "uncap max speed infinite" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.dangerous_actions.speed_multiplier_uncap,
				"speed_multiplier_uncap",
				nil,
				{
					dangerous = true,
				},
				options
			)
		end,
	},
	immediate_buy_and_sell = {
		loc_key = "immediate_buy_and_sell",
		keywords = { keyw.unsafe_control, keyw.sell },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.dangerous_actions.immediate_buy_and_sell,
				"immediate_buy_and_sell",
				{
					Handy.UI.PARTS.format_new_module_keys(Handy.cc.insta_buy_or_sell, true),
					Handy.UI.PARTS.localize_keybind_label("dangerous_modifier"),
					Handy.UI.PARTS.localize_keybind_label("quick_buy_or_sell"),
				},
				{
					dangerous = true,
				},
				options
			)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.dangerous_actions.immediate_buy_and_sell,
				"dangerous_modifier",
				{ dangerous = true, only_holdable = true },
				options
			)
		end,
	},
	immediate_buy_and_sell_queue = {
		loc_key = "immediate_buy_and_sell_queue",
		keywords = { keyw.unsafe_control, keyw.sell, "queue" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.dangerous_actions.immediate_buy_and_sell.queue,
				"immediate_buy_and_sell_queue",
				nil,
				{
					dangerous = true,
				},
				options
			)
		end,
	},
	sell_all_same_modifier = {
		loc_key = { "sell_all_same", "dangerous_all_same_modifier" },
		keywords = { keyw.unsafe_control, keyw.sell, "all same copies dublicates duplicates card modifier" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.dangerous_actions.sell_all_same,
				"sell_all_same",
				{
					Handy.UI.PARTS.format_new_module_keys(Handy.cc.dangerous_actions.immediate_buy_and_sell, true),
					Handy.UI.PARTS.localize_keybind_label("dangerous_modifier"),
					Handy.UI.PARTS.localize_keybind_label("dangerous_all_same_modifier"),
				},
				{
					only_first = true,
					dangerous = true,
				},
				options
			)
		end,
		keybind = function(options)
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.dangerous_actions.sell_all_same,
				"dangerous_all_same_modifier",
				{ dangerous = true, only_holdable = true },
				options
			)
		end,
	},
	sell_all_modifier = {
		loc_key = { "sell_all", "dangerous_all_modifier" },
		keywords = { keyw.unsafe_control, keyw.sell, "everything all everyone modifier cards" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.dangerous_actions.sell_all, "sell_all", {
				Handy.UI.PARTS.localize_keybind_label("dangerous_modifier"),
				Handy.UI.PARTS.localize_keybind_label("dangerous_all_modifier"),
			}, {
				only_first = true,
				dangerous = true,
			}, options)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.dangerous_actions.sell_all,
				"dangerous_all_modifier",
				{ dangerous = true, only_holdable = true },
				options
			)
		end,
	},
	remove_modifier = {
		loc_key = { "card_remove", "dangerous_remove_modifier" },
		keywords = { keyw.unsafe_control, "remove modifier skip tags cards" },
		checkbox = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.dangerous_actions.card_remove, "card_remove", {
				Handy.UI.PARTS.localize_keybind_label("dangerous_modifier"),
				Handy.UI.PARTS.localize_keybind_label("dangerous_remove_modifier"),
				Handy.UI.PARTS.localize_keybind_label("quick_buy_or_sell"),
				Handy.UI.PARTS.localize_keybind_label("dangerous_all_same_modifier"),
				Handy.UI.PARTS.localize_keybind_label("dangerous_all_modifier"),
			}, {
				dangerous = true,
				only_first = true,
			}, options)
		end,
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.dangerous_actions.card_remove,
				"dangerous_remove_modifier",
				{ dangerous = true, only_holdable = true },
				options
			)
		end,
	},

	misc_crash = {
		loc_key = "misc_crash",
		keywords = { "miscellaneous", "crash kill a game" },
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.misc.crash,
				"misc_crash",
				{ dangerous = true, only_safe = true },
				options
			)
		end,
	},
	misc_open_mod_settings = {
		loc_key = "misc_open_mod_settings",
		keywords = { "miscellaneous", "open mod handy settings configs options menu shortcut" },
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.misc.open_mod_settings,
				"misc_open_mod_settings",
				nil,
				options
			)
		end,
	},
	misc_save_run = {
		loc_key = "misc_save_run",
		keywords = { "miscellaneous", "save run state" },
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.misc.save_run, "misc_save_run", nil, options)
		end,
	},
	misc_quick_restart = {
		loc_key = "misc_quick_restart",
		keywords = { "miscellaneous", "quick restart run" },
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.misc.quick_restart, "misc_quick_restart", nil, options)
		end,
	},
	misc_start_fantoms_preview = {
		loc_key = "misc_start_fantoms_preview",
		keywords = { "miscellaneous", "fantoms score preview calculation calculating" },
		keybind = function(options)
			options = options or {}
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.misc.start_fantoms_preview,
				"misc_start_fantoms_preview",
				nil,
				options
			)
		end,
	},

	debugplus_prevent = {
		loc_key = "debugplus_prevent",
		keywords = { "debugplus debug plus", "prevent keybinds" },
		checkbox = function(options)
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.prevent_if_debugplus,
				"debugplus_prevent",
				{ Handy.UI.PARTS.localize_keybind("Ctrl", true) },
				options
			)
		end,
	},

	controller_swap_cursor_stick = {
		loc_key = "controller_swap_cursor_stick",
		keywords = { "controller", "swap cursor stick sticks" },
		checkbox = function(options)
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.swap_controller_cursor_stick,
				"controller_swap_cursor_stick",
				nil,
				options
			)
		end,
	},
	controller_sensivity = {
		loc_key = "controller_sensivity",
		keywords = { "controller", "cursor sensivity sensitivity" },
		checkbox = function(options)
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.controller_sensivity,
				"controller_sensivity",
				nil,
				options
			)
		end,
		slider = function(options)
			return Handy.UI.PARTS.create_module_slider(
				Handy.cc.controller_sensivity,
				"mult",
				"controller_sensivity",
				nil,
				{
					min = 0.5,
					max = 2,
					decimal_places = 2,
					callback = "handy_change_controller_sensivity",
				},
				options
			)
		end,
	},
}

local dictionary_order = {
	-- general
	"handy",
	"hide_options_button",
	"info_popups_level",
	"keybinds_trigger_mode",
	"device_select",

	-- hand
	"insta_highlight",
	"insta_unhighlight",
	"insta_highlight_entire_f_hand",
	"deselect_hand",

	-- regular
	"regular_keybinds",
	-- hand
	"regular_keybinds_play_hand",
	"regular_keybinds_discard",
	"regular_keybinds_sort_by_rank",
	"regular_keybinds_sort_by_suit",
	"regular_keybinds_toggle_sort",
	-- menus
	"regular_keybinds_run_info_hands",
	"regular_keybinds_run_info_blinds",
	"regular_keybinds_view_deck",
	"show_deck_preview",
	-- round
	"insta_cash_out",
	"not_just_yet_interaction",
	-- shop
	"insta_booster_skip",
	"regular_keybinds_reroll_shop",
	"regular_keybinds_leave_shop",
	"regular_keybinds_reroll_boss",
	-- blinds
	"regular_keybinds_skip_blind",
	"regular_keybinds_select_blind",

	-- quick actions
	"buy_sell_use_mode",
	"insta_buy_or_sell",
	"insta_buy_n_sell",
	"insta_use",
	"cryptid_code_use_last_interaction",

	-- speed multiplier
	"speed_multiplier",
	"speed_multiplier_multiply",
	"speed_multiplier_divide",
	"speed_multiplier_no_hold",

	-- animation skip
	"animation_skip",
	"animation_skip_increase",
	"animation_skip_decrease",
	"animation_skip_no_hold",

	-- nopeus
	"nopeus_interaction",
	"nopeus_interaction_increase",
	"nopeus_interaction_decrease",
	"nopeus_interaction_no_hold",

	-- scoring hold
	"scoring_hold",
	"scoring_hold_any_moment",

	-- controller
	"controller_swap_cursor_stick",
	"controller_sensivity",

	-- presets
	"presets_load_1",
	"presets_load_2",
	"presets_load_3",
	"presets_load_next",

	-- move highlight
	"move_highlight",
	"move_highlight_one_left",
	"move_highlight_one_right",
	"move_highlight_move_card",
	"move_highlight_to_end",

	--dangerous
	"dangerous_actions",
	"dangerous_speed_multiplier_uncap",
	"dangerous_nopeus_unsafe",
	"dangerous_animation_skip_unsafe",
	"immediate_buy_and_sell",
	"immediate_buy_and_sell_queue",
	"sell_all_same_modifier",
	"sell_all_modifier",
	"remove_modifier",

	--misc
	"misc_open_mod_settings",
	"misc_save_run",
	"misc_quick_restart",
	"misc_start_fantoms_preview",
	"misc_crash",

	--other
	"debugplus_prevent",
}

for k, v in pairs(dictionary) do
	v.order = 1
	v.order_not_set = true
	if not v.keywords then
		v.keywords = {}
	end
	-- local cleaned_string = string.gsub(k, "_", " ")
	-- table.insert(v.keywords, cleaned_string)
	v.keywords_list = Handy.utils.string_words_split(Handy.utils.table_concat_string(v.keywords))
end

for index, key in ipairs(dictionary_order) do
	dictionary[key].order = index
	dictionary[key].order_not_set = nil
end

for k, v in pairs(dictionary) do
	if v.order_not_set then
		print("Order not set for config dictionary: " .. k)
	end
end

-- Config dictionary
Handy.UI.CD = dictionary

function Handy.UI.cache_config_dictionary_search(only_update)
	for k, v in pairs(dictionary) do
		local temp_keywords = {}

		local function insert_keywords(t)
			for _, word in ipairs(t or {}) do
				temp_keywords[string.lower(word)] = true
			end
		end
		if not only_update then
			insert_keywords(v.keywords_list or {})
		end

		if v.loc_key then
			local result_keys = Handy.utils.as_array(v.loc_key)
			for _, loc_key in ipairs(result_keys) do
				for _, loc_key_platform in ipairs({ loc_key, loc_key .. "_gamepad", loc_key .. "_desktop" }) do
					pcall(function()
						local checkbox_object = G.localization.descriptions.Handy_ConfigCheckbox[loc_key_platform] or {}
						insert_keywords(Handy.utils.split_loc_table_into_words(checkbox_object.unlock or {}))
						insert_keywords(Handy.utils.split_loc_table_into_words(checkbox_object.text or {}))
					end)
					-- pcall(function()
					-- 	local popup_object = G.localization.descriptions.Handy_ConfigPopup[loc_key_platform] or {}
					-- 	insert_keywords(Handy.utils.split_loc_table_into_words(popup_object.text or {}))
					-- end)
				end
				pcall(function()
					local loc_label_line = G.localization.misc.handy_keybind_labels[loc_key] or ""
					insert_keywords(Handy.utils.string_words_split(loc_label_line))
				end)
			end
		end

		v.result_keywords = only_update and v.result_keywords or ""
		for tk, _ in pairs(temp_keywords) do
			v.result_keywords = v.result_keywords .. " " .. tk
		end
	end
end

function Handy.UI.is_config_dictionary_item_contain_words(dictionary_item, words)
	if not dictionary_item then
		return false
	end
	local keywords = dictionary_item.result_keywords
	for _, word in ipairs(words) do
		if string.find(keywords, word, 1, true) == nil then
			return false
		end
	end
	return true
end
function Handy.UI.is_config_dictionary_key_contain_words(dictionary_key, words)
	return Handy.UI.is_config_dictionary_item_contain_words(Handy.UI.CD[dictionary_key or ""], words)
end

function Handy.UI.search(input)
	local matches = {}
	local input_words = Handy.utils.string_words_split(string.lower(input))
	if #input_words == 0 then
		return matches
	end
	for dictionary_key, dictionary_item in pairs(Handy.UI.CD) do
		if Handy.UI.is_config_dictionary_item_contain_words(dictionary_item, input_words) then
			table.insert(matches, dictionary_key)
		end
	end
	return matches
end
