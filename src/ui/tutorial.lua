Handy.UI.TUTORIAL = {}

local new_arrows = {
	name_desc = {
		{
			r = math.rad(75),
			offset_x = 2.5,
			offset_y = -0.85 + 0.75,
			text_offset_x = 0,
			text_offset_y = -0.25,
			text = "Name",
			align = "tli",
		},
		{
			r = math.rad(105),
			offset_x = 2.75,
			offset_y = -0.25 + 0.75,
			text_offset_x = 0,
			text_offset_y = 0.05,
			text = "Description",
			align = "tli",
		},
		{
			r = math.rad(125),
			offset_x = 0.3,
			offset_y = 0 + 0.75,
			text_offset_x = 0,
			text_offset_y = 0.25,
			text = "Toggle",
			align = "tli",
		},
	},
	popup_alert = {
		{
			r = math.rad(-90),
			offset_x = -0.5,
			offset_y = 0.15,
			text_align = "cri",
			text_offset_x = 0,
			text_offset_y = 0,
			align = "tri",
			text = "Popup",
			prepend_text = true,
		},
		{
			r = math.rad(125),
			offset_x = 0.25,
			offset_y = -0.05 + 0.75,
			text_offset_x = 0,
			text_offset_y = 0.25,
			text = "Alert",
			align = "tli",
		},
	},
	keybind_desc = {
		{
			r = math.rad(-110),
			offset_x = -2,
			offset_y = 0.15,
			text_align = "cri",
			text_offset_x = 0,
			text_offset_y = 0.2,
			align = "cm",
			text = "Click",
			prepend_text = true,
		},
	},
}

local texts = {
	welcome = {
		"{s:1.5,E:1,C:white}Hello and Welcome, Balatro player{}",
		" ",
		"I'm {C:attention}SleepyG11{}, creator of {C:chips}Handy{}.",
		"Thank you for using my mod, I appreciating it a lot! {C:mult}<3{}",
	},

	intro_1 = {
		"This is a tutorial which you",
		"{C:attention}can skip{} in any moment.",
		" ",
		"{s:1.2}But you better don't, okay?",
		" ",
		"{s:1.4,C:attention}You need it.{}",
	},
	intro_2 = {
		"This mod adds a LOT of various controls and keybinds.",
		"{C:inactive}(Yes, not only drag to select!){}",
		" ",
		"To fit them all and make accessible, big custom",
		"config page is made with a lot of pages and tabs.",
	},
	intro_3 = {
		"Because of this, a lot of players missing",
		"most of cool things you can find in {C:chips}Handy{}!",
		" ",
		"So I want point main things to look at",
		"so you will not get lost!",
	},

	tutorial_skipped = {
		"Okay. Not holding you anymore.",
		"If you get lost in config, blame yourself.",
		" ",
		"You can start tutorial again by pressing",
		"corresponding button inside main page.",
		" ",
		"Again, thank you for using Handy! See you inside!",
	},

	line_example_1 = {
		"Since there's more than {C:attention}70{} configs",
		"with a lot of info and toggles, they're",
		"condensed into this unified conpact UI.",
		" ",
		"Let's break it down.",
	},
	line_example_2 = {
		"{C:attention}Name{} and {C:attention}Description{}, obviously.",
		" ",
		"On left, there's a {C:attention}toggle{} which used to",
		"{C:green}enable{} or {C:mult}disable{} features or controls.",
	},
	line_example_3 = {
		"On right, there's a {X:chips,C:white}(?){} circle which you can hover",
		"to see more info about specific control.",
		"{C:inactive}(Same info appear if you hover a name){}",
		" ",
		"Sometimes, control cannot work because of some conditions.",
		"You will notice when this happens if hover on this alert.",
	},
	line_example_4 = {
		"Controls can have familiar for you control",
		"elements such as sliders and cycles.",
		" ",
		"Easy!",
	},
	keybind_example_1 = {
		"This one is {C:attention}Keybind{}.",
		" ",
		"For this controls you can assign up to {C:attention}2{}",
		"different {C:attention}combinations{} of any keys.",
		"{C:inactive}(Any mouse, keyboard or gamepad button){}",
	},
	keybind_example_2 = {
		"1. Click on one of {C:chips}blue{} bittons to start assigning keybind",
		"2. Press all keys you want add to combination, or none of them",
		"3. Press [Escape] to finish and save input",
		" ",
		"Try it!",
	},
	dangerous_example_1 = {
		"If you see control red, this means it's {C:mult}Dangerous{} control.",
		" ",
		"Usually, it's very powerful or unsafe controls which may lead to",
		"unexpected game or performance issues, or even crashes!",
		"{C:inactive}(As example: mass selling and mass removing){}",
		" ",
		"They designed for heavily modded Balatro.",
		"Unless you really need, do not use them.",
	},

	lines_complete = {
		-- We did it, cleanup
		"Phew, that was a lot, but you did it!",
		"Congratulations to be not part of 98% Balatro players!",
		" ",
		"Now, quick explanations on what to look at.",
	},

	menus_info_1 = {
		-- Show buttons from main menu
		"In main config page, there's multiple buttons which leads",
		"to pages where controls are grouped for easier navigation.",
		"Check all of them!",
		" ",
		"in Mod Update page, you can find things for automatic mod updating.",
		"I'll downloadand install latest version for you. Handy, isn't it?",
	},
	menus_info_2 = {
		-- Show buttons which supposed to change tabs (on top)
		"Also, there's few tabs to look around.",
		" ",
		"In Presets, you can save/load your config",
		"and even switch between them in-game by using keybinds",
		" ",
		"In Search, you can find full list of all controls",
		"added by Handy, with a search input for easier",
		"finding specific controls you may need.",
	},
	-- If I'll add more tabs, I'll add explanation for them too

	tutorial_complete = {
		-- We did it
		"Now, you're ready.",
		" ",
		"Again, thank you for using Handy! See you inside!",
	},
}

local new_scenario = {
	welcome = {
		loc_txt = {
			main = texts.welcome,
			continue = {
				"Continue",
			},
		},
		layout = {
			type = "DEFAULT",
			transition_to = "intro_1",
		},
	},

	intro_1 = {
		loc_txt = {
			main = texts.intro_1,
			continue = {
				"Continue",
			},
		},
		layout = {
			type = "DEFAULT",
			transition_to = "intro_2",
		},
	},
	intro_2 = {
		loc_txt = {
			main = texts.intro_2,
			continue = {
				"Continue",
			},
		},
		layout = {
			type = "DEFAULT",
			transition_to = "intro_3",
		},
	},
	intro_3 = {
		loc_txt = {
			main = texts.intro_3,
			continue = {
				"Continue",
			},
		},
		layout = {
			type = "DEFAULT",
			transition_to = "line_example_1",
		},
	},

	line_example_1 = {
		loc_txt = {
			main = texts.line_example_1,
			continue = {
				"Continue",
			},
		},
		layout = {
			type = "DEFAULT",
			transition_to = "line_example_2",
			middle = {
				type = "R",
				centered = true,
				section_bg = true,
				get_nodes = function()
					return {
						{
							n = G.UIT.R,
							nodes = {
								{
									n = G.UIT.R,
									config = { colour = { 0, 0, 0, 0.1 }, r = 0.25 },
									nodes = {
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.appearance, { bg = true }),
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.notifications_level),
									},
								},
								Handy.UI.CP.r_sep(0.1),
								{
									n = G.UIT.R,
									config = { colour = { 0, 0, 0, 0.1 }, r = 0.25 },
									nodes = {
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.gamepad, { bg = true }),
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.controller_sensitivity),
									},
								},
								Handy.UI.CP.r_sep(0.1),
								{
									n = G.UIT.R,
									config = { colour = { 0, 0, 0, 0.1 }, r = 0.25 },
									nodes = {
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds, { bg = true }),
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_play),
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_restart_game),
										Handy.UI.CP.dictionary_item(
											Handy.D.dictionary.dangerous_actions_crash,
											{ bg = true }
										),
									},
								},
							},
						},
					}
				end,
			},
		},
	},
	line_example_2 = {
		loc_txt = {
			main = texts.line_example_2,
			continue = {
				"Continue",
			},
		},
		layout = {
			type = "DEFAULT",
			transition_to = "line_example_3",
			middle = {
				type = "R",
				get_nodes = function()
					return {
						{
							n = G.UIT.R,
							config = {
								func = "handy_setup_point_arrows",
								ref_table = new_arrows.name_desc,
							},
							nodes = {
								{
									n = G.UIT.R,
									config = { colour = { 0, 0, 0, 0.1 }, r = 0.25 },
									nodes = {
										Handy.UI.CP.r_sep(0.75),
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.speed_multiplier, { bg = true }),
										Handy.UI.CP.r_sep(0.75),
									},
								},
							},
						},
					}
				end,
			},
		},
	},
	line_example_3 = {
		loc_txt = {
			main = texts.line_example_3,
			continue = {
				"Continue",
			},
		},
		enter = function(self, content)
			Handy.UI.data.tutorial_fake_alert = true
		end,
		layout = {
			type = "DEFAULT",
			transition_to = "line_example_4",
			middle = {
				type = "R",
				get_nodes = function()
					return {
						{
							n = G.UIT.R,
							config = {
								func = "handy_setup_point_arrows",
								ref_table = new_arrows.popup_alert,
							},
							nodes = {
								{
									n = G.UIT.R,
									config = { colour = { 0, 0, 0, 0.1 }, r = 0.25 },
									nodes = {
										Handy.UI.CP.r_sep(0.75),
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.speed_multiplier, { bg = true }),
										Handy.UI.CP.r_sep(0.75),
									},
								},
							},
						},
					}
				end,
			},
		},
	},
	line_example_4 = {
		loc_txt = {
			main = texts.line_example_4,
			continue = {
				"Continue",
			},
		},
		enter = function(self, content)
			Handy.UI.data.tutorial_fake_alert = nil
		end,
		layout = {
			type = "DEFAULT",
			transition_to = "keybind_example_1",
			middle = {
				type = "R",
				centered = true,
				section_bg = true,
				get_nodes = function()
					return {
						{
							n = G.UIT.R,
							config = {
								func = "handy_setup_point_arrows",
								ref_table = new_arrows.name_desc,
							},
							nodes = {
								{
									n = G.UIT.R,
									config = { colour = { 0, 0, 0, 0.1 }, r = 0.25 },
									nodes = {
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.speed_multiplier_current_value),
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.animation_skip_current_value),
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.controller_sensitivity),
									},
								},
							},
						},
					}
				end,
			},
		},
	},
	keybind_example_1 = {
		loc_txt = {
			main = texts.keybind_example_1,
			continue = {
				"Continue",
			},
		},
		layout = {
			type = "DEFAULT",
			transition_to = "keybind_example_2",
			middle = {
				type = "R",
				centered = true,
				section_bg = true,
				get_nodes = function()
					return {
						{
							n = G.UIT.R,
							nodes = {
								Handy.UI.CP.r_sep(0.25),
								{
									n = G.UIT.R,
									config = { colour = { 0, 0, 0, 0.1 }, r = 0.25 },
									nodes = {
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_play),
									},
								},
								Handy.UI.CP.r_sep(0.25),
							},
						},
					}
				end,
			},
		},
	},
	keybind_example_2 = {
		loc_txt = {
			main = texts.keybind_example_2,
			continue = {
				"Continue",
			},
		},
		layout = {
			type = "DEFAULT",
			transition_to = "dangerous_example_1",
			middle = {
				type = "R",
				centered = true,
				section_bg = true,
				get_nodes = function()
					return {
						{
							n = G.UIT.R,
							config = {
								func = "handy_setup_point_arrows",
								ref_table = new_arrows.keybind_desc,
							},
							nodes = {
								Handy.UI.CP.r_sep(0.25),
								{
									n = G.UIT.R,
									config = { colour = { 0, 0, 0, 0.1 }, r = 0.25 },
									nodes = {
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_play),
									},
								},
								Handy.UI.CP.r_sep(0.25),
							},
						},
					}
				end,
			},
		},
	},
	dangerous_example_1 = {
		loc_txt = {
			main = texts.dangerous_example_1,
			continue = {
				"Continue",
			},
		},
		layout = {
			type = "DEFAULT",
			transition_to = "lines_complete",
			middle = {
				type = "R",
				centered = true,
				section_bg = true,
				get_nodes = function()
					return {
						{
							n = G.UIT.R,
							nodes = {
								{
									n = G.UIT.R,
									config = { colour = { 0, 0, 0, 0.1 }, r = 0.25 },
									nodes = {
										Handy.UI.CP.dictionary_item(
											Handy.D.dictionary.dangerous_actions_sell_all,
											{ bg = true }
										),
										Handy.UI.CP.dictionary_item(
											Handy.D.dictionary.dangerous_actions_remove_all,
											{ bg = true }
										),
										Handy.UI.CP.dictionary_item(
											Handy.D.dictionary.dangerous_actions_crash,
											{ bg = true }
										),
									},
								},
							},
						},
					}
				end,
			},
		},
	},
	lines_complete = {
		loc_txt = {
			main = texts.lines_complete,
			continue = {
				"Continue",
			},
		},
		layout = {
			type = "DEFAULT",
			transition_to = "lines_complete",
		},
	},

	--

	please_read = {
		loc_txt = {
			main = texts.explain_tutorial,
			continue = {
				"Continue",
			},
		},
		layout = {
			type = "DEFAULT",
			transition_to = "reason_for_tutorial",
		},
	},
	reason_for_tutorial = {
		loc_txt = {
			main = texts.ask_for_tutorial,
			continue = {
				"Continue",
			},
			skip = {
				"Skip",
			},
		},
		layout = {
			type = "DEFAULT",
			buttons = {
				{
					type = "SCENARIO_BUTTON",
					transition_to = "reason_for_tutorial",
					loc_txt = "continue",
				},
				{
					type = "SCENARIO_BUTTON",
					transition_to = "tutorial_skip_early",
					loc_txt = "skip",
					colour = G.C.MULT,
				},
			},
		},
	},
	tutorial_skip_early = {
		loc_txt = {
			main = texts.tutorial_skipped,
			exit = { "Exit" },
		},
		layout = {
			type = "DEFAULT",
			buttons = {
				{
					type = "BUTTON",
					button = "handy_options",
					loc_txt = "exit",
				},
			},
		},
	},

	line_explanation_1 = {
		loc_txt = {
			main = texts.line_example_1,
		},
		layout = {
			type = "DEFAULT",
			transition_to = "line_explanation_2",
			middle = {
				type = "R",
				section_bg = true,
				center = true,
				get_nodes = function()
					return {
						{
							n = G.UIT.R,
							config = { align = "cm" },
							nodes = {
								{
									n = G.UIT.C,
									config = { padding = 0.1, colour = { 0, 0, 0, 0.1 }, r = 0.25, align = "cm" },
									nodes = {
										create_option_cycle({
											w = 4,
											scale = 0.6,
											label = localize("b_set_windowmode"),
											options = localize("ml_windowmode_opt"),
											opt_callback = "handy_noop",
											current_option = 1,
										}),
										create_option_cycle({
											w = 4,
											scale = 0.6,
											label = localize("b_set_windowmode"),
											options = localize("ml_windowmode_opt"),
											opt_callback = "handy_noop",
											current_option = 1,
										}),
									},
								},
								Handy.UI.CP.c_sep(0.25),
								{
									n = G.UIT.C,
									config = { align = "cm" },
									nodes = {
										{
											n = G.UIT.R,
											config = {
												padding = 0.1,
												colour = { 0, 0, 0, 0.1 },
												r = 0.25,
												align = "cm",
											},
											nodes = {
												create_toggle({
													label = localize("b_high_contrast_cards"),
													ref_table = { value = 1 },
													ref_value = "value",
													callback = function() end,
												}),
											},
										},
										Handy.UI.CP.r_sep(0.25),
										{
											n = G.UIT.R,
											config = { padding = 0.1, colour = { 0, 0, 0, 0.1 }, r = 0.25 },
											nodes = {
												create_slider({
													w = 3.5,
													h = 0.4,
													ref_table = { value = 0.5 },
													ref_value = "value",
													min = 0,
													max = 1,
													label = "CRT",
												}),
											},
										},
									},
								},
							},
						},
					}
				end,
			},
		},
	},
	line_explanation_2 = {
		loc_txt = {
			main = texts.line_example_2,
		},
		layout = {
			type = "DEFAULT",
			transition_to = "line_explanation_3",
			middle = {
				type = "R",
				centered = true,
				section_bg = true,
				get_nodes = function()
					return {
						{
							n = G.UIT.R,
							nodes = {
								{
									n = G.UIT.R,
									config = { colour = { 0, 0, 0, 0.1 }, r = 0.25 },
									nodes = {
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.appearance, { bg = true }),
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.notifications_level),
									},
								},
								Handy.UI.CP.r_sep(0.1),
								{
									n = G.UIT.R,
									config = { colour = { 0, 0, 0, 0.1 }, r = 0.25 },
									nodes = {
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.gamepad, { bg = true }),
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.controller_sensitivity),
									},
								},
								Handy.UI.CP.r_sep(0.1),
								{
									n = G.UIT.R,
									config = { colour = { 0, 0, 0, 0.1 }, r = 0.25 },
									nodes = {
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds, { bg = true }),
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_play),
										Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_restart_game),
										Handy.UI.CP.dictionary_item(
											Handy.D.dictionary.dangerous_actions_crash,
											{ bg = true }
										),
									},
								},
							},
						},
					}
				end,
			},
		},
	},
	line_explanation_3 = {
		loc_txt = {
			main = texts.line_example_3,
		},
		layout = {
			type = "DEFAULT",
			transition_to = "line_explanation_4",
			middle = {
				type = "R",
				centered = true,
				section_bg = true,
				{
					type = "DICTIONARY_ITEMS",
					{
						key = "hand_selection",
					},
					{
						key = "regular_keybinds",
					},
					{
						key = "dangerous_actions",
						bg = true,
					},
				},
			},
		},
	},
	line_explanation_4 = {
		loc_txt = {
			main = texts.line_example_5,
		},
		layout = {
			type = "DEFAULT",
			transition_to = "line_explanation_5",
			middle = {
				type = "R",
				centered = true,
				section_bg = true,
				{
					type = "DICTIONARY_ITEMS",
					{
						key = "hand_selection",
					},
					{
						key = "speed_multiplier",
					},
					{
						key = "animation_skip",
					},
					{
						key = "dangerous_actions",
						bg = true,
					},
				},
			},
		},
	},
	line_explanation_5 = {
		loc_txt = {
			main = texts.line_example_4,
		},
		layout = {
			type = "DEFAULT",
			middle = {
				type = "R",
				centered = true,
				section_bg = true,
				{
					type = "DICTIONARY_ITEMS",
					{
						key = "speed_multiplier",
					},
					{
						key = "animation_skip",
					},
					{
						key = "prevent_if_debugplus",
					},
					{
						key = "move_highlight",
					},
					{
						key = "updater_auto_install_new_update",
					},
				},
			},
		},
	},
}

function Handy.UI.TUTORIAL.process_tutorial_layout(node, scenario)
	if node.type == "DEFAULT" then
		node = {
			type = "C",
			padding = 0.25,
			{
				type = "R",
				section_bg = true,
				center = true,
				{
					type = "ME",
					juice = true,
				},
				{
					type = "TEXT",
					loc_txt = "main",
				},
			},
			node.middle,
			{
				type = "R",
				section_bg = true,
				center = true,
				unpack(node.buttons or {
					{
						type = "SCENARIO_BUTTON",
						transition_to = node.transition_to,
						loc_txt = "continue",
					},
				}),
			},
		}
	end
	if node.type == "C" or node.type == "R" then
		local result = {
			n = G.UIT[node.type],
			config = {
				colour = node.section_bg and { 0, 0, 0, 0.1 } or nil,
				align = node.center and "cm" or nil,
				r = (node.section_bg and 0.25) or 0,
				padding = node.padding or (node.section_bg and 0.25) or 0,
			},
			nodes = node.get_nodes and node.get_nodes() or {},
		}
		for i, subnode in pairs(node) do
			if type(i) == "number" then
				result.nodes[#result.nodes + 1] = Handy.UI.TUTORIAL.process_tutorial_layout(subnode, scenario)
			end
		end
		return result
	end
	if node.type == "ME" then
		local area = CardArea(0, 0, G.CARD_W / 1.5, G.CARD_H / 1.5, {
			type = "title",
		})
		local card = Handy.UI.TUTORIAL.me
		if not card or card.REMOVED then
			card = Card(
				0,
				0,
				G.CARD_W / 1.5,
				G.CARD_H / 1.5,
				nil,
				G.P_CENTERS.j_joker,
				{ bypass_discovery_center = true, bypass_discovery_ui = true }
			)

			card.no_ui = true
			card.children.center.atlas = G.ASSET_ATLAS["handy_me_joker"]
			card.children.center:set_sprite_pos({ x = 0, y = 0 })
			card:start_materialize()
			card.states.collide.can = false

			Handy.UI.TUTORIAL.me = card
		end
		if card.area then
			card.area:remove_card(card)
		end
		area:emplace(card)
		card.states.collide.can = false
		if node.hard_set then
			area:align_cards()
			card:hard_set_VT()
		end
		if node.dissolve then
			card:start_dissolve()
		end
		if node.juice then
			card:juice_up()
		end
		return {
			n = G.UIT.O,
			config = {
				object = area,
			},
		}
	end
	if node.type == "TEXT" then
		return {
			n = G.UIT.C,
			config = { align = "cm" },
			nodes = {
				Handy.L.parse_lines(scenario.loc_txt[node.loc_txt], { default_col = G.C.UI.TEXT_LIGHT }),
			},
		}
	end
	if node.type == "SCENARIO_BUTTON" then
		return UIBox_button({
			label = scenario.loc_txt[node.loc_txt] or { "Continue" },
			-- scale = 0.3,
			colour = node.colour or G.C.CHIPS,
			col = true,
			button = "handy_tutorial_step",
			ref_table = {
				step_key = node.transition_to,
			},
		})
	end
	if node.type == "BUTTON" then
		return UIBox_button({
			label = scenario.loc_txt[node.loc_txt] or { "[UI ERROR]" },
			-- scale = 0.3,
			colour = node.colour or G.C.CHIPS,
			col = true,
			button = node.button,
			func = node.func,
		})
	end
	if node.type == "DICTIONARY_ITEMS" then
		local result = {
			n = G.UIT.R,
			config = { colour = { 0, 0, 0, 0.1 }, r = 0.25 },
			nodes = {},
		}
		for i, subnode in pairs(node) do
			if type(i) == "number" then
				result.nodes[#result.nodes + 1] = Handy.UI.CP.dictionary_item(Handy.D.dictionary[subnode.key], {
					bg = subnode.bg,
					readonly = subnode.readonly,
				})
			end
		end
		return result
	end
	if node.type == "DICTIONARY_ITEM" then
		return Handy.UI.CP.dictionary_item(Handy.D.dictionary[node.key], {
			bg = node.bg,
			readonly = node.readonly,
		})
	end
end

function Handy.UI.TUTORIAL.render_step(key)
	local container = G.OVERLAY_MENU:get_UIE_by_ID("handy_tutorial")
	if container then
		if not new_scenario[key] then
			print("No scenario", key)
			return
		end
		local new_content = UIBox({
			definition = {
				n = G.UIT.ROOT,
				config = { colour = G.C.CLEAR },
				nodes = {
					Handy.UI.TUTORIAL.process_tutorial_layout(new_scenario[key].layout, new_scenario[key]),
				},
			},
			config = { parent = container },
		})
		if new_scenario[key].enter then
			new_scenario[key]:enter(new_content)
		end
		container.config.object:remove()
		container.config.object = new_content
		container.config.object:recalculate()
		container.UIBox:recalculate()
		G.OVERLAY_MENU:recalculate()
	end
end

function G.FUNCS.handy_tutorial_step(e)
	G.E_MANAGER.queues.handy_tutorial = G.E_MANAGER.queues.handy_tutorial or {}
	G.E_MANAGER:clear_queue("handy_tutorial")
	G.CONTROLLER.locks.handy_tutorial = true
	G.E_MANAGER:add_event(
		Event({
			trigger = "after",
			delay = 0.75,
			blocking = false,
			blockable = false,
			no_delete = true,
			timer = "REAL",
			func = function()
				G.CONTROLLER.locks.handy_tutorial = nil
				return true
			end,
		}),
		nil,
		"handy_tutorial"
	)
	local step = e.config.ref_table.step_key
	Handy.UI.TUTORIAL.render_step(step)
end

function Handy.UI.TUTORIAL.exit()
	Handy.UI.data.tutorial_fake_alert = nil
end

function Handy.UI.TUTORIAL.test()
	G.E_MANAGER.queues.handy_tutorial = G.E_MANAGER.queues.handy_tutorial or {}
	G.E_MANAGER:clear_queue("handy_tutorial")
	G.CONTROLLER.locks.handy_tutorial = true
	G.E_MANAGER:add_event(
		Event({
			trigger = "after",
			delay = 0.75,
			blocking = false,
			blockable = false,
			no_delete = true,
			timer = "REAL",
			func = function()
				G.CONTROLLER.locks.handy_tutorial = nil
				return true
			end,
		}),
		nil,
		"handy_tutorial"
	)
	G.FUNCS.overlay_menu({
		definition = create_UIBox_generic_options({
			contents = {
				{
					n = G.UIT.R,
					config = { colour = G.C.CLEAR },
					nodes = {
						{
							n = G.UIT.O,
							config = {
								id = "handy_tutorial",
								object = UIBox({
									definition = {
										n = G.UIT.ROOT,
										config = { colour = G.C.CLEAR },
										nodes = {
											Handy.UI.TUTORIAL.process_tutorial_layout(
												new_scenario.keybind_example_2.layout,
												new_scenario.keybind_example_2
											),
										},
									},
									config = {},
								}),
							},
						},
					},
				},
			},
		}),
		is_handy_config = true,
	})
end

G.FUNCS.handy_setup_point_arrows = function(e)
	e.config.func = nil
	for index, arrow in ipairs(e.config.ref_table or {}) do
		local sprite = AnimatedSprite(0, 0, 0.5, 1.5, G.ANIMATION_ATLAS["handy_hint_arrow"], { x = 0, y = 0 })
		local content = {
			{
				n = G.UIT.O,
				config = {
					object = sprite,
				},
			},
		}
		local text_node = {
			n = G.UIT.O,
			config = {
				object = UIBox({
					definition = {
						n = G.UIT.ROOT,
						config = { padding = 0.1, r = 0.25, colour = { 0, 0, 0, 0.5 } },
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = arrow.text,
									scale = 0.32,
									colour = G.C.UI.TEXT_LIGHT,
								},
							},
						},
					},
					config = {
						align = arrow.text_align or "cli",
						offset = { x = arrow.text_offset_x or 0, y = arrow.text_offset_y or 0 },
					},
				}),
			},
		}
		if arrow.prepend_text then
			table.insert(content, 1, text_node)
		else
			table.insert(content, text_node)
		end
		local box = UIBox({
			definition = {
				n = G.UIT.ROOT,
				config = { colour = G.C.CLEAR, padding = 0.1, align = "cm" },
				nodes = content,
			},
			config = {
				major = e,
				parent = e,
				align = arrow.align,
				offset = {
					x = arrow.offset_x or 0,
					y = arrow.offset_y or 0,
				},
			},
		})
		if arrow.prepend_text then
			function box.UIRoot:draw_children()
				if self.states.visible then
					-- Draw children in reverse order
					for k = #self.children, 1, -1 do
						local v = self.children[k]
						if not v.config.draw_layer and k ~= "h_popup" and k ~= "alert" then
							if v.draw_self and not v.config.draw_after then
								v:draw_self()
							else
								v:draw()
							end
							if v.draw_children then
								v:draw_children()
							end
							if v.draw_self and v.config.draw_after then
								v:draw_self()
							else
								v:draw()
							end
						end
					end
				end
			end
		end
		sprite.role.r_bond = "Weak"
		sprite.T.r = arrow.r or 0.25
		sprite.VT.r = sprite.T.r
		sprite.states.collide.can = false
		box.states.collide.can = false
		e.children["handy_arrow_" .. index] = box
	end
end
