function Handy.UI.dangerous_page_definition()
	local CAI = {
		hand_W = 6 * G.CARD_W,
		hand_H = 0.95 * G.CARD_H,
	}

	local content = {
		n = G.UIT.R,
		config = { align = "cm", colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.1 },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					colour = adjust_alpha(G.C.MULT, 0.1),
					align = "cm",
					r = 0.5,
				},
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm", r = 0.1 },
						nodes = {
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.dangerous_actions, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.dangerous_actions_sell_one),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.dangerous_actions_remove_one),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.dangerous_actions_sell_all_same),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.dangerous_actions_remove_all_same),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.dangerous_actions_sell_all),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.dangerous_actions_remove_all),
						},
					},
				},
			},
		},
	}

	local hand_area = Handy.UI.utils.card_area({
		w = CAI.hand_W,
		h = CAI.hand_H,
		card_limit = 8,
		highlight_limit = 1,
		on_create = function(area)
			for index, center in ipairs({
				"j_greedy_joker",
				"j_greedy_joker",
				"j_greedy_joker",
				"j_greedy_joker",
				"j_wrathful_joker",
				"j_wrathful_joker",
				"j_wrathful_joker",
				"j_wrathful_joker",
			}) do
				local pos = Handy.UI.utils.calc_card_pos(area, G.CARD_W, G.CARD_H, index, 8)
				local card1 = Card(
					pos.x,
					pos.y,
					G.CARD_W,
					G.CARD_H,
					nil,
					G.P_CENTERS[center],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				if (index - 1) % 4 < 2 then
					card1.ability.eternal = true
				end
				area:emplace(card1)
				card1.handy_preview_dangerous_actions = true
			end
		end,
	})

	Handy.UI.data.dangerous_actions_preview_area = hand_area

	local example_hand_row = {
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
			},
		},
	}

	return {
		n = G.UIT.C,
		nodes = {
			content,
			Handy.UI.CP.r_sep(0.1),
			example_hand_row,
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
									text = Handy.L.dictionary("handy_modals_move_highlight_preview_description"),
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
function Handy.UI.dangerous_page_UIBox()
	return create_UIBox_generic_options({
		contents = {
			Handy.UI.dangerous_page_definition(),
		},
		back_func = "handy_back_to_options",
	})
end

function Handy.UI.dangerous_page()
	Handy.UI.data.rerender_uibox_func = Handy.UI.dangerous_page_UIBox
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = Handy.UI.dangerous_page_UIBox(),
		is_handy_config = true,
	})
	Handy.UI.CHAR.rerender()
	Handy.UI.attach_side_panel()
	G.OVERLAY_MENU:recalculate()
end

G.FUNCS.handy_dangerous = function(e)
	Handy.UI.dangerous_page()
end
