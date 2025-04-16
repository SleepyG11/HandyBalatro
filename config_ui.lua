Handy.UI.PARTS = {
	popups = {
		["insta_highlight"] = function()
			return {
				"Start holding key {C:attention}outside{} of cards",
				"and then hover them to highlight",
			}
		end,
		["deselect_hand"] = function()
			return {
				"Replaces vanilla {C:chips}[Right Mouse]{}",
				"but works the same and",
				"can be reassigned to other key",
				" ",
				"Uncheck to use vanilla control",
			}
		end,
		["insta_cash_out"] = function()
			return {
				"Holding a keybind will trigger it",
				"as soon as it will be available",
			}
		end,
		["insta_booster_skip"] = function()
			return {
				"Holding a keybind will trigger it",
				"as soon as it will be available",
			}
		end,
		["move_hightlight"] = function()
			return {
				"Select card in area and",
				"then use listed controls",
			}
		end,
		["affected_by_buy_sell_use"] = function()
			return {
				"Usage determined by {C:attention}Buy/Sell/Use mode{}",
			}
		end,
		["affected_by_buy_sell_use_1"] = function()
			return Handy.UI.PARTS.popups["affected_by_buy_sell_use"]()
		end,
		["affected_by_buy_sell_use_2"] = function()
			return Handy.UI.PARTS.popups["affected_by_buy_sell_use"]()
		end,
		["affected_by_buy_sell_use_3"] = function()
			return Handy.UI.PARTS.popups["affected_by_buy_sell_use"]()
		end,
		["affected_by_buy_sell_use_4"] = function()
			return Handy.UI.PARTS.popups["affected_by_buy_sell_use"]()
		end,
		["affected_by_buy_sell_use_5"] = function()
			return Handy.UI.PARTS.popups["affected_by_buy_sell_use"]()
		end,

		["speed_multiplier"] = function()
			return {
				"Game speed can be changed in",
				"range from {C:attention}x1/512{} to {C:attention}x512{}",
			}
		end,
		["nopeus_interaction"] = function()
			return {
				"Required mod {C:attention}Nopeus{} to work",
				" ",
				"{C:mult}Unsafe{} option must be",
				"enabled in {C:attention}Danger Zone{} tab",
			}
		end,
		["not_jut_yet_interaction"] = function()
			return {
				"Required mod {C:attention}NotJustYet{} to work",
			}
		end,
		["cryptid_code_use_last_interaction"] = function()
			local result = {
				"Required mod {C:attention}Cryptid{} to work",
				" ",
				"Shortcut for using a code card and selecting",
				"{C:green}[Input previous value]{} option for:",
				"{C:spectral}://POINTER{}, {C:green}://VARIABLE{}, {C:green}://CLASS{}, {C:green}://EXPLOIT{}",
			}
			if not Handy.controller.is_gamepad() then
				table.insert(result, " ")
				table.insert(result, "Usage determined by {C:attention}Buy/Sell/Use mode{}")
			end
			return result
		end,
		["instant_sell"] = function()
			return {
				'Hold {C:mult}["Dangerous" modifier]{}, {C:chips}[Quick Buy/Sell]{},',
				"and hover cards to sell them immediately",
			}
		end,
		["sell_queue"] = function()
			return {
				"Instead of selling immediately, {C:mult}[Instant Sell]{}",
				"will put all hovered cards in a list and",
				"all of them will be sold after keybind release",
				" ",
				"Allow more precise cards selection, but slower",
			}
		end,
		["nopeus_interaction_unsafe"] = function()
			return {
				"Required mod {C:attention}Nopeus{} to work",
				" ",
				"Even if this unchecked, {C:mult}Unsafe{} option",
				"can be set normally via game settings",
			}
		end,
		["sell_all_same"] = function()
			return {
				'Hold {C:mult}["Dangerous" modifier]{}, {C:mult}["All copies" modifier]{},',
				"and click on card to sell all of their copies",
			}
		end,
		["sell_all"] = function()
			return {
				'Hold {C:mult}["Dangerous" modifier]{}, {C:mult}["ALL" modifier]{},',
				"and click on card to sell {C:attention}ALL{} cards in area",
			}
		end,
		["card_remove"] = function()
			return {
				"When hold, instead of selling cards will be {C:attention,E:1}REMOVED{}",
				" ",
				'Hold {C:mult}["Dangerous" modifier]{}, {C:chips}[Quick Buy/Sell]{}, {C:mult}["REMOVE" modifier]{}',
				"and hover cards to {C:attention,E:1}REMOVE{} them (queue also applied)",
				" ",
				'Hold {C:mult}["Dangerous" modifier]{}, {C:mult}["All copies" modifier]{}, {C:mult}["REMOVE" modifier]{}',
				"and click on card {C:attention}or skip tag{} to {C:attention,E:1}REMOVE{} all of their copies",
				" ",
				'Hold {C:mult}["Dangerous" modifier]{}, {C:mult}["ALL" modifier]{}, {C:mult}["REMOVE" modifier]{}',
				"and click on card {C:attention}or skip tag{} to {C:attention,E:1}REMOVE{} {C:attention}ALL{} cards or skip tags",
			}
		end,
	},
	parse_popup_description = function(content)
		local parsed_lines = {}
		for _, line in ipairs(content) do
			table.insert(parsed_lines, {
				n = G.UIT.R,
				config = {
					align = "cm",
					padding = 0.01,
				},
				nodes = Handy.UI.PARTS.parse_popup_description_line(line),
			})
		end

		return { desc_from_rows({ parsed_lines }) }
	end,
	parse_popup_description_line = function(content_line)
		local loc_target = { loc_parse_string(content_line) }
		local args = {
			type = "text",
			vars = {},
			nodes = {},
		}
		for _, lines in ipairs(loc_target) do
			local final_line = {}
			for _, part in ipairs(lines) do
				local assembled_string = ""
				for _, subpart in ipairs(part.strings) do
					assembled_string = assembled_string
						.. (type(subpart) == "string" and subpart or args.vars[tonumber(subpart[1])] or "ERROR")
				end
				local desc_scale = G.LANG.font.DESCSCALE
				if G.F_MOBILE_UI then
					desc_scale = desc_scale * 1.5
				end
				if args.type == "name" then
					final_line[#final_line + 1] = {
						n = G.UIT.O,
						config = {
							object = DynaText({
								string = { assembled_string },
								colours = {
									(part.control.V and args.vars.colours[tonumber(part.control.V)])
										or (part.control.C and loc_colour(part.control.C))
										or G.C.UI.TEXT_LIGHT,
								},
								bump = true,
								silent = true,
								pop_in = 0,
								pop_in_rate = 4,
								maxw = 5,
								shadow = true,
								y_offset = -0.6,
								spacing = math.max(0, 0.32 * (17 - #assembled_string)),
								scale = (0.55 - 0.004 * #assembled_string)
									* (part.control.s and tonumber(part.control.s) or 1),
							}),
						},
					}
				elseif part.control.E then
					local _float, _silent, _pop_in, _bump, _spacing = nil, true, nil, nil, nil
					if part.control.E == "1" then
						_float = true
						_silent = true
						_pop_in = 0
					elseif part.control.E == "2" then
						_bump = true
						_spacing = 1
					end
					final_line[#final_line + 1] = {
						n = G.UIT.O,
						config = {
							object = DynaText({
								string = { assembled_string },
								colours = {
									part.control.V and args.vars.colours[tonumber(part.control.V)]
										or loc_colour(part.control.C or nil),
								},
								float = _float,
								silent = _silent,
								pop_in = _pop_in,
								bump = _bump,
								spacing = _spacing,
								scale = 0.32 * (part.control.s and tonumber(part.control.s) or 1) * desc_scale,
							}),
						},
					}
				elseif part.control.X then
					final_line[#final_line + 1] = {
						n = G.UIT.C,
						config = {
							align = "m",
							colour = loc_colour(part.control.X),
							r = 0.05,
							padding = 0.03,
							res = 0.15,
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = assembled_string,
									colour = loc_colour(part.control.C or nil),
									scale = 0.32 * (part.control.s and tonumber(part.control.s) or 1) * desc_scale,
								},
							},
						},
					}
				else
					final_line[#final_line + 1] = {
						n = G.UIT.T,
						config = {
							detailed_tooltip = part.control.T
									and (G.P_CENTERS[part.control.T] or G.P_TAGS[part.control.T])
								or nil,
							text = assembled_string,
							shadow = args.shadow,
							colour = part.control.V and args.vars.colours[tonumber(part.control.V)]
								or loc_colour(part.control.C or nil, args.default_col),
							scale = 0.32 * (part.control.s and tonumber(part.control.s) or 1) * desc_scale,
						},
					}
				end
			end
			if args.type == "name" or args.type == "text" then
				return final_line
			end
			args.nodes[#args.nodes + 1] = final_line
		end
	end,
	init_popups = function()
		if not G.OVERLAY_MENU then
			return
		end
		local gamepad = Handy.controller.is_gamepad()
		for k, content in pairs(Handy.UI.PARTS.popups) do
			local element = G.OVERLAY_MENU:get_UIE_by_ID("handy_popup_" .. k)
			if element then
				element.float = true
				element.states.hover.can = true
				element.states.collide.can = true
				element.hover = function()
					local popup_content = content()
					if popup_content then
						element.config.h_popup_config =
							{ align = "mt", offset = { x = 0, y = gamepad and -0.2 or -0.1 }, parent = element }
						element.config.h_popup = {
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
													nodes = Handy.UI.PARTS.parse_popup_description(popup_content),
												},
											},
										},
									},
								},
							},
						}
					else
						element.config.h_popup_config = nil
						element.config.h_popup = nil
					end
					Node.hover(element)
				end
			end
		end
	end,

	format_module_keys = function(module, only_first)
		local key_1, key_2 = "key_1", "key_2"
		if Handy.controller.is_gamepad() then
			key_1, key_2 = "key_1_gamepad", "key_2_gamepad"
		end

		local result = "[" .. module[key_1] .. "]"
		if only_first or not module[key_2] or module[key_2] == "None" then
			return result
		end
		return result .. " or [" .. module[key_2] .. "]"
	end,
	create_module_checkbox = function(module, label, text_prefix, text_lines, skip_keybinds, popup_id)
		local desc_lines = {
			{ n = G.UIT.R, config = { minw = 5 } },
		}

		if skip_keybinds then
			table.insert(desc_lines, {
				n = G.UIT.R,
				config = { padding = 0.025 },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = text_prefix .. " " .. text_lines[1],
							scale = 0.3,
							colour = G.C.TEXT_LIGHT,
						},
					},
				},
			})
		else
			table.insert(desc_lines, {
				n = G.UIT.R,
				config = { padding = 0.025 },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = text_prefix
								.. " "
								.. Handy.UI.PARTS.format_module_keys(module)
								.. " "
								.. text_lines[1],
							scale = 0.3,
							colour = G.C.TEXT_LIGHT,
						},
					},
				},
			})
		end

		for i = 2, #text_lines do
			table.insert(desc_lines, {
				n = G.UIT.R,
				config = { padding = 0.025 },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = text_lines[i],
							scale = 0.3,
							colour = G.C.TEXT_LIGHT,
						},
					},
				},
			})
		end

		local label_lines = {}
		if type(label) == "string" then
			label = { label }
		end
		for i = 1, #label do
			table.insert(label_lines, {
				n = G.UIT.R,
				config = { minw = 2.75 },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = label[i],
							scale = 0.4,
							colour = G.C.WHITE,
						},
					},
				},
			})
		end

		local gamepad = Handy.controller.is_gamepad()
		local result_popup_id = (popup_id and "handy_popup_" .. popup_id) or nil
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

		if gamepad then
			result_toggle.nodes[2].nodes[1].nodes[1].config.id = result_popup_id
		end

		return {
			n = G.UIT.R,
			config = { align = "cm", id = not gamepad and result_popup_id or nil },
			nodes = {
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = label_lines,
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

	create_module_section = function(label)
		return {
			n = G.UIT.R,
			config = { align = "cm", padding = 0.075 },
			nodes = {
				{
					n = G.UIT.T,
					config = { text = label, colour = G.C.WHITE, scale = 0.35, align = "cm" },
				},
			},
		}
	end,
	create_module_keybind = function(module, label, dangerous, rerender)
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
							config = { text = label, colour = G.C.WHITE, scale = 0.3 },
						},
					},
				},
				{
					n = G.UIT.C,
					config = { align = "cm", minw = 0.75 },
				},
				UIBox_button({
					label = { module[key_1] or "None" },
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
							config = { text = "or", colour = G.C.WHITE, scale = 0.3 },
						},
					},
				},
				UIBox_button({
					label = { module[key_2] or "None" },
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
														text = "Hide mod button",
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
														text = "in options menu",
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
							label = "Info popups level",
							scale = 0.8,
							options = {
								"None",
								"Dangerous only",
								"Features-related",
								"All",
							},
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
							label = "Keybinds trigger mode",
							scale = 0.8,
							options = {
								"On key press",
								"On key release",
							},
							opt_callback = "handy_change_keybinds_trigger_mode",
							current_option = Handy.cc.keybinds_trigger_mode,
						}),
					},
				},
			},
		},
		{ n = G.UIT.R, config = { padding = 0.05 }, nodes = {} },
		Handy.UI.PARTS.create_module_checkbox(
			Handy.cc.handy,
			{ "HandyBalatro v" .. Handy.version, "by SleepyG11" },
			"Uncheck",
			{
				"to disable ALL mod features",
				"(no restart required)",
			},
			true
		),
		{ n = G.UIT.R, config = { minh = 0.25 } },
		{
			n = G.UIT.R,
			nodes = {
				{
					n = G.UIT.C,
					nodes = {
						Handy.UI.PARTS.create_module_checkbox(Handy.cc.regular_keybinds, "Regular keybinds", "Use", {
							"keybinds for",
							"common game actions",
							"(Play, Discard, Reroll, Skip blind, etc.)",
						}, true, "regular_keybinds"),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(Handy.cc.insta_highlight, "Quick Highlight", "Hold", {
							"and",
							"hover cards in hand to highlight",
						}, false, "insta_highlight"),
						{ n = G.UIT.R, config = { minh = 0.25 } } or nil,
						Handy.UI.PARTS.create_module_checkbox(Handy.cc.show_deck_preview, "Deck preview", "Hold", {
							"to",
							"show deck preview",
						}) or nil,
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.PARTS.create_module_checkbox(Handy.cc.deselect_hand, "Deselect hand", "Press", {
							"to",
							"deselect hand",
						}, false, not gamepad and "deselect_hand" or nil),
						{ n = G.UIT.R, config = { minh = 0.25 } } or nil,
						Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.insta_cash_out,
							"Quick Cash Out",
							"Press/hold",
							{
								"to",
								"skip Cash Out stage",
							},
							false,
							"insta_cash_out"
						) or nil,
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.insta_booster_skip,
							{ "Quick skip", "Booster Packs" },
							"Press/hold",
							{
								"to",
								"skip booster pack",
							},
							false,
							"insta_booster_skip"
						),
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
						text = gamepad and 'Each control can be assigned to any gamepad buttons in "Keybinds" tabs'
							or 'Each control can be assigned to mouse button, mouse wheel or keyboard key in "Keybinds" tabs',
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
							label = "Buy/Sell/Use mode",
							scale = 0.8,
							options = {
								"Hold key + Click card",
								"Hover card + Press key",
							},
							opt_callback = "handy_change_insta_actions_trigger_mode",
							current_option = Handy.cc.insta_actions_trigger_mode,
						}),
					},
				},
			},
		} or nil,
		not gamepad and { n = G.UIT.R, config = { padding = 0.05 }, nodes = {} } or nil,
		not gamepad and Handy.UI.PARTS.create_module_checkbox(Handy.cc.move_highlight, "Move highlight", "Press", {
			Handy.UI.PARTS.format_module_keys(Handy.cc.move_highlight.dx.one_left, true)
				.. " or "
				.. Handy.UI.PARTS.format_module_keys(Handy.cc.move_highlight.dx.one_right, true),
			"to move highlight in card area.",
			"Hold "
				.. Handy.UI.PARTS.format_module_keys(Handy.cc.move_highlight.swap, true)
				.. " to move card instead.",
			"Hold "
				.. Handy.UI.PARTS.format_module_keys(Handy.cc.move_highlight.to_end, true)
				.. " to move to first/last card",
		}, true, "move_hightlight") or nil,
		not gamepad and { n = G.UIT.R, config = { minh = 0.25 } } or nil,
		{
			n = G.UIT.R,
			nodes = {
				{
					n = G.UIT.C,
					nodes = {
						not gamepad and Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.insta_buy_or_sell,
							"Quick Buy/Sell",
							"Use",
							{
								"to",
								"buy or sell card",
							},
							false,
							"affected_by_buy_sell_use_1"
						) or nil,
						not gamepad and { n = G.UIT.R, config = { minh = 0.25 } } or nil,
						Handy.UI.PARTS.create_module_checkbox(Handy.cc.insta_buy_n_sell, "Quick Buy'n'Sell", "Use", {
							"to",
							"buy card and sell",
							"immediately after",
						}, false, not gamepad and "affected_by_buy_sell_use_2" or nil),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						not gamepad
								and Handy.UI.PARTS.create_module_checkbox(Handy.cc.insta_use, "Quick use", "Use", {
									"to",
									"use card if possible",
									"(overrides Quick Buy/Sell)",
								}, false, "affected_by_buy_sell_use_3")
							or nil,
						not gamepad and { n = G.UIT.R, config = { minh = 0.3 } } or nil,
						Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.cryptid_code_use_last_interaction,
							{ "Cryptid: use", "previous input" },
							"Use",
							{
								"to",
								"use code card if possible with",
								"previously inputted value",
							},
							false,
							"cryptid_code_use_last_interaction"
						),
						gamepad and { n = G.UIT.R, config = { minh = 0.25 } } or nil,
						gamepad and Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.not_just_yet_interaction,
							{ "NotJustYet:", "End round" },
							"Press",
							{
								"to",
								"end round",
							},
							false,
							"not_jut_yet_interaction"
						) or nil,
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.PARTS.create_module_checkbox(Handy.cc.speed_multiplier, "Speed Multiplier", "Hold", {
							"and",
							Handy.UI.PARTS.format_module_keys(Handy.cc.speed_multiplier.multiply, true)
								.. " to multiply or",
							Handy.UI.PARTS.format_module_keys(Handy.cc.speed_multiplier.divide, true)
								.. " to divide game speed",
						}, false, "speed_multiplier"),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.insta_highlight_entire_f_hand,
							{ "Highlight", "entire hand" },
							"Press",
							{
								"to",
								"highlight entire hand",
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.nopeus_interaction,
							{ "Nopeus:", "fast-forward" },
							"Hold",
							{
								"and",
								Handy.UI.PARTS.format_module_keys(Handy.cc.nopeus_interaction.increase, true)
									.. " to increase or",
								Handy.UI.PARTS.format_module_keys(Handy.cc.nopeus_interaction.decrease, true)
									.. " to decrease",
								"fast-forward setting",
							},
							false,
							"nopeus_interaction"
						),
						not gamepad and { n = G.UIT.R, config = { minh = 0.25 } } or nil,
						not gamepad and Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.not_just_yet_interaction,
							{ "NotJustYet:", "End round" },
							"Press",
							{
								"to",
								"end round",
							},
							false,
							"not_jut_yet_interaction"
						) or nil,
					},
				},
			},
		},
		-- { n = G.UIT.R, config = { minh = 0.25 } },
	}
end

Handy.UI.get_config_tab_interactions = function()
	return {
		{
			n = G.UIT.R,
			nodes = {
				{
					n = G.UIT.C,
					nodes = {
						Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.nopeus_interaction,
							{ "Nopeus:", "fast-forward" },
							"Hold",
							{
								"and",
								Handy.UI.PARTS.format_module_keys(Handy.cc.nopeus_interaction.increase, true)
									.. " to increase or",
								Handy.UI.PARTS.format_module_keys(Handy.cc.nopeus_interaction.decrease, true)
									.. " to decrease",
								"fast-forward setting",
							}
						),
						{
							n = G.UIT.R,
							config = { minh = 0.25 },
						},
						Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.not_just_yet_interaction,
							{ "NotJustYet:", "End round" },
							"Press",
							{
								"to",
								"end round",
							}
						),
					},
				},
			},
		},
	}
end

Handy.UI.get_config_tab_dangerous = function()
	return {
		-- {
		-- 	n = G.UIT.R,
		-- 	config = { padding = 0.05, align = "cm" },
		-- 	nodes = {

		-- 	},
		-- },
		-- { n = G.UIT.R, config = { padding = 0.05 }, nodes = {} },
		{
			n = G.UIT.R,
			config = { padding = 0.05, align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
					nodes = {
						Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.dangerous_actions,
							{ "Dangerous", "actions" },
							"Enable",
							{
								"unsafe controls. They're",
								"designed to be speed-first,",
								"which can cause bugs or crashes",
							},
							true
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
						Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.dangerous_actions.immediate_buy_and_sell,
							"Instant Sell",
							"Hold",
							{
								Handy.UI.PARTS.format_module_keys(Handy.cc.dangerous_actions.immediate_buy_and_sell)
									.. ",",
								"hold " .. Handy.UI.PARTS.format_module_keys(Handy.cc.insta_buy_or_sell) .. "",
								"and hover card to sell it",
							},
							true,
							"instant_sell"
						),
						{ n = G.UIT.R, config = { minh = 0.275 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.dangerous_actions.immediate_buy_and_sell.queue,
							"Sell Queue",
							"Start",
							{
								"selling cards only when",
								"keybind was released",
							},
							true,
							"sell_queue"
						),
						{ n = G.UIT.R, config = { minh = 0.275 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.dangerous_actions.nopeus_unsafe,
							{ "Nopeus: Unsafe", "fast-forward" },
							"Allow",
							{
								"increase fast-forward",
								'setting to "Unsafe"',
							},
							true,
							"nopeus_interaction_unsafe"
						),
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.dangerous_actions.sell_all_same,
							{ "Sell all", "card copies" },
							"Hold",
							{
								Handy.UI.PARTS.format_module_keys(Handy.cc.dangerous_actions.immediate_buy_and_sell)
									.. ",",
								"hold "
									.. Handy.UI.PARTS.format_module_keys(Handy.cc.dangerous_actions.sell_all_same)
									.. ",",
								"and click on card to sell",
								"all of their copies",
							},
							true,
							"sell_all_same"
						),
						{ n = G.UIT.R, config = { minh = 0.1 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.dangerous_actions.sell_all,
							"Sell ALL",
							"Hold",
							{
								"to",
								"sell ALL cards in area instead",
							},
							false,
							"sell_all"
						),
						{ n = G.UIT.R, config = { minh = 0.1 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.cc.dangerous_actions.card_remove,
							{ "REMOVE* cards", "or skip tags" },
							"Hold",
							{
								"to",
								"REMOVE cards instead",
								"of selling, works for skip tags",
							},
							false,
							"card_remove"
						),
					},
				},
			},
		},
		{ n = G.UIT.R, config = { minh = 0.5 } },
		Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_buy_or_sell, "Quick Buy/Sell", false, true),
		Handy.UI.PARTS.create_module_keybind(
			Handy.cc.dangerous_actions.immediate_buy_and_sell,
			'"Dangerous" modifier',
			true,
			true
		),
		Handy.UI.PARTS.create_module_keybind(
			Handy.cc.dangerous_actions.sell_all_same,
			'"All copies" modifier',
			true,
			true
		),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.dangerous_actions.sell_all, '"ALL" modifier', true, true),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.dangerous_actions.card_remove, '"REMOVE" modifier', true, true),
		{ n = G.UIT.R, config = { minh = 0.4 } },
		{
			n = G.UIT.R,
			config = { padding = 0.1, align = "cm" },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = "*REMOVE card/tag - delete without any checks, effects, triggers or money refunds",
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
	return {
		Handy.UI.PARTS.create_module_section("Round"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.play, "Play hand"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.discard, "Discard"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.sort_by_rank, "Sort by rank"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.sort_by_suit, "Sort by suit"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.deselect_hand, "Deselect hand"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_cash_out, "Cash Out"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.not_just_yet_interaction, "NotJustYet: End round"),
		Handy.UI.PARTS.create_module_section("Shop and Blinds"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_booster_skip, "Skip Booster Pack"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.reroll_shop, "Shop reroll"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.leave_shop, "Leave shop"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.skip_blind, "Skip blind"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.select_blind, "Select blind"),
		Handy.UI.PARTS.create_module_section("Menus"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.run_info, "Run info: Poker hands"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.run_info_blinds, "Run info: Blinds"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.regular_keybinds.view_deck, "View deck"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.show_deck_preview, "Deck preview"),
	}
end

Handy.UI.get_config_tab_keybinds_2 = function()
	return {
		Handy.UI.PARTS.create_module_section("Quick actions"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_highlight, "Quick highlight"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_buy_or_sell, "Quick Buy/Sell"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_use, "Quick Use"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_buy_n_sell, "Quick Buy'n'Sell"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.insta_highlight_entire_f_hand, "Highlight entire hand"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.cryptid_code_use_last_interaction, "Cryptid: use previous input"),
		Handy.UI.PARTS.create_module_section("Game speed and animations"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.speed_multiplier, "Speed Multiplier"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.speed_multiplier.multiply, "Multiply"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.speed_multiplier.divide, "Divide"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.nopeus_interaction, "Nopeus: fast-forward"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.nopeus_interaction.increase, "Increase"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.nopeus_interaction.decrease, "Decrease"),
		Handy.UI.PARTS.create_module_section("Highlight movement"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.move_highlight.dx.one_left, "Move one left"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.move_highlight.dx.one_right, "Move one right"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.move_highlight.swap, "Move card"),
		Handy.UI.PARTS.create_module_keybind(Handy.cc.move_highlight.to_end, "Move to end"),
	}
end

Handy.UI.get_config_tab = function(_tab, _index)
	local result = {
		n = G.UIT.ROOT,
		config = { align = "cm", padding = 0.05, colour = G.C.CLEAR, minh = 5, minw = 5 },
		nodes = {},
	}
	Handy.UI.config_tab_index = _index
	if _tab == "Overall" then
		result.nodes = Handy.UI.get_config_tab_overall()
	elseif _tab == "Quick" then
		result.nodes = Handy.UI.get_config_tab_quick()
	elseif _tab == "Interactions" then
		result.nodes = Handy.UI.get_config_tab_interactions()
	elseif _tab == "Dangerous" then
		result.nodes = Handy.UI.get_config_tab_dangerous()
	elseif _tab == "Keybinds" then
		result.nodes = Handy.UI.get_config_tab_regular_keybinds()
	elseif _tab == "Keybinds 2" then
		result.nodes = Handy.UI.get_config_tab_keybinds_2()
	end

	G.E_MANAGER:add_event(Event({
		blocking = false,
		blockable = false,
		no_delete = true,
		func = function()
			Handy.UI.PARTS.init_popups()
			return true
		end,
	}))

	return result
end

--

function Handy.UI.get_options_tabs()
	return {
		{
			label = "General & Vanilla",
			tab_definition_function = function()
				return Handy.UI.get_config_tab("Overall", 1)
			end,
		},
		{
			label = "Quick actions",
			tab_definition_function = function()
				return Handy.UI.get_config_tab("Quick", 2)
			end,
		},
		{
			label = "Regular keybinds",
			tab_definition_function = function()
				return Handy.UI.get_config_tab("Keybinds", 3)
			end,
		},
		{
			label = "Other keybinds",
			tab_definition_function = function()
				return Handy.UI.get_config_tab("Keybinds 2", 4)
			end,
		},
		{
			label = "Danger zone",
			tab_definition_function = function()
				return Handy.UI.get_config_tab("Dangerous", 5)
			end,
		},
	}
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
