return {
	descriptions = {
		Handy_ConfigCheckbox = {
			handy = {
				unlock = { "HandyBalatro v#2#", "by {C:white,E:2,s:1.15}#3#{}" },
				text = {
					"Uncheck to disable {C:attention}ALL{} mod features",
					"{C:handy_secondary}(no restart required){}",
				},
			},
			regular_keybinds = {
				unlock = { "Regular keybinds" },
				text = {
					"Use keybinds for",
					"common game actions",
				},
			},
			insta_highlight = {
				unlock = {
					"{C:edition}Fast hand selection{}",
					"{C:handy_secondary,s:0.75}(drag, hover, swipe, slide){}",
				},
				text = {
					"Hold {C:chips}#1#{} and",
					"hover cards in hand to select them",
				},
			},
			insta_unhighlight = {
				unlock = {
					"Fast hand",
					"deselection",
				},
				text = {
					"Allow {C:edition}[Fast hand selection]{}",
					"to deselect cards aswell",
				},
			},
			insta_highlight_OUTSIDE = {
				unlock = {
					"{C:edition}Fast hand selection{}",
					"{C:handy_secondary,s:0.75}(drag, hover, swipe, slide){}",
				},
				text = {
					"Start hold {C:chips}#1#{} {C:attention}OUTSIDE{} of cards,",
					"and then hover them in hand to select",
				},
			},
			show_deck_preview = {
				unlock = { "Deck preview" },
				text = {
					"Hold {C:chips}#1#{} to",
					"show deck preview",
				},
			},
			deselect_hand = {
				unlock = { "Deselect hand" },
				text = {
					"Press {C:chips}#1#{} to",
					"deselect cards in hand",
				},
			},
			insta_cash_out = {
				unlock = { "Quick cash out" },
				text = {
					"Press/hold {C:chips}#1#{} to",
					"speed up Cash Out stage",
				},
			},
			insta_booster_skip = {
				unlock = { "Quick skip", "booster pack" },
				text = {
					"Press/hold {C:chips}#1#{} to",
					"skip booster pack",
				},
			},
			move_highlight = {
				unlock = { "Move highlight" },
				text = {
					"Press {C:chips}#2#{} or {C:chips}#3#{}",
					"to move highlight in card area.",
					"Hold {C:chips}#4#{} to move card instead.",
					"Hold {C:chips}#5#{} to move to first/last card",
				},
			},
			insta_buy_or_sell = {
				unlock = { "Quick buy/sell" },
				text = {
					"Use {C:chips}#1#{} to",
					"buy or sell card",
				},
			},
			insta_buy_n_sell = {
				unlock = { "Quick buy'n'sell" },
				text = {
					"Use {C:chips}#1#{} to",
					"buy card and sell",
					"immediately after",
				},
			},
			insta_use = {
				unlock = { "Quick use" },
				text = {
					"Use {C:chips}#1#{} to",
					"use card if possible",
					"{C:handy_secondary}(overrides Quick Buy/Sell){}",
				},
			},
			cryptid_code_use_last_interaction = {
				unlock = { "Cryptid: use", "previous input" },
				text = {
					"Use {C:chips}#1#{} to",
					"use Code card if possible with",
					"previously inputted value",
				},
			},
			not_just_yet_interaction = {
				unlock = { "NotJustYet:", "end round" },
				text = {
					"Press {C:chips}#1#{} to",
					"end round",
				},
			},
			speed_multiplier = {
				unlock = { "Speed multiplier" },
				text = {
					"Hold {C:chips}#1#{} and",
					"{C:chips}#2#{} to multiply or",
					"{C:chips}#3#{} to divide game speed",
				},
			},
			insta_highlight_entire_f_hand = {
				unlock = { "Highlight", "entire hand" },
				text = {
					"Press {C:chips}#1#{} to",
					"highlight entire hand",
				},
			},
			nopeus_interaction = {
				unlock = { "Nopeus:", "fast-forward" },
				text = {
					"Hold {C:chips}#1#{} and",
					"{C:chips}#2#{} to increase or",
					"{C:chips}#3#{} to decrease",
					"fast-forward setting",
				},
			},
			dangerous_actions = {
				unlock = { "Dangerous actions" },
				text = {
					"Enable unsafe controls. They're",
					"designed to be speed-first, which",
					"{C:mult}can cause bugs or crashes!{}",
				},
			},
			immediate_buy_and_sell = {
				unlock = { "Instant sell" },
				text = {
					"Hold {C:mult}#1#{},",
					"hold {C:chips}#2#{},",
					"and hover card to sell it",
				},
			},
			immediate_buy_and_sell_queue = {
				unlock = { "Sell queue" },
				text = {
					"Start selling cards only when",
					"keybind was released",
				},
			},
			nopeus_unsafe = {
				unlock = { "Nopeus: unsafe", "fast-forward" },
				text = {
					"Allow increase fast-forward",
					"setting to {C:mult}Unsafe{}",
				},
			},
			sell_all_same = {
				unlock = { "Sell all", "card copies" },
				text = {
					"Hold {C:mult}#2#{}, hold {C:mult}#1#{},",
					"and click on card to sell",
					"all of their copies",
				},
			},
			sell_all = {
				unlock = { "Sell ALL" },
				text = {
					"Hold {C:mult}#1#{} to sell {C:attention}ALL{}",
					"cards in area instead",
				},
			},
			card_remove = {
				unlock = { "REMOVE* cards", "or skip tags" },
				text = {
					"Hold {C:mult}#1#{} to {C:attention,E:1}REMOVE{} cards",
					"{C:handy_secondary}(works for skip tags){}",
				},
			},
		},
		Handy_ConfigPopup = {
			regular_keybinds = {
				text = {
					"Play hand, Discard, hand sorting,",
					"Reroll shop, Leave shop, Select blind,",
					"Skip blind, Select blind, View deck, Run info",
				},
			},
			insta_highlight = {
				text = {
					"If key set to {C:chips}[Left Mouse]{},",
					"start holding key {C:attention}OUTSIDE{} of cards",
					"and then hover them to highlight",
				},
			},
			insta_unhighlight = {
				text = {
					"Select cards if first card was not selected.",
					"Deselect cards if first card was selected.",
				},
			},
			insta_highlight_gamepad = {
				text = {
					"Works both for cursor and movement",
					"via direction buttons",
				},
			},
			deselect_hand_desktop = {
				text = {
					"Replaces vanilla {C:chips}[Right Mouse]{}",
					"but works the same and",
					"can be reassigned to other key",
					" ",
					"Uncheck to use vanilla control",
				},
			},
			insta_cash_out = {
				text = {
					"Holding a keybind will trigger it",
					"as soon as it will be available",
				},
			},
			insta_booster_skip = {
				text = {
					"Holding a keybind will trigger it",
					"as soon as it will be available",
				},
			},
			move_highlight = {
				text = {
					"Select card in area and",
					"then use listed controls",
				},
			},
			speed_multiplier = {
				text = {
					"Game speed can be changed in",
					"range from {C:attention}x1/512{} to {C:attention}x512{}",
				},
			},
			nopeus_interaction = {
				text = {
					"Required mod {C:attention}Nopeus{} to work",
					" ",
					"{C:mult}Unsafe{} option must be",
					"enabled in {C:attention}Danger Zone{} tab",
				},
			},
			not_just_yet_interaction = {
				text = {
					"Required mod {C:attention}NotJustYet{} to work",
				},
			},
			insta_buy_or_sell_desktop = {
				text = {
					"Usage determined by {C:attention}Buy/Sell/Use mode{}",
				},
			},
			insta_buy_n_sell_desktop = {
				text = {
					"Usage determined by {C:attention}Buy/Sell/Use mode{}",
				},
			},
			insta_use_desktop = {
				text = {
					"Usage determined by {C:attention}Buy/Sell/Use mode{}",
				},
			},
			cryptid_code_use_last_interaction = {
				text = {
					"Required mod {C:attention}Cryptid{} to work",
					" ",
					"Shortcut for using a code card and selecting",
					"{C:green}[Input previous value]{} option for:",
					"{C:spectral}://POINTER{}, {C:green}://VARIABLE{}, {C:green}://CLASS{}, {C:green}://EXPLOIT{}",
					" ",
					"Usage determined by {C:attention}Buy/Sell/Use mode{}",
				},
			},
			cryptid_code_use_last_interaction_gamepad = {
				text = {
					"Required mod {C:attention}Cryptid{} to work",
					" ",
					"Shortcut for using a code card and selecting",
					"{C:green}[Input previous value]{} option for:",
					"{C:spectral}://POINTER{}, {C:green}://VARIABLE{}, {C:green}://CLASS{}, {C:green}://EXPLOIT{}",
				},
			},
			insta_highlight_entire_f_hand = {
				text = {
					"Select max possible amount of cards",
					"in hand, from left to right",
				},
			},
			immediate_buy_and_sell = {
				text = {
					'Hold {C:mult}["Dangerous" modifier]{}, {C:chips}[Quick buy/sell]{},',
					"and hover cards to sell them immediately",
				},
			},
			immediate_buy_and_sell_queue = {
				text = {
					"Instead of selling immediately, {C:mult}[Instant sell]{}",
					"will put all hovered cards in a list and",
					"all of them will be sold after keybind release",
					" ",
					"Allow more precise cards selection, but slower",
				},
			},
			immediate_buy_and_sell_queue_gamepad = {
				text = {
					"Instead of selling immediately, {C:mult}[Instant sell]{}",
					"will put all hovered cards in a list and",
					"all of them will be sold after keybind release",
					" ",
					"Allow more precise cards selection, but slower",
					" ",
					"{C:attention}Always active for gamepad{}",
				},
			},
			nopeus_unsafe = {
				text = {
					"Required mod {C:attention}Nopeus{} to work",
					" ",
					"Even if this unchecked, {C:mult}Unsafe{} option",
					"can be set normally via game settings",
				},
			},
			sell_all_same = {
				text = {
					'Hold {C:mult}["Dangerous" modifier]{}, {C:mult}["All copies" modifier]{},',
					"and click on card to sell all of their copies",
				},
			},
			sell_all = {
				text = {
					'Hold {C:mult}["Dangerous" modifier]{}, {C:mult}["ALL" modifier]{},',
					"and click on card to sell {C:attention}ALL{} cards in area",
				},
			},
			card_remove = {
				text = {
					"When hold, instead of selling cards {C:attention}or skip tags{} will be {C:attention,E:1}REMOVED{}",
					" ",
					'Hold {C:mult}["Dangerous" modifier]{}, {C:mult}["REMOVE" modifier]{}, {C:chips}[Quick buy/sell]{}',
					"and hover cards to {C:attention,E:1}REMOVE{} them (queue also applied)",
					" ",
					'Hold {C:mult}["Dangerous" modifier]{}, {C:mult}["REMOVE" modifier]{}, {C:mult}["All copies" modifier]{}',
					"and click on card {C:attention}or skip tag{} to {C:attention,E:1}REMOVE{} all of their copies",
					" ",
					'Hold {C:mult}["Dangerous" modifier]{}, {C:mult}["REMOVE" modifier]{}, {C:mult}["ALL" modifier]{},',
					"and click on card {C:attention}or skip tag{} to {C:attention,E:1}REMOVE{} {C:attention}ALL{} of them",
				},
			},
		},
	},
	misc = {
		handy_keybinds = {
			["Left"] = "Left",
			["(A)"] = "(A)",
		},
		handy_keybind_labels = {
			play_hand = "Play hand",
			discard = "Discard",
			sort_by_rank = "Sort by rank",
			sort_by_suit = "Sort by suit",
			deselect_hand = "Deselect hand",
			cash_out = "Cash out",
			not_just_yet_end_round = "NotJustYet: end round",
			skip_booster = "Skip booster pack",
			reroll_shop = "Shop reroll",
			leave_shop = "Leave shop",
			skip_blind = "Skip blind",
			select_blind = "Select blind",
			run_info_hands = "Run info: poker hands",
			run_info_blinds = "Run info: blinds",
			view_deck = "View deck",
			deck_preview = "Deck preview",
			quick_highlight = "Fast hand selection",
			quick_buy_or_sell = "Quick buy/sell",
			quick_buy_n_sell = "Quick buy'n'sell",
			quick_use = "Quick use",
			highlight_entire_f_hand = "Highlight entire hand",
			cryptid_code_use_last_interaction = "Cryptid: use previous input",
			speed_multiplier = "Speed multiplier",
			speed_multiplier_multiply = "Multiply",
			speed_multiplier_divide = "Divide",
			nopeus_interaction = "Nopeus: fast-forward",
			nopeus_interaction_increase = "Increase",
			nopeus_interaction_decrease = "Decrease",
			move_highlight_one_left = "Move one left",
			move_highlight_one_right = "Move one right",
			move_highlight_move_card = "Move card",
			move_highlight_to_end = "Move to end",

			dangerous_modifier = '"Dangerous" modifier',
			dangerous_all_same_modifier = '"All copies" modifier',
			dangerous_all_modifier = '"ALL" modifier',
			dangerous_remove_modifier = '"REMOVE" modifier',
		},
		handy_keybind_sections = {
			round = "Round",
			shop = "Shop",
			blinds = "Blinds",
			menus = "Menus",
			quick_actions = "Quick actions",
			gamespeed = "Game speed",
			animations = "Animations",
			highlight_movement = "Highlight movement",
			shop_and_blinds = "Shop and Blinds",
			gamespeed_and_animations = "Game speed and animations",
		},
		handy_tabs = {
			["Overall"] = "General & Vanilla",
			["Quick"] = "Quick actions",
			["Keybinds"] = "Regular keybinds",
			["Keybinds 2"] = "Other keybinds",
			["Dangerous"] = "Danger zone",
		},
		v_dictionary = {
			Handy_module_keys_single = "[#1#]",
			Handy_module_keys_or = "[#1#] or [#2#]",
			Handy_items_in_queue = "[#1# in queue]",
			Handy_gamespeed_multiplier = "Game speed multiplier: #1#",
			Handy_nopeus_fastforward = "Nopeus fast-forward: #1#",
		},
		dictionary = {
			handy_or = "or",

			b_handy_hide_mod_button_1 = "Hide mod button",
			b_handy_hide_mod_button_2 = "in options menu",

			b_handy_notif_quick = "Quick actions",
			b_handy_notif_dangerous = "Dangerous actions",

			ph_handy_any_button_hint = 'Each control can be assigned to mouse button, mouse wheel or keyboard key in "Keybinds" tabs.',
			ph_handy_any_gamepad_hint = 'Each control can be assigned to any gamepad buttons in "Keybinds" tabs.',
			ph_handy_remove_hint = "*REMOVE card/tag - delete without any checks, effects, triggers or money refunds.",
			ph_handy_keybinds_guide_desktop = "Click on a button and next inputted key will be assigned. [Escape] to unbind.",
			ph_handy_keybinds_guide_gamepad = "Click on a button and next inputted key will be assigned. [(Back)] to unbind.",

			ph_handy_notif_quick_use = "Quick use",
			ph_handy_notif_quick_buy_or_sell = "Quick buy or sell",
			ph_handy_notif_quick_buy_n_sell = "Quick buy and immediately sell",
			ph_handy_notif_unsafe_disabled = "Unsafe actions disabled in mod settings",
			ph_handy_notif_unsafe_disabled_by_other_mod = "Unsafe actions disabled by other mod",
			ph_handy_notif_unsafe = "[Unsafe] Bugs can appear!",
			ph_handy_notif_insta_remove = "Instant REMOVE",
			ph_handy_notif_insta_sell = "Instant sell",
			ph_handy_notif_remove_all = "REMOVE ALL cards/tags in clicked area",
			ph_handy_notif_sell_all = "Sell ALL cards in clicked area",
			ph_handy_notif_remove_all_same = "REMOVE all copies of clicked card/tag",
			ph_handy_notif_sell_all_same = "Sell all copies of clicked card",
			ph_handy_notif_nopeus_unsafe_disabled = "Unsafe option disabled in mod settings",

			b_handy_info_popups_level_select = "Info popups level",
			handy_info_popups_level_opt = {
				[1] = "None",
				[2] = "Dangerous only",
				[3] = "Features-related",
				[4] = "All",
			},
			b_handy_keybinds_trigger_mode_select = "Keybinds trigger mode",
			handy_keybinds_trigger_mode_opt = {
				[1] = "On key press",
				[2] = "On key release",
			},
			b_handy_buy_sell_use_mode_select = "Buy/Sell/Use mode",
			handy_buy_sell_use_mode_opt = {
				[1] = "Hold key + Click card",
				[2] = "Hover card + Press key",
			},
		},
	},
}
