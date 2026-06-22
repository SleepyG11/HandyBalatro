Handy.dictionary.register({
	key = "regular_keybinds",
	order = 13,

	keywords = { "basic vanilla regular common default keybinds" },
	get_module = function(self)
		return Handy.cc.regular_keybinds
	end,

	checkbox = true,
})

--

Handy.dictionary.register({
	key = "regular_keybinds_group_game",
	parent = "regular_keybinds",
	order = 1,

	kywords = { "general game" },
})

Handy.dictionary.register({
	key = "regular_keybinds_restart",
	parent = "regular_keybinds_group_game",
	order = 1,

	keywords = { "vanilla run game restart" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_restart
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,
	loc_vars = function()
		return {
			vars = { Handy.L.brackets(Handy.L.keys("R")) },
		}
	end,
	no_mp = true,

	checkbox = {
		advanced = true,
	},
	keybind = {
		allow_multiple = true,
		only_holdable = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_quick_restart",
	parent = "regular_keybinds_group_game",
	order = 2,

	keywords = { "vanilla fast quick run game restart instant without animation no animations instant" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_quick_restart
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,
	loc_vars = function()
		return {
			vars = { Handy.L.brackets(Handy.L.keys("R")) },
		}
	end,
	no_mp = true,

	checkbox = {
		advanced = true,
	},
	keybind = {
		allow_multiple = true,
		only_safe = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_save_run",
	parent = "regular_keybinds_group_game",
	order = 3,

	keywords = { "save run" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_save_run
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,
	no_mp = true,

	checkbox = {
		advanced = true,
	},
	keybind = {
		allow_multiple = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_reload_run",
	parent = "regular_keybinds_group_game",
	order = 4,

	keywords = { "reload start run" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_reload_run
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,
	no_mp = true,

	checkbox = {
		advanced = true,
	},
	keybind = {
		allow_multiple = true,
		only_safe = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_restart_game",
	parent = "regular_keybinds_group_game",
	order = 5,

	keywords = { "restart game balatro" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_restart_game
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,
	no_mp = true,

	checkbox = {
		advanced = true,
	},
	keybind = {
		allow_multiple = true,
		only_safe = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_copy_log_file",
	parent = "regular_keybinds_group_game",
	order = 6,

	keywords = { "copy lovely log file get logs files" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_copy_log_file
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	checkbox = {
		advanced = true,
	},
	keybind = {
		allow_multiple = true,
	},
})

--

Handy.dictionary.register({
	key = "regular_keybinds_group_hand",
	parent = "regular_keybinds",
	order = 2,

	keywords = { "hand" },
})

Handy.dictionary.register({
	key = "regular_keybinds_play",
	parent = "regular_keybinds_group_hand",
	order = 1,

	keywords = { "play hand" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_play
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_discard",
	parent = "regular_keybinds_group_hand",
	order = 2,

	keywords = { "discard hand" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_discard
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_change_sort_rank",
	parent = "regular_keybinds_group_hand",
	order = 3,

	keywords = { "sort hand rank" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_sort_by_rank
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_change_sort_suit",
	parent = "regular_keybinds_group_hand",
	order = 4,

	keywords = { "sort hand suit" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_sort_by_suit
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_toggle_sort",
	parent = "regular_keybinds_group_hand",
	order = 5,

	keywords = { "sort hand rank suit toggle switch next" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_toggle_sort
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})

--

Handy.dictionary.register({
	key = "regular_keybinds_group_round",
	parent = "regular_keybinds",
	order = 3,

	keywords = { "round" },
})

Handy.dictionary.register({
	key = "regular_keybinds_cash_out",
	parent = "regular_keybinds_group_round",
	order = 1,

	keywords = { "cash out cashout" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_cash_out
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_not_just_yet_interaction",
	parent = "regular_keybinds_group_round",
	order = 2,

	keywords = { "not just yet notjustyet end round njy" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_not_just_yet_interaction, { Handy.D.dictionary.regular_keybinds }
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,
	mod_deps = {
		["NotJustYet"] = "required",
	},

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_start_fantoms_preview",
	parent = "regular_keybinds_group_round",
	order = 3,

	keywords = { "multiplayer mp bmp score hand preview fantoms fantom calculate button calc" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_start_fantoms_preview
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,
	mod_deps = {
		["Multiplayer"] = "required",
	},

	checkbox = {
		advanced = true,
	},
	keybind = {
		allow_multiple = true,
	},
})

--

Handy.dictionary.register({
	key = "regular_keybinds_group_shop",
	parent = "regular_keybinds",
	order = 4,

	keywords = { "shop" },
})

Handy.dictionary.register({
	key = "regular_keybinds_skip_booster",
	parent = "regular_keybinds_group_shop",
	order = 1,

	keywords = { "booster pack packs boosters skip" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_skip_booster
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_reroll_shop",
	parent = "regular_keybinds_group_shop",
	order = 2,

	keywords = { "shop roll reroll one more" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_reroll_shop
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_leave_shop",
	parent = "regular_keybinds_group_shop",
	order = 3,

	keywords = { "go next leave shop" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_leave_shop
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})

--

Handy.dictionary.register({
	key = "regular_keybinds_group_blind_select",
	parent = "regular_keybinds",
	order = 5,
})

Handy.dictionary.register({
	key = "regular_keybinds_skip_blind",
	parent = "regular_keybinds_group_blind_select",
	order = 1,

	keywords = { "skip blind" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_skip_blind
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_select_blind",
	parent = "regular_keybinds_group_blind_select",
	order = 2,

	keywords = { "select start round blind" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_select_blind
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_reroll_boss",
	parent = "regular_keybinds_group_blind_select",
	order = 3,

	keywords = { "reroll boss blind directors cut retcon director" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_reroll_boss
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})

--

Handy.dictionary.register({
	key = "regular_keybinds_group_swappable_menus",
	parent = "regular_keybinds",
	order = 6,
	keywords = { "ui menus panels" },
})

Handy.dictionary.register({
	key = "regular_keybinds_swappable_overlays_mode",
	parent = "regular_keybinds_group_swappable_menus",
	order = 1,

	keywords = { "in game ingame swappable menus mode hold to open release to close double press again" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_swappable_overlays_mode
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	option_cycle = {
		get_values = function()
			return {
				options = {
					Handy.L.dictionary("handy_regular_keybinds_swappable_overlays_mode", 1),
					Handy.L.dictionary("handy_regular_keybinds_swappable_overlays_mode", 2),
					Handy.L.dictionary("handy_regular_keybinds_swappable_overlays_mode", 3),
				},
			}
		end,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_run_info",
	parent = "regular_keybinds_group_swappable_menus",
	order = 2,

	keywords = { "run info poker hands pokerhands" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_run_info
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_run_info_blinds",
	parent = "regular_keybinds_group_swappable_menus",
	order = 3,

	keywords = { "run info blinds current ante" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_run_info_blinds
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_view_deck",
	parent = "regular_keybinds_group_swappable_menus",
	order = 4,

	keywords = { "open view deck" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_view_deck
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_view_lobby_info",
	parent = "regular_keybinds_group_swappable_menus",
	order = 5,

	keywords = { "multiplayer lobby info players" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_lobby_info
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,
	mod_deps = {
		["Multiplayer"] = "required",
	},

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})

--

Handy.dictionary.register({
	key = "regular_keybinds_group_menus",
	parent = "regular_keybinds",
	order = 7,

	keywords = { "ui menus panels menus" },
})

Handy.dictionary.register({
	key = "regular_keybinds_show_deck_preview",
	parent = "regular_keybinds_group_menus",
	order = 1,

	keywords = { "deck preview summary peek" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_show_deck_preview
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
		only_holdable = true,
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_options",
	parent = "regular_keybinds_group_menus",
	order = 2,

	keywords = { "game options esc escape menu" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_options
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,
	loc_vars = function()
		return {
			vars = { Handy.L.brackets(Handy.L.keys("Escape")) },
		}
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_collection",
	parent = "regular_keybinds_group_menus",
	order = 3,

	keywords = { "collection menu" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_collection
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_mod_settings",
	parent = "regular_keybinds_group_menus",
	order = 4,

	keywords = { "handy mod settings config" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_mod_settings
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,

	keybind = {
		allow_multiple = "advanced",
	},
	checkbox = {
		advanced = true,
	},
})
