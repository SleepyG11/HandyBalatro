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
							Handy.UI.CD.insta_buy_or_sell.checkbox(),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.CD.insta_buy_n_sell.checkbox(),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.CD.insta_use.checkbox(),
						},
					},
					{
						n = G.UIT.C,
						config = { minw = 4 },
						nodes = {
							Handy.UI.CD.insta_highlight_entire_f_hand.checkbox(),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.CD.cryptid_code_use_last_interaction.checkbox(),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.CD.not_just_yet_interaction.checkbox(),
						},
					},
				},
			},
			-- { n = G.UIT.R, config = { minh = 0.25 } },
		}
	elseif page == 2 then
		result = {
			Handy.UI.CD.move_highlight.checkbox(),
			{ n = G.UIT.R, config = { minh = 0.25 } },
			{
				n = G.UIT.R,
				nodes = {
					{
						n = G.UIT.C,
						config = { minw = 4 },
						nodes = {
							Handy.UI.CD.speed_multiplier.checkbox(),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.CD.animation_skip.checkbox(),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.CD.nopeus_interaction.checkbox(),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.CD.scoring_hold.checkbox(),
						},
					},
					{
						n = G.UIT.C,
						config = { minw = 4 },
						nodes = {
							Handy.UI.CD.speed_multiplier_no_hold.checkbox(),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.CD.animation_skip_no_hold.checkbox(),
							{ n = G.UIT.R, config = { minh = 0.25 } },
							Handy.UI.CD.nopeus_interaction_no_hold.checkbox(),
							{ n = G.UIT.R, config = { minh = 0.25 } },
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
						Handy.UI.CD.insta_highlight.checkbox(),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.CD.insta_unhighlight.checkbox(),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.CD.regular_keybinds.checkbox(),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.CD.show_deck_preview.checkbox(),
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.CD.hide_options_button.checkbox(),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.CD.deselect_hand.checkbox(),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.CD.insta_cash_out.checkbox(),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.CD.insta_booster_skip.checkbox(),
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
						Handy.UI.CD.dangerous_modifier.checkbox(),
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
						Handy.UI.CD.dangerous_nopeus_unsafe.checkbox(),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.CD.immediate_buy_and_sell.checkbox(),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.CD.immediate_buy_and_sell_queue.checkbox(),
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.CD.dangerous_animation_skip_unsafe.checkbox(),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.CD.sell_all_same_modifier.checkbox(),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.CD.sell_all_modifier.checkbox(),
					},
				},
			},
		},
		{ n = G.UIT.R, config = { minh = 0.25 } },
		Handy.UI.CD.remove_modifier.checkbox(),
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
								Handy.UI.CD.insta_buy_or_sell.keybind(),
								Handy.UI.CD.immediate_buy_and_sell.keybind(),
								Handy.UI.CD.sell_all_same_modifier.keybind(),
								Handy.UI.CD.sell_all_modifier.keybind(),
								Handy.UI.CD.remove_modifier.keybind(),
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
