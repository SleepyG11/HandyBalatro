function Handy.UI.hand_selection_page_definition()
	local CAI = {
		hand_W = 4 * G.CARD_W,
		hand_H = 0.95 * G.CARD_H,
	}

	local drag_alerted = false

	local hand_area = Handy.UI.utils.card_area({
		w = CAI.hand_W,
		h = CAI.hand_H,
		card_limit = 8,
		highlight_limit = 5,
		on_create = function(area)
			for index, front in ipairs({
				"C_A",
				"C_K",
				"C_Q",
				"C_J",
				"C_T",
				"C_9",
				"C_8",
				"C_7",
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
	Handy.UI.data.hand_selection_preview_area = hand_area
	local example_hand_row = {
		n = G.UIT.R,
		config = {
			padding = 0.125,
			align = "cm",
		},
		nodes = {
			{
				n = G.UIT.C,
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
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.hand_selection_insta_highlight),
							Handy.UI.CP.dictionary_item(
								Handy.D.dictionary.hand_selection_insta_highlight_allow_deselect
							),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.hand_selection_deselect_hand),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.hand_selection_entire_f_hand),
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
	Handy.UI.CHAR.rerender()
	Handy.UI.attach_side_panel()
	G.OVERLAY_MENU:recalculate()
end

G.FUNCS.handy_hand_selection = function(e)
	Handy.UI.hand_selection_page()
end
