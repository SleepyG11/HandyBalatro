return {
	descriptions = {
		Handy_ConfigDictionary = {
			-- [Version, Author]
			general = {
				name = "Handy v#1# by #2#",
				text = {},
			},

			-- []
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

			-- []
			keybinds_trigger_mode = {
				name = "Keybinds trigger mode",
				text = {},
			},
			-- [Auto]
			current_device = {
				name = "Input device",
				text = { "Mouse + Keyboard, or Gamepad" },
				unlock = {
					"Mod uses separate layout of keybinds",
					"for {C:attention}Mouse + Keyboard{} and {C:attention}Gamepad{}",
					"and switches between them depending",
					"on what device you're currently using",
					'{C:inactive}(if "#1#" mod is selected){}',
				},
			},
			-- [Ctrl]
			prevent_if_debugplus = {
				name = "DebugPlus: Prevent intersections",
				text = {},
				unlock = {
					"Do not execute any controls when {C:chips}#1#{}",
					"is hold to prevent intersecting with",
					"{C:attention}DebugPlus{} controls",
					" ",
					'Require {C:attention}"CTRL for Keybinds"{} to be',
					"enabled in mod settings",
					" ",
					"As side effect, makes keybinds",
					"with {C:chips}#1#{} button {C:mult}unusable{}",
				},
			},

			-- []
			gamepad = {
				name = "Gamepad settings",
				text = {},
			},
			-- [Right stick, Left stick]
			swap_controller_cursor_stick = {
				name = "Gamepad: Swap cursor stick",
				text = {},
				unlock = {
					"By default, {C:chips}#1#{} activates",
					"built-in game cursor.",
					" ",
					"This setting switches it to {C:chips}#2#{}",
				},
			},
			-- []
			controller_sensitivity = {
				name = "Gamepad: Cursor sensitivity",
				text = {},
			},

			-- []
			appearance = {
				name = "Appearance",
				text = {},
			},
			-- []
			hide_options_button = {
				name = "Hide mod button in options",
				text = {},
			},
			-- []
			notifications_level = {
				name = "Notifications",
				text = {},
			},
			-- []
			speed_multiplier_settings_toggle = {
				name = "Speed Multiplier: Toggle in settings",
				text = {},
				unlock = {
					"Placed near Vanilla {C:attention}Game speed{} setting",
				},
			},
			-- []
			animation_skip_settings_toggle = {
				name = "Animations Skip: Toggle in settings",
				text = {},
				unlock = {
					"Placed near Vanilla {C:attention}Game speed{} setting",
				},
			},
			-- []
			show_custom_pip = {
				name = "Display keybinds on buttons",
				text = {},
				unlock = {
					"Visually show keybinds on",
					"buttons they activate",
					"{C:inactive}(Play hand, Discard, Run info, Reroll, etc.){}",
				},
			},

			-- []
			updater = {
				name = "Mod auto-updating",
				text = { "I know you're lazy" },
			},
			-- []
			updater_target_release_type = {
				name = "Target release",
				text = {},
			},
			-- []
			updater_notify_about_new_update = {
				name = "Notify about new update",
				text = {},
				unlock = {
					"You'll see notification on {C:attention}game startup{}",
				},
			},
			-- []
			updater_auto_install_new_update = {
				name = "Auto-install new update",
				text = {},
				unlock = {
					"Update will be installed on {C:attention}game startup{}",
				},
			},
			-- []
			updater_auto_restart_game_after_update = {
				name = "Auto-restart a game after update",
				text = {},
			},

			-- [@lord.ruby]
			me = {
				name = "Hello, that's Me! I'll follow you...",
				text = {
					"Art by {C:mult}#1#{}",
				},
			},
			-- []
			me_in_mod_config = {
				name = "...in mod config",
				text = {},
			},
			-- []
			me_in_game_over = {
				name = "...in game over screen",
				text = {},
			},
			-- []
			me_in_game_win = {
				name = "...in game win screen",
				text = {},
			},
			-- []
			me_in_screenswipe = {
				name = "...in screen wipe card",
				text = {},
			},

			-- []
			hand_selection = {
				name = "Hand selection & Deselection",
				text = {
					"Swipe to select, and more",
				},
			},
			-- [Left Mouse, Hand deselection]
			hand_selection_mode = {
				name = "Hand selection implementation",
				text = {
					"Select mod you used before",
				},
				unlock = {
					"Affects how some nuances of",
					"{C:attention}hand selection{} and {C:attention}deselection{} works",
					"when using key other that {C:chips}#1#{}",
					"and/or {C:chips}#2#{} have same keybind:",
					" ",
					"{C:attention}Handy{} - select immediately, cannot deselect",
					"{C:attention}BMaG{} - select only after move, deselect on release",
				},
			},
			-- [Left mouse]
			hand_selection_insta_highlight = {
				name = { "Fast hand selection" },
				text = {
					"Drag, hover, swipe, slide to select",
				},
				unlock = {
					"When assigned to {C:chips}#1#{},",
					"start holding {C:attention}OUTSIDE{} of cards",
					"and then hover them to select",
					"{C:inactive}(because otherwise you'll grab a card){}",
				},
			},
			-- []
			hand_selection_insta_highlight_allow_deselect = {
				name = { "Fast hand deselection" },
				text = {},
				unlock = {
					"{C:inactive}When you hover cards:{}",
					"If {C:attention}first{} card {C:mult}wasn't{} selected, {C:chips}select{} cards",
					"If {C:attention}first{} card {C:chips}was{} selected, {C:mult}deselect{} cards",
				},
			},
			-- []
			hand_selection_combine_select_deselect = {
				name = { "Combined select & deselect" },
				text = {},
				unlock = {
					"{C:inactive}When you hover cards:{}",
					"If card {C:mult}isn't{} selected, {C:chips}select{} it",
					"If card {C:chips}is{} selected, {C:mult}deselect{} it",
				},
			},
			-- [Right mouse]
			hand_selection_deselect_hand = {
				name = { "Deselect hand" },
				text = {
					"Vanilla #1#",
				},
			},
			-- []
			hand_selection_entire_f_hand = {
				name = { "Select entire hand" },
				text = {},
				unlock = {
					"Select {C:attention}max possible{} amount",
					"of cards, from left to right",
				},
			},

			-- [None, Messages, Animations, Everything]
			animation_skip = {
				name = "Animations Skip",
				text = {
					"Remove scoring and other game animations",
				},
				unlock = {
					"Direct replacement of same feature",
					"from mods like {C:attention}Talisman{}, {C:attention}Saturn{} or {C:attention}Nopeus{}",
					" ",
					"Has 4 levels:",
					"{C:chips}#1#{} - no changes",
					"{C:chips}#2#{} - no {C:mult}XMult{}, {C:attention}Again!{} and other trigger messages",
					"{C:attention}#3#{} - instant scoring",
					"{C:attention}#4#{} - most animations removed; instant cards draw",
				},
				handy_override_align = {
					unlock = {
						[5] = "cl",
						[6] = "cl",
						[7] = "cl",
						[8] = "cl",
					},
				},
			},
			-- []
			animation_skip_current_value = {
				name = "Animations Skip: Current value",
				text = {},
			},
			-- []
			animation_skip_default_value = {
				name = "Animations Skip: Game startup value",
				text = {},
			},
			-- []
			animation_skip_increase = {
				name = { "Animations Skip: Increase" },
				text = {},
			},
			-- []
			animation_skip_decrease = {
				name = { "Animations Skip: Decrease" },
				text = {},
			},
			-- []
			animation_skip_toggle_temp_disabled = {
				name = { "Animations Skip: Toggle" },
				text = {},
			},
			-- [Unsafe]
			dangerous_actions_animation_skip_unsafe = {
				name = { "Animations Skip: Unsafe" },
				text = {},
				unlock = {
					"Allow increase to level {C:mult}#1#{}",
					" ",
					"{C:mult}Game's absolute limit: everything is instant{}",
				},
			},

			-- [128x]
			speed_multiplier = {
				name = "Speed Multiplier",
				text = {
					"Increase game speed",
				},
				unlock = {
					"As name suggests, {C:attention}multiplies{} game speed,",
					"which means default value is always {C:attention}1x{}",
					" ",
					"Starting from {C:attention}#1#{}, accelerates",
					"{C:attention}Event Queue{} to bypass limit",
					"of 60 actions per second",
				},
			},
			-- []
			speed_multiplier_current_value = {
				name = "Speed Multiplier: Current value",
				text = {},
			},
			-- []
			speed_multiplier_default_value = {
				name = "Speed Multiplier: Game startup value",
				text = {},
			},
			-- []
			speed_multiplier_multiply = {
				name = { "Speed Multiplier: Increase" },
				text = {},
			},
			-- []
			speed_multiplier_divide = {
				name = { "Speed Multiplier: Decrease" },
				text = {},
			},
			-- []
			speed_multiplier_toggle_temp_disabled = {
				name = { "Speed Multiplier: Toggle" },
				text = {},
			},
			-- [x200k]
			dangerous_actions_speed_multiplier_uncap = {
				name = { "Speed Multiplier: Uncap" },
				text = {},
				unlock = {
					"Increases max speed limit up to {C:mult}#1#{}",
					" ",
					"{C:mult}Tanks performance on very high values{}",
				},
			},

			-- []
			move_highlight = {
				name = "Precise selection",
				text = {
					"Precise cards selection & movement",
				},
				unlock = {
					"Useful for managing cards when there's",
					"a lot of them in one card area",
					" ",
					"{C:attention}Select{} card in card area",
					"and then use listed controls",
				},
			},
			-- []
			move_highlight_one_left = {
				name = { "Precise selection: One left" },
				text = {},
				unlock = {
					"You can {C:attention}hold{} this keybind",
					"to keep moving faster",
				},
			},
			-- []
			move_highlight_one_right = {
				name = { "Precise selection: One right" },
				text = {},
				unlock = {
					"You can {C:attention}hold{} this keybind",
					"to keep moving faster",
				},
			},
			-- []
			move_highlight_swap = {
				name = { "Precise selection: Move card" },
				text = {},
				unlock = {
					"{C:attention}While held{}, card itself",
					"will be moved instead",
				},
			},
			-- []
			move_highlight_to_end = {
				name = { "Precise selection: Move to end" },
				text = {},
				unlock = {
					"While {C:attention}held{}, instead of moving selection/card",
					"{C:attention}one left/one right{}, will be moved to",
					"{C:attention}leftmost/rightmost{} position respectively",
				},
			},

			-- []
			presets = {
				name = "Config presets",
				text = {
					"Config layouts easy to switch between",
				},
			},
			-- []
			presets_load_1 = {
				name = { "Presets: Load preset 1" },
				text = {},
			},
			-- []
			presets_load_2 = {
				name = { "Presets: Load preset 2" },
				text = {},
			},
			-- []
			presets_load_3 = {
				name = { "Presets: Load preset 3" },
				text = {},
			},
			-- []
			presets_load_next = {
				name = { "Presets: Load next preset" },
				text = { "1 -> 2 -> 3 -> 1" },
				unlock = {
					"Skips empty or disabled presets",
				},
			},

			-- []
			insta_actions = {
				name = "Quick Buy/Sell/Use",
				text = {
					"Save clicks and use cards faster",
				},
			},
			-- []
			insta_actions_trigger_mode = {
				name = "Buy/Sell/Use mode",
				text = {},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_buy_or_sell = {
				name = { "Quick Buy/Sell card" },
				text = {},
				unlock = {
					"Usage determined by {C:attention}#1#{}",
					" ",
					"{C:attention}Hold{} keybind and {C:attention}click{} on a card",
					"to buy {C:inactive}(from shop){}, select {C:inactive}(from booster pack){}",
					"or sell {C:inactive}(from joker/consumable slots){}",
				},
			},
			-- [Buy/Sell/Use mode]
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
			-- [Buy/Sell/Use mode]
			insta_actions_buy_n_sell = {
				name = { "Quick Buy'n'Sell card" },
				text = { "Buy and Sell immediately after" },
				unlock = {
					"Usage determined by {C:attention}#1#{}",
					" ",
					"{C:attention}Hold{} keybind and {C:attention}click{} on a card",
					"to buy {C:inactive}(from shop){} or select {C:inactive}(from booster pack){}",
					"and {C:attention}sell immediately{} after",
				},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_buy_n_sell_alt = {
				name = { "Quick Buy'n'Sell card" },
				text = { "Buy and Sell immediately after" },
				unlock = {
					"Usage determined by {C:attention}#1#{}",
					" ",
					"{C:attention}Hover/grab{} card and {C:attention}press{} keybind",
					"to buy {C:inactive}(from shop){} or select {C:inactive}(from booster pack){}",
					"and {C:attention}sell immediately{} after",
				},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_use = {
				name = { "Quick Use card" },
				text = {},
				unlock = {
					"Usage determined by {C:attention}#1#{}",
					" ",
					"{C:attention}Hold{} keybind and {C:attention}click{} card",
					"to use it {C:inactive}(if possible){}",
				},
			},
			-- [Buy/Sell/Use mode]
			insta_actions_use_alt = {
				name = { "Quick Use card" },
				text = {},
				unlock = {
					"Usage determined by {C:attention}#1#{}",
					" ",
					"{C:attention}Hover/grab{} card and {C:attention}press{} keybind",
					"to use it {C:inactive}(if possible){}",
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

			-- []
			scoring_hold = {
				name = { "Scoring hold" },
				text = {},
				unlock = {
					"{C:attention}Hold{} to pause scoring animations",
					"{C:attention}before{} final hand score is calculated",
					" ",
					"Useful for shuffling jokers before round end",
				},
			},
			-- []
			scoring_hold_any_moment = {
				name = { "Scoring hold: Any moment of scoring" },
				text = {},
				unlock = {
					"{C:attention}Hold{} to pause scoring animations",
					"in {C:attention}any moment{} of scoring",
				},
			},

			-- []
			regular_keybinds = {
				name = "Regular & Vanilla keybinds",
				text = {
					"All controls from base game, and more",
				},
			},

			-- []
			regular_keybinds_group_game = {
				name = "Game",
				text = {},
			},
			-- [R]
			regular_keybinds_restart = {
				name = { "Restart run" },
				text = { "Vanilla #1#" },
			},
			-- [R]
			regular_keybinds_quick_restart = {
				name = { "Instant run restart" },
				text = { "Vanilla #1# but instant" },
				unlock = {
					"Works from {C:attention}Game Over{} screen too",
				},
			},
			-- []
			regular_keybinds_save_run = {
				name = { "Save run" },
				text = {
					"Autosave but manual",
				},
				unlock = {
					"Game autosave run after some actions",
					"{C:inactive}(like Play hand, Discard, Shop reroll){}",
					" ",
					"This keybind allows to do this manually",
				},
			},
			-- []
			regular_keybinds_reload_run = {
				name = { "Load run" },
				text = {
					"Main menu -> Continue run",
				},
				unlock = {
					"Simulates exiting to Main Menu",
					"and then Continuing run",
					"with {C:attention}skipped animation{}",
				},
			},
			-- []
			regular_keybinds_restart_game = {
				name = "Restart Balatro",
				text = {},
			},
			-- []
			regular_keybinds_copy_log_file = {
				name = { "Copy Lovely log" },
				text = {},
				unlock = {
					"Due to technical limitations, log",
					"copied {C:attention}as text{}, not as file",
				},
			},

			-- []
			regular_keybinds_group_hand = {
				name = "Hand",
				text = {},
			},
			-- []
			regular_keybinds_play = {
				name = { "Play hand" },
				text = {},
			},
			-- []
			regular_keybinds_discard = {
				name = { "Discard hand" },
				text = {},
			},
			-- []
			regular_keybinds_change_sort_rank = {
				name = { "Sort hand by Rank" },
				text = {},
			},
			-- []
			regular_keybinds_change_sort_suit = {
				name = { "Sort hand by Suit" },
				text = {},
			},
			-- []
			regular_keybinds_toggle_sort = {
				name = { "Switch hand sorting" },
				text = { "Suit > Rank > Suit..." },
			},

			-- []
			regular_keybinds_group_round = {
				name = "Round",
				text = {},
			},
			-- []
			regular_keybinds_start_fantoms_preview = {
				name = { "Fantom's Preview: Calculate score" },
				text = {},
			},
			-- []
			regular_keybinds_cash_out = {
				name = { "Cash out" },
				text = {},
				unlock = {
					"{C:attention}Hold{} keybind to skip Cash Out",
					"as soon as it became available",
				},
			},
			-- []
			regular_keybinds_not_just_yet_interaction = {
				name = { "NotJustYet: End round" },
				text = {},
			},

			-- []
			regular_keybinds_group_shop = {
				name = "Shop",
				text = {},
			},
			-- []
			regular_keybinds_skip_booster = {
				name = { "Skip Booster pack" },
				text = {},
				unlock = {
					"{C:attention}Hold{} keybind to skip Booster pack",
					"as soon as it became available",
					" ",
					"{C:attention}Keep holding{} keybind to skip multiple",
					"Booster packs {C:attention}back to back{}",
				},
			},
			-- []
			regular_keybinds_reroll_shop = {
				name = { "Reroll shop" },
				text = {},
			},
			-- []
			regular_keybinds_leave_shop = {
				name = { "Leave shop" },
				text = {},
			},
			-- []
			regular_keybinds_group_blind_select = {
				name = "Blind Select",
				text = {},
			},

			-- []
			regular_keybinds_skip_blind = {
				name = { "Skip blind" },
				text = {},
			},
			-- []
			regular_keybinds_select_blind = {
				name = { "Select blind" },
				text = {},
			},
			-- []
			regular_keybinds_reroll_boss = {
				name = { "Reroll Boss blind" },
				text = {},
			},

			-- []
			regular_keybinds_group_menus = {
				name = "Menus",
				text = {},
			},
			-- []
			regular_keybinds_mod_settings = {
				name = { "Handy: Mod settings" },
				text = {},
			},
			-- []
			regular_keybinds_show_deck_preview = {
				name = { "Deck preview" },
				text = { "Same as hovering a deck" },
			},
			-- [Escape]
			regular_keybinds_options = {
				name = { "Options" },
				text = { "Same as #1#" },
			},
			-- []
			regular_keybinds_collection = {
				name = { "Collection" },
				text = {},
			},

			-- []
			regular_keybinds_group_swappable_menus = {
				name = "In-Game Menus",
				text = {},
				unlock = {
					"You can move between menus",
					"by using keybinds",
					"{C:attention}without closing{} them first",
				},
			},
			-- []
			regular_keybinds_swappable_overlays_mode = {
				name = "In-Game Menus mode",
				text = {},
			},
			-- []
			regular_keybinds_run_info = {
				name = { "Run info: Poker hands" },
				text = {},
			},
			-- []
			regular_keybinds_run_info_blinds = {
				name = { "Run info: Blinds" },
				text = {},
			},
			-- []
			regular_keybinds_view_deck = {
				name = { "Open Deck" },
				text = {},
			},
			-- []
			regular_keybinds_view_lobby_info = {
				name = { "Multiplayer: Lobby info" },
				text = {},
			},

			-- []
			dangerous_actions = {
				name = "Dangerous actions",
				text = {
					"When there's too much stuff to handle",
				},
			},
			-- []
			dangerous_actions_sell_one = {
				name = { "Instant sell" },
				text = {},
				unlock = {
					"{C:attention}Hold{} keybind and start {C:attention}hovering{}",
					"cards you want to sell",
					" ",
					"While {C:attention}holding{}, hovered items added to list",
					"On {C:attention}release{}, all of them will be sold",
				},
			},
			-- []
			dangerous_actions_remove_one = {
				name = { "Instant remove" },
				text = { "Also works on Skip tags" },
				unlock = {
					"{C:attention}Hold{} keybind and start {C:attention}hovering{}",
					"cards/skip tags you want to {C:mult}remove{}",
					" ",
					"While {C:attention}holding{}, hovered items added to list",
					"On {C:attention}release{}, all of them will be {C:mult}removed{}",
					"{C:inactive}(bypasses all checks, no refund){}",
				},
			},
			-- [Instant sell all same, Instant REMOVE all same, Instant sell all, Instant REMOVE ALL]
			dangerous_actions_mass_sell_remove_mode = {
				name = "Mass Sell/Remove mode",
				text = {},
				unlock = {
					"Applied to controls:",
					"{C:mult}#1#{}",
					"{C:mult}#2#{}",
					"{C:mult}#3#{}",
					"{C:mult}#4#{}",
				},
			},
			-- []
			dangerous_actions_sell_all_same = {
				name = { "Instant sell all same" },
				text = {},
				unlock = {
					"{C:attention}Hold{} keybind and {C:attention}click{} card",
					"you want to sell",
				},
			},
			-- []
			dangerous_actions_remove_all_same = {
				name = { "Instant remove all same" },
				text = { "Also works on Skip tags" },
				unlock = {
					"{C:attention}Hold{} keybind and {C:attention}click{} card/skip tag",
					"you want to {C:mult}remove{}",
					"{C:inactive}(bypasses all checks, no refund){}",
				},
			},
			-- []
			dangerous_actions_sell_all = {
				name = { "Instant sell ALL" },
				text = {},
				unlock = {
					"{C:attention}Hold{} keybind and {C:attention}click{} card",
					"you want to sell",
				},
			},
			-- []
			dangerous_actions_remove_all = {
				name = { "Instant remove ALL" },
				text = { "Also works on Skip tags" },
				unlock = {
					"{C:attention}Hold{} keybind and {C:attention}click{} card/skip tag",
					"you want to {C:mult}remove{}",
					"{C:inactive}(bypasses all checks, no refund){}",
				},
			},
			-- []
			dangerous_actions_crash = {
				name = { "Crash the game" },
				text = {},
				unlock = {
					"{C:mult}Literally{}",
				},
			},
			-- []
			dangerous_actions_stack_overflow = {
				name = { "Crash the game: Stack overflow" },
				text = {},
				unlock = {
					"{C:mult}Literally{}",
					"{C:mult}Game will freeze and/or exit itself{}",
				},
			},

			-- []
			misc = {
				name = "Miscellaneous",
				text = {},
			},

			-- []
			mp_extension = {
				name = { "Multiplayer Extension" },
				text = { "Multiplayer-specific features" },
			},

			-- []
			mp_extension_current_lobby = {
				name = { "MP Extension: current lobby options" },
				text = {},
			},
			-- [Speed multiplier, Animations skip]
			mp_extension_enabled = {
				name = "Allow Multiplayer Extension",
				text = {},
				unlock = {
					"By enabling this checkbox, {C:attention}YOU{} allow to",
					"{C:mult}Multiplayer Extension{} be enabled in this lobby",
					" ",
					"Only when {C:attention}ALL{} players in lobby have it enabled,",
					"controls such {C:chips}#1#{} and {C:attention}#2#{}",
					"became available to use for {C:attention}ALL{} players in lobby",
				},
			},
			-- []
			mp_extension_speed_multiplier_mode = {
				name = "Speed Multiplier: lobby max value",
				text = {},
			},
			-- []
			mp_extension_animation_skip_mode = {
				name = "Animations Skip: lobby max value",
				text = {},
			},
			-- []
			mp_extension_dangerous_actions_mode = {
				name = "Dangerous Actions: lobby mode",
				text = {},
				unlock = {
					"Allow to enable some {C:mult}Dangerous Actions{}",
					"for mass selling",
				},
			},

			-- []
			mp_extension_default_values = {
				name = { "MP Extension: default lobby options" },
				text = {},
			},
			-- []
			mp_extension_speed_multiplier_mode_default_value = {
				name = "Speed Multiplier: lobby default max value",
				text = {},
				unlock = {
					"When you {C:attention}create a lobby{},",
					"this value will be set by default",
				},
			},
			-- []
			mp_extension_animation_skip_mode_default_value = {
				name = "Animations Skip: lobby default max value",
				text = {},
				unlock = {
					"When you {C:attention}create a lobby{},",
					"this value will be set by default",
				},
			},
			-- []
			mp_extension_dangerous_actions_mode_default_value = {
				name = "Dangerous Actions: lobby default mode",
				text = {},
				unlock = {
					"When you {C:attention}create a lobby{},",
					"this value will be set by default",
				},
			},
			-- []
			mp_extension_enabled_default_value = {
				name = "Allow MP Extension: default value",
				text = {},
				unlock = {
					"When you {C:attention}create or join a lobby{},",
					"this value will be set by default",
				},
			},

			-- []
			debug_things = {
				name = "Development & Debugging",
				text = {},
			},
			-- []
			debug_things_reload_localization = {
				name = "Dev: Reload Localization",
				text = {},
				unlock = { "G:set_language();", "init_localization();" },
			},
			-- []
			debug_things_reload_prototypes = {
				name = "Dev: Reload Item Prototypes",
				text = {},
				unlock = { "G:set_language();", "G:init_item_prototypes();" },
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
			["full_default"] = {
				name = "Reset to Default",
				text = {
					"Full configuration reset to default",
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
					"- Gamepad support",
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
					"This control is disabled in {C:mult}Multiplayer{}",
				},
			},
			cant_use_with_gamepad = {
				text = {
					"This control is disabled on {C:attention}Gamepad{}",
				},
			},
			missing_req_mods = {
				text = {
					"This control require other mods to work:",
				},
			},
			conflict_mods = {
				text = {
					"This control is inactive due to other mods:",
				},
			},
			mp_lobby_require_all_hint = {
				text = {
					"All listed lobby settings have effect only when",
					"{C:attention}ALL{} lobby members have {C:chips}Handy v2.0{} or newer installed",
				},
			},
			better_mouse_and_gamepad_in_hand_selection = {
				text = {
					"{C:mult,s:1.5}Ooopsie...{}",
					" ",
					"Looks like {C:attention}Better Mouse and Gamepad{} is installed.",
					"I have 2 news for you: {C:mult}Bad{} and {C:green}Good{}.",
					" ",
					"{C:mult}Bad news{} is {C:attention}BMaG{} overrides {C:chips}Handy{}'s hand selection entirely",
					"and breaks input for buttons such as",
					"{C:chips}[Wheel Up/Down]{}, {C:chips}[Mouse 3]{}, {C:chips}[Right Mouse]{} and more.",
					" ",
					"{C:green}Good news{} is {C:chips}Handy{} has {C:inactive,s:0.75}almost{} all controls implemented from it",
					"so you can uninstall {C:attention}BMaG{} and don't lose anything.",
					" ",
					"Or, you can continue use {C:attention}both mods{} and mostly you're fine.",
					"{s:0.8}Despite me not liking it, who am I to tell you which mods to use?{}",
				},
			},
			mp_extension_empty = {
				text = {
					"Install {C:mult}Multiplayer{} to get",
					"additional settings here",
					"{C:inactive}1.0 features is Work in Progress{}",
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

			["General"] = "General",
			["Fast hand selection"] = "Hand selection",
			["Speed & Animations"] = "Speed & Animations",
			["Vanilla keybinds"] = "Keybinds",
			["Quick buy/sell/use"] = "Buy, Sell & Use",
			["Highlight movement"] = "Precise selection",
			["Misc"] = "Miscellaneous",
			["Dangerous"] = "Danger Zone",
			["Debug"] = "Dev & Debug",

			["Speed"] = "Speed",
			["Animations"] = "Animations",
			["Hold"] = "Hold",
			["Round"] = "Round",
			["Hand & Round"] = "Hand/Round",
			["Shop & Blind Select"] = "Shop/Blinds",
			["Game"] = "Game",
			["Menus"] = "Menus",
			["MP Extension"] = "Multiplayer",

			["Updater"] = "Mod updates",
			["Updater Settings"] = "Settings",
		},
		v_dictionary = {
			Handy_version_by = "v#1# by #2#",
			Handy_module_keys_single = "[#1#]",
			Handy_module_keys_or = "[#1#] or [#2#]",
			Handy_items_in_queue = "[#1# in queue]",
			Handy_temp_disabled = "[disabled]",
			Handy_disabled_in_mp = "[disabled by Multiplayer]",

			Handy_gamespeed_multiplier = "Game speed multiplier: #1#",
			Handy_event_queue_retriggers_amount = "Event queue acceleration: #1#",
			Handy_animation_skip = "Animations skip: #1#",

			Handy_skip_booster_pack = "Skip booster pack",

			Handy_scoring_hold = "Pause scoring animation",
			Handy_scoring_hold_hand_score = "Hand score: [#1#]",

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
			Handy_binding_esc_hint = "Press #1# to save",
			Handy_binding_guide = "Press keys to add them to combination",

			Handy_reload_run_done = "Run reloaded",
			Handy_reload_run_nothing_to_load = "No run to reload",
			Handy_load_run_done = "Run loaded",
			Handy_load_run_nothing_to_load = "No run to load",

			Handy_prevented_by_debugplus = "Prevented by DebugPlus",
			Handy_log_file_copied = "Lovely log file copied to clipboard",

			Handy_updater_finish_success = "Release installed successfully",
			Handy_updater_finish_no_fetcher = "No available API for requests",
			Handy_updater_finish_no_connection = "Missing interner connection",
			Handy_updater_finish_fetcher_error = "Unexpected error",
			Handy_updater_finish_invalid_server_response = "Invalid server response",
			Handy_updater_finish_no_release = "No release found",
			Handy_updater_finish_check_request_failed = "Cannot check available releases",
			Handy_updater_finish_cannot_write_zip = "Cannot save release files",
			Handy_updater_finish_download_request_failed = "Cannot download release",
			Handy_updater_finish_cannot_unzip = "Cannot extract release files",
			Handy_updater_finish_cannot_move_files = "Cannot install release files",
			Handy_updater_finish_no_data_to_replace = "No release files to install",
			Handy_updater_finish_description = "Restart a game to apply changes",

			Handy_updater_progress_getting_releases = "Getting releases...",
			Handy_updater_progress_downloading_release = "Downloading release...",
			Handy_updater_progress_unzipping_archive = "Unzipping release...",
			Handy_updater_progress_installing_files = "Installing release...",

			Handy_new_pre_release_available = "New Pre-release available",
			Handy_new_stable_available = "New Stable release available",
			Handy_new_release_description = "Go to mod settings for details and download",
			Handy_updater_auto_restart = "Restarting a game to apply changes...",
		},
		dictionary = {
			handy_or = "or",
			handy_disabled = "Disabled",
			handy_mod_enabled = "Mod enabled",
			handy_mod_disabled = "Mod disabled",

			handy_example_state_panel = "Various notifications displayed here",

			ph_handy_premade_presets = "Pre-made config presets",
			ph_handy_custom_presets = "Custom config presets",

			b_handy_mp_extension = "Multiplayer Extension",

			b_handy_preset_save = "Save",
			b_handy_preset_load = "Load",
			b_handy_preset_clear = "Clear",

			handy_preset_name_placeholder = "Preset name",

			b_handy_notif_quick = "Handy actions",
			b_handy_notif_dangerous = "Dangerous actions",

			b_handy_search_placeholder = "Search...",
			b_handy_search = "Search",
			b_handy_clear = "Clear",
			b_handy_open_github = "Open on GitHub",

			ph_handy_notif_quick_use = "Quick use",
			ph_handy_notif_quick_buy_or_sell = "Quick buy or sell",
			ph_handy_notif_quick_buy_n_sell = "Quick buy and immediately sell",
			ph_handy_notif_unsafe_disabled = "Unsafe actions disabled in mod settings",
			ph_handy_notif_unsafe_disabled_by_other_mod = "Unsafe actions disabled by other mod",
			ph_handy_notif_unsafe = "[Unsafe]",
			ph_handy_notif_insta_remove = "Instant REMOVE",
			ph_handy_notif_insta_sell = "Instant sell",
			ph_handy_notif_remove_all = "REMOVE ALL cards/tags in clicked area",
			ph_handy_notif_sell_all = "Sell ALL cards in clicked area",
			ph_handy_notif_remove_all_same = "REMOVE all copies of clicked card/tag",
			ph_handy_notif_sell_all_same = "Sell all copies of clicked card",
			ph_handy_notif_animation_skip_unsafe_disabled = "Unsafe option disabled in mod settings",

			ph_handy_notif_misc_save_run_start = "Starting run saving...",
			ph_handy_notif_misc_save_run_saving = "Saving a run...",
			ph_handy_notif_misc_save_run_saved = "Run saved",
			ph_handy_notif_misc_save_run_interrupt = "Cannot save run right now",

			ph_handy_notif_reload_localization = "Debug: Localization reloaded",
			ph_handy_notif_reload_item_prototypes = "Debug: Item Prototypes reloaded",

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
			handy_advanced_mode_description = "More control & info",

			k_handy_preview_sell = "Sell",
			k_handy_preview_buy = "Buy",
			k_handy_preview_use = "Use",
			k_handy_preview_buy_n_use = "Buy & Use",
			k_handy_preview_buy_n_sell = "Buy & Sell",
			k_handy_preview_remove = "REMOVE",

			handy_mp_speed_multiplier_mode = "Speed Multiplier: lobby max value",
			handy_mp_animation_skip_mode = "Animations Skip: lobby max value",
			handy_mp_dangerous_actions_mode = "Dangerous Actions: lobby mode",
			handy_mp_dangerous_actions_modes = {
				"Disabled",
				"Mass sell",
				"Mass sell & remove",
			},

			handy_regular_keybinds_swappable_overlays_mode = {
				"Press to open",
				"Press to open / Press again to close",
				"Hold to open / Release to close",
			},

			handy_dangerous_actions_mass_sell_remove_mode = {
				"Affect all cards",
				"Affect all but target card",
			},

			handy_show_custom_pip_mode = {
				"None",
				"Gamepad only",
				"Always",
			},

			handy_mp_extension_status_not_initialized = "Multiplayer Extension is NOT LOADED in this lobby",
			handy_mp_extension_status_disabled = "Multiplayer Extension in this lobby is DISABLED by YOU",
			handy_mp_extension_status_disabled_by_ruleset = "Multiplayer Extension in this lobby is DISABLED by RULESET",
			handy_mp_extension_status_disabled_by_other_player = "Multiplayer Extension in this lobby is DISABLED by OTHER players",
			handy_mp_extension_status_enabled = "Multiplayer Extension in this lobby is ENABLED",

			handy_updater_no_release_found = "No release data found",
			handy_updater_status_no_data = "No release data",
			handy_updater_status_current_version = "Current version",
			handy_updater_status_already_installed = "Installed - Restart a game",
			handy_updater_status_busy = "Please wait...",
			handy_updater_status_ready_for_installation = "Ready for installation",
			handy_updater_status_new_version_available = "New version available",
			b_handy_install = "Install",
			b_handy_restart_game = "Restart game",

			handy_release_type_stable = "Stable",
			handy_release_type_pre_release = "Pre-release",

			handy_smods_compat_mode = "Compat mode: loading from .zip archive require updated SMODS!",

			handy_gamepad_2step_select = "to select",
			handy_gamepad_2step_adjust = "to adjust",
			handy_gamepad_2step_deselect = "to deselect",
		},
	},
}
