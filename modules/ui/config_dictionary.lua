local dictionary = {
	hide_options_button = {
		keywords = {
			"hide",
			"menu",
			"options",
			"button",
			"config",
			"remove",
		},
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.hide_options_button, "hide_options_button")
		end,
		keybind = function() end,
	},

	insta_highlight = {
		keywords = { "hand", "selection", "swipe", "drag", "highlight", "quick", "mobile-like", "hover", "cards" },
		checkbox = function()
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
				}
			)
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.insta_highlight,
				"quick_highlight",
				{ only_holdable = true }
			)
		end,
	},
	insta_unhighlight = {
		keywords = { "hand", "deselection", "swipe", "drag", "unhighlight", "quick", "mobile-like", "hover", "cards" },
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.insta_highlight.allow_deselect,
				"insta_unhighlight",
				{ Handy.UI.PARTS.localize_keybind_label("quick_highlight") }
			)
		end,
		keybind = function() end,
	},
	insta_highlight_entire_f_hand = {
		keywords = { "hand", "selection", "highlight", "quick", "entire", "full", "cards" },
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.insta_highlight_entire_f_hand,
				"insta_highlight_entire_f_hand"
			)
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.insta_highlight_entire_f_hand,
				"highlight_entire_f_hand"
			)
		end,
	},
	deselect_hand = {
		keywords = { "hand", "deselection", "unhighlight", "quick", "entire", "full", "cards" },
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.deselect_hand, "deselect_hand", {
				Handy.UI.PARTS.localize_keybind("Right Mouse", true),
			})
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.deselect_hand, "deselect_hand")
		end,
	},

	regular_keybinds = {
		keywords = {
			"play",
			"hand",
			"discard",
			"shop",
			"leave",
			"sorting",
			"rank",
			"suit",
			"sort by",
			"reroll",
			"select",
			"view",
			"deck",
			"run",
			"info",
			"screen",
			"menus",
			"run info",
			"pokerhands",
			"round",
		},
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.regular_keybinds, "regular_keybinds")
		end,
		keybind = function() end,
	},
	regular_keybinds_play_hand = {
		keywords = {
			"round",
			"play",
			"hand",
		},
		checkbox = function()
			return Handy.UI.CD.regular_keybinds.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.play, "play_hand")
		end,
	},
	regular_keybinds_discard = {
		keywords = {
			"round",
			"discard",
			"hand",
		},
		checkbox = function()
			return Handy.UI.CD.regular_keybinds.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.discard, "discard")
		end,
	},
	regular_keybinds_sort_by_rank = {
		keywords = {
			"round",
			"hand",
			"sorting",
			"sort by",
			"rank",
		},
		checkbox = function()
			return Handy.UI.CD.regular_keybinds.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.sort_by_rank, "sort_by_rank")
		end,
	},
	regular_keybinds_sort_by_suit = {
		keywords = {
			"round",
			"hand",
			"sorting",
			"sort by",
			"suit",
		},
		checkbox = function()
			return Handy.UI.CD.regular_keybinds.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.sort_by_suit, "sort_by_suit")
		end,
	},
	regular_keybinds_toggle_sort = {
		keywords = {
			"round",
			"hand",
			"sorting",
			"sort by",
			"suit",
			"rank",
			"toggle",
			"switch",
		},
		checkbox = function()
			return Handy.UI.CD.regular_keybinds.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.toggle_sort, "toggle_sort")
		end,
	},
	regular_keybinds_run_info_hands = {
		keywords = {
			"round",
			"menus",
			"run info",
			"pokerhands",
		},
		checkbox = function()
			return Handy.UI.CD.regular_keybinds.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.run_info, "run_info_hands")
		end,
	},
	regular_keybinds_run_info_blinds = {
		keywords = {
			"round",
			"menus",
			"run info",
			"blinds",
			"bosses",
			"ante",
		},
		checkbox = function()
			return Handy.UI.CD.regular_keybinds.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.run_info_blinds, "run_info_blinds")
		end,
	},
	regular_keybinds_view_deck = {
		keywords = {
			"round",
			"menus",
			"view",
			"deck",
		},
		checkbox = function()
			return Handy.UI.CD.regular_keybinds.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.view_deck, "view_deck")
		end,
	},
	regular_keybinds_reroll_shop = {
		keywords = {
			"shop",
			"reroll shop",
			"shop reroll",
			"one more",
			"restock",
		},
		checkbox = function()
			return Handy.UI.CD.regular_keybinds.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.reroll_shop, "reroll_shop")
		end,
	},
	regular_keybinds_skip_blind = {
		keywords = {
			"round",
			"skip blind",
			"blind skip",
		},
		checkbox = function()
			return Handy.UI.CD.regular_keybinds.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.skip_blind, "skip_blind")
		end,
	},
	regular_keybinds_select_blind = {
		keywords = {
			"round",
			"select blind",
			"blind select",
			"new round",
		},
		checkbox = function()
			return Handy.UI.CD.regular_keybinds.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.select_blind, "select_blind")
		end,
	},
	regular_keybinds_leave_shop = {
		keywords = {
			"shop",
			"leave shop",
			"shop leave",
			"go next",
		},
		checkbox = function()
			return Handy.UI.CD.regular_keybinds.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.leave_shop, "leave_shop")
		end,
	},

	show_deck_preview = {
		keywords = {
			"round",
			"menus",
			"view",
			"deck",
			"preview",
			"show",
		},
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.show_deck_preview, "show_deck_preview")
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.show_deck_preview,
				"deck_preview",
				{ only_holdable = true }
			)
		end,
	},
	insta_cash_out = {
		keywords = { "round", "cash out", "cashout", "get me out" },
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.insta_cash_out, "insta_cash_out")
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_cash_out, "cash_out", { only_holdable = true })
		end,
	},
	insta_booster_skip = {
		keywords = { "boosterpack", "booster pack", "skip" },
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.insta_booster_skip, "insta_booster_skip")
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.insta_booster_skip,
				"skip_booster",
				{ only_holdable = true }
			)
		end,
	},
	not_just_yet_interaction = {
		keywords = { "round", "end", "not just yet", "notjustyet" },
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.not_just_yet_interaction,
				"not_just_yet_interaction"
			)
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.not_just_yet_interaction,
				"not_just_yet_end_round",
				{ only_holdable = true }
			)
		end,
	},

	move_highlight = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.move_highlight, "move_highlight", {
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.dx.one_left, true),
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.dx.one_right, true),
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.swap, true),
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.to_end, true),
			}, { full_width = true })
		end,
		keybind = function() end,
	},
	move_highlight_one_left = {
		checkbox = function()
			return Handy.UI.CD.move_highlight.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.move_highlight.dx.one_left,
				"move_highlight_one_left",
				{ disabled = Handy.controller.is_gamepad() }
			)
		end,
	},
	move_highlight_one_right = {
		checkbox = function()
			return Handy.UI.CD.move_highlight.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.move_highlight.dx.one_right,
				"move_highlight_one_right",
				{ disabled = Handy.controller.is_gamepad() }
			)
		end,
	},
	move_highlight_move_card = {
		checkbox = function()
			return Handy.UI.CD.move_highlight.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.move_highlight.swap,
				"move_highlight_move_card",
				{ disabled = Handy.controller.is_gamepad(), only_holdable = true }
			)
		end,
	},
	move_highlight_to_end = {
		checkbox = function()
			return Handy.UI.CD.move_highlight.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.move_highlight.to_end,
				"move_highlight_to_end",
				{ disabled = Handy.controller.is_gamepad(), only_holdable = true }
			)
		end,
	},

	insta_buy_or_sell = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.insta_buy_or_sell, "insta_buy_or_sell", {
				localize("b_handy_buy_sell_use_mode_select"),
			})
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_buy_or_sell, "quick_buy_or_sell")
		end,
	},
	insta_buy_n_sell = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.insta_buy_n_sell, "insta_buy_n_sell", {
				localize("b_handy_buy_sell_use_mode_select"),
			})
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_buy_n_sell, "quick_buy_n_sell")
		end,
	},
	insta_use = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.insta_use, "insta_use", {
				localize("b_handy_buy_sell_use_mode_select"),
			})
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_use, "quick_use")
		end,
	},
	cryptid_code_use_last_interaction = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.cryptid_code_use_last_interaction,
				"cryptid_code_use_last_interaction",
				{
					localize("b_handy_buy_sell_use_mode_select"),
				}
			)
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.cryptid_code_use_last_interaction,
				"cryptid_code_use_last_interaction"
			)
		end,
	},

	speed_multiplier = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.speed_multiplier, "speed_multiplier", {
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.speed_multiplier.multiply, true),
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.speed_multiplier.divide, true),
				"x1/512",
				"x512",
			})
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.speed_multiplier,
				"speed_multiplier",
				{ only_holdable = true }
			)
		end,
	},
	speed_multiplier_multiply = {
		checkbox = function()
			return Handy.UI.CD.speed_multiplier.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.speed_multiplier.multiply, "speed_multiplier_multiply")
		end,
	},
	speed_multiplier_divide = {
		checkbox = function()
			return Handy.UI.CD.speed_multiplier.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.speed_multiplier.divide, "speed_multiplier_divide")
		end,
	},
	speed_multiplier_no_hold = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.speed_multiplier.no_hold,
				"speed_multiplier_no_hold",
				{
					Handy.UI.PARTS.localize_keybind_label("speed_multiplier"),
				}
			)
		end,
		keybind = function()
			return Handy.UI.CD.speed_multiplier.keybind()
		end,
	},

	animation_skip = {
		checkbox = function()
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
			})
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.animation_skip,
				"animation_skip",
				{ only_holdable = true }
			)
		end,
	},
	animation_skip_increase = {
		checkbox = function()
			return Handy.UI.CD.animation_skip.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.animation_skip.increase, "animation_skip_increase")
		end,
	},
	animation_skip_decrease = {
		checkbox = function()
			return Handy.UI.CD.animation_skip.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.animation_skip.decrease, "animation_skip_decrease")
		end,
	},
	animation_skip_no_hold = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.animation_skip.no_hold,
				"animation_skip_no_hold",
				{
					Handy.UI.PARTS.localize_keybind_label("animation_skip"),
				}
			)
		end,
		keybind = function()
			return Handy.UI.CD.animation_skip.keybind()
		end,
	},

	nopeus_interaction = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.nopeus_interaction, "nopeus_interaction", {
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.nopeus_interaction.increase, true),
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.nopeus_interaction.decrease, true),
				localize("Dangerous", "handy_tabs"),
			})
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.nopeus_interaction,
				"nopeus_interaction",
				{ only_holdable = true }
			)
		end,
	},
	nopeus_interaction_increase = {
		checkbox = function()
			return Handy.UI.CD.nopeus_interaction.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.nopeus_interaction.increase,
				"nopeus_interaction_increase"
			)
		end,
	},
	nopeus_interaction_decrease = {
		checkbox = function()
			return Handy.UI.CD.nopeus_interaction.checkbox()
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.nopeus_interaction.decrease,
				"nopeus_interaction_decrease"
			)
		end,
	},
	nopeus_interaction_no_hold = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.nopeus_interaction.no_hold,
				"nopeus_interaction_no_hold",
				{
					Handy.UI.PARTS.localize_keybind_label("nopeus_interaction"),
				}
			)
		end,
		keybind = function()
			return Handy.UI.CD.nopeus_interaction.keybind()
		end,
	},

	scoring_hold = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.scoring_hold, "scoring_hold")
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.scoring_hold, "scoring_hold", { only_holdable = true })
		end,
	},
	scoring_hold_any_moment = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.scoring_hold.any_moment,
				"scoring_hold_any_moment",
				{
					Handy.UI.PARTS.localize_keybind_label("scoring_hold"),
				}
			)
		end,
		keybind = function()
			return Handy.UI.CD.scoring_hold.keybind()
		end,
	},

	presets_load_1 = {
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_1, "presets_load_1")
		end,
	},
	presets_load_2 = {
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_2, "presets_load_2")
		end,
	},
	presets_load_3 = {
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_3, "presets_load_3")
		end,
	},
	presets_load_next = {
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_next, "presets_load_next")
		end,
	},

	dangerous_modifier = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.dangerous_actions,
				"dangerous_actions",
				nil,
				{ full_width = true }
			)
		end,
	},
	dangerous_nopeus_unsafe = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.dangerous_actions.nopeus_unsafe, "nopeus_unsafe")
		end,
	},
	dangerous_animation_skip_unsafe = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.dangerous_actions.animation_skip_unsafe,
				"animation_skip_unsafe",
				{
					localize("handy_animation_skip_levels")[5],
				}
			)
		end,
	},
	immediate_buy_and_sell = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.dangerous_actions.immediate_buy_and_sell,
				"immediate_buy_and_sell",
				{
					Handy.UI.PARTS.format_new_module_keys(Handy.cc.insta_buy_or_sell, true),
					Handy.UI.PARTS.localize_keybind_label("dangerous_modifier"),
					Handy.UI.PARTS.localize_keybind_label("quick_buy_or_sell"),
				}
			)
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.dangerous_actions.immediate_buy_and_sell,
				"dangerous_modifier",
				{ dangerous = true, only_holdable = true }
			)
		end,
	},
	immediate_buy_and_sell_queue = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(
				Handy.cc.dangerous_actions.immediate_buy_and_sell.queue,
				"immediate_buy_and_sell_queue"
			)
		end,
	},
	sell_all_same_modifier = {
		checkbox = function()
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
				}
			)
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.dangerous_actions.sell_all_same,
				"dangerous_all_same_modifier",
				{ dangerous = true, only_holdable = true }
			)
		end,
	},
	sell_all_modifier = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.dangerous_actions.sell_all, "sell_all", {
				Handy.UI.PARTS.localize_keybind_label("dangerous_modifier"),
				Handy.UI.PARTS.localize_keybind_label("dangerous_all_modifier"),
			}, {
				only_first = true,
			})
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.dangerous_actions.sell_all,
				"dangerous_all_modifier",
				{ dangerous = true, only_holdable = true }
			)
		end,
	},
	remove_modifier = {
		checkbox = function()
			return Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.dangerous_actions.card_remove, "card_remove", {
				Handy.UI.PARTS.localize_keybind_label("dangerous_modifier"),
				Handy.UI.PARTS.localize_keybind_label("dangerous_remove_modifier"),
				Handy.UI.PARTS.localize_keybind_label("quick_buy_or_sell"),
				Handy.UI.PARTS.localize_keybind_label("dangerous_all_same_modifier"),
				Handy.UI.PARTS.localize_keybind_label("dangerous_all_modifier"),
			}, {
				only_first = true,
			})
		end,
		keybind = function()
			return Handy.UI.PARTS.create_module_keybind(
				Handy.cc.dangerous_actions.card_remove,
				"dangerous_remove_modifier",
				{ dangerous = true, only_holdable = true }
			)
		end,
	},
}

-- Config dictionary
Handy.UI.CD = dictionary
