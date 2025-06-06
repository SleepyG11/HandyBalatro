-- Paginated content

Handy.UI.get_keybinds_page = function(page)
	local gamepad = Handy.controller.is_gamepad()
	local result = {}
	if page == 1 then
		result = {
			Handy.UI.PARTS.create_module_section("hand_selection"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_highlight, "quick_highlight", { only_holdable = true }),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_highlight_entire_f_hand, "highlight_entire_f_hand"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.deselect_hand, "deselect_hand"),
			Handy.UI.PARTS.create_module_section("hand"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.play, "play_hand"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.discard, "discard"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.sort_by_rank, "sort_by_rank"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.sort_by_suit, "sort_by_suit"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.toggle_sort, "toggle_sort"),
			Handy.UI.PARTS.create_module_section("menus"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.run_info, "run_info_hands"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.run_info_blinds, "run_info_blinds"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.view_deck, "view_deck"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.show_deck_preview, "deck_preview", { only_holdable = true }),
		}
	elseif page == 2 then
		result = {
			Handy.UI.PARTS.create_module_section("round"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_cash_out, "cash_out", { only_holdable = true }),
			Handy.UI.PARTS.create_module_keybind(
				Handy.cc.not_just_yet_interaction,
				"not_just_yet_end_round",
				{ only_holdable = true }
			),
			Handy.UI.PARTS.create_module_section("shop"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_booster_skip, "skip_booster", { only_holdable = true }),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.reroll_shop, "reroll_shop"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.leave_shop, "leave_shop"),
			Handy.UI.PARTS.create_module_section("blinds"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.skip_blind, "skip_blind"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.select_blind, "select_blind"),
			Handy.UI.PARTS.create_module_section("quick_actions"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_buy_or_sell, "quick_buy_or_sell"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_buy_n_sell, "quick_buy_n_sell"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_use, "quick_use"),
			Handy.UI.PARTS.create_module_keybind(
				Handy.cc.cryptid_code_use_last_interaction,
				"cryptid_code_use_last_interaction"
			),
		}
	elseif page == 3 then
		result = {
			Handy.UI.PARTS.create_module_section("gamespeed"),
			Handy.UI.PARTS.create_module_keybind(
				Handy.cc.speed_multiplier,
				"speed_multiplier",
				{ only_holdable = true }
			),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.speed_multiplier.multiply, "speed_multiplier_multiply"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.speed_multiplier.divide, "speed_multiplier_divide"),
			Handy.UI.PARTS.create_module_section("animations"),
			Handy.UI.PARTS.create_module_keybind(
				Handy.cc.nopeus_interaction,
				"nopeus_interaction",
				{ only_holdable = true }
			),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.nopeus_interaction.increase, "nopeus_interaction_increase"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.nopeus_interaction.decrease, "nopeus_interaction_decrease"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.animation_skip, "animation_skip", { only_holdable = true }),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.animation_skip.increase, "animation_skip_increase"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.animation_skip.decrease, "animation_skip_decrease"),
		}
	elseif page == 4 then
		result = {
			Handy.UI.PARTS.create_module_section("highlight_movement"),
			Handy.UI.PARTS.create_module_keybind(
				Handy.cc.move_highlight.dx.one_left,
				"move_highlight_one_left",
				{ disabled = gamepad }
			),
			Handy.UI.PARTS.create_module_keybind(
				Handy.cc.move_highlight.dx.one_right,
				"move_highlight_one_right",
				{ disabled = gamepad }
			),
			Handy.UI.PARTS.create_module_keybind(
				Handy.cc.move_highlight.swap,
				"move_highlight_move_card",
				{ disabled = gamepad, only_holdable = true }
			),
			Handy.UI.PARTS.create_module_keybind(
				Handy.cc.move_highlight.to_end,
				"move_highlight_to_end",
				{ disabled = gamepad, only_holdable = true }
			),
			Handy.UI.PARTS.create_module_section("presets"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_1, "presets_load_1"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_2, "presets_load_2"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_3, "presets_load_3"),
			Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_next, "presets_load_next"),
			Handy.UI.PARTS.create_module_section("dangerous_actions"),
			Handy.UI.PARTS.create_module_keybind(
				Handy.cc.dangerous_actions.immediate_buy_and_sell,
				"dangerous_modifier",
				{ dangerous = true, only_holdable = true }
			),
			Handy.UI.PARTS.create_module_keybind(
				Handy.cc.dangerous_actions.sell_all_same,
				"dangerous_all_same_modifier",
				{ dangerous = true, only_holdable = true }
			),
			Handy.UI.PARTS.create_module_keybind(
				Handy.cc.dangerous_actions.sell_all,
				"dangerous_all_modifier",
				{ dangerous = true, only_holdable = true }
			),
			Handy.UI.PARTS.create_module_keybind(
				Handy.cc.dangerous_actions.card_remove,
				"dangerous_remove_modifier",
				{ dangerous = true, only_holdable = true }
			),
		}
	end
	if result then
		result = {
			n = G.UIT.ROOT,
			config = {
				colour = adjust_alpha(HEX("000000"), 0.1),
				align = "cm",
				padding = 0.25,
				r = 0.5,
				minh = 7.7,
				maxh = 7.7,
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						padding = 0.05,
					},
					nodes = result,
				},
			},
		}
	end
	return result, 4
end
Handy.UI.get_quick_page = function(page)
	local gamepad = Handy.controller.is_gamepad()
	local result = {}
	if page == 1 then
		result = {
			not gamepad and {
				n = G.UIT.R,
				config = { padding = 0.05, align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						nodes = {
							create_option_cycle({
								w = 6,
								label = localize("b_handy_buy_sell_use_mode_select"),
								scale = 0.8,
								options = localize("handy_buy_sell_use_mode_opt"),
								opt_callback = "handy_change_insta_actions_trigger_mode",
								current_option = Handy.cc.insta_actions_trigger_mode,
							}),
						},
					},
				},
			} or nil,
			not gamepad and { n = G.UIT.R, config = { padding = 0.05 }, nodes = {} } or nil,
			{
				n = G.UIT.R,
				nodes = {
					{
						n = G.UIT.C,
						config = { minw = 4 },
						nodes = {
							Handy.UI.PARTS.create_new_module_checkbox(
								Handy.cc.insta_buy_or_sell,
								"insta_buy_or_sell",
								{
									localize("b_handy_buy_sell_use_mode_select"),
								}
							),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.insta_buy_n_sell, "insta_buy_n_sell", {
								localize("b_handy_buy_sell_use_mode_select"),
							}),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.insta_use, "insta_use", {
								localize("b_handy_buy_sell_use_mode_select"),
							}),
						},
					},
					{
						n = G.UIT.C,
						config = { minw = 4 },
						nodes = {
							Handy.UI.PARTS.create_new_module_checkbox(
								Handy.cc.insta_highlight_entire_f_hand,
								"insta_highlight_entire_f_hand"
							),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.PARTS.create_new_module_checkbox(
								Handy.cc.cryptid_code_use_last_interaction,
								"cryptid_code_use_last_interaction",
								{
									localize("b_handy_buy_sell_use_mode_select"),
								}
							),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.PARTS.create_new_module_checkbox(
								Handy.cc.not_just_yet_interaction,
								"not_just_yet_interaction"
							),
						},
					},
				},
			},
			-- { n = G.UIT.R, config = { minh = 0.25 } },
		}
	elseif page == 2 then
		result = {
			Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.move_highlight, "move_highlight", {
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.dx.one_left, true),
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.dx.one_right, true),
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.swap, true),
				Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.to_end, true),
			}, { full_width = true }),
			{ n = G.UIT.R, config = { minh = 0.25 } },
			{
				n = G.UIT.R,
				nodes = {
					{
						n = G.UIT.C,
						config = { minw = 4 },
						nodes = {
							Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.speed_multiplier, "speed_multiplier", {
								Handy.UI.PARTS.format_new_module_keys(Handy.cc.speed_multiplier.multiply, true),
								Handy.UI.PARTS.format_new_module_keys(Handy.cc.speed_multiplier.divide, true),
								"x1/512",
								"x512",
							}),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.PARTS.create_new_module_checkbox(
								Handy.cc.nopeus_interaction,
								"nopeus_interaction",
								{
									Handy.UI.PARTS.format_new_module_keys(Handy.cc.nopeus_interaction.increase, true),
									Handy.UI.PARTS.format_new_module_keys(Handy.cc.nopeus_interaction.decrease, true),
									localize("Dangerous", "handy_tabs"),
								}
							),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.animation_skip, "animation_skip", {
								Handy.UI.PARTS.format_new_module_keys(Handy.cc.animation_skip.increase, true),
								Handy.UI.PARTS.format_new_module_keys(Handy.cc.animation_skip.decrease, true),
								localize("Dangerous", "handy_tabs"),
							}),
						},
					},
					{
						n = G.UIT.C,
						config = { minw = 4 },
						nodes = {
							Handy.UI.PARTS.create_new_module_checkbox(
								Handy.cc.speed_multiplier.no_hold,
								"speed_multiplier_no_hold",
								{
									Handy.UI.PARTS.localize_keybind_label("speed_multiplier"),
								}
							),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.PARTS.create_new_module_checkbox(
								Handy.cc.nopeus_interaction.no_hold,
								"nopeus_interaction_no_hold",
								{
									Handy.UI.PARTS.localize_keybind_label("nopeus_interaction"),
								}
							),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.PARTS.create_new_module_checkbox(
								Handy.cc.animation_skip.no_hold,
								"animation_skip_no_hold",
								{
									Handy.UI.PARTS.localize_keybind_label("animation_skip"),
								}
							),
						},
					},
				},
			},
		}
	end
	if result then
		result = {
			n = G.UIT.ROOT,
			config = { colour = G.C.CLEAR, align = "cm", padding = 0.05, minh = 6, maxh = 6 },
			nodes = result,
		}
	end
	return result, 2
end

-- Tabs definitions

Handy.UI.get_config_tab_overall = function()
	local gamepad = Handy.controller.is_gamepad()
	return {
		{
			n = G.UIT.R,
			config = { padding = 0.05, align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
					nodes = {
						create_option_cycle({
							w = 6,
							label = localize("b_handy_info_popups_level_select"),
							scale = 0.8,
							options = localize("handy_info_popups_level_opt"),
							opt_callback = "handy_change_notifications_level",
							current_option = Handy.cc.notifications_level,
						}),
					},
				},
				{
					n = G.UIT.C,
					nodes = {
						create_option_cycle({
							w = 6,
							label = localize("b_handy_keybinds_trigger_mode_select"),
							scale = 0.8,
							options = localize("handy_keybinds_trigger_mode_opt"),
							opt_callback = "handy_change_keybinds_trigger_mode",
							current_option = Handy.cc.keybinds_trigger_mode,
						}),
					},
				},
				{
					n = G.UIT.C,
					nodes = {
						create_option_cycle({
							w = 6,
							label = localize("b_handy_device_select"),
							scale = 0.8,
							options = localize("handy_device_opt"),
							opt_callback = "handy_change_current_device",
							current_option = Handy.cc.current_device,
						}),
					},
				},
			},
		},
		{ n = G.UIT.R, config = { padding = 0.05 }, nodes = {} },
		{
			n = G.UIT.R,
			config = {
				align = "cm",
			},
			nodes = {
				{
					n = G.UIT.R,
					config = {
						padding = 0.25,
						r = 0.5,
						colour = adjust_alpha(HEX("000000"), 0.1),
					},
					nodes = {
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.handy,
							"handy",
							{ Handy.version, "SleepyG11" },
							{ full_width = true }
						),
					},
				},
			},
		},
		{ n = G.UIT.R, config = { minh = 0.25 } },
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.insta_highlight,
							(
								Handy.controller.resolve_first_module_key(Handy.cc.insta_highlight, true)
										== "mouse1"
									and "insta_highlight_OUTSIDE"
								or "insta_highlight"
							),
							{
								Handy.UI.PARTS.localize_keybind("Left Mouse", true),
							},
							{
								only_first = true,
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.insta_highlight.allow_deselect,
							"insta_unhighlight",
							{ Handy.UI.PARTS.localize_keybind_label("quick_highlight") }
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.regular_keybinds, "regular_keybinds"),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.show_deck_preview, "show_deck_preview"),
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.hide_options_button, "hide_options_button"),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.deselect_hand, "deselect_hand", {
							Handy.UI.PARTS.localize_keybind("Right Mouse", true),
						}),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.insta_cash_out, "insta_cash_out"),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.insta_booster_skip, "insta_booster_skip"),
					},
				},
			},
		},
		{ n = G.UIT.R, config = { minh = 0.4 } },
		{
			n = G.UIT.R,
			config = { padding = 0.1, align = "cm" },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = localize({
							type = "variable",
							key = gamepad and "Handy_overall_guide_gamepad" or "Handy_overall_guide_button",
							vars = {
								localize("Keybinds Paginated", "handy_tabs"),
							},
						}),
						scale = 0.3,
						colour = { 1, 1, 1, 0.6 },
						align = "cm",
					},
				},
			},
		},
		-- { n = G.UIT.R, config = { minh = 0.25 } },
	}
end
Handy.UI.get_config_tab_quick_paginated = function()
	local gamepad = Handy.controller.is_gamepad()
	local page_definition, max_page = Handy.UI.get_quick_page(Handy.UI.quick_page or 1)
	local options = {}
	for i = 1, max_page do
		table.insert(options, localize("k_page") .. " " .. tostring(i) .. "/" .. tostring(max_page))
	end
	return {
		{
			n = G.UIT.R,
			config = {
				align = "cm",
			},
			nodes = {
				{
					n = G.UIT.O,
					config = {
						id = "handy_quick_page_content",
						object = UIBox({
							definition = page_definition,
							config = {
								colour = G.C.CLEAR,
								align = "cm",
							},
						}),
						align = "cm",
					},
				},
			},
		},
		{ n = G.UIT.R, config = { minh = 0.1 } },
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				create_option_cycle({
					options = options,
					w = 4.5,
					cycle_shoulders = true,
					opt_callback = "handy_change_quick_page",
					current_option = Handy.UI.quick_page or 1,
					colour = G.C.RED,
					no_pips = true,
					focus_args = { nav = "wide" },
					scale = 0.8,
				}),
			},
		},
	}
end
Handy.UI.get_config_tab_keybinds_paginated = function()
	local gamepad = Handy.controller.is_gamepad()
	local page_definition, max_page = Handy.UI.get_keybinds_page(Handy.UI.keybinds_page or 1)
	local options = {}
	for i = 1, max_page do
		table.insert(options, localize("k_page") .. " " .. tostring(i) .. "/" .. tostring(max_page))
	end
	return {
		{
			n = G.UIT.R,
			config = {
				align = "cm",
			},
			nodes = {
				{
					n = G.UIT.O,
					config = {
						id = "handy_keybinds_page_content",
						object = UIBox({
							definition = page_definition,
							config = {
								colour = G.C.CLEAR,
								align = "cm",
							},
						}),
						align = "cm",
					},
				},
			},
		},
		{ n = G.UIT.R, config = { minh = 0.05 } },
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				create_option_cycle({
					options = options,
					w = 4.5,
					cycle_shoulders = true,
					opt_callback = "handy_change_keybinds_page",
					current_option = Handy.UI.keybinds_page or 1,
					colour = G.C.RED,
					no_pips = true,
					focus_args = { nav = "wide" },
					scale = 0.8,
				}),
			},
		},
		{ n = G.UIT.R, config = { minh = 0.15 } },
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = localize({
							type = "variable",
							key = gamepad and "Handy_keybinds_guide_gamepad" or "Handy_keybinds_guide_desktop",
							vars = {
								Handy.UI.PARTS.localize_keybind(gamepad and "(Back)" or "Escape", true),
							},
						}),
						scale = 0.3,
						colour = { 1, 1, 1, 0.6 },
						align = "cm",
					},
				},
			},
		},
	}
end
Handy.UI.get_config_tab_presets = function()
	local gamepad = Handy.controller.is_gamepad()
	return {
		{
			n = G.UIT.R,
			config = { padding = 0.1, align = "cm" },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = localize("ph_handy_premade_presets"),
						scale = 0.4,
						colour = G.C.WHITE,
						align = "cm",
					},
				},
			},
		},
		{ n = G.UIT.R, config = { minh = 0.1 } },
		Handy.UI.PARTS.create_example_preset("default"),
		Handy.UI.PARTS.create_example_preset("better_mouse_and_gamepad"),
		{ n = G.UIT.R, config = { minh = 0.2 } },
		{
			n = G.UIT.R,
			config = { padding = 0.1, align = "cm" },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = localize("ph_handy_custom_presets"),
						scale = 0.4,
						colour = G.C.WHITE,
						align = "cm",
					},
				},
			},
		},
		{ n = G.UIT.R, config = { minh = 0.1 } },
		Handy.UI.PARTS.create_user_preset(1),
		Handy.UI.PARTS.create_user_preset(2),
		Handy.UI.PARTS.create_user_preset(3),
		{ n = G.UIT.R, config = { minh = 0.15 } },
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.R,
					config = {
						colour = adjust_alpha(HEX("000000"), 0.1),
						align = "cm",
						padding = 0.25,
						r = 0.5,
					},
					nodes = {
						{
							n = G.UIT.C,
							config = {
								padding = 0.05,
							},
							nodes = {
								Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_1, "presets_load_1"),
								Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_2, "presets_load_2"),
								Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_3, "presets_load_3"),
								Handy.UI.PARTS.create_module_keybind(Handy.cc.presets.load_next, "presets_load_next"),
							},
						},
					},
				},
			},
		},
		{ n = G.UIT.R, config = { minh = 0.25 } },
		{
			n = G.UIT.R,
			config = { padding = 0.1, align = "cm" },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = localize({
							type = "variable",
							key = "Handy_presets_guide",
							vars = {},
						}),
						scale = 0.3,
						colour = { 1, 1, 1, 0.6 },
						align = "cm",
					},
				},
			},
		},
	}
end
Handy.UI.get_config_tab_dangerous = function()
	local gamepad = Handy.controller.is_gamepad()
	return {
		{
			n = G.UIT.R,
			config = {
				align = "cm",
			},
			nodes = {
				{
					n = G.UIT.R,
					config = {
						padding = 0.25,
						r = 0.5,
						colour = adjust_alpha(HEX("000000"), 0.1),
					},
					nodes = {
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.dangerous_actions,
							"dangerous_actions",
							nil,
							{ full_width = true }
						),
					},
				},
			},
		},
		{ n = G.UIT.R, config = { minh = 0.25 } },
		{
			n = G.UIT.R,
			nodes = {
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.dangerous_actions.nopeus_unsafe,
							"nopeus_unsafe"
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.dangerous_actions.immediate_buy_and_sell,
							"immediate_buy_and_sell",
							{
								Handy.UI.PARTS.format_new_module_keys(Handy.cc.insta_buy_or_sell, true),
								Handy.UI.PARTS.localize_keybind_label("dangerous_modifier"),
								Handy.UI.PARTS.localize_keybind_label("quick_buy_or_sell"),
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.dangerous_actions.immediate_buy_and_sell.queue,
							"immediate_buy_and_sell_queue"
						),
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.dangerous_actions.animation_skip_unsafe,
							"animation_skip_unsafe"
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.dangerous_actions.sell_all_same,
							"sell_all_same",
							{
								Handy.UI.PARTS.format_new_module_keys(
									Handy.cc.dangerous_actions.immediate_buy_and_sell,
									true
								),
								Handy.UI.PARTS.localize_keybind_label("dangerous_modifier"),
								Handy.UI.PARTS.localize_keybind_label("dangerous_all_same_modifier"),
							},
							{
								only_first = true,
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.dangerous_actions.sell_all, "sell_all", {
							Handy.UI.PARTS.localize_keybind_label("dangerous_modifier"),
							Handy.UI.PARTS.localize_keybind_label("dangerous_all_modifier"),
						}, {
							only_first = true,
						}),
					},
				},
			},
		},
		{ n = G.UIT.R, config = { minh = 0.25 } },
		Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.dangerous_actions.card_remove, "card_remove", {
			Handy.UI.PARTS.localize_keybind_label("dangerous_modifier"),
			Handy.UI.PARTS.localize_keybind_label("dangerous_remove_modifier"),
			Handy.UI.PARTS.localize_keybind_label("quick_buy_or_sell"),
			Handy.UI.PARTS.localize_keybind_label("dangerous_all_same_modifier"),
			Handy.UI.PARTS.localize_keybind_label("dangerous_all_modifier"),
		}, {
			only_first = true,
		}),
		{ n = G.UIT.R, config = { minh = 0.25 } },
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.R,
					config = {
						colour = adjust_alpha(HEX("000000"), 0.1),
						align = "cm",
						padding = 0.25,
						r = 0.5,
					},
					nodes = {
						{
							n = G.UIT.C,
							config = {
								padding = 0.05,
							},
							nodes = {
								Handy.UI.PARTS.create_module_keybind(
									Handy.cc.insta_buy_or_sell,
									"quick_buy_or_sell",
									{ rerender = true }
								),
								Handy.UI.PARTS.create_module_keybind(
									Handy.cc.dangerous_actions.immediate_buy_and_sell,
									"dangerous_modifier",
									{ dangerous = true, rerender = true, only_holdable = true }
								),
								Handy.UI.PARTS.create_module_keybind(
									Handy.cc.dangerous_actions.sell_all_same,
									"dangerous_all_same_modifier",
									{ dangerous = true, rerender = true, only_holdable = true }
								),
								Handy.UI.PARTS.create_module_keybind(
									Handy.cc.dangerous_actions.sell_all,
									"dangerous_all_modifier",
									{ dangerous = true, rerender = true, only_holdable = true }
								),
								Handy.UI.PARTS.create_module_keybind(
									Handy.cc.dangerous_actions.card_remove,
									"dangerous_remove_modifier",
									{ dangerous = true, rerender = true, only_holdable = true }
								),
							},
						},
					},
				},
			},
		},
		{ n = G.UIT.R, config = { minh = 0.25 } },
		{
			n = G.UIT.R,
			config = { padding = 0.05, align = "cm" },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = localize({
							type = "variable",
							key = "Handy_danger_zone_guide",
							vars = {},
						}),
						scale = 0.3,
						colour = { 1, 1, 1, 0.6 },
						align = "cm",
					},
				},
			},
		},
	}
end

-- Tabs order

Handy.UI.PARTS.tabs_list = {
	["Overall"] = {
		definition = function()
			return Handy.UI.get_config_tab_overall()
		end,
	},
	["Quick"] = {
		definition = function()
			return Handy.UI.get_config_tab_quick_paginated()
		end,
	},
	["Keybinds"] = {
		definition = function()
			return Handy.UI.get_config_tab_regular_keybinds()
		end,
	},
	["Keybinds 2"] = {
		definition = function()
			return Handy.UI.get_config_tab_keybinds_2()
		end,
	},
	["Keybinds Paginated"] = {
		definition = function()
			return Handy.UI.get_config_tab_keybinds_paginated()
		end,
	},
	["Dangerous"] = {
		definition = function()
			return Handy.UI.get_config_tab_dangerous()
		end,
	},
	["Presets"] = {
		definition = function()
			return Handy.UI.get_config_tab_presets()
		end,
	},
}
Handy.UI.PARTS.tabs_order = {
	"Overall",
	"Quick",
	-- "Keybinds",
	-- "Keybinds 2",
	"Keybinds Paginated",
	"Presets",
	"Dangerous",
}

-- Getters

function Handy.UI.get_config_tab(_tab, _index)
	local result = {
		n = G.UIT.ROOT,
		config = { align = "cm", padding = 0.05, colour = G.C.CLEAR, minh = 5, minw = 5 },
		nodes = {},
	}
	Handy.UI.config_tab_index = _index
	result.nodes = Handy.UI.PARTS.tabs_list[_tab].definition()
	return result
end
function Handy.UI.get_options_tabs()
	local result = {}
	for index, k in ipairs(Handy.UI.PARTS.tabs_order) do
		table.insert(result, {
			label = localize(k, "handy_tabs"),
			tab_definition_function = function()
				return Handy.UI.get_config_tab(k, index)
			end,
		})
	end
	return result
end
