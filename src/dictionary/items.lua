local items_list = {}

local function l(item)
	table.insert(items_list, item)
end

l({
	key = "general",

	keywords = { "general global common" },
	loc_vars = function()
		return {
			vars = { Handy.version, "SleepyG11" },
		}
	end,

	group = true,
	items = {
		{
			key = "handy",

			keywords = { "mod enable disable toggle all" },

			get_module = function(self)
				return Handy.cc.handy
			end,
			checkbox = true,
		},
		{
			key = "keybinds_trigger_mode",
			keywords = { "trigger mode on press on release key button" },
			get_module = function(self)
				return Handy.cc.keybinds_trigger_mode
			end,
			option_cycle = {
				get_values = function()
					return {
						options = {
							Handy.L.dictionary("handy_keybinds_trigger_mode_press"),
							Handy.L.dictionary("handy_keybinds_trigger_mode_release"),
						},
					}
				end,
			},
		},
		{
			key = "current_device",
			keywords = { "current input device gamepad controller mouse keyboard auto" },
			get_module = function(self)
				return Handy.cc.current_device
			end,
			option_cycle = {
				get_values = function()
					return {
						options = {
							Handy.L.dictionary("handy_current_device_auto"),
							Handy.L.dictionary("handy_current_device_keyboard"),
							Handy.L.dictionary("handy_current_device_gamepad"),
						},
					}
				end,
				callback = function()
					Handy.controller.device.update_type({ check = true })
				end,
			},
			loc_vars = function()
				return { vars = { Handy.L.dictionary("handy_current_device_auto") } }
			end,
		},
		{
			key = "prevent_if_debugplus",
			keywords = { "debug plus prevent intersections keybinds" },
			get_module = function(self)
				return Handy.cc.prevent_if_debugplus
			end,
			loc_vars = function()
				return { vars = { Handy.L.with_brackets(Handy.L.keys("Ctrl"), true) } }
			end,
			checkbox = true,
		},
	},
})
l({
	key = "gamepad",
	keywords = { "gamepad controller" },
	group = true,
	items = {
		{
			key = "controller_sensitivity",
			keywords = { "cursor sensitivity speed" },
			get_module = function(self)
				return Handy.cc.controller_sensitivity
			end,
			checkbox = {
				callback = function()
					Handy.controller_sensitivity.apply()
				end,
			},
			slider = {
				min = 0.5,
				max = 2,
				decimal_places = 2,
				save = true,
				get_values = function()
					return {}
				end,
				callback = function()
					Handy.controller_sensitivity.apply()
				end,
			},
		},
		{
			key = "swap_controller_cursor_stick",
			keywords = { "stick sticks swap change" },
			get_module = function(self)
				return Handy.cc.swap_controller_cursor_stick
			end,
			checkbox = true,
		},
	},
})
l({
	key = "appearance",
	keywords = { "appearance buttons button toggle toggles checkboxes checkbox" },
	group = true,
	items = {
		{
			key = "notifications_level",
			keywords = { "notifications popup" },
			get_module = function(self)
				return Handy.cc.notifications_level
			end,
			option_cycle = {
				get_values = function()
					return {
						options = {
							Handy.L.dictionary("handy_notification_level_none"),
							Handy.L.dictionary("handy_notification_level_dangerous"),
							Handy.L.dictionary("handy_notification_level_essential"),
							Handy.L.dictionary("handy_notification_level_all"),
						},
					}
				end,
				callback = function()
					Handy.UI.state_panel.render(true)
				end,
			},
			info_func = "handy_show_example_state_panel",
		},
		{
			key = "hide_options_button",
			keywords = { "settings config mod blue button" },
			get_module = function(self)
				return Handy.cc.hide_options_button
			end,
			checkbox = true,
		},
		{
			key = "speed_multiplier_settings_toggle",
			keywords = { "settings config speed multiplier more speed toggle checkbox cycle" },
			get_module = function(self)
				return Handy.cc.speed_multiplier_settings_toggle, { Handy.D.dictionary.speed_multiplier }
			end,
			checkbox = true,
			no_mp = Handy.speed_multiplier.is_disabled_by_mp,
		},
		{
			key = "animation_skip_settings_toggle",
			keywords = { "settings config animation skip remove animations toggle checkbox cycle" },
			get_module = function(self)
				return Handy.cc.animation_skip_settings_toggle, { Handy.D.dictionary.animation_skip }
			end,
			checkbox = true,
			no_mp = Handy.animation_skip.is_disabled_by_mp,
		},
	},
})
l({
	key = "hand_selection",
	keywords = { "hand selection select cards card" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.hand_selection
	end,

	group = true,
	items = {
		{
			key = "hand_selection_insta_highlight",
			keywords = { "swipe hover drag slide insta highlight quick" },
			keybind = {
				allow_multiple = "advanced",
			},
			checkbox = true,

			get_module = function(self)
				return Handy.cc.hand_selection_insta_highlight, { Handy.D.dictionary.hand_selection }
			end,
		},
		{
			key = "hand_selection_insta_highlight_allow_deselect",
			keywords = { "swipe hover drag slide insta highlight quick deselect unhighlight" },
			checkbox = true,

			get_module = function(self)
				return Handy.cc.hand_selection_insta_highlight_allow_deselect,
					{ Handy.D.dictionary.hand_selection, Handy.D.dictionary.hand_selection_insta_highlight }
			end,
		},
		{
			key = "hand_selection_deselect_hand",
			keywords = { "deselect hand vanilla unhighlight all cards" },

			keybind = {
				allow_multiple = "advanced",
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.hand_selection_deselect_hand, { Handy.D.dictionary.hand_selection }
			end,

			loc_vars = function()
				return { vars = { Handy.L.with_brackets(Handy.L.keys("Right Mouse"), true) } }
			end,
		},
		{
			key = "hand_selection_entire_f_hand",
			keywords = { "select all cards hand highlight entire card" },
			keybind = {
				allow_multiple = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.hand_selection_entire_f_hand, { Handy.D.dictionary.hand_selection }
			end,
		},
	},
})
l({
	key = "speed_multiplier",
	keywords = { "speed multiplier", "fast faster more speed accelerate acceleration increase decrease" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.speed_multiplier
	end,

	no_mp = Handy.speed_multiplier.is_disabled_by_mp,

	simple_option_cycle = {
		left_callback = function()
			Handy.speed_multiplier.change(-1)
		end,
		right_callback = function()
			Handy.speed_multiplier.change(1)
		end,
		get_values = function()
			return {
				ref_table = Handy.speed_multiplier,
				ref_value = "value_text",
				prefix = Handy.L.name_text("Handy_ConfigDictionary", "speed_multiplier") .. ": ",
			}
		end,
		colour = G.C.CHIPS,
	},

	group = true,
	items = {
		{
			key = "speed_multiplier_default_value",
			keywords = { "default value on startup game start launch" },
			get_module = function(self)
				return Handy.cc.speed_multiplier_default_value, { Handy.D.dictionary.speed_multiplier }
			end,
			checkbox = {
				advanced = true,
			},
			option_cycle = {
				get_values = function()
					return {
						options = {
							"1x",
							"2x",
							"4x",
							"8x",
							"16x",
							"32x",
							"64x",
							"128x",
							"256x",
							"512x",
						},
					}
				end,
			},
			no_mp = Handy.speed_multiplier.is_disabled_by_mp,
		},
		{
			key = "speed_multiplier_multiply",
			keywords = { "increase" },
			keybind = {
				allow_multiple = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.speed_multiplier_multiply, { Handy.D.dictionary.speed_multiplier }
			end,
			no_mp = Handy.speed_multiplier.is_disabled_by_mp,
		},
		{
			key = "speed_multiplier_divide",
			keywords = { "decrease" },
			keybind = {
				allow_multiple = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.speed_multiplier_divide, { Handy.D.dictionary.speed_multiplier }
			end,
			no_mp = Handy.speed_multiplier.is_disabled_by_mp,
		},
		{
			key = "speed_multiplier_toggle_temp_disabled",
			keywords = { "toggle", "temporary disable" },
			keybind = {
				allow_multiple = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.speed_multiplier_toggle_temp_disabled, { Handy.D.dictionary.speed_multiplier }
			end,
			no_mp = Handy.speed_multiplier.is_disabled_by_mp,
		},
		{
			key = "dangerous_actions_speed_multiplier_uncap",
			keywords = { "dangerous max speed uncap unsafe" },
			dangerous = true,
			checkbox = true,

			get_module = function(self)
				return Handy.cc.dangerous_actions_speed_multiplier_uncap, { Handy.D.dictionary.speed_multiplier }
			end,
			no_mp = Handy.speed_multiplier.is_disabled_by_mp,
		},
	},
})
l({
	key = "animation_skip",
	keywords = { "animation skip", "faster remove no animations animation nopeus instant scoring game" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.animation_skip
	end,

	simple_option_cycle = {
		left_callback = function()
			Handy.animation_skip.change(-1)
		end,
		right_callback = function()
			Handy.animation_skip.change(1)
		end,
		get_values = function()
			return {
				ref_table = Handy.animation_skip,
				ref_value = "value_text",
				prefix = Handy.L.name_text("Handy_ConfigDictionary", "animation_skip") .. ": ",
			}
		end,
		colour = G.C.ORANGE,
	},
	no_mp = Handy.animation_skip.is_disabled_by_mp,

	group = true,
	items = {
		{
			key = "animation_skip_default_value",
			keywords = { "default value on startup game start launch" },
			get_module = function(self)
				return Handy.cc.animation_skip_default_value, { Handy.D.dictionary.animation_skip }
			end,
			checkbox = {
				advanced = true,
			},
			option_cycle = {
				get_values = function()
					return {
						options = {
							Handy.L.dictionary("handy_animation_skip_levels", 1),
							Handy.L.dictionary("handy_animation_skip_levels", 2),
							Handy.L.dictionary("handy_animation_skip_levels", 3),
							Handy.L.dictionary("handy_animation_skip_levels", 4),
						},
					}
				end,
			},
			no_mp = Handy.animation_skip.is_disabled_by_mp,
		},
		{
			key = "animation_skip_increase",
			keywords = { "increase" },
			keybind = {
				allow_multiple = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.animation_skip_increase, { Handy.D.dictionary.animation_skip }
			end,
			no_mp = Handy.animation_skip.is_disabled_by_mp,
		},
		{
			key = "animation_skip_decrease",
			keywords = { "decrease" },
			keybind = {
				allow_multiple = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.animation_skip_decrease, { Handy.D.dictionary.animation_skip }
			end,
			no_mp = Handy.animation_skip.is_disabled_by_mp,
		},
		{
			key = "animation_skip_toggle_temp_disabled",
			keywords = { "toggle", "temporary disable" },
			keybind = {
				allow_multiple = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.animation_skip_toggle_temp_disabled, { Handy.D.dictionary.animation_skip }
			end,
			no_mp = Handy.animation_skip.is_disabled_by_mp,
		},
		{
			key = "dangerous_actions_animation_skip_unsafe",
			keywords = { "no animations", "dangerous unsafe remove all animations" },
			checkbox = true,
			dangerous = true,

			get_module = function(self)
				return Handy.cc.dangerous_actions_animation_skip_unsafe, { Handy.D.dictionary.animation_skip }
			end,
			no_mp = Handy.animation_skip.is_disabled_by_mp,
		},
	},
})
l({
	key = "move_highlight",
	keywords = { "cards card selection highlight movement precise" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.move_highlight
	end,

	no_gamepad = true,

	group = true,
	items = {
		{
			key = "move_highlight_one_left",
			keywords = { "left" },
			keybind = {
				allow_multiple = true,
			},
			no_gamepad = true,

			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.move_highlight_dx_one_left, { Handy.D.dictionary.move_highlight }
			end,
		},
		{
			key = "move_highlight_one_right",
			keywords = { "right" },
			keybind = {
				allow_multiple = true,
			},
			no_gamepad = true,
			checkbox = {
				advanced = true,
			},
			get_module = function(self)
				return Handy.cc.move_highlight_dx_one_right, { Handy.D.dictionary.move_highlight }
			end,
		},
		{
			key = "move_highlight_swap",
			keywords = { "swap move card" },
			keybind = {
				allow_multiple = true,
				only_holdable = true,
			},
			no_gamepad = true,
			checkbox = {
				advanced = true,
			},
			get_module = function(self)
				return Handy.cc.move_highlight_swap, { Handy.D.dictionary.move_highlight }
			end,
		},
		{
			key = "move_highlight_to_end",
			keywords = {},
			keybind = {
				allow_multiple = true,
				only_holdable = true,
			},
			no_gamepad = true,
			checkbox = {
				advanced = true,
			},
			get_module = function(self)
				return Handy.cc.move_highlight_to_end, { Handy.D.dictionary.move_highlight }
			end,
		},
	},
})
l({
	key = "insta_actions",
	keywords = { "insta quick actions quick buy sell use" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.insta_actions
	end,

	group = true,
	items = {
		{
			key = "insta_actions_trigger_mode",
			keywords = { "trigger mode" },
			get_module = function(self)
				return Handy.cc.insta_actions_trigger_mode
			end,
			option_cycle = {
				save = true,
				get_values = function()
					return {
						options = {
							Handy.L.dictionary("handy_buy_sell_use_mode_hold_n_click"),
							Handy.L.dictionary("handy_buy_sell_use_mode_hover_n_press"),
						},
					}
				end,
			},
		},
		{
			key = "insta_actions_buy_or_sell",
			keywords = { "buy or sell card cards" },
			keybind = {
				allow_multiple = "advanced",
			},
			checkbox = true,

			get_module = function(self)
				return Handy.cc.insta_actions_buy_or_sell, { Handy.D.dictionary.insta_actions }
			end,

			loc_vars = function()
				return {
					vars = { Handy.L.name_text("Handy_ConfigDictionary", "insta_actions_trigger_mode") },
					key = Handy.cc.insta_actions_trigger_mode.value == 2 and "insta_actions_buy_or_sell_alt" or nil,
				}
			end,
		},
		{
			key = "insta_actions_buy_n_sell",
			keywords = { "buy and sell buy n sell card cards" },
			keybind = {
				allow_multiple = "advanced",
			},
			checkbox = true,

			get_module = function(self)
				return Handy.cc.insta_actions_buy_n_sell, { Handy.D.dictionary.insta_actions }
			end,

			loc_vars = function()
				return {
					vars = { Handy.L.name_text("Handy_ConfigDictionary", "insta_actions_trigger_mode") },
					key = Handy.cc.insta_actions_trigger_mode.value == 2 and "insta_actions_buy_n_sell_alt" or nil,
				}
			end,
		},
		{
			key = "insta_actions_use",
			keywords = { "use consumables consumeables card cards" },
			keybind = {
				allow_multiple = "advanced",
			},
			checkbox = true,

			get_module = function(self)
				return Handy.cc.insta_actions_use, { Handy.D.dictionary.insta_actions }
			end,

			loc_vars = function()
				return {
					vars = { Handy.L.name_text("Handy_ConfigDictionary", "insta_actions_trigger_mode") },
					key = Handy.cc.insta_actions_trigger_mode.value == 2 and "insta_actions_use_alt" or nil,
				}
			end,
		},
		-- {
		-- 	key = "insta_actions_cryptid_code_use_last_interaction",
		-- 	keywords = {},
		-- 	keybind = {
		-- 		allow_multiple = "advanced",
		-- 	},
		-- 	checkbox = true,

		-- 	get_module = function(self)
		-- 		return Handy.cc.insta_actions_cryptid_code_use_last_interaction, { Handy.D.dictionary.insta_actions }
		-- 	end,

		-- 	loc_vars = function()
		-- 		return {
		-- 			vars = { Handy.L.name_text("Handy_ConfigDictionary", "insta_actions_trigger_mode") },
		-- 			key = Handy.cc.insta_actions_trigger_mode.value == 2
		-- 					and "insta_actions_cryptid_code_use_last_interaction_alt"
		-- 				or nil,
		-- 		}
		-- 	end,
		-- },
	},
})
l({
	key = "presets",
	keywords = { "presets config layouts settings" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.presets
	end,

	group = true,
	items = {
		{
			key = "presets_load_1",
			keywords = { "load 1" },
			keybind = {
				allow_multiple = "advanced",
				rerender = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.presets_load_1, { Handy.D.dictionary.presets }
			end,
		},
		{
			key = "presets_load_2",
			keywords = { "load 2" },
			keybind = {
				allow_multiple = "advanced",
				rerender = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.presets_load_2, { Handy.D.dictionary.presets }
			end,
		},
		{
			key = "presets_load_3",
			keywords = { "load 3" },
			keybind = {
				allow_multiple = "advanced",
				rerender = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.presets_load_3, { Handy.D.dictionary.presets }
			end,
		},
		{
			key = "presets_load_next",
			keywords = { "load next" },
			keybind = {
				allow_multiple = "advanced",
				rerender = true,
			},
			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.presets_load_next, { Handy.D.dictionary.presets }
			end,
		},
	},
})
l({
	key = "scoring_hold",
	keywords = { "scoring hold", "pause stop animations before during scoring" },
	get_module = function(self)
		return Handy.cc.scoring_hold
	end,
	checkbox = true,
	keybind = {
		allow_multiple = "advanced",
		only_holdable = true,
	},

	group = true,
	items = {
		{
			key = "scoring_hold_any_moment",
			keywords = { "pause any moment" },
			get_module = function(self)
				return Handy.cc.scoring_hold_any_moment, { Handy.D.dictionary.scoring_hold }
			end,
			checkbox = true,
		},
	},
})
l({
	key = "regular_keybinds",
	get_module = function(self)
		return Handy.cc.regular_keybinds
	end,
	checkbox = true,
	keywords = { "vanilla regular common default keybinds" },

	group = true,
	items = {
		{
			key = "regular_keybinds_group_game",
			kywords = { "general game" },
			group = true,
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
							vars = { Handy.L.with_brackets(Handy.L.keys("R"), true) },
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
					},
					get_module = function(self)
						return Handy.cc.regular_keybinds_reload_run, { Handy.D.dictionary.regular_keybinds }
					end,
					no_mp = true,
				},
			},
		},
		{
			key = "regular_keybinds_group_round",
			keywords = { "round" },
			group = true,
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
				},
			},
		},
		{
			key = "regular_keybinds_group_shop",
			keywords = { "shop" },
			group = true,
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
			group = true,
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
			key = "regular_keybinds_group_menus",
			keywords = { "ui menus panels menus" },
			group = true,
			items = {
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
l({
	key = "dangerous_actions",
	get_module = function(self)
		return Handy.cc.dangerous_actions
	end,
	keywords = { "dangerous unsafe" },
	checkbox = true,
	dangerous = true,

	group = true,
	items = {
		{
			key = "dangerous_actions_sell_one",
			keywords = { "quick instant mass sell in bulk" },
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_sell_one
			end,
			no_mp = Handy.dangerous_actions.is_sell_disabled_in_mp,
		},
		{
			key = "dangerous_actions_remove_one",
			keywords = { "quick instant mass remove in bulk card cards skip tags" },
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_remove_one
			end,
			no_mp = Handy.dangerous_actions.is_remove_disabled_in_mp,
		},
		{
			key = "dangerous_actions_sell_all_same",
			keywords = { "quick instant mass sell in bulk all same copies card cards" },
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_sell_all_same
			end,
			no_mp = Handy.dangerous_actions.is_sell_disabled_in_mp,
		},
		{
			key = "dangerous_actions_remove_all_same",
			keywords = { "quick instant mass remove in bulk all same copies card cards skip tags" },
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_remove_all_same
			end,
			no_mp = Handy.dangerous_actions.is_remove_disabled_in_mp,
		},
		{
			key = "dangerous_actions_sell_all",
			keywords = { "quick instant mass sell in bulk all card cards" },
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_sell_all
			end,
			no_mp = Handy.dangerous_actions.is_sell_disabled_in_mp,
		},
		{
			key = "dangerous_actions_remove_all",
			keywords = { "quick instant mass remove in bulk all card cards skip tags" },
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_remove_all
			end,
			no_mp = Handy.dangerous_actions.is_remove_disabled_in_mp,
		},
		{
			key = "dangerous_actions_crash",
			keywords = { "crash game fuck you" },
			checkbox = true,
			dangerous = true,
			keybind = {
				allow_multiple = true,
				only_safe = true,
			},
			get_module = function(self)
				return Handy.cc.dangerous_actions_crash
			end,
			no_mp = true,
		},
	},
})
-- l({
-- 	key = "misc",
-- 	get_module = function(self)
-- 		return Handy.cc.misc
-- 	end,
-- 	checkbox = true,

-- 	group = true,
-- 	items = {
-- 	},
-- })
l({
	key = "mp_extension",
	keywords = { "multiplayer extension mp lobby bmp" },

	group = true,
	items = {
		{
			key = "mp_extension_current_lobby",
			keywords = { "current lobby" },

			group = true,
			items = {
				{
					key = "mp_extension_enabled",

					checkbox = {
						get_values = function()
							return {
								disabled = not Handy.b_is_in_multiplayer() or G.STAGE ~= G.STAGES.MAIN_MENU,
							}
						end,
						callback = function()
							Handy.EXT.Multiplayer.send_action_setEnabled()
						end,
					},

					loc_vars = function()
						return {
							vars = {
								Handy.L.with_brackets(
									Handy.L.name_text("Handy_ConfigDictionary", "speed_multiplier"),
									true
								),
								Handy.L.with_brackets(
									Handy.L.name_text("Handy_ConfigDictionary", "animation_skip"),
									true
								),
							},
						}
					end,

					get_module = function(self)
						return setmetatable({}, {
							__index = function(t, k)
								local lobby = Handy.get_mp_lobby()
								return lobby and lobby.handy_mp_extension_local_player_enabled
							end,
							__newindex = function(t, k, v)
								local lobby = Handy.get_mp_lobby()
								if not lobby or G.STAGE == G.STAGES.RUN then
									return
								end
								lobby.handy_mp_extension_local_player_enabled = v
							end,
						})
					end,
				},
				{
					key = "mp_extension_speed_multiplier_mode",

					get_module = function()
						return setmetatable({}, {
							__index = function(t, k)
								local r = Handy.get_mp_lobby_config_value("handy_speed_multiplier_mode", {
									default_value = 1,
									force = true,
									bypass_active = G.STAGE == G.STAGES.MAIN_MENU,
								})
								return r
							end,
							__newindex = function(t, k, v)
								local lobby = Handy.get_mp_lobby()
								if not lobby or not Handy.EXT.Multiplayer.can_change_lobby_settings() then
									return
								end
								(lobby.config or {}).handy_speed_multiplier_mode = v
							end,
						})
					end,
					option_cycle = {
						get_values = function()
							local _, is_forced = Handy.get_mp_lobby_config_value("handy_speed_multiplier_mode", {
								default_value = 1,
								force = true,
							})
							return {
								options = {
									"1x",
									"2x",
									"4x",
									"8x",
									"16x",
									"32x",
									"64x",
									"128x",
									"256x",
									"512x",
								},
								disabled = is_forced or not Handy.EXT.Multiplayer.can_change_lobby_settings(),
							}
						end,
						callback = function()
							MP.ACTIONS.lobby_options()
						end,
						colour = G.C.CHIPS,
					},
				},
				{
					key = "mp_extension_animation_skip_mode",

					get_module = function()
						return setmetatable({}, {
							__index = function(t, k)
								local r = Handy.get_mp_lobby_config_value("handy_animation_skip_mode", {
									force = true,
									default_value = 1,
									bypass_active = G.STAGE == G.STAGES.MAIN_MENU,
								})
								return r
							end,
							__newindex = function(t, k, v)
								local lobby = Handy.get_mp_lobby()
								if not lobby or not Handy.EXT.Multiplayer.can_change_lobby_settings() then
									return
								end
								(lobby.config or {}).handy_animation_skip_mode = v
							end,
						})
					end,
					option_cycle = {
						get_values = function()
							local _, is_forced = Handy.get_mp_lobby_config_value("handy_animation_skip_mode", {
								default_value = 1,
								force = true,
							})
							return {
								options = {
									Handy.L.dictionary("handy_animation_skip_levels", 1),
									Handy.L.dictionary("handy_animation_skip_levels", 2),
									Handy.L.dictionary("handy_animation_skip_levels", 3),
									Handy.L.dictionary("handy_animation_skip_levels", 4),
								},
								disabled = is_forced or not Handy.EXT.Multiplayer.can_change_lobby_settings(),
							}
						end,
						callback = function()
							MP.ACTIONS.lobby_options()
						end,
						colour = G.C.ORANGE,
					},
				},
				{
					key = "mp_extension_dangerous_actions_mode",
					get_module = function()
						return setmetatable({}, {
							__index = function(t, k)
								local r = Handy.get_mp_lobby_config_value("handy_dangerous_actions_mode", {
									force = true,
									default_value = 1,
									bypass_active = G.STAGE == G.STAGES.MAIN_MENU,
								})
								return r
							end,
							__newindex = function(t, k, v)
								local lobby = Handy.get_mp_lobby()
								if not lobby or not Handy.EXT.Multiplayer.can_change_lobby_settings() then
									return
								end
								(lobby.config or {}).handy_dangerous_actions_mode = v
							end,
						})
					end,
					option_cycle = {
						get_values = function()
							local _, is_forced = Handy.get_mp_lobby_config_value("handy_dangerous_actions_mode", {
								default_value = 1,
								force = true,
							})
							return {
								options = {
									Handy.L.dictionary("handy_mp_dangerous_actions_modes", 1),
									Handy.L.dictionary("handy_mp_dangerous_actions_modes", 2),
									-- Handy.L.dictionary("handy_mp_dangerous_actions_modes", 3),
								},
								disabled = is_forced or not Handy.EXT.Multiplayer.can_change_lobby_settings(),
							}
						end,
						callback = function()
							MP.ACTIONS.lobby_options()
						end,
						colour = G.C.MULT,
					},
				},
			},
		},
		{
			key = "mp_extension_default_values",
			keywords = { "default lobby values" },

			group = true,
			items = {
				{
					key = "mp_extension_enabled_default_value",
					checkbox = true,

					get_module = function(self)
						return Handy.cc.mp_extension_enabled_default_value
					end,
				},
				{
					key = "mp_extension_speed_multiplier_mode_default_value",
					get_module = function()
						return Handy.cc.mp_extension_speed_multiplier_mode_default_value
					end,
					checkbox = true,
					option_cycle = {
						get_values = function()
							return {
								options = {
									"1x",
									"2x",
									"4x",
									"8x",
									"16x",
									"32x",
									"64x",
									"128x",
									"256x",
									"512x",
								},
							}
						end,
						colour = G.C.CHIPS,
					},
				},
				{
					key = "mp_extension_animation_skip_mode_default_value",
					get_module = function()
						return Handy.cc.mp_extension_animation_skip_mode_default_value
					end,
					checkbox = true,
					option_cycle = {
						get_values = function()
							return {
								options = {
									Handy.L.dictionary("handy_animation_skip_levels", 1),
									Handy.L.dictionary("handy_animation_skip_levels", 2),
									Handy.L.dictionary("handy_animation_skip_levels", 3),
									Handy.L.dictionary("handy_animation_skip_levels", 4),
								},
							}
						end,
						colour = G.C.ORANGE,
					},
				},
				{
					key = "mp_extension_dangerous_actions_mode_default_value",
					get_module = function()
						return Handy.cc.mp_extension_dangerous_actions_mode_default_value
					end,
					checkbox = true,
					option_cycle = {
						get_values = function()
							return {
								options = {
									Handy.L.dictionary("handy_mp_dangerous_actions_modes", 1),
									Handy.L.dictionary("handy_mp_dangerous_actions_modes", 2),
									-- Handy.L.dictionary("handy_mp_dangerous_actions_modes", 3),
								},
							}
						end,
						colour = G.C.MULT,
					},
				},
			},
		},
	},
})

--

local next_index = 1
local process_item
process_item = function(item)
	if not item.key then
		return
	end
	item.parents = item.parents or {}
	Handy.D.dictionary[item.key] = item
	table.insert(Handy.D.list, item)

	item.get_module = item.get_module or function() end

	local keywords = item.keywords or {}
	item.keywords_list = Handy.utils.table_concat(
		(not keywords.replace and item.parent) and item.parent.keywords_list or {},
		Handy.utils.string_words_split(Handy.utils.string_join_keywords(keywords))
	)

	if item.checkbox then
		table.insert(Handy.D.checkboxes, item)
	end
	if item.keybind then
		table.insert(Handy.D.keybinds, item)
	end
	if item.option_cycle then
		table.insert(Handy.D.option_cycles, item)
	end
	if item.simple_option_cycle then
		table.insert(Handy.D.simple_option_cycles, item)
	end
	if item.slider then
		table.insert(Handy.D.sliders, item)
	end
	if item.items then
		table.insert(Handy.D.groups, item)
		for index, subitem in ipairs(item.items) do
			subitem.parent = item
			subitem.parents = Handy.utils.table_concat(item.parents or {}, { item })
			if not subitem.order then
				subitem.order = next_index
				next_index = next_index + 1
			else
				next_index = math.max(subitem.order + 1, next_index)
			end
			next_index = next_index + 1
			process_item(subitem)
		end
	else
		table.insert(Handy.D.items, item)
	end
end

for index, item in ipairs(items_list) do
	if not item.order then
		item.order = next_index
		next_index = next_index + 1
	else
		next_index = math.max(item.order + 1, next_index)
	end
	process_item(item)
end
