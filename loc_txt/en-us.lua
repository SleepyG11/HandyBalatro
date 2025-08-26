return {
	descriptions = {
		-- For all checkboxes and popups, first var is keybind
		-- Further mentioned vars starts from #2#
		Handy_ConfigCheckbox = {
			-- Vars: version, author
			handy = {
				unlock = { "HandyBalatro v#2#", "by {C:white,E:2,s:1.15}#3#{}" },
				text = {
					"Uncheck to disable {C:attention}ALL{} mod features",
					"{C:handy_secondary}(no restart required){}",
				},
			},
			hide_options_button = {
				unlock = { "Hide mod button", "in options menu" },
				text = {
					"{C:handy_secondary}Only when Steamodded installed{}",
				},
			},
			debugplus_prevent = {
				unlock = { "DebugPlus:", "prevent actions" },
				text = { "Prevent any Handy keybinds", "when {C:chips}#2#{} is hold" },
			},
			regular_keybinds = {
				unlock = { "Regular keybinds" },
				text = {
					"Use keybinds for",
					"common game actions",
				},
			},
			-- Vars: [Left Mouse]
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
			-- Vars: [Left Mouse]
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
			-- Vars: [Fast hand selection]
			insta_unhighlight = {
				unlock = {
					"Fast hand",
					"deselection",
				},
				text = {
					"Allow {C:edition}#2#{}",
					"to deselect cards aswell",
				},
			},
			show_deck_preview = {
				unlock = { "Deck preview" },
				text = {
					"Hold {C:chips}#1#{} to",
					"show deck preview",
				},
			},
			-- Vars: [Right Mouse]
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
			-- Vars: Buy/Sell/Use mode
			insta_buy_or_sell = {
				unlock = { "Quick buy/sell" },
				text = {
					"Use {C:chips}#1#{} to",
					"buy or sell card",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_n_sell = {
				unlock = { "Quick buy'n'sell" },
				text = {
					"Use {C:chips}#1#{} to",
					"buy card and sell",
					"immediately after",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_use = {
				unlock = { "Quick use" },
				text = {
					"Use {C:chips}#1#{} to",
					"use card if possible",
				},
			},
			-- Vars: Buy/Sell/Use mode
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
			-- Vars: [keybind for Multiply], [keybind for Divide], min value, max value
			speed_multiplier = {
				unlock = { "Speed multiplier" },
				text = {
					"Hold {C:chips}#1#{} and",
					"{C:chips}#2#{}/{C:chips}#3#{} to",
					"multiply/divide game speed",
				},
			},
			-- Vars: [Speed Multiplier]
			speed_multiplier_no_hold = {
				unlock = { "Speed multiplier:", "No hold" },
				text = {
					"Decrease amount of",
					"keybinds needed to use",
					"#2#",
				},
			},
			insta_highlight_entire_f_hand = {
				unlock = { "Highlight", "entire hand" },
				text = {
					"Press {C:chips}#1#{} to",
					"highlight entire hand",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab]
			nopeus_interaction = {
				unlock = { "Nopeus:", "fast-forward" },
				text = {
					"Hold {C:chips}#1#{} and",
					"{C:chips}#2#{}/{C:chips}#3#{} to",
					"increase/decrease fast-forward setting",
				},
			},
			-- Vars: [Nopeus: fast-forward]
			nopeus_interaction_no_hold = {
				unlock = { "Nopeus:", "No hold" },
				text = {
					"Decrease amount of",
					"keybinds needed to use",
					"#2#",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab], None, Messages, Animations, Everything, Unsafe, [Danger zone tab]
			animation_skip = {
				unlock = { "Animation skip" },
				text = {
					"Hold {C:chips}#1#{} and",
					"{C:chips}#2#{}/{C:chips}#3#{} to",
					"increase/decrease animation skip",
				},
			},
			-- Vars: [Animation skip]
			animation_skip_no_hold = {
				unlock = { "Animation skip:", "No hold" },
				text = {
					"Decrease amount of",
					"keybinds needed to use",
					"#2#",
				},
			},
			scoring_hold = {
				unlock = { "Pause scoring", "animation" },
				text = {
					"Hold {C:chips}#1#{} to",
					"pause scoring animation after",
					"counting total hand score",
				},
			},
			scoring_hold_any_moment = {
				unlock = { "Pause scoring", "in any moment" },
				text = {
					"Allow #2# to",
					"pause in any moment of",
					"scoring animation",
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
			-- Vars: [keybind for Quick buy/sell], [Quick buy/sell], ["Dangerous" modifier]
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
			speed_multiplier_uncap = {
				unlock = { "Speed multiplier:", "uncap" },
				text = {
					"Allow increase game speed",
					"to insane values",
				},
			},
			-- Vars: [Animation skip]
			animation_skip_unsafe = {
				unlock = { "Animation skip:", "unsafe" },
				text = {
					"Allow increase",
					"setting to {C:mult}#2#{}",
				},
			},
			-- Vars: [keybind for Quick buy/sell], ["Dangerous" modifier], ["All copies" modifier]
			sell_all_same = {
				unlock = { "Sell all", "card copies" },
				text = {
					"Hold {C:mult}#2#{}, hold {C:mult}#1#{},",
					"and click on card to sell",
					"all of their copies",
				},
			},
			-- Vars: ["Dangerous" modifier], ["Sell ALL" modifier]
			sell_all = {
				unlock = { "Sell ALL" },
				text = {
					"Hold {C:mult}#1#{} to sell {C:attention}ALL{}",
					"cards in area instead",
				},
			},
			-- Vars: ["Dangerous" modifier], ["REMOVE" modifier], [Quick buy/sell], ["All copies" modifier], ["ALL" modifier]
			card_remove = {
				unlock = { "REMOVE* cards", "or skip tags" },
				text = {
					"Hold {C:mult}#1#{} to {C:attention,E:1}REMOVE{} cards",
					"{C:handy_secondary}(works for skip tags){}",
				},
			},
			controller_swap_cursor_stick = {
				unlock = { "Controller: swap", "cursor stick" },
				text = {
					"Swap behaviour of",
					"Left and Right Sticks",
				},
			},
			controller_sensivity = {
				unlock = { "Controller: adjust", "cursor sensitivity" },
				text = {
					"Allow to change sensitivity",
					"of controller's cursor",
				},
			},
		},
		Handy_ConfigPopup = {
			debugplus_prevent = {
				text = {
					"Require mod {C:attention}DebugPlus{} and enabled",
					"{C:attention}CTRL for Keybinds{} option to work",
				},
			},
			regular_keybinds = {
				text = {
					"Play hand, Discard, hand sorting,",
					"Reroll shop, Leave shop, Select blind,",
					"Skip blind, View deck, Run info",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight = {
				text = {
					"If key set to {C:chips}#2#{},",
					"start holding key {C:attention}OUTSIDE{} of cards",
					"and then hover them to highlight",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_gamepad = {
				text = {
					"Works both for cursor and movement",
					"via direction buttons",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_OUTSIDE = {
				text = {
					"For keys other than {C:chips}#2#{},",
					"start holding keybind while hover",
					"a card will work as well",
				},
			},
			-- Vars: [Left Mouse]
			insta_highlight_OUTSIDE_gamepad = {
				text = {
					"Works both for cursor and movement",
					"via direction buttons",
				},
			},
			-- Vars: [Fast hand selection]
			insta_unhighlight = {
				text = {
					"Select cards if first card was not selected.",
					"Deselect cards if first card was selected.",
				},
			},
			-- Vars: [Right Mouse]
			deselect_hand_desktop = {
				text = {
					"Replaces vanilla {C:chips}#2#{}",
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
			move_highlight_gamepad = {
				text = {
					"{C:mult}Have no effect on gamepad{}",
				},
			},
			-- Vars: [keybind for Multiply], [keybind for Divide], min value, max value
			speed_multiplier = {
				text = {
					"Game speed can be changed in",
					"range from {C:attention}#4#{} to {C:attention}#5#{}",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab]
			nopeus_interaction = {
				text = {
					"Required mod {C:attention}Nopeus{} to work",
					" ",
					"{C:mult}Unsafe{} option must be",
					"enabled in {C:attention}#4#{} tab",
				},
			},
			-- Vars: [keybind for Increase], [keybind for Decrease], [Danger zone tab], None, Messages, Animations, Everything, Unsafe, [Danger zone tab]
			animation_skip = {
				text = {
					"5 levels of animation skip are present",
					" ",
					"{C:attention}#4#{} - default game behaviour",
					"{C:attention}#5#{} - removed card texts like {C:attention}Again!{} and {C:chips}+Chips{}",
					"{C:attention}#6#{} - instant scoring, removed cards wiggling",
					"{C:attention}#7#{} - removed unnecessary animations, instant cards draw and restart",
					"{C:mult}#8#{} - game's absolute limit: everything instant",
					" ",
					"{C:mult}#8#{} option must be enabled in {C:attention}#9#{} tab",
				},
			},
			scoring_hold = {
				text = {
					"Useful for shuffling jokers or checking",
					"a score before end of round on",
					"high game speed or skipped animations",
				},
			},
			not_just_yet_interaction = {
				text = {
					"Required mod {C:attention}NotJustYet{} to work",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_or_sell_desktop = {
				text = {
					"Usage determined by {C:attention}#2#{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_or_sell_gamepad = {
				text = {
					"Replaces vanilla {C:chips}#3#{}",
					"but works the same and",
					"can be reassigned to other key",
					" ",
					"Uncheck to use vanilla control",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_buy_n_sell_desktop = {
				text = {
					"Usage determined by {C:attention}#2#{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_use_desktop = {
				text = {
					"Usage determined by {C:attention}#2#{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
			insta_use_gamepad = {
				text = {
					"Replaces vanilla {C:chips}#3#{}",
					"but works the same and",
					"can be reassigned to other key",
					" ",
					"Uncheck to use vanilla control",
				},
			},
			-- Vars: Buy/Sell/Use mode
			cryptid_code_use_last_interaction = {
				text = {
					"Required mod {C:attention}Cryptid{} to work",
					" ",
					"Shortcut for using a code card and selecting",
					"{C:green}[Input previous value]{} option for:",
					"{C:spectral}://POINTER{}, {C:green}://VARIABLE{}, {C:green}://CLASS{}, {C:green}://EXPLOIT{}",
					" ",
					"Usage determined by {C:attention}#2#{}",
				},
			},
			-- Vars: Buy/Sell/Use mode
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
			-- Vars: [keybind for Quick buy/sell], [Quick buy/sell], ["Dangerous" modifier]
			immediate_buy_and_sell = {
				text = {
					"Hold {C:mult}#3#{}, {C:chips}#4#{},",
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
					"{C:attention}Always active on gamepad{}",
				},
			},
			speed_multiplier_uncap = {
				text = {
					"{C:mult}Drastically hurts performance{}",
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
			-- Vars: [keybind for Quick buy/sell], ["Dangerous" modifier], ["All copies" modifier]
			sell_all_same = {
				text = {
					"Hold {C:mult}#3#{}, {C:mult}#4#{},",
					"and click on card to sell all of their copies",
				},
			},
			-- Vars: ["Dangerous" modifier], ["Sell ALL" modifier]
			sell_all = {
				text = {
					"Hold {C:mult}#2#{}, {C:mult}#3#{},",
					"and click on card to sell {C:attention}ALL{} cards in area",
				},
			},
			-- Vars: ["Dangerous" modifier], ["REMOVE" modifier], [Quick buy/sell], ["All copies" modifier], ["ALL" modifier]
			card_remove = {
				text = {
					"When hold, instead of selling cards {C:attention}or skip tags{} will be {C:attention,E:1}REMOVED{}",
					" ",
					"Hold {C:mult}#2#{}, {C:mult}#3#{}, {C:chips}#4#{}",
					"and hover cards to {C:attention,E:1}REMOVE{} them (queue also applied)",
					" ",
					"Hold {C:mult}#2#{}, {C:mult}#3#{}, {C:mult}#5#{}",
					"and click on card {C:attention}or skip tag{} to {C:attention,E:1}REMOVE{} all of their copies",
					" ",
					"Hold {C:mult}#2#{}, {C:mult}#3#{}, {C:mult}#6#{},",
					"and click on card {C:attention}or skip tag{} to {C:attention,E:1}REMOVE{} {C:attention}ALL{} of them",
				},
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
		handy_keybind_labels = {
			play_hand = "Play hand",
			discard = "Discard",
			toggle_sort = "Toggle sort",
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
			reroll_boss = "Reroll boss",
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
			speed_multiplier_multiply = "Speed multiplier: Multiply",
			speed_multiplier_divide = "Speed multiplier: Divide",
			nopeus_interaction = "Nopeus: fast-forward",
			nopeus_interaction_increase = "Nopeus: Increase",
			nopeus_interaction_decrease = "Nopeus: Decrease",
			animation_skip = "Animation skip",
			animation_skip_increase = "Animation skip: Increase",
			animation_skip_decrease = "Animation skip: Decrease",
			move_highlight_one_left = "Move one left",
			move_highlight_one_right = "Move one right",
			move_highlight_move_card = "Move card",
			move_highlight_to_end = "Move to end",

			dangerous_modifier = '"Dangerous" modifier',
			dangerous_all_same_modifier = '"All copies" modifier',
			dangerous_all_modifier = '"ALL" modifier',
			dangerous_remove_modifier = '"REMOVE" modifier',

			scoring_hold = "Pause scoring animation",

			presets_load_1 = "Load preset 1",
			presets_load_2 = "Load preset 2",
			presets_load_3 = "Load preset 3",
			presets_load_next = "Load next preset",

			misc_open_mod_settings = "Open mod settings",
			misc_crash = "Crash a game",
			misc_save_run = "Save run",
			misc_quick_restart = "Quick restart",
		},
		handy_keybind_sections = {
			hand = "Hand",
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
			hand_selection = "Hand selection",
			presets = "Presets",
			dangerous_actions = "Dangerous actions",
			misc = "Miscellaneous",
		},
		handy_tabs = {
			["Overall"] = "General & Vanilla",
			["Quick"] = "Quick actions",
			["Keybinds"] = "Regular keybinds",
			["Keybinds 2"] = "Other keybinds",
			["Dangerous"] = "Danger zone",
			["Presets"] = "Presets",
			["Keybinds Paginated"] = "Keybinds",
			["Search"] = "Search",
		},
		v_dictionary = {
			Handy_module_keys_single = "[#1#]",
			Handy_module_keys_or = "[#1#] or [#2#]",
			Handy_items_in_queue = "[#1# in queue]",
			Handy_gamespeed_multiplier = "Game speed multiplier: #1#",
			Handy_event_queue_retriggers_amount = "Event queue acceleration: #1#",
			Handy_nopeus_fastforward = "Nopeus fast-forward: #1#",
			Handy_animation_skip = "Animation skip: #1#",
			Handy_skip_booster_pack = "Skip booster pack",

			Handy_scoring_hold = "Pause scoring animation",

			Handy_hand_sorting = "Hand sorting: #1#",

			Handy_preset_index = "Preset #1#",
			Handy_preset_loaded = "Preset #1# [#2#] loaded",
			Handy_preset_empty = "Preset #1# [#2#] is empty",
			Handy_preset_disabled = "Preset #1# [#2#] is disabled",
			Handy_preset_nothing_to_load = "No presets to load",

			Handy_overall_guide_button = 'Each control can be assigned to mouse button, mouse wheel or keyboard key in "#1#" tab.',
			Handy_overall_guide_gamepad = 'Each control can be assigned to any gamepad buttons in "#1#" tab.',
			Handy_popups_guide = "Hover controls to see more info about them.",
			Handy_popups_guide_gamepad = "Move between controls to see more info about them.",
			Handy_search_guide = 'Use "#1#" tab for search.',
			Handy_keybinds_guide_desktop = "Click on a button and next inputted key will be assigned. #1# to unbind.",
			Handy_keybinds_guide_gamepad = "#2# on a button and next inputted key will be assigned. #1# to unbind.",
			Handy_presets_guide = "Preset - set of configs and keybinds which can be applied in any time",
			Handy_danger_zone_guide = "*REMOVE card/tag - delete without any checks, effects, triggers or money refunds.",

			Handy_default_value = "#1#: default value",
		},
		dictionary = {
			handy_or = "or",

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
			ph_handy_search_no_results = 'Use keywords like "more speed", "animations", "sell" etc.',

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
			ph_handy_notif_cannot_bind_non_holdable = "Cannot bind mouse wheel here",
			ph_handy_notif_cannot_bind_non_safe = "Cannot bind this button here",

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

			b_handy_device_select = "Input device",
			handy_device_opt = {
				[1] = "Auto",
				[2] = "Mouse + Keyboard",
				[3] = "Gamepad",
			},
		},
	},
}
