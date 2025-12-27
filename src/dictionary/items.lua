local items_list = {}

local function l(item)
	table.insert(items_list, item)
end

l({
	key = "general",

	keywords = { "general global" },
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
						callback = function()
							Handy.controller.device.update_type({ check = true })
						end,
					}
				end,
			},
			loc_vars = function()
				return { vars = { Handy.L.dictionary("handy_current_device_auto") } }
			end,
		},
		{
			key = "prevent_if_debugplus",
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

	group = true,
	items = {
		{
			key = "controller_sensitivity",
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
			get_module = function(self)
				return Handy.cc.swap_controller_cursor_stick
			end,
			checkbox = true,
		},
	},
})
l({
	key = "appearance",

	group = true,
	items = {
		{
			key = "notifications_level",
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
						callback = function()
							Handy.UI.state_panel.render(true)
						end,
					}
				end,
			},
			info_func = "handy_show_example_state_panel",
		},
		{
			key = "hide_options_button",
			get_module = function(self)
				return Handy.cc.hide_options_button
			end,
			checkbox = true,
		},
		{
			key = "speed_multiplier_settings_toggle",
			get_module = function(self)
				return Handy.cc.speed_multiplier_settings_toggle, { Handy.D.dictionary.speed_multiplier }
			end,
			checkbox = true,
		},
		{
			key = "animation_skip_settings_toggle",
			get_module = function(self)
				return Handy.cc.animation_skip_settings_toggle, { Handy.D.dictionary.animation_skip }
			end,
			checkbox = true,
		},
	},
})
l({
	key = "hand_selection",
	keywords = {},
	checkbox = true,
	get_module = function(self)
		return Handy.cc.hand_selection
	end,

	group = true,
	items = {
		{
			key = "hand_selection_insta_highlight",
			keywords = {},
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
			checkbox = true,

			get_module = function(self)
				return Handy.cc.hand_selection_insta_highlight_allow_deselect,
					{ Handy.D.dictionary.hand_selection, Handy.D.dictionary.hand_selection_insta_highlight }
			end,
		},
		{
			key = "hand_selection_deselect_hand",
			keywords = { "toggle", "temporary disable" },

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
			keywords = { "decrease" },
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
	keywords = { "speed multiplier", "faster more speed" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.speed_multiplier
	end,

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
		},
		{
			key = "dangerous_actions_speed_multiplier_uncap",
			keywords = { "no animations", "unsafe" },
			dangerous = true,
			checkbox = true,

			get_module = function(self)
				return Handy.cc.dangerous_actions_speed_multiplier_uncap, { Handy.D.dictionary.speed_multiplier }
			end,
		},
	},
})
l({
	key = "animation_skip",
	keywords = { "animation skip", "faster animations nopeus" },
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

	group = true,
	items = {
		{
			key = "animation_skip_default_value",
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
		},
		{
			key = "dangerous_actions_animation_skip_unsafe",
			keywords = { "no animations", "unsafe" },
			checkbox = true,
			dangerous = true,

			get_module = function(self)
				return Handy.cc.dangerous_actions_animation_skip_unsafe, { Handy.D.dictionary.animation_skip }
			end,
		},
	},
})
l({
	key = "move_highlight",
	keywords = {},
	checkbox = true,
	get_module = function(self)
		return Handy.cc.move_highlight
	end,

	group = true,
	items = {
		{
			key = "move_highlight_one_left",
			keywords = {},
			keybind = {
				allow_multiple = true,
			},

			checkbox = {
				advanced = true,
			},

			get_module = function(self)
				return Handy.cc.move_highlight_dx_one_left, { Handy.D.dictionary.move_highlight }
			end,
		},
		{
			key = "move_highlight_one_right",
			keywords = {},
			keybind = {
				allow_multiple = true,
			},
			checkbox = {
				advanced = true,
			},
			get_module = function(self)
				return Handy.cc.move_highlight_dx_one_right, { Handy.D.dictionary.move_highlight }
			end,
		},
		{
			key = "move_highlight_swap",
			keywords = {},
			keybind = {
				allow_multiple = true,
				only_holdable = true,
			},
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
	keywords = {},
	checkbox = true,
	get_module = function(self)
		return Handy.cc.insta_actions
	end,

	group = true,
	items = {
		{
			key = "insta_actions_trigger_mode",
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
			keywords = {},
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
			keywords = {},
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
			keywords = {},
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
		{
			key = "insta_actions_cryptid_code_use_last_interaction",
			keywords = {},
			keybind = {
				allow_multiple = "advanced",
			},
			checkbox = true,

			get_module = function(self)
				return Handy.cc.insta_actions_cryptid_code_use_last_interaction, { Handy.D.dictionary.insta_actions }
			end,

			loc_vars = function()
				return {
					vars = { Handy.L.name_text("Handy_ConfigDictionary", "insta_actions_trigger_mode") },
					key = Handy.cc.insta_actions_trigger_mode.value == 2
							and "insta_actions_cryptid_code_use_last_interaction_alt"
						or nil,
				}
			end,
		},
	},
})
l({
	key = "presets",
	keywords = {},
	checkbox = true,
	get_module = function(self)
		return Handy.cc.presets
	end,

	group = true,
	items = {
		{
			key = "presets_load_1",
			keywords = {},
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
			keywords = {},
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
			keywords = {},
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
			keywords = {},
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
	keywords = { "scoring hold", "pause animation" },
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

	group = true,
	items = {
		{
			key = "regular_keybinds_group_round",
			group = true,
			items = {
				{
					key = "regular_keybinds_play",
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
			},
		},
		{
			key = "regular_keybinds_group_shop",
			group = true,
			items = {
				{
					key = "regular_keybinds_skip_booster",
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
			group = true,
			items = {
				{
					key = "regular_keybinds_run_info",
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
	checkbox = true,
	dangerous = true,

	group = true,
	items = {
		{
			key = "dangerous_actions_sell_one",
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_sell_one
			end,
		},
		{
			key = "dangerous_actions_remove_one",
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_remove_one
			end,
		},
		{
			key = "dangerous_actions_sell_all_same",
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_sell_all_same
			end,
		},
		{
			key = "dangerous_actions_remove_all_same",
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_remove_all_same
			end,
		},
		{
			key = "dangerous_actions_sell_all",
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_sell_all
			end,
		},
		{
			key = "dangerous_actions_remove_all",
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_remove_all
			end,
		},
	},
})
l({
	key = "misc",
	get_module = function(self)
		return Handy.cc.misc
	end,
	checkbox = true,

	group = true,
	items = {
		{
			key = "misc_quick_restart",
			checkbox = {
				advanced = true,
			},
			keybind = {
				allow_multiple = true,
				only_safe = true,
			},
			get_module = function(self)
				return Handy.cc.misc_quick_restart, { Handy.D.dictionary.misc }
			end,
		},
		{
			key = "misc_start_fantoms_preview",
			checkbox = {
				advanced = true,
			},
			keybind = {
				allow_multiple = true,
			},
			get_module = function(self)
				return Handy.cc.misc_start_fantoms_preview, { Handy.D.dictionary.misc }
			end,
		},
		{
			key = "misc_save_run",
			checkbox = {
				advanced = true,
			},
			keybind = {
				allow_multiple = true,
			},
			get_module = function(self)
				return Handy.cc.misc_save_run, { Handy.D.dictionary.misc }
			end,
		},
		{
			key = "misc_crash",
			checkbox = true,
			dangerous = true,
			keybind = {
				allow_multiple = true,
				only_safe = true,
			},
			get_module = function(self)
				return Handy.cc.misc_crash, { Handy.D.dictionary.misc }
			end,
		},
	},
})

--

Handy.D = {
	list = {},
	dictionary = {},

	groups = {},
	items = {},

	checkboxes = {},
	keybinds = {},
	option_cycles = {},
	simple_option_cycles = {},
	sliders = {},
}

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

--

local items_sorter = function(a, b)
	local a_p_order = a.parent and a.parent.order or 999999
	local b_p_order = b.parent and b.parent.order or 999999

	if a_p_order ~= b_p_order then
		return a_p_order < b_p_order
	end
	return a.order < b.order
end

table.sort(Handy.D.list, items_sorter)
table.sort(Handy.D.checkboxes, items_sorter)
table.sort(Handy.D.keybinds, items_sorter)
table.sort(Handy.D.option_cycles, items_sorter)

--

function Handy.D.search(search_string, args)
	args = args or {}
	local items = args.items or Handy.D.list
	if not search_string or #search_string == 0 then
		return items
	end

	local matches = {}
	local parents = {}
	local input_words = Handy.utils.string_words_split(string.lower(search_string))
	if #input_words == 0 then
		return matches
	end

	for _, item in ipairs(items) do
		for _, word in ipairs(input_words) do
			if string.find(item.result_keywords or "", word, 1, true) then
				matches[item.key] = item
				if args.remove_parents then
					while item.parent do
						parents[item.parent.key] = true
						item = item.parent
					end
				end
				break
			end
		end
	end

	local result = {}
	for _, item in pairs(matches) do
		if
			-- remove groups which will be rendered anyway
			parents[item.key]
			-- remove groups which can be rendered but have nothing to render
			or (
				item.items
				and not (item.checkbox or item.keybind or item.option_cycle or item.simple_option_cycle or item.slider)
			)
		then
		else
			table.insert(result, item)
		end
	end
	table.sort(result, items_sorter)

	return result
end
