Handy.UI.PARTS = {
	localize_keybind = function(key)
		if not key then
			key = "None"
		end
		return G.localization.misc.handy_keybinds[key] or key
	end,

	format_new_module_keys = function(module, only_first)
		local key_1, key_2 = "key_1", "key_2"
		if Handy.controller.is_gamepad() then
			key_1, key_2 = "key_1_gamepad", "key_2_gamepad"
		end

		local keys_table = {
			[key_1] = module[key_1] ~= "None" and module[key_1] or nil,
			[key_2] = module[key_2] ~= "None" and module[key_2] or nil,
		}

		local keys_count = 0
		if keys_table[key_1] then
			keys_count = keys_count + 1
		end
		if keys_table[key_2] then
			keys_count = keys_count + 1
		end

		if only_first or keys_count < 2 then
			return localize({
				type = "variable",
				key = "Handy_module_keys_single",
				vars = { Handy.UI.PARTS.localize_keybind(keys_table[key_1] or keys_table[key_2] or "None") },
			})
		else
			return localize({
				type = "variable",
				key = "Handy_module_keys_or",
				vars = {
					Handy.UI.PARTS.localize_keybind(keys_table[key_1]),
					Handy.UI.PARTS.localize_keybind(keys_table[key_2]),
				},
			})
		end
	end,
	create_new_module_checkbox = function(module, loc_key, loc_vars, options)
		options = options or {}
		local formatted_keys = Handy.UI.PARTS.format_new_module_keys(module, options.only_first)
		local result_loc_vars = { formatted_keys }
		local result_popup_loc_vars = { formatted_keys }
		for _, v in ipairs(loc_vars or {}) do
			table.insert(result_loc_vars, v)
			table.insert(result_popup_loc_vars, v)
		end
		local checkbox_name = {}
		localize({
			type = "unlocks",
			set = "Handy_ConfigCheckbox",
			key = loc_key,
			vars = result_loc_vars,
			nodes = checkbox_name,
			default_col = G.C.WHITE,
		})
		local checkbox_text = {}
		localize({
			type = "descriptions",
			set = "Handy_ConfigCheckbox",
			key = loc_key,
			vars = result_loc_vars,
			nodes = checkbox_text,
			default_col = G.C.UI.TEXT_LIGHT,
		})

		local name_lines = {}
		for _, line in ipairs(checkbox_name) do
			for _, line_part in ipairs(line) do
				line_part.config.scale = 0.4
			end
			table.insert(name_lines, {
				n = G.UIT.R,
				config = { minw = 2.75, maxw = not options.full_width and 2.75 or nil },
				nodes = line,
			})
		end
		local desc_lines = {
			{ n = G.UIT.R, config = { minw = 5 } },
		}
		for _, line in ipairs(checkbox_text) do
			table.insert(desc_lines, {
				n = G.UIT.R,
				config = { padding = 0.025, maxw = not options.full_width and 4.5 or nil },
				nodes = line,
			})
		end

		local result_toggle = create_toggle({
			callback = function(b)
				return G.FUNCS.handy_toggle_module_enabled(b, module)
			end,
			label_scale = 0.4,
			label = "",
			ref_table = module,
			ref_value = "enabled",
			w = 0,
		})

		return {
			n = G.UIT.R,
			config = {
				align = "cm",
				func = "handy_setup_config_popup",
				handy_loc_key = loc_key,
				funnel_from = true,
			},
			nodes = {
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = name_lines,
				},
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = {
						result_toggle,
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 0.1 },
				},
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = desc_lines,
				},
			},
		}
	end,

	create_module_section = function(loc_key)
		return {
			n = G.UIT.R,
			config = { align = "cm", padding = 0.075 },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = localize(loc_key, "handy_keybind_sections"),
						colour = G.C.WHITE,
						scale = 0.35,
						align = "cm",
					},
				},
			},
		}
	end,
	create_module_keybind = function(module, loc_key, dangerous, rerender)
		local key_1, key_2 = "key_1", "key_2"
		if Handy.controller.is_gamepad() then
			key_1, key_2 = "key_1_gamepad", "key_2_gamepad"
		end

		return {
			n = G.UIT.R,
			config = { align = "cm", padding = 0.01 },
			nodes = {
				{
					n = G.UIT.C,
					config = { align = "c", minw = 4 },
					nodes = {
						{
							n = G.UIT.T,
							config = {
								text = localize(loc_key, "handy_keybind_labels"),
								colour = G.C.WHITE,
								scale = 0.3,
							},
						},
					},
				},
				{
					n = G.UIT.C,
					config = { align = "cm", minw = 0.75 },
				},
				UIBox_button({
					label = { Handy.UI.PARTS.localize_keybind(module[key_1] or "None") },
					col = true,
					colour = dangerous and G.C.MULT or G.C.CHIPS,
					scale = 0.3,
					minw = 2.75,
					minh = 0.4,
					ref_table = {
						module = module,
						key = key_1,
						rerender = rerender,
					},
					button = "handy_init_keybind_change",
				}),
				{
					n = G.UIT.C,
					config = { align = "cm", minw = 0.6 },
					nodes = {
						{
							n = G.UIT.T,
							config = { text = localize("handy_or"), colour = G.C.WHITE, scale = 0.3 },
						},
					},
				},
				UIBox_button({
					label = { Handy.UI.PARTS.localize_keybind(module[key_2] or "None") },
					col = true,
					colour = dangerous and G.C.MULT or G.C.CHIPS,
					scale = 0.3,
					minw = 2.75,
					minh = 0.4,
					ref_table = {
						module = module,
						key = key_2,
						rerender = rerender,
					},
					button = "handy_init_keybind_change",
				}),
			},
		}
	end,
}

--

Handy.UI.get_config_tab_overall = function()
	local gamepad = Handy.controller.is_gamepad()
	return {
		{
			n = G.UIT.R,
			config = { padding = 0.05, align = "cm" },
			nodes = {
				Handy.current_mod and {
					n = G.UIT.C,
					config = {
						align = "cm",
						padding = 0.1,
					},
					nodes = {
						{
							n = G.UIT.R,
							config = {
								padding = 0.15,
							},
							nodes = {},
						},
						{
							n = G.UIT.R,
							config = { align = "cm" },
							nodes = {
								{
									n = G.UIT.C,
									config = { align = "cm" },
									nodes = {
										{
											n = G.UIT.R,
											config = { minw = 2.5 },
											nodes = {
												{
													n = G.UIT.T,
													config = {
														text = localize("b_handy_hide_mod_button_1"),
														scale = 0.4,
														colour = G.C.WHITE,
													},
												},
											},
										},
										{
											n = G.UIT.R,
											config = { minw = 2.5 },
											nodes = {
												{
													n = G.UIT.T,
													config = {
														text = localize("b_handy_hide_mod_button_2"),
														scale = 0.4,
														colour = G.C.WHITE,
													},
												},
											},
										},
									},
								},
								{
									n = G.UIT.C,
									config = { align = "cm" },
									nodes = {
										create_toggle({
											callback = function(b)
												return G.FUNCS.handy_toggle_menu_button(b)
											end,
											label_scale = 0.4,
											label = "",
											ref_table = Handy.cc,
											ref_value = "hide_in_menu",
											w = 0,
										}),
									},
								},
							},
						},
					},
				} or nil,
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
			},
		},
		{ n = G.UIT.R, config = { padding = 0.05 }, nodes = {} },
		Handy.UI.PARTS.create_new_module_checkbox(
			Handy.cc.handy,
			"handy",
			{ Handy.version, "SleepyG11" },
			{ full_width = true }
		),
		{ n = G.UIT.R, config = { minh = 0.25 } },
		{
			n = G.UIT.R,
			nodes = {
				{
					n = G.UIT.C,
					nodes = {
						Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.regular_keybinds, "regular_keybinds"),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.insta_highlight, "insta_highlight"),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.show_deck_preview, "show_deck_preview"),
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.deselect_hand, "deselect_hand"),
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
						text = localize(gamepad and "ph_handy_any_gamepad_hint" or "ph_handy_any_button_hint"),
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

Handy.UI.get_config_tab_quick = function()
	local gamepad = Handy.controller.is_gamepad()
	return {
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
		not gamepad and Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.move_highlight, "move_highlight", {
			Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.dx.one_left, true),
			Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.dx.one_right, true),
			Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.swap, true),
			Handy.UI.PARTS.format_new_module_keys(Handy.cc.move_highlight.to_end, true),
		}, { full_width = true }) or nil,
		not gamepad and { n = G.UIT.R, config = { minh = 0.25 } } or nil,
		{
			n = G.UIT.R,
			nodes = {
				{
					n = G.UIT.C,
					nodes = {
						not gamepad and Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.insta_buy_or_sell,
							"insta_buy_or_sell"
						) or nil,
						not gamepad and { n = G.UIT.R, config = { minh = 0.25 } } or nil,
						Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.insta_buy_n_sell, "insta_buy_n_sell"),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						not gamepad and Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.insta_use, "insta_use")
							or nil,
						not gamepad and { n = G.UIT.R, config = { minh = 0.3 } } or nil,
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.cryptid_code_use_last_interaction,
							"cryptid_code_use_last_interaction"
						),
						gamepad and { n = G.UIT.R, config = { minh = 0.25 } } or nil,
						gamepad and Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.not_just_yet_interaction,
							"not_just_yet_interaction"
						) or nil,
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.speed_multiplier, "speed_multiplier", {
							Handy.UI.PARTS.format_new_module_keys(Handy.cc.speed_multiplier.multiply, true),
							Handy.UI.PARTS.format_new_module_keys(Handy.cc.speed_multiplier.divide, true),
						}),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.insta_highlight_entire_f_hand,
							"insta_highlight_entire_f_hand"
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(Handy.cc.nopeus_interaction, "nopeus_interaction", {
							Handy.UI.PARTS.format_new_module_keys(Handy.cc.nopeus_interaction.increase, true),
							Handy.UI.PARTS.format_new_module_keys(Handy.cc.nopeus_interaction.decrease, true),
						}),
						not gamepad and { n = G.UIT.R, config = { minh = 0.25 } } or nil,
						not gamepad and Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.not_just_yet_interaction,
							"not_just_yet_interaction"
						) or nil,
					},
				},
			},
		},
		-- { n = G.UIT.R, config = { minh = 0.25 } },
	}
end

Handy.UI.get_config_tab_dangerous = function()
	return {
		{
			n = G.UIT.R,
			config = { padding = 0.05, align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
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
		{ n = G.UIT.R, config = { minh = 0.5 } },
		{
			n = G.UIT.R,
			nodes = {
				{
					n = G.UIT.C,
					nodes = {
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.dangerous_actions.immediate_buy_and_sell,
							"immediate_buy_and_sell",
							{
								Handy.UI.PARTS.format_new_module_keys(Handy.cc.insta_buy_or_sell, true),
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.dangerous_actions.immediate_buy_and_sell.queue,
							"immediate_buy_and_sell_queue"
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.dangerous_actions.nopeus_unsafe,
							"nopeus_unsafe"
						),
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.dangerous_actions.sell_all_same,
							"sell_all_same",
							{
								Handy.UI.PARTS.format_new_module_keys(
									Handy.cc.dangerous_actions.immediate_buy_and_sell,
									true
								),
							},
							{
								only_first = true,
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.dangerous_actions.sell_all,
							"sell_all",
							nil,
							{
								only_first = true,
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_new_module_checkbox(
							Handy.cc.dangerous_actions.card_remove,
							"card_remove",
							nil,
							{
								only_first = true,
							}
						),
					},
				},
			},
		},
		{ n = G.UIT.R, config = { minh = 0.5 } },
		Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_buy_or_sell, "quick_buy_or_sell", false, true),
		Handy.UI.PARTS.create_module_keybind(
			Handy.cc.dangerous_actions.immediate_buy_and_sell,
			"dangerous_modifier",
			true,
			true
		),
		Handy.UI.PARTS.create_module_keybind(
			Handy.cc.dangerous_actions.sell_all_same,
			"dangerous_all_same_modifier",
			true,
			true
		),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.dangerous_actions.sell_all, "dangerous_all_modifier", true, true),
		Handy.UI.PARTS.create_module_keybind(
			Handy.cc.dangerous_actions.card_remove,
			"dangerous_remove_modifier",
			true,
			true
		),
		{ n = G.UIT.R, config = { minh = 0.4 } },
		{
			n = G.UIT.R,
			config = { padding = 0.1, align = "cm" },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = localize("ph_handy_remove_hint"),
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

Handy.UI.get_config_tab_regular_keybinds = function()
	local gamepad = Handy.controller.is_gamepad()
	return {
		Handy.UI.PARTS.create_module_section("round"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.play, "play_hand"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.discard, "discard"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.sort_by_rank, "sort_by_rank"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.sort_by_suit, "sort_by_suit"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.deselect_hand, "deselect_hand"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_cash_out, "cash_out"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.not_just_yet_interaction, "not_just_yet_end_round"),
		Handy.UI.PARTS.create_module_section("shop_and_blinds"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_booster_skip, "skip_booster"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.reroll_shop, "reroll_shop"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.leave_shop, "leave_shop"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.skip_blind, "skip_blind"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.select_blind, "select_blind"),
		Handy.UI.PARTS.create_module_section("menus"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.run_info, "run_info_hands"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.run_info_blinds, "run_info_blinds"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.view_deck, "view_deck"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.show_deck_preview, "deck_preview"),
		{ n = G.UIT.R, config = { minh = 0.15 } },
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = localize(
							gamepad and "ph_handy_keybinds_guide_gamepad" or "ph_handy_keybinds_guide_desktop"
						),
						scale = 0.3,
						colour = { 1, 1, 1, 0.6 },
						align = "cm",
					},
				},
			},
		},
	}
end

Handy.UI.get_config_tab_keybinds_2 = function()
	local gamepad = Handy.controller.is_gamepad()
	return {
		Handy.UI.PARTS.create_module_section("quick_actions"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_highlight, "quick_highlight"),
		not gamepad and Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_buy_or_sell, "quick_buy_or_sell") or nil,
		Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_buy_n_sell, "quick_buy_n_sell"),
		not gamepad and Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_use, "quick_use") or nil,
		Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_highlight_entire_f_hand, "highlight_entire_f_hand"),
		Handy.UI.PARTS.create_module_keybind(
			Handy.cc.cryptid_code_use_last_interaction,
			"cryptid_code_use_last_interaction"
		),
		Handy.UI.PARTS.create_module_section("gamespeed_and_animations"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.speed_multiplier, "speed_multiplier"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.speed_multiplier.multiply, "speed_multiplier_multiply"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.speed_multiplier.divide, "speed_multiplier_divide"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.nopeus_interaction, "nopeus_interaction"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.nopeus_interaction.increase, "nopeus_interaction_increase"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.nopeus_interaction.decrease, "nopeus_interaction_decrease"),
		not gamepad and Handy.UI.PARTS.create_module_section("highlight_movement") or nil,
		not gamepad
				and Handy.UI.PARTS.create_module_keybind(Handy.cc.move_highlight.dx.one_left, "move_highlight_one_left")
			or nil,
		not gamepad and Handy.UI.PARTS.create_module_keybind(
			Handy.cc.move_highlight.dx.one_right,
			"move_highlight_one_right"
		) or nil,
		not gamepad and Handy.UI.PARTS.create_module_keybind(Handy.cc.move_highlight.swap, "move_highlight_move_card")
			or nil,
		not gamepad and Handy.UI.PARTS.create_module_keybind(Handy.cc.move_highlight.to_end, "move_highlight_to_end")
			or nil,
		{ n = G.UIT.R, config = { minh = 0.15 } },
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = localize(
							gamepad and "ph_handy_keybinds_guide_gamepad" or "ph_handy_keybinds_guide_desktop"
						),
						scale = 0.3,
						colour = { 1, 1, 1, 0.6 },
						align = "cm",
					},
				},
			},
		},
	}
end

--

Handy.UI.PARTS.tabs_list = {
	["Overall"] = {
		definition = function()
			return Handy.UI.get_config_tab_overall()
		end,
	},
	["Quick"] = {
		definition = function()
			return Handy.UI.get_config_tab_quick()
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
	["Dangerous"] = {
		definition = function()
			return Handy.UI.get_config_tab_dangerous()
		end,
	},
}
Handy.UI.PARTS.tabs_order = {
	"Overall",
	"Quick",
	"Keybinds",
	"Keybinds 2",
	"Dangerous",
}

Handy.UI.get_config_tab = function(_tab, _index)
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

--

function G.UIDEF.handy_options()
	local tabs = Handy.UI.get_options_tabs()
	tabs[Handy.UI.config_tab_index or 1].chosen = true
	local t = create_UIBox_generic_options({
		back_func = "handy_exit_options",
		contents = {
			{
				n = G.UIT.R,
				config = { align = "cm", padding = 0 },
				nodes = {
					create_tabs({
						tabs = tabs,
						snap_to_nav = true,
						colour = G.C.BOOSTER,
					}),
				},
			},
		},
	})
	return t
end

function G.FUNCS.handy_open_options(e)
	G.SETTINGS.paused = true
	Handy.UI.config_opened = true
	Handy.UI.config_tab_index = 1
	G.FUNCS.overlay_menu({
		definition = G.UIDEF.handy_options(),
	})
end

function G.FUNCS.handy_exit_options(e)
	Handy.UI.config_opened = nil
	Handy.UI.config_tab_index = nil
	if e then
		return G.FUNCS.options(e)
	end
end

function G.FUNCS.handy_setup_config_popup(e)
	if e.handy_popup_processed then
		return
	end

	local loc_key = e.config.handy_loc_key
	local popup_hover = function(self)
		local is_gamepad = Handy.controller.is_gamepad()
		local loc_suffix = ""
		local is_popup_present = G.localization.descriptions.Handy_ConfigPopup[loc_key]
		if is_gamepad then
			if G.localization.descriptions.Handy_ConfigPopup[loc_key .. "_gamepad"] then
				is_popup_present = true
				loc_suffix = "_gamepad"
			end
		else
			if G.localization.descriptions.Handy_ConfigPopup[loc_key .. "_desktop"] then
				is_popup_present = true
				loc_suffix = "_desktop"
			end
		end
		if is_popup_present then
			local popup_content = {}
			localize({
				type = "descriptions",
				set = "Handy_ConfigPopup",
				key = loc_key .. loc_suffix,
				nodes = popup_content,
			})
			local desc_lines = {}
			for _, line in ipairs(popup_content) do
				table.insert(desc_lines, {
					n = G.UIT.R,
					config = {
						align = "cm",
						padding = 0.01,
					},
					nodes = line,
				})
			end

			self.config.h_popup_config = { align = "mt", offset = { x = 0, y = -0.1 }, parent = self }
			self.config.h_popup = {
				n = G.UIT.ROOT,
				config = { align = "cm", colour = G.C.CLEAR },
				nodes = {
					{
						n = G.UIT.C,
						config = {
							align = "cm",
						},
						nodes = {
							{
								n = G.UIT.R,
								config = {
									padding = 0.05,
									r = 0.12,
									colour = lighten(G.C.JOKER_GREY, 0.5),
									emboss = 0.07,
								},
								nodes = {
									{
										n = G.UIT.R,
										config = {
											align = "cm",
											padding = 0.07,
											r = 0.1,
											colour = adjust_alpha(darken(G.C.BLACK, 0.1), 0.8),
										},
										nodes = { desc_from_rows({ desc_lines }) },
									},
								},
							},
						},
					},
				},
			}
		else
			self.config.h_popup_config = nil
			self.config.h_popup = nil
		end
		Node.hover(self)
	end

	e.float = true
	e.states.hover.can = true
	e.states.collide.can = true
	e.hover = popup_hover
	-- Well... it works xd
	pcall(function()
		if Handy.controller.is_gamepad() then
			e.children[2].children[1].children[2].children[1].children[1].hover = popup_hover
		end
	end)
	e.handy_popup_processed = true
end

function Handy.UI.get_options_button()
	return UIBox_button({ label = { "Handy" }, button = "handy_open_options", minw = 5, colour = G.C.CHIPS })
end

-- Code taken from Anhk by MathIsFun
local create_uibox_options_ref = create_UIBox_options
function create_UIBox_options()
	local contents = create_uibox_options_ref()
	if Handy.UI.show_options_button then
		table.insert(contents.nodes[1].nodes[1].nodes[1].nodes, Handy.UI.get_options_button())
	end
	return contents
end

function Handy.UI.rerender(silent)
	local result
	if SMODS and G.ACTIVE_MOD_UI and G.ACTIVE_MOD_UI == Handy.current_mod then
		result = {
			definition = create_UIBox_mods(),
		}
	elseif Handy.UI.config_opened then
		result = {
			definition = G.UIDEF.handy_options(),
		}
	end
	if result then
		if silent then
			G.ROOM.jiggle = G.ROOM.jiggle - 1
			result.config = {
				offset = {
					x = 0,
					y = 0,
				},
			}
		end
		G.FUNCS.overlay_menu(result)
	end
end

local exit_overlay_ref = G.FUNCS.exit_overlay_menu
function G.FUNCS.exit_overlay_menu(...)
	Handy.UI.config_opened = nil
	Handy.UI.config_tab_index = nil
	return exit_overlay_ref(...)
end
