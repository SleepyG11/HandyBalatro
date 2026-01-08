return {
	descriptions = {
		Handy_ConfigDictionary = {
			general = {
				name = "Handy v#1# by #2#",
				text = {},
			},

			handy = {
				name = "Global mod toggle",
				text = {
					"Uncheck to disable ALL mod features",
				},
				unlock = {
					"Any controls can be enabled/disabled",
					"in {C:attention}any moment{} without",
					"game restart or reloading a run",
				},
			},

			keybinds_trigger_mode = {
				name = "Keybinds trigger mode",
				text = {},
				unlock = {
					"Applied to most controls",
				},
			},
			current_device = {
				name = "Current input device",
				text = {},
				unlock = {
					"Mod uses separate layout of keybinds",
					"for {C:attention}Mouse + Keyboard{} and {C:attention}Gamepad{}",
					"and switches between them depending",
					"on what device you're currently using",
					'{C:inactive}(if "#1#" mod is selected){}',
				},
			},
			prevent_if_debugplus = {
				name = "DebugPlus: prevent intersections",
				text = {},
				unlock = {
					"Do not execute any controls when {C:chips}#1#{}",
					"is hold to prevent intersecting with",
					"DebugPlus controls",
					" ",
					'Require {C:attention}"CTRL for Keybinds"{} to be',
					"enabled in DebugPlus's settings",
					" ",
					"{C:attention}As side effect{}, makes keybinds",
					"with {C:chips}#1#{} button {C:mult}unusable{}",
				},
			},

			gamepad = {
				name = "Gamepad settings",
				text = {},
			},
			swap_controller_cursor_stick = {
				name = "Swap sticks",
				text = {},
			},
			controller_sensitivity = {
				name = "Cursor sensitivity",
				text = {},
			},

			appearance = {
				name = "Appearance",
				text = {},
			},
			hide_options_button = {
				name = "Hide mod button in options",
				text = {},
				unlock = {
					"Only when {C:attention}Steamodded{} present",
				},
			},
			notifications_level = {
				name = "Notifications level",
				text = {},
			},
			speed_multiplier_settings_toggle = {
				name = "Speed multiplier: toggle in settings",
				text = {},
			},
			animation_skip_settings_toggle = {
				name = "Animation skip: toggle in settings",
				text = {},
			},

			hand_selection = {
				name = "Hand selection & Deselection",
				text = {},
			},
			hand_selection_insta_highlight = {
				name = { "Fast hand selection" },
				text = {
					"Drag, hover, swipe, slide to select",
				},
				unlock = {
					"When assigned to {C:chips}[Left Mouse]{},",
					"start holding {C:attention}OUSIDE{} of card",
					"and then hover them to select",
					"{C:inactive}(because otherwise you'll grab a card){}",
				},
			},
			hand_selection_insta_highlight_allow_deselect = {
				name = { "Fast hand deselection" },
				text = {},
				unlock = {
					"{C:attention}Select{} cards if first card {C:attention}was not{} selected",
					"{C:attention}Deselect{} cards if first card {C:attention}was{} selected",
				},
			},
			hand_selection_deselect_hand = {
				name = { "Deselect hand" },
				text = {},
				unlock = {
					"Act as {C:attention}replacement{} for Vanilla",
					"{C:chips}#1#{}, works identical",
				},
			},
			hand_selection_entire_f_hand = {
				name = { "Select entire hand" },
				text = {},
				unlock = {
					"Select {C:attention}max possible{} amount",
					"of cards, from left to right",
				},
			},

			animation_skip = {
				name = "Animation skip",
				text = {
					"Remove scoring and other game animations",
				},
				unlock = {
					"Direct replacement of same feature",
					"from mods like {C:attention}Saturn{} or {C:attention}Nopeus{}",
				},
			},
			animation_skip_default_value = {
				name = "Animation Skip: game startup value",
				text = {},
			},
			animation_skip_increase = {
				name = { "Animation Skip: Increase" },
				text = {},
			},
			animation_skip_decrease = {
				name = { "Animation Skip: Decrease" },
				text = {},
			},
			animation_skip_toggle_temp_disabled = {
				name = { "Animation Skip: Temporary disable" },
				text = {},
				unlock = {
					"Convenient switch to {C:attention}toggle{} feature",
					"without needing to decrease/increase",
					"value manually every time",
				},
			},
			dangerous_actions_animation_skip_unsafe = {
				name = { "Animation Skip: Unsafe" },
				text = {},
				unlock = {
					"Allow to increase Animation Skip to level {C:mult}Unsafe{}",
					" ",
					"{C:mult}Game's absolute limit: everything is instant{}",
				},
			},

			speed_multiplier = {
				name = "Speed multiplier",
				text = {
					"Increase game speed",
				},
				unlock = {
					"Game speed can be changed from",
					"{C:attention}x1/512{} to {C:attention}x512{}",
				},
			},
			speed_multiplier_default_value = {
				name = "Speed Multiplier: game startup value",
				text = {},
			},
			speed_multiplier_multiply = {
				name = { "Speed Multiplier: Increase" },
				text = {},
			},
			speed_multiplier_divide = {
				name = { "Speed Multiplier: Decrease" },
				text = {},
			},
			speed_multiplier_toggle_temp_disabled = {
				name = { "Speed Multiplier: Temporary disable" },
				text = {},
				unlock = {
					"Convenient switch to {C:attention}toggle{} feature",
					"without needing to decrease/increase",
					"value manually every time",
				},
			},
			dangerous_actions_speed_multiplier_uncap = {
				name = { "Speed Multiplier: Uncap" },
				text = {},
				unlock = {
					"Increase limit of max Speed Multiplier",
					" ",
					"{C:mult}Tanks performance on very high values{}",
				},
			},

			move_highlight = {
				name = "Move selection",
				text = {
					"Precise cards selection",
				},
				unlock = {
					"Useful for managing cards when ther's",
					"a lot of them in one card area",
					" ",
					"{C:attention}Select{} card in card area",
					"and then use listed controls",
				},
			},
			move_highlight_one_left = {
				name = { "Move selection: one left" },
				text = {},
			},
			move_highlight_one_right = {
				name = { "Move selection: one right" },
				text = {},
			},
			move_highlight_swap = {
				name = { "Move selection: move card" },
				text = {},
				unlock = {
					"{C:attention}While held{}, card itself",
					"will be moved instead of selection",
					"{C:inactive}(works not in all card areas){}",
				},
			},
			move_highlight_to_end = {
				name = { "Move selection: move to end" },
				text = {},
				unlock = {
					"{C:attention}While held{}, instead of moving selection/card",
					"{C:attention}one left/one right{}, will be moved to",
					"{C:attention}leftmost/rightmost{} position respectively",
				},
			},

			presets = {
				name = "Config presets",
				text = {
					"Config layouts easy to switch between",
				},
			},
			presets_load_1 = {
				name = { "Presets: load preset 1" },
				text = {},
			},
			presets_load_2 = {
				name = { "Presets: load preset 2" },
				text = {},
			},
			presets_load_3 = {
				name = { "Presets: load preset 3" },
				text = {},
			},
			presets_load_next = {
				name = { "Presets: load next preset" },
				text = {},
				unlock = {
					"Order: {C:attention}1{} -> {C:attention}2{} -> {C:attention}3{} -> {C:attention}1{}",
					"Skips empty or disabled presets",
				},
			},

			insta_actions = {
				name = "Quick Buy/Sell/Use",
				text = {
					"Save clicks and use cards faster",
				},
			},
			insta_actions_trigger_mode = {
				name = "Buy/Sell/Use mode",
				text = {},
			},
			insta_actions_buy_or_sell = {
				name = { "Quick Buy/Sell card" },
				text = {},
				unlock = {
					"Usage determined by {C:attention}#1#{}",
					" ",
					"{C:attention}Hold{} keybind and {C:attention}click{} card",
					"to buy {C:inactive}(from shop){}, select {C:inactive}(from booster pack){}",
					"or sell {C:inactive}(from joker/consumable slots){}",
				},
			},
			insta_actions_buy_or_sell_alt = {
				name = { "Quick Buy/Sell card" },
				text = {},
				unlock = {
					"Usage determined by {C:attention}#1#{}",
					" ",
					"{C:attention}Hover/grab{} card and {C:attention}press{} keybind",
					"to buy {C:inactive}(from shop){}, select {C:inactive}(from booster pack){}",
					"or sell {C:inactive}(from joker/consumable slots){}",
				},
			},
			insta_actions_buy_n_sell = {
				name = { "Quick Buy'n'Sell card" },
				text = { "Buy and Sell immediately after" },
				unlock = {
					"Usage determined by {C:attention}#1#{}",
					" ",
					"{C:attention}Hold{} keybind and {C:attention}click{} card",
					"to buy {C:inactive}(from shop){} or select {C:inactive}(from booster pack){}",
					"and sell immediately after",
				},
			},
			insta_actions_buy_n_sell_alt = {
				name = { "Quick Buy'n'Sell card" },
				text = { "Buy and Sell immediately after" },
				unlock = {
					"Usage determined by {C:attention}#1#{}",
					" ",
					"{C:attention}Hover/grab{} card and {C:attention}press{} keybind",
					"to buy {C:inactive}(from shop){} or select {C:inactive}(from booster pack){}",
					"and sell immediately after",
				},
			},
			insta_actions_use = {
				name = { "Quick Use card" },
				text = {},
				unlock = {
					"Usage determined by {C:attention}#1#{}",
					" ",
					"{C:attention}Hold{} keybind and {C:attention}click{} card",
					"to use consumable {C:inactive}(if possible){}",
				},
			},
			insta_actions_use_alt = {
				name = { "Quick Use card" },
				text = {},
				unlock = {
					"Usage determined by {C:attention}#1#{}",
					" ",
					"{C:attention}Hover/grab{} card and {C:attention}press{} keybind",
					"to use consumable {C:inactive}(if possible){}",
				},
			},
			-- insta_actions_cryptid_code_use_last_interaction = {
			-- 	name = { 'Cryptid: Code card\'s "Use previous"' },
			-- 	text = {},
			-- 	unlock = {
			-- 		"Applicable only for cards from {C:attention}Cryptid{}:",
			-- 		"{C:green}://VARIABLE{}, {C:green}://CLASS{}, {C:green}://EXPLOIT{}",
			-- 		" ",
			-- 		"Usage determined by {C:attention}#1#{}",
			-- 		" ",
			-- 		"{C:attention}Hold{} keybind and {C:attention}click{} card",
			-- 		'to execute "Use previous" option',
			-- 	},
			-- },
			-- insta_actions_cryptid_code_use_last_interaction_alt = {
			-- 	name = { 'Cryptid: Code card\'s "Use previous"' },
			-- 	text = {},
			-- 	unlock = {
			-- 		"Applicable only for cards from {C:attention}Cryptid{}:",
			-- 		"{C:green}://VARIABLE{}, {C:green}://CLASS{}, {C:green}://EXPLOIT{}",
			-- 		" ",
			-- 		"Usage determined by {C:attention}#1#{}",
			-- 		" ",
			-- 		"{C:attention}Hover/grab{} card and {C:attention}press{} keybind",
			-- 		'to execute "Use previous" option',
			-- 	},
			-- },

			scoring_hold = {
				name = { "Scoring hold" },
				text = {},
				unlock = {
					"Allow to pause animations {C:attention}before{}",
					"final hand score is calculated",
					" ",
					"Useful for shuffling jokers before round end",
				},
			},
			scoring_hold_any_moment = {
				name = { "Scoring hold: Any moment of scoring" },
				text = {},
				unlock = {
					"Allow to pause animations during",
					"{C:attention}any moment{} of scoring",
				},
			},

			regular_keybinds = {
				name = "Regular & Vanilla keybinds",
				text = {
					"All controls from base game, and more",
				},
			},

			regular_keybinds_group_game = {
				name = "Game",
				text = {},
			},
			regular_keybinds_restart = {
				name = { "Run restart" },
				text = {},
				unlock = {
					"Act as {C:attention}replacement{} for Vanilla",
					"{C:chips}#1#{}, works {C:inactive,s:0.75}almost{} identical",
				},
			},
			regular_keybinds_quick_restart = {
				name = { "Instant run restart" },
				text = {},
				unlock = {
					"Same as Vanilla restart",
					"but with {C:attention}skipped animation{}",
					" ",
					"Works from {C:attention}Game Over{} screen too",
				},
			},
			regular_keybinds_save_run = {
				name = { "Save run" },
				text = {
					"Like autosave but manual",
				},
				unlock = {
					"Game autosave run after some actions",
					"{C:inactive}(like Play hand, Discard, Shop reroll){}",
					" ",
					"This keybind allows to do this manually",
				},
			},

			regular_keybinds_group_round = {
				name = "Round",
				text = {},
			},
			regular_keybinds_play = {
				name = { "Play hand" },
				text = {},
			},
			regular_keybinds_discard = {
				name = { "Discard hand" },
				text = {},
			},
			regular_keybinds_change_sort_rank = {
				name = { "Sort by Rank" },
				text = {},
			},
			regular_keybinds_change_sort_suit = {
				name = { "Sort by Suit" },
				text = {},
			},
			regular_keybinds_toggle_sort = {
				name = { "Toggle sort" },
				text = {},
			},
			regular_keybinds_start_fantoms_preview = {
				name = { "Fantom's Preview: Calculate score" },
				text = {},
			},
			regular_keybinds_cash_out = {
				name = { "Cash out" },
				text = {},
				unlock = {
					"You can start {C:attention}holding{} keybind",
					"early to skip Cash Out",
					"{C:attention}as soon{} as it became available",
				},
			},
			regular_keybinds_not_just_yet_interaction = {
				name = { "NotJustYet: End round" },
				text = {},
			},

			regular_keybinds_group_shop = {
				name = "Shop",
				text = {},
			},
			regular_keybinds_skip_booster = {
				name = { "Skip Booster pack" },
				text = {},
				unlock = {
					"By {C:attention}holding{} keybind you can skip Booster pack",
					"{C:attention}as soon{} as it became available",
					" ",
					"{C:attention}Keep holding{} keybind to skip multiple",
					"Booster packs {C:attention}back to back{}",
				},
			},
			regular_keybinds_reroll_shop = {
				name = { "Reroll shop" },
				text = {},
			},
			regular_keybinds_leave_shop = {
				name = { "Leave shop" },
				text = {},
			},
			regular_keybinds_group_blind_select = {
				name = "Blind Select",
				text = {},
			},

			regular_keybinds_skip_blind = {
				name = { "Skip blind" },
				text = {},
			},
			regular_keybinds_select_blind = {
				name = { "Select blind" },
				text = {},
			},
			regular_keybinds_reroll_boss = {
				name = { "Reroll Boss blind" },
				text = {},
			},

			regular_keybinds_group_menus = {
				name = "Menus",
				text = {},
				unlock = {
					"By using this keybinds, you can go",
					"between menus {C:attention}without closing{} them",
				},
			},
			regular_keybinds_run_info = {
				name = { "Run info: Poker hands" },
				text = {},
			},
			regular_keybinds_run_info_blinds = {
				name = { "Run info: Blinds" },
				text = {},
			},
			regular_keybinds_view_deck = {
				name = { "View deck" },
				text = {},
			},
			regular_keybinds_view_lobby_info = {
				name = { "Multiplayer: Lobby info" },
				text = {},
			},
			regular_keybinds_mod_settings = {
				name = { "Handy: Mod settings" },
				text = {},
			},
			regular_keybinds_show_deck_preview = {
				name = { "Deck preview" },
				text = {},
				unlock = {
					"Displays a panel which shows",
					"when hover a deck",
				},
			},

			dangerous_actions = {
				name = "Dangerous actions",
				text = {
					"When there's too much stuff to handle",
				},
			},
			dangerous_actions_sell_one = {
				name = { "Instant sell" },
				text = {},
				unlock = {
					"{C:attention}Hold{} keybind and start {C:attention}hovering{} cards",
					"you want to sell",
					" ",
					"While {C:attention}holding{} keybind, all hovered items",
					"will be added to queue",
					"On keybind {C:attention}release{}, all of them will be sold",
				},
			},
			dangerous_actions_remove_one = {
				name = { "Instant remove" },
				text = { "Also works on Skip tags" },
				unlock = {
					"{C:attention}Hold{} keybind and start {C:attention}hovering{} cards/skip tags",
					"you want to {C:mult}remove{}",
					" ",
					"While {C:attention}holding{} keybind, all hovered items",
					"will be added to queue",
					"On keybind {C:attention}release{}, all of them will be {C:mult}removed{}",
					"{C:inactive}(bypasses all checks, no refund){}",
				},
			},
			dangerous_actions_sell_all_same = {
				name = { "Instant sell all same" },
				text = {},
				unlock = {
					"{C:attention}Hold{} keybind and {C:attention}click{} card",
					"you want to sell",
				},
			},
			dangerous_actions_remove_all_same = {
				name = { "Instant remove all same" },
				text = { "Also works on Skip tags" },
				unlock = {
					"{C:attention}Hold{} keybind and {C:attention}click{} card/skip tag",
					"you want to {C:mult}remove{}",
					"{C:inactive}(bypasses all checks, no refund){}",
				},
			},
			dangerous_actions_sell_all = {
				name = { "Instant sell ALL" },
				text = {},
				unlock = {
					"{C:attention}Hold{} keybind and {C:attention}click{} card",
					"you want to sell",
				},
			},
			dangerous_actions_remove_all = {
				name = { "Instant remove ALL" },
				text = { "Also works on Skip tags" },
				unlock = {
					"{C:attention}Hold{} keybind and {C:attention}click{} card/skip tag",
					"you want to {C:mult}remove{}",
					"{C:inactive}(bypasses all checks, no refund){}",
				},
			},
			dangerous_actions_crash = {
				name = { "Crash the game" },
				text = {},
				unlock = {
					"{C:mult}Literally.{}",
					" ",
					"Can be used in any moment",
				},
			},

			misc = {
				name = "Miscellaneous",
				text = {},
			},
		},

		Handy_Preset = {
			["default"] = {
				name = "Default",
				text = {
					"Default mod controls",
				},
			},
			["better_mouse_and_gamepad"] = {
				name = "Better Mouse and Gamepad",
				text = {
					"Controls similar to Better Mouse and Gamepad mod",
				},
			},
		},
		Handy_Other = {
			overall_title = {
				text = {
					"- Swipe to select cards",
					"- In-game keybinds",
					"- More game speed",
					"- Removing animations",
					"- Enhanced gamepad support",
					" ",
					"- Controls can be assigned to {C:chips}any combination{}",
					"  of keyboard, mouse or gamepad buttons",
					"  and enabled/disabled in {C:chips}any moment{}",
					"  without game restart or reloading a run",
					"- Does {C:chips}not{} disables achievements",
				},
			},
			missing_deps = {
				text = {
					"This control is inactive until listed",
					"controls is enabled:",
				},
			},
			cant_use_in_mp = {
				text = {
					"{C:mult}This control is disabled in Multiplayer{}",
				},
			},
		},
	},
	misc = {
		-- You don't need to translate all of them, only necessary ones
		handy_keybinds = {
			-- No button assigned
			["None"] = "None",
			-- Button which cannot be recognized
			["Unknown"] = "Unknown",

			-- Mouse
			["Left Mouse"] = nil,
			["Right Mouse"] = nil,
			["Middle Mouse"] = nil,
			["Mouse 4"] = nil,
			["Mouse 5"] = nil,
			["Wheel Up"] = nil,
			["Wheel Down"] = nil,
			-- Controls
			["Escape"] = nil,
			["Shift"] = nil,
			["Ctrl"] = nil,
			["Alt"] = nil,
			["GUI"] = nil, -- Windows button, or CMD for Mac
			["Enter"] = nil,
			["Tab"] = nil,
			["Backspace"] = nil,
			["Num Lock"] = nil,
			["Caps Lock"] = nil,
			["Scroll Lock"] = nil,
			-- Arrow keys
			["Left"] = nil,
			["Right"] = nil,
			["Up"] = nil,
			["Down"] = nil,
			-- Symbols
			["Backquote"] = nil, -- `
			["Singlequote"] = nil, -- '
			["Quote"] = nil, -- "
			["Left Bracket"] = nil, -- [
			["Right Bracket"] = nil, -- ]
			-- Weird buttons
			["Printscreen"] = nil,
			["Delete"] = nil,
			["Home"] = nil,
			["Insert"] = nil,
			["End"] = nil,
			["Pause"] = nil,
			["Help"] = nil,
			["Sysreq"] = nil,
			["Menu"] = nil,
			["Undo"] = nil,
			["Mode"] = nil,
			["Page Up"] = nil,
			["Page Down"] = nil,
			-- Very weird buttons, did they exist in 21th century?
			["Www"] = nil,
			["Mail"] = nil,
			["Calculator"] = nil,
			["Computer"] = nil,
			["Appsearch"] = nil,
			["Apphome"] = nil,
			["Appback"] = nil,
			["Appforward"] = nil,
			["Apprefresh"] = nil,
			["Appbookmarks"] = nil,
			["Currencyunit"] = nil,
			["Application"] = nil,
			["Power"] = nil, -- What a heck

			-- Gamepad: buttons
			["(A)"] = nil,
			["(B)"] = nil,
			["(X)"] = nil,
			["(Y)"] = nil,
			["(Back)"] = nil,
			["(Guide)"] = nil,
			["(Start)"] = nil,
			-- Gamepad: directions
			-- In Balatro, Left Stick movement treated as direction buttons
			["(Up)"] = nil,
			["(Down)"] = nil,
			["(Left)"] = nil,
			["(Right)"] = nil,
			-- Gamepad: sticks, triggers, bumpers and paddles
			["Left Stick"] = nil, -- Click
			["Right Stick"] = nil, -- Click
			["Left Bumper"] = nil, -- LB
			["Right Bumper"] = nil, -- RB
			["Left Trigger"] = nil, -- LT
			["Right Trigger"] = nil, -- RT
			-- Not supported by current LOVE engine version
			["First Paddle"] = nil, -- P1
			["Second Paddle"] = nil, -- P2
			["Third Paddle"] = nil, -- P3
			["Fourth Paddle"] = nil, -- P4
			["(Misc. Button)"] = nil,
			-- Gamepad: touchpad
			["Touchpad Press"] = nil,

			-- Not listed here, but can be added if you ever need:
			-- All english letters uppercase, (Q, W, E, R, T, Y...)
			-- All numbers (1, 2, 3...0)
			-- All F keys (F1, F2, F3...)
			-- All NUM keys (NUM 0 ... NUM 9, NUM Enter, NUM +, NUM -, NUM *, NUM /, NUM .)
			-- Other symbols (. ; / \ - + etc)
		},
		handy_tabs = {
			["Overall"] = "General",
			["Presets"] = "Presets",
			["Search"] = "Search",

			["Generall & Appearance"] = "Generall & Appearance",
			["Fast hand selection"] = "Fast hand selection",
			["Speed & Animations"] = "Speed & Animations",
			["Vanilla keybinds"] = "Vanilla keybinds",
			["Quick buy/sell/use"] = "Quick buy/sell/use",
			["Highlight movement"] = "Selection movement",
			["Misc"] = "Miscellaneous",
			["Dangerous"] = "Danger Zone",

			["Speed"] = "Speed",
			["Animations"] = "Animations",
			["Hold"] = "Hold",
			["Round"] = "Round",
			["Shop & Blind Select"] = "Shop/Blinds",
			["Game & Menus"] = "Game/Menus",
		},
		v_dictionary = {
			Handy_by = "#1# by #2#",
			Handy_module_keys_single = "[#1#]",
			Handy_module_keys_or = "[#1#] or [#2#]",
			Handy_items_in_queue = "[#1# in queue]",
			Handy_temp_disabled = "[disabled]",

			Handy_gamespeed_multiplier = "Game speed multiplier: #1#",
			Handy_event_queue_retriggers_amount = "Event queue acceleration: #1#",
			Handy_animation_skip = "Animation skip: #1#",

			Handy_skip_booster_pack = "Skip booster pack",

			Handy_scoring_hold = "Pause scoring animation",

			Handy_hand_sorting = "Hand sorting: #1#",

			Handy_preset_index = "Preset #1#",
			Handy_preset_saved = "Preset #1# [#2#] saved",
			Handy_preset_loaded = "Preset #1# [#2#] loaded",
			Handy_preset_empty = "Preset #1# [#2#] is empty",
			Handy_preset_disabled = "Preset #1# [#2#] is disabled",
			Handy_preset_example_loaded = "Pre-made preset [#1#] loaded",
			Handy_preset_nothing_to_load = "No presets to load",

			Handy_binding_canceled = "Binding canceled",
			Handy_binding_cancel_reason_no_safe = 'Cannot assign #1# here to prevent "softlock"',
			Handy_binding_cancel_reason_no_hold = 'Cannot assign #1# here since it cannot be "holded"',
			Handy_binding_cancel_reason_multiple_no_hold = "Combination cannot contain multiple non-holdable keys",
			Handy_binding_finished = "Binding finished: #1#",
			Handy_binding_progress = "Binding: #1#",
			Handy_binding_esc_hint = "#1# to save",

			Handy_prevented_by_debugplus = "Prevented by DebugPlus",
		},
		dictionary = {
			handy_or = "or",
			handy_mod_enabled = "Mod enabled",
			handy_mod_disabled = "Mod disabled",

			handy_example_state_panel = "Various notifications displayed here",

			ph_handy_premade_presets = "Pre-made presets",
			ph_handy_custom_presets = "Custom presets",

			b_handy_preset_save = "Save",
			b_handy_preset_load = "Load",
			b_handy_preset_clear = "Clear",

			handy_preset_name_placeholder = "Preset name",

			b_handy_notif_quick = "Quick actions",
			b_handy_notif_dangerous = "Dangerous actions",

			b_handy_search_placeholder = "Search...",
			b_handy_search = "Search",
			b_handy_clear = "Clear",

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
			ph_handy_notif_animation_skip_unsafe_disabled = "Unsafe option disabled in mod settings",

			ph_handy_notif_misc_save_run_start = "Starting run saving...",
			ph_handy_notif_misc_save_run_saving = "Saving a run...",
			ph_handy_notif_misc_save_run_saved = "Run saved",
			ph_handy_notif_misc_save_run_interrupt = "Cannot save run right now",

			handy_animation_skip_levels = {
				[1] = "None",
				[2] = "Messages",
				[3] = "Animations",
				[4] = "Everything",
				[5] = "Unsafe",
			},

			handy_modals_start_calculation = {
				"Start",
				"calculation",
			},
			handy_modals_stop_calculation = {
				"Stop",
				"calculation",
			},
			handy_modals_preview_description = "Use preview to see settings effect",
			handy_modals_move_highlight_preview_description = "Use preview to test controls",

			ph_handy_dangerous_actions_sell_one = "Sell one",
			ph_handy_dangerous_actions_remove_one = "Remove one",
			ph_handy_dangerous_actions_sell_all_same = "Sell all same",
			ph_handy_dangerous_actions_remove_all_same = "Remove all same",
			ph_handy_dangerous_actions_sell_all = "Sell ALL",
			ph_handy_dangerous_actions_remove_all = "Remove ALL",

			handy_keybinds_trigger_mode_press = "On key press",
			handy_keybinds_trigger_mode_release = "On key release",

			handy_current_device_auto = "Auto",
			handy_current_device_keyboard = "Mouse + Keyboard",
			handy_current_device_gamepad = "Gamepad",

			handy_notification_level_none = "None",
			handy_notification_level_dangerous = "Dangerous only",
			handy_notification_level_essential = "Essential",
			handy_notification_level_all = "All",

			handy_buy_sell_use_mode_hold_n_click = "Hold key + Click card",
			handy_buy_sell_use_mode_hover_n_press = "Hover or grab card + Press key",

			handy_advanced_mode = "Advanced mode",
			handy_advanced_mode_description = "More controls toggles",

			k_handy_preview_sell = "Sell",
			k_handy_preview_buy = "Buy",
			k_handy_preview_use = "Use",
			k_handy_preview_buy_n_use = "Buy & Use",
			k_handy_preview_buy_n_sell = "Buy & Sell",
			k_handy_preview_remove = "REMOVE",
		},
	},
}
