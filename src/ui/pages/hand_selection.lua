local is_bmag_present = function()
	return SMODS and SMODS.Mods and (SMODS.Mods.BetterMouseAndGamepad or {}).can_load
end

function Handy.UI.hand_selection_page_definition()
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
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.hand_selection, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.hand_selection_mode),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.hand_selection_insta_highlight),
							Handy.UI.CP.dictionary_item(
								Handy.D.dictionary.hand_selection_insta_highlight_allow_deselect
							),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.hand_selection_combine_select_deselect),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.hand_selection_deselect_hand),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.hand_selection_entire_f_hand),
						},
					},
				},
			},
		},
	}

	if not is_bmag_present() then
		local CAI = {
			hand_W = 5.5 * G.CARD_W,
			hand_H = 0.95 * G.CARD_H,
		}

		local drag_alerted = false

		local hand_area = Handy.UI.utils.card_area({
			w = CAI.hand_W,
			h = CAI.hand_H,
			card_limit = 8,
			highlight_limit = 5,
			on_create = function(area)
				local suit = pseudorandom_element({ "C", "S", "H", "D" }, pseudoseed("handy_" .. math.random()))
				for index, front in ipairs({
					suit .. "_A",
					suit .. "_K",
					suit .. "_Q",
					suit .. "_J",
					suit .. "_T",
					suit .. "_9",
					suit .. "_8",
					suit .. "_7",
				}) do
					local pos = Handy.UI.utils.calc_card_pos(area, G.CARD_W, G.CARD_H, index, 8)
					local card1 = Card(
						pos.x,
						pos.y,
						G.CARD_W,
						G.CARD_H,
						G.P_CARDS[front],
						G.P_CENTERS.c_base,
						{ bypass_discovery_center = true, bypass_discovery_ui = true }
					)
					card1.handy_insta_highlight_preview = true

					local old_drag = card1.drag
					function card1:drag(...)
						old_drag(self, ...)
						if not drag_alerted then
							drag_alerted = true
							Handy.UI.CHAR.set_sprite_pos("me", "angry")
							Handy.UI.CHAR.jump("me")
							delay(0.1, "handy_chars")
							Handy.UI.CHAR.set_sprite_pos("me", "default", true)
						end
					end
					local old_stop_drag = card1.stop_drag
					function card1:stop_drag(...)
						old_stop_drag(self, ...)
						G.E_MANAGER:add_event(
							Event({
								trigger = "after",
								delay = 0.25,
								blocking = false,
								func = function()
									drag_alerted = false
									return true
								end,
							}),
							"handy_chars"
						)
					end
					area:emplace(card1)
				end
			end,
		})
		hand_area.handy_prevent_gamepad_unhighlight = true

		Handy.UI.data.hand_selection_preview_area = hand_area
		local example_hand_row = {
			n = G.UIT.R,
			config = {
				padding = 0.1,
				align = "cm",
				colour = { 0, 0, 0, 0.1 },
				r = 0.25,
			},
			nodes = {
				{
					n = G.UIT.C,
					nodes = {
						{
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
										object = hand_area,
									},
								},
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
				Handy.UI.CP.r_sep(0.5),
				{
					n = G.UIT.R,
					config = { align = "cm" },
					nodes = {
						example_hand_row,
					},
				},
				Handy.UI.CP.r_sep(0.1),
				{
					n = G.UIT.R,
					config = { align = "cm" },
					nodes = {
						{
							n = G.UIT.T,
							config = {
								text = Handy.L.dictionary("handy_modals_move_highlight_preview_description"),
								colour = { 1, 1, 1, 0.6 },
								scale = 0.3,
							},
						},
					},
				},
			},
		}
	else
		local me_area = Handy.UI.utils.card_area({
			w = G.CARD_W,
			h = 0.95 * G.CARD_H,
			card_limit = 1,
			highlight_limit = 0,
            collection = true,
			on_create = function(area)
				local pos = Handy.UI.utils.calc_card_pos(area, G.CARD_W, G.CARD_H, 1, 1)
				local me = Card(
					pos.x,
					pos.y,
					G.CARD_W,
					G.CARD_H,
					nil,
					G.P_CENTERS.c_base,
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				me.no_ui = true
				Handy.me.set_joker_center(me)
				area:emplace(me)
			end,
		})

		return {
			n = G.UIT.C,
			nodes = {
				content,
				Handy.UI.CP.r_sep(0.5),
				{
					n = G.UIT.R,
					config = { align = "cm" },
					nodes = {
						{
							n = G.UIT.R,
							config = { align = "cm", padding = 0.1, r = 0.25, colour = { 0, 0, 0, 0.1 } },
							nodes = {
								{
									n = G.UIT.R,
									config = { align = "cm", padding = 0.1, r = 0.25, colour = { 0, 0, 0, 0.1 } },
									nodes = {
										{
											n = G.UIT.C,
											config = { padding = 0.075 },
											nodes = {
												Handy.UI.CP.r_sep(0.025),
												{
													n = G.UIT.R,
													nodes = {
														{
															n = G.UIT.O,
															config = {
																object = me_area,
															},
														},
													},
												},
											},
										},
										{
											n = G.UIT.C,
											nodes = {
												Handy.L.description(
													"Handy_Other",
													"better_mouse_and_gamepad_in_hand_selection",
													{
														default_col = G.C.UI.TEXT_LIGHT,
														scale = 0.85,
														align = "c",
													}
												),
											},
										},
									},
								},
							},
						},
					},
				},
			},
		}
	end
end
function Handy.UI.hand_selection_page_UIBox()
	return create_UIBox_generic_options({
		contents = {
			Handy.UI.hand_selection_page_definition(),
		},
		back_func = "handy_back_to_options",
	})
end

function Handy.UI.hand_selection_page()
	Handy.UI.data.rerender_uibox_func = Handy.UI.hand_selection_page_UIBox
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = Handy.UI.hand_selection_page_UIBox(),
		is_handy_config = true,
	})
	if is_bmag_present() then
		Handy.UI.CHAR.hide("me")
	else
		Handy.UI.CHAR.rerender()
	end
	Handy.UI.attach_side_panel()
	G.OVERLAY_MENU:recalculate()
end

G.FUNCS.handy_hand_selection = function(e)
	Handy.UI.hand_selection_page()
end
