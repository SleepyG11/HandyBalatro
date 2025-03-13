Handy.UI.PARTS = {
	format_module_keys = function(module, only_first)
		local result = "[" .. module.key_1 .. "]"
		if only_first or not module.key_2 or module.key_2 == "None" then
			return result
		end
		return result .. "or [" .. module.key_2 .. "]"
	end,
	create_module_checkbox = function(module, label, text_prefix, text_lines, skip_keybinds)
		local desc_lines = {
			{ n = G.UIT.R, config = { minw = 5.5 } },
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

		return {
			n = G.UIT.R,
			config = { align = "cm" },
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
						create_toggle({
							callback = function(b)
								return G.FUNCS.handy_toggle_module_enabled(b, module)
							end,
							label_scale = 0.4,
							label = "",
							ref_table = module,
							ref_value = "enabled",
							w = 0,
						}),
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
	create_module_keybind = function(module, label, dangerous)
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
					label = { module.key_1 or "None" },
					col = true,
					colour = dangerous and G.C.MULT or G.C.CHIPS,
					scale = 0.3,
					minw = 2.75,
					minh = 0.4,
					ref_table = {
						module = module,
						key = "key_1",
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
					label = { module.key_2 or "None" },
					col = true,
					colour = dangerous and G.C.MULT or G.C.CHIPS,
					scale = 0.3,
					minw = 2.75,
					minh = 0.4,
					ref_table = {
						module = module,
						key = "key_2",
					},
					button = "handy_init_keybind_change",
				}),
			},
		}
	end,
}

--

Handy.UI.get_config_tab_overall = function()
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
											ref_table = Handy.config.current,
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
							w = 4.25,
							label = "Info popups level",
							scale = 0.8,
							options = {
								"None",
								"Dangerous only",
								"Features-related",
								"All",
							},
							opt_callback = "handy_change_notifications_level",
							current_option = Handy.config.current.notifications_level,
						}),
					},
				},
				{
					n = G.UIT.C,
					nodes = {
						create_option_cycle({
							w = 4.25,
							label = "Keybinds trigger mode",
							scale = 0.8,
							options = {
								"On key press",
								"On key release",
							},
							opt_callback = "handy_change_keybinds_trigger_mode",
							current_option = Handy.config.current.keybinds_trigger_mode,
						}),
					},
				},
				{
					n = G.UIT.C,
					nodes = {
						create_option_cycle({
							w = 4.25,
							label = "Buy/Sell/Use mode",
							scale = 0.8,
							options = {
								"Hold + Card click",
								"Card hover + Press",
							},
							opt_callback = "handy_change_insta_actions_trigger_mode",
							current_option = Handy.config.current.insta_actions_trigger_mode,
						}),
					},
				},
			},
		},
		{ n = G.UIT.R, config = { padding = 0.05 }, nodes = {} },
		Handy.UI.PARTS.create_module_checkbox(Handy.config.current.regular_keybinds, "Regular keybinds", "Use", {
			"keybinds for",
			"common game actions",
			"(Play, Discard, Reroll, Skip blind, etc.)",
		}, true),
		{ n = G.UIT.R, config = { minh = 0.25 } },
		{
			n = G.UIT.R,
			nodes = {
				{
					n = G.UIT.C,
					nodes = {
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.show_deck_preview,
							"Deck preview",
							"Hold",
							{
								"to",
								"show deck preview",
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.move_highlight,
							"Move highlight",
							"Press",
							{
								"["
									.. tostring(Handy.config.current.move_highlight.dx.one_left.key_1)
									.. "] or ["
									.. tostring(Handy.config.current.move_highlight.dx.one_right.key_1)
									.. "]",
								"to move highlight in card area.",
								"Hold ["
									.. tostring(Handy.config.current.move_highlight.swap.key_1)
									.. "] to move card instead.",
								"Hold ["
									.. tostring(Handy.config.current.move_highlight.to_end.key_1)
									.. "] to move to first/last card",
							},
							true
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.insta_buy_or_sell,
							"Quick Buy/Sell",
							"Use",
							{
								"to",
								"buy or sell card",
								"(check Buy/Sell/Use mode)",
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.insta_buy_n_sell,
							"Quick Buy'n'Sell",
							"Use",
							{
								"to",
								"buy card and sell",
								"immediately after",
								"(check Buy/Sell/Use mode)",
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(Handy.config.current.insta_use, "Quick use", "Use", {
							"to",
							"use card if possible",
							"(overrides Quick Buy/Sell)",
							"(check Buy/Sell/Use mode)",
						}),
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.insta_highlight,
							"Quick Highlight",
							"Hold [Left Mouse]",
							{
								"and",
								"hover cards in hand to highlight",
							},
							true
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.insta_highlight_entire_f_hand,
							{ "Highlight", "entire hand" },
							"Press",
							{
								"to",
								"highlight entire hand",
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.deselect_hand,
							"Deselect hand",
							"Press",
							{
								"to",
								"deselect hand.",
								"Overrides vanilla keybind",
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.insta_cash_out,
							"Quick Cash Out",
							"Press",
							{
								"to",
								"speedup animation and",
								"skip Cash Out stage",
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.insta_booster_skip,
							{ "Quick skip", "Booster Packs" },
							"Hold",
							{
								"to",
								"skip booster pack",
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.speed_multiplier,
							"Speed Multiplier",
							"Hold",
							{
								"and",
								"[Wheel Up] to multiply or",
								"[Wheel Down] to divide game speed",
							}
						),
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
							Handy.config.current.nopeus_interaction,
							{ "Nopeus:", "fast-forward" },
							"Hold",
							{
								"and",
								"[Wheel Up] to increase or",
								"[Wheel Down] to decrease",
								"fast-forward setting",
							}
						),
						{
							n = G.UIT.R,
							config = { minh = 0.25 },
						},
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.not_just_yet_interaction,
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
							Handy.config.current.dangerous_actions,
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
							Handy.config.current.dangerous_actions.immediate_buy_and_sell,
							"Instant Sell",
							"Hold",
							{
								Handy.UI.PARTS.format_module_keys(
									Handy.config.current.dangerous_actions.immediate_buy_and_sell
								) .. ",",
								"hold "
									.. Handy.UI.PARTS.format_module_keys(Handy.config.current.insta_buy_or_sell)
									.. "",
								"and hover card to sell it",
							},
							true
						),
						{ n = G.UIT.R, config = { minh = 0.1 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.dangerous_actions.immediate_buy_and_sell.queue,
							"Sell Queue",
							"Start",
							{
								"selling cards only when",
								"keybind was released",
							},
							true
						),
						{ n = G.UIT.R, config = { minh = 0.45 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.dangerous_actions.nopeus_unsafe,
							{ "Nopeus: Unsafe", "fast-forward" },
							"Allow",
							{
								"increase fast-forward",
								'setting to "Unsafe"',
							},
							true
						),
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.dangerous_actions.sell_all_same,
							{ "Sell all", "card copies" },
							"Hold",
							{
								Handy.UI.PARTS.format_module_keys(
									Handy.config.current.dangerous_actions.immediate_buy_and_sell
								) .. ",",
								"hold " .. Handy.UI.PARTS.format_module_keys(
									Handy.config.current.dangerous_actions.sell_all_same
								) .. ",",
								"and click on card to sell",
								"all of their copies",
							},
							true
						),
						{ n = G.UIT.R, config = { minh = 0.1 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.dangerous_actions.sell_all,
							"Sell ALL",
							"Hold",
							{
								"to",
								"sell ALL cards in area instead",
							}
						),
						{ n = G.UIT.R, config = { minh = 0.1 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.dangerous_actions.card_remove,
							{ "Remove cards", "or skip tags" },
							"Hold",
							{
								"to",
								"REMOVE cards instead",
								"of selling, works for skip tags",
							}
						),
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
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.regular_keybinds.play, "Play hand"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.regular_keybinds.discard, "Discard"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.regular_keybinds.sort_by_rank, "Sort by rank"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.regular_keybinds.sort_by_suit, "Sort by suit"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.deselect_hand, "Deselect hand"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.insta_cash_out, "Cash Out"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.not_just_yet_interaction, "NotJustYet: End round"),
		Handy.UI.PARTS.create_module_section("Shop and Blinds"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.insta_booster_skip, "Skip Booster Pack"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.regular_keybinds.reroll_shop, "Shop reroll"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.regular_keybinds.leave_shop, "Leave shop"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.regular_keybinds.skip_blind, "Skip blind"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.regular_keybinds.select_blind, "Select blind"),
		Handy.UI.PARTS.create_module_section("Menus"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.regular_keybinds.run_info, "Run info: Poker hands"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.regular_keybinds.run_info_blinds, "Run info: Blinds"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.regular_keybinds.view_deck, "View deck"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.show_deck_preview, "Deck preview"),
	}
end

Handy.UI.get_config_tab_keybinds_2 = function()
	return {
		Handy.UI.PARTS.create_module_section("Quick actions"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.insta_buy_or_sell, "Quick Buy/Sell"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.insta_use, "Quick Use"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.insta_buy_n_sell, "Quick Buy'n'Sell"),
		Handy.UI.PARTS.create_module_keybind(
			Handy.config.current.insta_highlight_entire_f_hand,
			"Highlight entire hand"
		),
		Handy.UI.PARTS.create_module_section("Dangerous actions"),
		Handy.UI.PARTS.create_module_keybind(
			Handy.config.current.dangerous_actions.immediate_buy_and_sell,
			"Dangerous modifier",
			true
		),
		Handy.UI.PARTS.create_module_keybind(
			Handy.config.current.dangerous_actions.sell_all_same,
			"Sell all copies of card",
			true
		),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.dangerous_actions.sell_all, "Sell ALL cards", true),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.dangerous_actions.card_remove, "REMOVE cards", true),
		Handy.UI.PARTS.create_module_section("Game speed and animations"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.speed_multiplier, "Speed Multiplier"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.nopeus_interaction, "Nopeus: fast-forward"),
		Handy.UI.PARTS.create_module_section("Highlight movement"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.move_highlight.dx.one_left, "Move one left"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.move_highlight.dx.one_right, "Move one right"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.move_highlight.swap, "Move card"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.move_highlight.to_end, "Move to end"),
	}
end

Handy.UI.get_config_tab = function(_tab)
	local result = {
		n = G.UIT.ROOT,
		config = { align = "cm", padding = 0.05, colour = G.C.CLEAR, minh = 5, minw = 5 },
		nodes = {},
	}
	if _tab == "Overall" then
		result.nodes = Handy.UI.get_config_tab_overall()
	elseif _tab == "Interactions" then
		result.nodes = Handy.UI.get_config_tab_interactions()
	elseif _tab == "Dangerous" then
		result.nodes = Handy.UI.get_config_tab_dangerous()
	elseif _tab == "Regular" then
		result.nodes = Handy.UI.get_config_tab_regular_keybinds()
	elseif _tab == "Keybinds 2" then
		result.nodes = Handy.UI.get_config_tab_keybinds_2()
	end
	return result
end

--

function Handy.UI.get_options_tabs()
	return {
		{
			label = "Overall",
			tab_definition_function = function()
				return Handy.UI.get_config_tab("Overall")
			end,
		},
		{
			label = "Interactions",
			tab_definition_function = function()
				return Handy.UI.get_config_tab("Interactions")
			end,
		},
		{
			label = "Dangerous",
			tab_definition_function = function()
				return Handy.UI.get_config_tab("Dangerous")
			end,
		},
		{
			label = "Regular keybinds",
			tab_definition_function = function()
				return Handy.UI.get_config_tab("Regular")
			end,
		},
		{
			label = "Other keybinds",
			tab_definition_function = function()
				return Handy.UI.get_config_tab("Keybinds 2")
			end,
		},
	}
end

--

function G.UIDEF.handy_options()
	local tabs = Handy.UI.get_options_tabs()
	tabs[1].chosen = true
	local t = create_UIBox_generic_options({
		back_func = "options",
		contents = {
			{
				n = G.UIT.R,
				config = { align = "cm", padding = 0 },
				nodes = {
					create_tabs({
						tabs = tabs,
						snap_to_nav = true,
					}),
				},
			},
		},
	})
	return t
end

function G.FUNCS.handy_open_options()
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = G.UIDEF.handy_options(),
	})
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
