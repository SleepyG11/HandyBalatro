Handy.dictionary.register({
	key = "regular_keybinds",
	get_module = function(self)
		return Handy.cc.regular_keybinds
	end,
	checkbox = true,
	keywords = { "vanilla regular common default keybinds" },
})

--

Handy.dictionary.register({
	key = "regular_keybinds_group_game",
	parent = "regular_keybinds",
	kywords = { "general game" },
})

Handy.dictionary.register({
	key = "regular_keybinds_restart",
	parent = "regular_keybinds_group_game",
	keywords = { "vanilla game restart" },
	checkbox = {
		advanced = true,
	},
	keybind = {
		allow_multiple = true,
		only_holdable = true,
	},
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
})
Handy.dictionary.register({
	key = "regular_keybinds_quick_restart",
	parent = "regular_keybinds_group_game",
	keywords = { "vanilla quick game restart instant without animation no animations instant" },
	checkbox = {
		advanced = true,
	},
	keybind = {
		allow_multiple = true,
		only_safe = true,
	},
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
})
Handy.dictionary.register({
	key = "regular_keybinds_save_run",
	parent = "regular_keybinds_group_game",
	keywords = { "save run" },
	checkbox = {
		advanced = true,
	},
	keybind = {
		allow_multiple = true,
	},
	get_module = function(self)
		return Handy.cc.regular_keybinds_save_run
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,
	no_mp = true,
})
Handy.dictionary.register({
	key = "regular_keybinds_reload_run",
	parent = "regular_keybinds_group_game",
	keywords = { "reload start run" },
	checkbox = {
		advanced = true,
	},
	keybind = {
		allow_multiple = true,
		only_safe = true,
	},
	get_module = function(self)
		return Handy.cc.regular_keybinds_reload_run
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,
	no_mp = true,
})
Handy.dictionary.register({
	key = "regular_keybinds_restart_game",
	parent = "regular_keybinds_group_game",
	keywords = { "restart game" },
	checkbox = {
		advanced = true,
	},
	keybind = {
		allow_multiple = true,
		only_safe = true,
	},
	get_module = function(self)
		return Handy.cc.regular_keybinds_restart_game
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,
	no_mp = true,
})
Handy.dictionary.register({
	key = "regular_keybinds_copy_log_file",
	parent = "regular_keybinds_group_game",
	keywords = { "copy lovely log file get" },
	checkbox = {
		advanced = true,
	},
	keybind = {
		allow_multiple = true,
	},
	get_module = function(self)
		return Handy.cc.regular_keybinds_copy_log_file
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,
})

--

Handy.dictionary.register({
	key = "regular_keybinds_group_hand",
	parent = "regular_keybinds",
	keywords = { "hand" },
})

Handy.dictionary.register({
	key = "regular_keybinds_play",
	parent = "regular_keybinds_group_hand",
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
	keywords = { "sort hand rank suit toggle switch" },
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
	keywords = { "round" },
})

Handy.dictionary.register({
	key = "regular_keybinds_cash_out",
	parent = "regular_keybinds_group_round",
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
	keywords = { "not just jet notjustyet end round" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_not_just_yet_interaction, { Handy.D.dictionary.regular_keybinds }
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
	mod_deps = {
		["NotJustYet"] = "required",
	},
})
Handy.dictionary.register({
	key = "regular_keybinds_start_fantoms_preview",
	parent = "regular_keybinds_group_round",
	keywords = { "multiplayer mp score hand preview fantoms" },
	checkbox = {
		advanced = true,
	},
	keybind = {
		allow_multiple = true,
	},
	get_module = function(self)
		return Handy.cc.regular_keybinds_start_fantoms_preview
	end,
	get_deps = function(self)
		return { Handy.D.dictionary.regular_keybinds }
	end,
	mod_deps = {
		["Multiplayer"] = "required",
	},
})

--

Handy.dictionary.register({
	key = "regular_keybinds_group_shop",
	parent = "regular_keybinds",
	keywords = { "shop" },
})

Handy.dictionary.register({
	key = "regular_keybinds_skip_booster",
	parent = "regular_keybinds_group_shop",
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
	keywords = { "reroll one more" },
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
})

Handy.dictionary.register({
	key = "regular_keybinds_skip_blind",
	parent = "regular_keybinds_group_blind_select",
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
	keywords = { "ui menus panels menus" },
})

Handy.dictionary.register({
	key = "regular_keybinds_swappable_overlays_mode",
	parent = "regular_keybinds_group_swappable_menus",
	keywords = { "swappable menus mode hold to open release to close double press again" },
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
	keywords = { "run info poker hands" },
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
	keywords = { "multiplayer lobby info players" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_lobby_info
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
	mod_deps = {
		["Multiplayer"] = "required",
	},
})

--

Handy.dictionary.register({
	key = "regular_keybinds_group_menus",
	keywords = { "ui menus panels menus" },
	parent = "regular_keybinds",
})

Handy.dictionary.register({
	key = "regular_keybinds_show_deck_preview",
	parent = "regular_keybinds_group_menus",
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
	keywords = { "game options esc escape menu" },
	get_module = function(self)
		return Handy.cc.regular_keybinds_options
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
	loc_vars = function()
		return {
			vars = { Handy.L.brackets(Handy.L.keys("Escape")) },
		}
	end,
})
Handy.dictionary.register({
	key = "regular_keybinds_collection",
	parent = "regular_keybinds_group_menus",
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
