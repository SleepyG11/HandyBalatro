local function calculate(deck, hand, jokers)
	Handy.__override_event_queue = "handy_config"
	Handy.__use_gamespeed = true
	Handy.UI.data.is_speed_n_animations_calculate = true
	for i = 1, 5 do
		Handy.UI.utils.draw_from_to(deck, hand)
	end
	Handy.UI.utils.delay(1)
	local total_triggers = 80
	local current_trigger = 1
	G.E_MANAGER:add_event(Event({
		func = function()
			local again = function(card)
				Handy.UI.utils.card_eval_status_text(card, "extra", nil, 0.75, nil, {
					message = localize("k_again_ex"),
				})
			end
			for i, king in ipairs(hand.cards) do
				local juice = function(baron)
					if baron then
						Handy.UI.utils.juice_card(baron)
					end
					Handy.UI.utils.card_eval_status_text(king, "x_mult", 1.5, current_trigger / total_triggers + 0.5)
					current_trigger = current_trigger + 1
				end
				local barons = function()
					juice()
					for j, baron in ipairs(jokers.cards) do
						if baron.config.center.key == "j_baron" then
							juice(baron)
						end
					end
				end
				-- card itself: steel + barons
				barons()
				-- red seals
				again(king)
				barons()
				-- mimes
				for i, mime in ipairs(jokers.cards) do
					if mime.config.center.key == "j_mime" then
						again(mime)
						barons()
					end
				end
			end
			Handy.UI.utils.delay(1.5)
			Handy.scoring_hold.preview_create_hold_event(false)
			G.E_MANAGER:add_event(Event({
				func = function()
					G.FUNCS.handy_speed_n_animations_stop_calculation(nil)
					return true
				end,
			}))
			return true
		end,
	}))
end

--

function Handy.UI.speed_n_animations_speed_tab_definition()
	local content = {
		n = G.UIT.R,
		config = { align = "cm", colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.1 },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					colour = adjust_alpha(HEX("000000"), 0.1),
					align = "cm",
					r = 0.5,
				},
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm", r = 0.1 },
						nodes = {
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.speed_multiplier, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.speed_multiplier_default_value),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.speed_multiplier_multiply),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.speed_multiplier_divide),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.speed_multiplier_toggle_temp_disabled),
							Handy.UI.CP.dictionary_item(
								Handy.D.dictionary.dangerous_actions_speed_multiplier_uncap,
								{ bg = true }
							),
						},
					},
				},
			},
		},
	}
	return {
		n = G.UIT.C,
		nodes = {
			content,
		},
	}
end
function Handy.UI.speed_n_animations_hold_tab_definition()
	local content = {
		n = G.UIT.R,
		config = { align = "cm", colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.1 },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					colour = adjust_alpha(HEX("000000"), 0.1),
					align = "cm",
					r = 0.5,
				},
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm", r = 0.1 },
						nodes = {
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.scoring_hold, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.scoring_hold_any_moment),
						},
					},
				},
			},
		},
	}
	return {
		n = G.UIT.C,
		nodes = {
			content,
		},
	}
end
function Handy.UI.speed_n_animations_animations_tab_definition()
	local content = {
		n = G.UIT.R,
		config = { align = "cm", colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.1 },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					colour = adjust_alpha(HEX("000000"), 0.1),
					align = "cm",
					r = 0.5,
				},
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm", r = 0.1 },
						nodes = {
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.animation_skip, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.animation_skip_default_value),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.animation_skip_increase),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.animation_skip_decrease),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.animation_skip_toggle_temp_disabled),
							Handy.UI.CP.dictionary_item(
								Handy.D.dictionary.dangerous_actions_animation_skip_unsafe,
								{ bg = true }
							),
						},
					},
				},
			},
		},
	}
	return {
		n = G.UIT.C,
		nodes = {
			content,
		},
	}
end

function Handy.UI.get_speed_n_animations_tabs()
	local result = {
		{
			label = Handy.L.tab("Speed"),
			tab_definition_function = function()
				return Handy.UI.speed_n_animations_speed_tab_definition()
			end,
		},
		{
			label = Handy.L.tab("Animations"),
			tab_definition_function = function()
				return Handy.UI.speed_n_animations_animations_tab_definition()
			end,
		},
		{
			label = Handy.L.tab("Hold"),
			tab_definition_function = function()
				return Handy.UI.speed_n_animations_hold_tab_definition()
			end,
		},
	}
	for index, item in ipairs(result) do
		local old_def = item.tab_definition_function
		item.tab_definition_function = function()
			Handy.UI.data.speed_n_animations_tab_index = index
			return {
				n = G.UIT.ROOT,
				config = { colour = G.C.CLEAR, minh = 4, align = "cm" },
				nodes = {
					old_def(),
				},
			}
		end
	end
	return result
end

--

function Handy.UI.speed_n_animations_page_definition()
	if not G.E_MANAGER.queues.handy_config then
		G.E_MANAGER.queues.handy_config = {}
	end
	local CAI = {
		deck_W = G.CARD_W,
		deck_H = 0.95 * G.CARD_H,
		hand_W = 2.5 * G.CARD_W,
		hand_H = 0.95 * G.CARD_H,
		jokers_W = 1.5 * G.CARD_W,
		jokers_H = 0.95 * G.CARD_H,
	}

	local jokers_area, hand_area, deck_area
	jokers_area =
		CardArea(G.ROOM.T.x + G.ROOM.T.w / 2, G.ROOM.T.h, CAI.jokers_W, CAI.jokers_H, { card_limit = 2, type = "play" })
	hand_area =
		CardArea(G.ROOM.T.x + G.ROOM.T.w / 2, G.ROOM.T.h, CAI.hand_W, CAI.hand_H, { card_limit = 5, type = "play" })
	deck_area =
		CardArea(G.ROOM.T.x + G.ROOM.T.w / 2, G.ROOM.T.h, CAI.deck_W, CAI.deck_H, { card_limit = 52, type = "deck" })

	G.E_MANAGER:add_event(
		Event({
			timer = "REAL",
			func = function()
				if jokers_area.REMOVED then
					return true
				end
				for i = 1, 2 do
					local pos = Handy.UI.utils.calc_card_pos(jokers_area, G.CARD_W, G.CARD_H, i, 2)
					local card = Card(
						pos.x,
						pos.y,
						G.CARD_W,
						G.CARD_H,
						G.P_CARDS.empty,
						i == 1 and G.P_CENTERS.j_baron or G.P_CENTERS.j_mime,
						{ bypass_discovery_center = true, bypass_discovery_ui = true }
					)
					jokers_area:emplace(card)
				end
				for i = 1, 15 do
					local card1 = Card(
						deck_area.VT.x + deck_area.VT.w / 2 - G.CARD_W / 2,
						deck_area.VT.y,
						G.CARD_W,
						G.CARD_H,
						G.P_CARDS.H_K,
						G.P_CENTERS.m_steel,
						{ bypass_discovery_center = true, bypass_discovery_ui = true }
					)
					card1:set_seal("Red", true, true)
					deck_area:emplace(card1)
				end
				return true
			end,
		}),
		"handy_config"
	)

	Handy.UI.data.speed_n_animations_preview = {
		jokers = jokers_area,
		hand = hand_area,
		deck = deck_area,
	}

	local areas_containers = {}
	for _, area in ipairs({ jokers_area, hand_area, deck_area }) do
		table.insert(areas_containers, {
			n = G.UIT.C,
			config = {
				colour = { 0, 0, 0, 0.1 },
				r = 0.1,
				padding = 0.1,
			},
			nodes = {
				{
					n = G.UIT.O,
					config = {
						object = area,
					},
				},
			},
		})
	end

	local example_calc_row = {
		n = G.UIT.R,
		config = {
			padding = 0.125,
			align = "cm",
		},
		nodes = {
			{
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0.125 },
						nodes = areas_containers,
					},
				},
			},
			{
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = {
					UIBox_button({
						label = Handy.L.dictionary("handy_modals_start_calculation"),
						scale = 0.3,
						colour = G.C.CHIPS,
						button = "handy_speed_n_animations_calculate",
					}),
					{ n = G.UIT.R, config = { minh = 0.25 } },
					UIBox_button({
						label = Handy.L.dictionary("handy_modals_stop_calculation"),
						scale = 0.3,
						colour = G.C.MULT,
						button = "handy_speed_n_animations_stop_calculation",
					}),
				},
			},
		},
	}

	local tabs = Handy.UI.get_speed_n_animations_tabs()
	tabs[Handy.UI.data.speed_n_animations_tab_index or 1].chosen = true

	local content = {
		n = G.UIT.R,
		config = { align = "cm" },
		nodes = {
			create_tabs({
				tabs = tabs,
				colour = G.C.BOOSTER,
			}),
		},
	}

	return {
		n = G.UIT.C,
		nodes = {
			content,
			Handy.UI.CP.c_sep(0.1),
			example_calc_row,
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = Handy.L.dictionary("handy_modals_preview_description"),
									colour = { 1, 1, 1, 0.6 },
									scale = 0.3,
								},
							},
						},
					},
				},
			},
		},
	}
end

function Handy.UI.speed_n_animations_page_UIBox()
	return create_UIBox_generic_options({
		contents = {
			Handy.UI.speed_n_animations_page_definition(),
		},
		back_func = "handy_leave_speed_n_animations",
	})
end
function Handy.UI.speed_n_animations_page()
	Handy.UI.data.speed_n_animations_tab_index = nil
	Handy.UI.data.rerender_uibox_func = Handy.UI.speed_n_animations_page_UIBox
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = Handy.UI.speed_n_animations_page_UIBox(),
		is_handy_config = true,
	})
	Handy.UI.CHAR.rerender()
	Handy.UI.attach_side_panel()
	G.OVERLAY_MENU:recalculate()
end

G.FUNCS.handy_speed_n_animations = function(e)
	Handy.UI.speed_n_animations_page()
end
G.FUNCS.handy_leave_speed_n_animations = function(e)
	G.E_MANAGER:clear_queue("handy_config")
	Handy.__override_event_queue = nil
	Handy.__use_gamespeed = nil
	Handy.UI.data.is_speed_n_animations_calculate = nil
	G.FUNCS.handy_back_to_options(e)
	Handy.UI.data.speed_n_animations_preview = nil
end

function G.FUNCS.handy_speed_n_animations_stop_calculation(e, without_cleanup)
	local d = Handy.UI.data.speed_n_animations_preview
	if not d then
		return
	end
	G.E_MANAGER:clear_queue("handy_config")
	Handy.__override_event_queue = "handy_config"
	Handy.__use_gamespeed = true
	Handy.UI.data.is_speed_n_animations_calculate = nil
	for i = 1, #d.hand.cards + 1 do
		Handy.UI.utils.draw_from_to(d.hand, d.deck)
	end
	if not without_cleanup then
		G.E_MANAGER:add_event(Event({
			force_pause = true,
			func = function()
				Handy.__override_event_queue = nil
				Handy.__use_gamespeed = nil
				Handy.UI.data.is_speed_n_animations_calculate = nil
				return true
			end,
		}))
	end
end
function G.FUNCS.handy_speed_n_animations_calculate(e)
	local d = Handy.UI.data.speed_n_animations_preview
	if not d then
		return
	end
	G.FUNCS.handy_speed_n_animations_stop_calculation(e, true)
	Handy.__use_gamespeed = true
	Handy.UI.utils.delay(0.2)
	G.E_MANAGER:add_event(Event({
		force_pause = true,
		func = function()
			calculate(d.deck, d.hand, d.jokers)
			return true
		end,
	}))
end
