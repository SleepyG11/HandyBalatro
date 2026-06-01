Handy.dictionary.register({
	key = "regular_keybinds",
	get_module = function(self)
		return Handy.cc.regular_keybinds
	end,
	checkbox = true,
	keywords = { "vanilla regular common default keybinds" },

	items = {
		{
			key = "regular_keybinds_group_game",
			kywords = { "general game" },

			items = {
				{
					key = "regular_keybinds_restart",
					keywords = { "vanilla game restart" },
					checkbox = {
						advanced = true,
					},
					keybind = {
						allow_multiple = true,
						only_holdable = true,
					},
					get_module = function(self)
						return Handy.cc.regular_keybinds_restart, { Handy.D.dictionary.regular_keybinds }
					end,
					loc_vars = function()
						return {
							vars = { Handy.L.brackets(Handy.L.keys("R")) },
						}
					end,
					no_mp = true,
				},
				{
					key = "regular_keybinds_quick_restart",
					keywords = { "vanilla quick game restart instant without animation no animations instant" },
					checkbox = {
						advanced = true,
					},
					keybind = {
						allow_multiple = true,
						only_safe = true,
					},
					get_module = function(self)
						return Handy.cc.regular_keybinds_quick_restart, { Handy.D.dictionary.regular_keybinds }
					end,
					loc_vars = function()
						return {
							vars = { Handy.L.brackets(Handy.L.keys("R")) },
						}
					end,
					no_mp = true,
				},
				{
					key = "regular_keybinds_save_run",
					keywords = { "save run" },
					checkbox = {
						advanced = true,
					},
					keybind = {
						allow_multiple = true,
					},
					get_module = function(self)
						return Handy.cc.regular_keybinds_save_run, { Handy.D.dictionary.regular_keybinds }
					end,
					no_mp = true,
				},
				{
					key = "regular_keybinds_reload_run",
					keywords = { "reload start run" },
					checkbox = {
						advanced = true,
					},
					keybind = {
						allow_multiple = true,
						only_safe = true,
					},
					get_module = function(self)
						return Handy.cc.regular_keybinds_reload_run, { Handy.D.dictionary.regular_keybinds }
					end,
					no_mp = true,
				},
				{
					key = "regular_keybinds_restart_game",
					keywords = { "restart game" },
					checkbox = {
						advanced = true,
					},
					keybind = {
						allow_multiple = true,
						only_safe = true,
					},
					get_module = function(self)
						return Handy.cc.regular_keybinds_restart_game, { Handy.D.dictionary.regular_keybinds }
					end,
					no_mp = true,
				},
				{
					key = "regular_keybinds_copy_log_file",
					keywords = { "copy lovely log file get" },
					checkbox = {
						advanced = true,
					},
					keybind = {
						allow_multiple = true,
					},
					get_module = function(self)
						return Handy.cc.regular_keybinds_copy_log_file, { Handy.D.dictionary.regular_keybinds }
					end,
				},
			},
		},
		{
			key = "regular_keybinds_group_hand",
			keywords = { "hand" },

			items = {
				{
					key = "regular_keybinds_play",
					keywords = { "play hand" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_play, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},
				{
					key = "regular_keybinds_discard",
					keywords = { "discard hand" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_discard, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},
				{
					key = "regular_keybinds_change_sort_rank",
					keywords = { "sort hand rank" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_sort_by_rank, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},
				{
					key = "regular_keybinds_change_sort_suit",
					keywords = { "sort hand suit" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_sort_by_suit, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},
				{
					key = "regular_keybinds_toggle_sort",
					keywords = { "sort hand rank suit toggle switch" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_toggle_sort, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},
			},
		},
		{
			key = "regular_keybinds_group_round",
			keywords = { "round" },

			items = {
				{
					key = "regular_keybinds_cash_out",
					keywords = { "cash out cashout" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_cash_out, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},
				{
					key = "regular_keybinds_not_just_yet_interaction",
					keywords = { "not just jet notjustyet end round" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_not_just_yet_interaction,
							{ Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
					mods_deps = {
						["NotJustYet"] = "required",
					},
				},
				{
					key = "regular_keybinds_start_fantoms_preview",
					keywords = { "multiplayer mp score hand preview fantoms" },
					checkbox = {
						advanced = true,
					},
					keybind = {
						allow_multiple = true,
					},
					get_module = function(self)
						return Handy.cc.regular_keybinds_start_fantoms_preview, { Handy.D.dictionary.regular_keybinds }
					end,
					mods_deps = {
						["Multiplayer"] = "required",
					},
				},
			},
		},
		{
			key = "regular_keybinds_group_shop",
			keywords = { "shop" },

			items = {
				{
					key = "regular_keybinds_skip_booster",
					keywords = { "booster pack packs boosters skip" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_skip_booster, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},
				{
					key = "regular_keybinds_reroll_shop",
					keywords = { "reroll one more" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_reroll_shop, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},
				{
					key = "regular_keybinds_leave_shop",
					keywords = { "go next leave shop" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_leave_shop, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},
			},
		},
		{
			key = "regular_keybinds_group_blind_select",

			items = {
				{
					key = "regular_keybinds_skip_blind",
					keywords = { "skip blind" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_skip_blind, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},
				{
					key = "regular_keybinds_select_blind",
					keywords = { "select start round blind" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_select_blind, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},
				{
					key = "regular_keybinds_reroll_boss",
					keywords = { "reroll boss blind directors cut retcon director" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_reroll_boss, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},
			},
		},

		{
			key = "regular_keybinds_group_swappable_menus",
			keywords = { "ui menus panels menus" },

			items = {
				{
					key = "regular_keybinds_swappable_overlays_mode",
					keywords = { "swappable menus mode hold to open release to close double press again" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_swappable_overlays_mode,
							{ Handy.D.dictionary.regular_keybinds }
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
				},
				{
					key = "regular_keybinds_run_info",
					keywords = { "run info poker hands" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_run_info, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},
				{
					key = "regular_keybinds_run_info_blinds",
					keywords = { "run info blinds current ante" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_run_info_blinds, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},

				{
					key = "regular_keybinds_view_deck",
					keywords = { "open view deck" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_view_deck, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},

				{
					key = "regular_keybinds_view_lobby_info",
					keywords = { "multiplayer lobby info players" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_lobby_info, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
					mods_deps = {
						["Multiplayer"] = "required",
					},
				},
			},
		},
		{
			key = "regular_keybinds_group_menus",
			keywords = { "ui menus panels menus" },

			items = {
				{
					key = "regular_keybinds_show_deck_preview",
					keywords = { "deck preview summary peek" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_show_deck_preview, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
						only_holdable = true,
					},
					checkbox = {
						advanced = true,
					},
				},
				{
					key = "regular_keybinds_options",
					keywords = { "game options esc escape menu" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_options, { Handy.D.dictionary.regular_keybinds }
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
				},
				{
					key = "regular_keybinds_collection",
					keywords = { "collection menu" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_collection, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},

				{
					key = "regular_keybinds_mod_settings",
					keywords = { "handy mod settings config" },
					get_module = function(self)
						return Handy.cc.regular_keybinds_mod_settings, { Handy.D.dictionary.regular_keybinds }
					end,
					keybind = {
						allow_multiple = "advanced",
					},
					checkbox = {
						advanced = true,
					},
				},
			},
		},
	},
})
