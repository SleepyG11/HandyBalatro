-- Paginated content

Handy.UI.get_keybinds_page = function(page)
	local result = {}
	if page == 1 then
		result = {
			Handy.UI.PARTS.create_module_section("hand_selection"),
			Handy.UI.CD.insta_highlight.keybind(),
			Handy.UI.CD.insta_highlight_entire_f_hand.keybind(),
			Handy.UI.CD.deselect_hand.keybind(),
			Handy.UI.PARTS.create_module_section("hand"),
			Handy.UI.CD.regular_keybinds_play_hand.keybind(),
			Handy.UI.CD.regular_keybinds_discard.keybind(),
			Handy.UI.CD.regular_keybinds_sort_by_rank.keybind(),
			Handy.UI.CD.regular_keybinds_sort_by_suit.keybind(),
			Handy.UI.CD.regular_keybinds_toggle_sort.keybind(),
			Handy.UI.PARTS.create_module_section("menus"),
			Handy.UI.CD.regular_keybinds_run_info_hands.keybind(),
			Handy.UI.CD.regular_keybinds_run_info_blinds.keybind(),
			Handy.UI.CD.regular_keybinds_view_deck.keybind(),
			Handy.UI.CD.show_deck_preview.keybind(),
		}
	elseif page == 2 then
		result = {
			Handy.UI.PARTS.create_module_section("round"),
			Handy.UI.CD.insta_cash_out.keybind(),
			Handy.UI.CD.not_just_yet_interaction.keybind(),
			Handy.UI.PARTS.create_module_section("shop"),
			Handy.UI.CD.insta_booster_skip.keybind(),
			Handy.UI.CD.regular_keybinds_reroll_shop.keybind(),
			Handy.UI.CD.regular_keybinds_leave_shop.keybind(),
			Handy.UI.PARTS.create_module_section("blinds"),
			Handy.UI.CD.regular_keybinds_skip_blind.keybind(),
			Handy.UI.CD.regular_keybinds_select_blind.keybind(),
			Handy.UI.CD.regular_keybinds_reroll_boss.keybind(),
			Handy.UI.PARTS.create_module_section("quick_actions"),
			Handy.UI.CD.insta_buy_or_sell.keybind(),
			Handy.UI.CD.insta_buy_n_sell.keybind(),
			Handy.UI.CD.insta_use.keybind(),
			Handy.UI.CD.cryptid_code_use_last_interaction.keybind(),
		}
	elseif page == 3 then
		result = {
			Handy.UI.PARTS.create_module_section("gamespeed"),
			Handy.UI.CD.speed_multiplier.keybind(),
			Handy.UI.CD.speed_multiplier_multiply.keybind(),
			Handy.UI.CD.speed_multiplier_divide.keybind(),
			Handy.UI.PARTS.create_module_section("animations"),
			Handy.UI.CD.animation_skip.keybind(),
			Handy.UI.CD.animation_skip_increase.keybind(),
			Handy.UI.CD.animation_skip_decrease.keybind(),
			Handy.UI.CD.nopeus_interaction.keybind(),
			Handy.UI.CD.nopeus_interaction_increase.keybind(),
			Handy.UI.CD.nopeus_interaction_decrease.keybind(),
			Handy.UI.CD.scoring_hold.keybind(),
		}
	elseif page == 4 then
		result = {
			Handy.UI.PARTS.create_module_section("highlight_movement"),
			Handy.UI.CD.move_highlight_one_left.keybind(),
			Handy.UI.CD.move_highlight_one_right.keybind(),
			Handy.UI.CD.move_highlight_move_card.keybind(),
			Handy.UI.CD.move_highlight_to_end.keybind(),
			Handy.UI.PARTS.create_module_section("presets"),
			Handy.UI.CD.presets_load_1.keybind(),
			Handy.UI.CD.presets_load_2.keybind(),
			Handy.UI.CD.presets_load_3.keybind(),
			Handy.UI.CD.presets_load_next.keybind(),
			Handy.UI.PARTS.create_module_section("dangerous_actions"),
			Handy.UI.CD.immediate_buy_and_sell.keybind(),
			Handy.UI.CD.sell_all_same_modifier.keybind(),
			Handy.UI.CD.sell_all_modifier.keybind(),
			Handy.UI.CD.remove_modifier.keybind(),
		}
	elseif page == 5 then
		result = {
			Handy.UI.PARTS.create_module_section("misc"),
			Handy.UI.CD.misc_open_mod_settings.keybind(),
			Handy.UI.CD.misc_save_run.keybind(),
			Handy.UI.CD.misc_quick_restart.keybind(),
			Handy.UI.CD.misc_crash.keybind(),
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
				minh = 8.1,
				maxh = 8.1,
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
	return result, 5
end
Handy.UI.get_quick_page = function(page)
	local gamepad = Handy.controller.is_gamepad()
	local result = {}
	if page == 1 then
		result = {
			{
				n = G.UIT.R,
				config = { padding = 0.05, align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						nodes = {
							Handy.UI.CD.buy_sell_use_mode.option_cycle({ compress = gamepad }),
						},
					},
				},
			},
			Handy.UI.PARTS.create_separator_r(0.05),
			Handy.UI.CD.move_highlight.checkbox({ full_width = true }),
			Handy.UI.PARTS.create_separator_r(),
			{
				n = G.UIT.R,
				nodes = {
					{
						n = G.UIT.C,
						config = { minw = 4 },
						nodes = {
							Handy.UI.CD.insta_buy_or_sell.checkbox(),
							Handy.UI.PARTS.create_separator_r(),
							Handy.UI.CD.insta_buy_n_sell.checkbox(),
							Handy.UI.PARTS.create_separator_r(),
							Handy.UI.CD.insta_use.checkbox(),
						},
					},
					{
						n = G.UIT.C,
						config = { minw = 4 },
						nodes = {
							Handy.UI.CD.insta_highlight_entire_f_hand.checkbox(),
							Handy.UI.PARTS.create_separator_r(),
							Handy.UI.CD.cryptid_code_use_last_interaction.checkbox(),
							Handy.UI.PARTS.create_separator_r(),
							Handy.UI.CD.not_just_yet_interaction.checkbox(),
						},
					},
				},
			},
			-- Handy.UI.PARTS.create_separator_r(),
		}
	elseif page == 2 then
		result = {
			not gamepad and {
				n = G.UIT.R,
				config = { padding = 0.05, align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						nodes = {
							Handy.UI.CD.speed_multiplier_default_value.option_cycle(),
						},
					},
					{
						n = G.UIT.C,
						nodes = {
							Handy.UI.CD.animation_skip_default_value.option_cycle(),
						},
					},
				},
			} or nil,
			gamepad and {
				n = G.UIT.R,
				config = { padding = 0, align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						nodes = {
							Handy.UI.CD.speed_multiplier_default_value.option_cycle({ compress = true }),
						},
					},
					{
						n = G.UIT.R,
						nodes = {
							Handy.UI.CD.animation_skip_default_value.option_cycle({ compress = true }),
						},
					},
				},
			} or nil,
			Handy.UI.PARTS.create_separator_r(),
			{
				n = G.UIT.R,
				nodes = {
					{
						n = G.UIT.C,
						config = { minw = 4 },
						nodes = {
							Handy.UI.CD.speed_multiplier.checkbox(),
							Handy.UI.PARTS.create_separator_r(),
							Handy.UI.CD.animation_skip.checkbox(),
							Handy.UI.PARTS.create_separator_r(),
							Handy.UI.CD.nopeus_interaction.checkbox(),
							Handy.UI.PARTS.create_separator_r(),
							Handy.UI.CD.scoring_hold.checkbox(),
						},
					},
					{
						n = G.UIT.C,
						config = { minw = 4 },
						nodes = {
							Handy.UI.CD.speed_multiplier_no_hold.checkbox(),
							Handy.UI.PARTS.create_separator_r(),
							Handy.UI.CD.animation_skip_no_hold.checkbox(),
							Handy.UI.PARTS.create_separator_r(),
							Handy.UI.CD.nopeus_interaction_no_hold.checkbox(),
							Handy.UI.PARTS.create_separator_r(),
							Handy.UI.CD.scoring_hold_any_moment.checkbox(),
						},
					},
				},
			},
		}
	end
	if result then
		result = {
			n = G.UIT.ROOT,
			config = { colour = G.C.CLEAR, align = "cm", padding = 0.05, minh = 6.5, maxh = 6.5 },
			nodes = result,
		}
	end
	return result, 2
end
Handy.UI.get_search_no_result_page = function()
	local function create_input_button(label, value)
		return UIBox_button({
			label = { label },
			button = "handy_apply_search_with_value",
			ref_table = { handy_search_input_value = value },
			scale = 0.3,
			minw = 3.5,
			maxw = 3.5,
			minh = 0.4,
			maxh = 0.4,
			colour = G.C.CHIPS,
		})
	end

	return {
		{
			n = G.UIT.C,
			config = { align = "cm", padding = 0.5 },
			nodes = {
				{
					n = G.UIT.R,
					config = {
						align = "cm",
					},
					nodes = {
						{
							n = G.UIT.T,
							config = {
								text = localize("ph_handy_search_no_results"),
								colour = G.C.WHITE,
								scale = 0.4,
								align = "cm",
							},
						},
					},
				},
				{
					n = G.UIT.R,
					config = {
						align = "cm",
						padding = 0.05,
					},
					nodes = {
						{
							n = G.UIT.C,
							config = { padding = 0.05, align = "cm" },
							nodes = {
								create_input_button(
									Handy.UI.PARTS.localize_keybind_label("quick_highlight", true),
									"fast hand selection"
								),
								create_input_button(
									localize("gamespeed", "handy_keybind_sections"),
									"speed multiplier"
								),
								create_input_button(localize("animations", "handy_keybind_sections"), "animation"),
							},
						},
						Handy.UI.PARTS.create_separator_c(),
						{
							n = G.UIT.C,
							config = { padding = 0.05, align = "cm" },
							nodes = {
								create_input_button(localize("Keybinds", "handy_tabs"), "regular keybinds"),
								create_input_button(localize("misc", "handy_keybind_sections"), "miscellaneous"),
								create_input_button(localize("Dangerous", "handy_tabs"), "dangerous"),
							},
						},
					},
				},
			},
		},
	}
end
Handy.UI.get_search_result_page = function(result)
	local keybinds_limit = 14
	local checkboxes_limit = 7
	local result_keybinds = {}
	local result_checkboxes = {}

	table.sort(result, function(a, b)
		return (Handy.UI.CD[a].order or 1) < (Handy.UI.CD[b].order or 1)
	end)

	local used_buffer = {
		checkbox = {},
		keybind = {},
		option_cycle = {},
	}

	Handy.UI.is_in_search_result_page = true
	for _, key in ipairs(result) do
		local item = Handy.UI.CD[key]
		if item.keybind and not item.keybind_group then
			if #result_keybinds < keybinds_limit then
				used_buffer.keybind[key] = item
				local render = item.keybind()
				if render then
					table.insert(result_keybinds, render)
				end
			end
		end
		if item.checkbox and not item.checkbox_group then
			if #result_checkboxes < checkboxes_limit then
				used_buffer.checkbox[key] = item
				local render = item.checkbox()
				if render then
					table.insert(result_checkboxes, render)
				end
			end
		end
		if item.option_cycle and not item.option_cycle_group then
			if #result_checkboxes < checkboxes_limit then
				used_buffer.option_cycle[key] = item
				local render = item.option_cycle({ compress = true })
				if render then
					table.insert(result_checkboxes, render)
				end
			end
		end
	end
	for _, key in ipairs(result) do
		local item = Handy.UI.CD[key]
		if item.keybind and item.keybind_group and not used_buffer.keybind[item.keybind_group] then
			if #result_keybinds < keybinds_limit then
				used_buffer.keybind[item.keybind_group] = Handy.UI.CD[item.keybind_group]
				local render = item.keybind()
				if render then
					table.insert(result_keybinds, render)
				end
			end
		end
		if item.checkbox and item.checkbox_group and not used_buffer.checkbox[item.checkbox_group] then
			if #result_checkboxes < checkboxes_limit then
				used_buffer.checkbox[item.checkbox_group] = Handy.UI.CD[item.checkbox_group]
				local render = item.checkbox()
				if render then
					table.insert(result_checkboxes, render)
				end
			end
		end
		if item.option_cycle and item.option_cycle_group and not used_buffer.option_cycle[item.option_cycle_group] then
			if #result_checkboxes < checkboxes_limit then
				used_buffer.option_cycle[item.option_cycle_group] = Handy.UI.CD[item.option_cycle_group]
				local render = item.option_cycle({ compress = true })
				if render then
					table.insert(result_checkboxes, render)
				end
			end
		end
	end
	Handy.UI.is_in_search_result_page = nil

	return {
		#result_keybinds > 0 and {
			n = G.UIT.C,
			config = {
				colour = adjust_alpha(HEX("000000"), 0.1),
				align = "cm",
				padding = 0.25,
				r = 0.5,
				minh = 7,
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						padding = 0.05,
					},
					nodes = Handy.utils.table_slice(result_keybinds, 14),
				},
			},
		} or nil,
		Handy.UI.PARTS.create_separator_c(),
		{
			n = G.UIT.C,
			config = { padding = 0.05, minh = 7 },
			nodes = Handy.utils.table_slice(result_checkboxes, 7),
		},
	}
end

-- Tabs definitions

Handy.UI.get_config_tab_overall = function()
	local gamepad = Handy.controller.is_gamepad()
	return {
		not gamepad and {
			n = G.UIT.R,
			config = { padding = 0.05, align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
					nodes = {
						Handy.UI.CD.info_popups_level.option_cycle(),
					},
				},
				{
					n = G.UIT.C,
					nodes = {
						Handy.UI.CD.keybinds_trigger_mode.option_cycle(),
					},
				},
				{
					n = G.UIT.C,
					nodes = {
						Handy.UI.CD.device_select.option_cycle(),
					},
				},
			},
		} or nil,
		Handy.UI.PARTS.create_separator_r(0.05),
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
						Handy.UI.CD.handy.checkbox({ full_width = true }),
					},
				},
			},
		},
		gamepad and Handy.UI.PARTS.create_separator_r(gamepad and 0.125) or nil,
		gamepad and {
			n = G.UIT.R,
			config = { padding = 0, align = "cm" },
			nodes = {
				{
					n = G.UIT.R,
					nodes = {
						Handy.UI.CD.info_popups_level.option_cycle({ compress = true }),
					},
				},
				{
					n = G.UIT.R,
					nodes = {
						Handy.UI.CD.keybinds_trigger_mode.option_cycle({ compress = true }),
					},
				},
				{
					n = G.UIT.R,
					nodes = {
						Handy.UI.CD.device_select.option_cycle({ compress = true }),
					},
				},
			},
		} or nil,
		Handy.UI.PARTS.create_separator_r(gamepad and 0.125 or nil),
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.CD.insta_highlight.checkbox(),
						Handy.UI.PARTS.create_separator_r(),
						Handy.UI.CD.insta_unhighlight.checkbox(),
						Handy.UI.PARTS.create_separator_r(),
						Handy.UI.CD.regular_keybinds.checkbox(),
						Handy.UI.PARTS.create_separator_r(),
						Handy.UI.CD.show_deck_preview.checkbox(),
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.CD.hide_options_button.checkbox(),
						Handy.UI.PARTS.create_separator_r(),
						Handy.UI.CD.deselect_hand.checkbox(),
						Handy.UI.PARTS.create_separator_r(),
						Handy.UI.CD.insta_cash_out.checkbox(),
						Handy.UI.PARTS.create_separator_r(),
						Handy.UI.CD.insta_booster_skip.checkbox(),
					},
				},
			},
		},
		Handy.UI.PARTS.create_separator_r(0.4),
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
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = localize({
							type = "variable",
							key = gamepad and "Handy_popups_guide_gamepad" or "Handy_popups_guide",
							vars = {},
						}) .. " " .. localize({
							type = "variable",
							key = "Handy_search_guide",
							vars = {
								localize("Search", "handy_tabs"),
							},
						}),
						scale = 0.3,
						colour = { 1, 1, 1, 0.6 },
						align = "cm",
					},
				},
			},
		},
		-- Handy.UI.PARTS.create_separator_r(),
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
		Handy.UI.PARTS.create_separator_r(0.1),
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
		Handy.UI.PARTS.create_separator_r(0.05),
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
		Handy.UI.PARTS.create_separator_r(0.15),
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
		Handy.UI.PARTS.create_separator_r(0.1),
		Handy.UI.PARTS.create_example_preset("default"),
		Handy.UI.PARTS.create_example_preset("better_mouse_and_gamepad"),
		Handy.UI.PARTS.create_separator_r(0.2),
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
		Handy.UI.PARTS.create_separator_r(0.1),
		Handy.UI.PARTS.create_user_preset(1),
		Handy.UI.PARTS.create_user_preset(2),
		Handy.UI.PARTS.create_user_preset(3),
		Handy.UI.PARTS.create_separator_r(0.15),
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
								Handy.UI.CD.presets_load_1.keybind(),
								Handy.UI.CD.presets_load_2.keybind(),
								Handy.UI.CD.presets_load_3.keybind(),
								Handy.UI.CD.presets_load_next.keybind(),
							},
						},
					},
				},
			},
		},
		Handy.UI.PARTS.create_separator_r(0.25),
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
						Handy.UI.CD.dangerous_actions.checkbox({ full_width = true }),
					},
				},
			},
		},
		Handy.UI.PARTS.create_separator_r(),
		{
			n = G.UIT.R,
			nodes = {
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.PARTS.create_separator_r(),
						Handy.UI.CD.dangerous_speed_multiplier_uncap.checkbox(),
						Handy.UI.PARTS.create_separator_r(),
						Handy.UI.CD.dangerous_nopeus_unsafe.checkbox(),
						Handy.UI.PARTS.create_separator_r(),
						Handy.UI.CD.dangerous_animation_skip_unsafe.checkbox(),
						Handy.UI.PARTS.create_separator_r(),
						Handy.UI.CD.immediate_buy_and_sell_queue.checkbox(),
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.CD.immediate_buy_and_sell.checkbox(),
						Handy.UI.PARTS.create_separator_r(),
						Handy.UI.CD.sell_all_same_modifier.checkbox(),
						Handy.UI.PARTS.create_separator_r(),
						Handy.UI.CD.sell_all_modifier.checkbox(),
						Handy.UI.PARTS.create_separator_r(),
						Handy.UI.CD.remove_modifier.checkbox(),
					},
				},
			},
		},

		Handy.UI.PARTS.create_separator_r(),
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
								Handy.UI.CD.insta_buy_or_sell.keybind({ rerender = true }),
								Handy.UI.CD.immediate_buy_and_sell.keybind({ rerender = true }),
								Handy.UI.CD.sell_all_same_modifier.keybind({ rerender = true }),
								Handy.UI.CD.sell_all_modifier.keybind({ rerender = true }),
								Handy.UI.CD.remove_modifier.keybind({ rerender = true }),
							},
						},
					},
				},
			},
		},
		Handy.UI.PARTS.create_separator_r(),
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
Handy.UI.get_config_tab_search = function()
	local result = Handy.UI.search(Handy.UI.search_input_value or "")
	local result_content = {}
	if #result > 0 then
		result_content = Handy.UI.get_search_result_page(result)
	else
		result_content = Handy.UI.get_search_no_result_page()
	end
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
						align = "cm",
						minw = 14,
					},
					nodes = {
						{
							n = G.UIT.R,
							config = { align = "cm" },
							nodes = {
								{
									n = G.UIT.C,
									config = {},
									nodes = {
										create_text_input({
											w = 4,
											max_length = 32,
											ref_table = Handy.UI,
											ref_value = "search_input_value",
											extended_corpus = true,
											id = "handy_search",
											prompt_text = localize("b_handy_search_placeholder"),
											callback = function()
												if not Handy.controller.is_gamepad() then
													Handy.UI.render_search_results(true)
												end
											end,
										}),
									},
								},
								Handy.UI.PARTS.create_separator_c(),
								UIBox_button({
									label = { localize("b_handy_clear") },
									col = true,
									colour = G.C.MULT,
									scale = 0.4,
									minh = 0.6,
									maxh = 0.6,
									minw = 2,
									maxw = 2,
									button = "handy_clear_search",
								}),
								Handy.UI.PARTS.create_separator_c(0.05),
								UIBox_button({
									label = { localize("b_handy_search") },
									col = true,
									colour = G.C.CHIPS,
									scale = 0.4,
									minh = 0.6,
									maxh = 0.6,
									minw = 2,
									maxw = 2,
									button = "handy_apply_search",
								}),
							},
						},
					},
				},
				Handy.UI.PARTS.create_separator_r(),
				{
					n = G.UIT.R,
					config = {
						align = "cm",
					},
					nodes = result_content,
				},
			},
		},
	}
end

function Handy.UI.render_search_results(rerender)
	G.E_MANAGER:add_event({
		blocking = false,
		blockable = false,
		no_pause = true,
		no_delete = true,
		func = function()
			Handy.UI.rerender(true)
			return true
		end,
	})
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
	["Search"] = {
		definition = function()
			return Handy.UI.get_config_tab_search()
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
	"Search",
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
