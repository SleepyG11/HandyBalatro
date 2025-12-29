function Handy.UI.insta_actions_page_definition()
	local CAI = {
		hand_W = 2.5 * G.CARD_W,
		hand_H = 0.95 * G.CARD_H,
		shop_W = 2.5 * G.CARD_W,
		shop_H = 0.95 * G.CARD_H,
	}

	local create_cards = function(is_shop)
		return function(area)
			for index, center in ipairs({ "j_joker", "c_earth" }) do
				local pos = Handy.UI.utils.calc_card_pos(area, G.CARD_W, G.CARD_H, index, 2)
				local card1 = Card(
					pos.x,
					pos.y,
					G.CARD_W,
					G.CARD_H,
					nil,
					G.P_CENTERS[center],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card1.handy_preview_insta_actions = {
					type = "hand",
					sell = Handy.L.dictionary("k_handy_preview_sell"),
					use = Handy.L.dictionary("k_handy_preview_use"),
				}

				function card1:handy_preview_buy_or_sell()
					Handy.UI.utils.card_eval_status_text(self, "extra", nil, nil, nil, {
						message = card1.handy_preview_insta_actions.sell,
						no_skip = true,
						colour = G.C.MULT,
						instant = true,
						sound = is_shop and "coin1" or "coin2",
						timer = "REAL",
					})
				end
				function card1:handy_preview_use()
					if self.config.center.key ~= "c_earth" then
						return
					end
					Handy.UI.utils.card_eval_status_text(self, "extra", nil, nil, nil, {
						message = card1.handy_preview_insta_actions.use,
						no_skip = true,
						colour = G.C.SECONDARY_SET.Tarot,
						instant = true,
						sound = "tarot1",
						timer = "REAL",
					})
				end
				function card1:handy_preview_buy_n_sell() end

				if is_shop then
					card1.handy_preview_insta_actions = {
						type = "shop",
						sell = Handy.L.dictionary("k_handy_preview_sell"),
						use = Handy.L.dictionary("k_handy_preview_buy_n_use"),
						buy_n_sell = Handy.L.dictionary("k_handy_preview_buy_n_sell"),
					}
					local t1 = {
						n = G.UIT.ROOT,
						config = {
							minw = 0.6,
							align = "tm",
							colour = darken(G.C.BLACK, 0.2),
							shadow = true,
							r = 0.05,
							padding = 0.05,
							minh = 1,
						},
						nodes = {
							{
								n = G.UIT.R,
								config = {
									align = "cm",
									colour = lighten(G.C.BLACK, 0.1),
									r = 0.1,
									minw = 1,
									minh = 0.55,
									emboss = 0.05,
									padding = 0.03,
								},
								nodes = {
									{
										n = G.UIT.O,
										config = {
											object = DynaText({
												string = {
													{
														prefix = localize("$"),
														ref_table = card1,
														ref_value = "cost",
													},
												},
												colours = { G.C.MONEY },
												shadow = true,
												silent = true,
												bump = true,
												pop_in = 0,
												scale = 0.5,
											}),
										},
									},
								},
							},
						},
					}
					card1.children.price = UIBox({
						definition = t1,
						config = {
							align = "tm",
							offset = { x = 0, y = 0.38 },
							major = card1,
							-- bond = "Weak",
							parent = card1,
						},
					})
					function card1:handy_preview_buy_n_sell()
						Handy.UI.utils.card_eval_status_text(self, "extra", nil, nil, nil, {
							message = card1.handy_preview_insta_actions.buy_n_sell,
							no_skip = true,
							colour = G.C.CHIPS,
							instant = true,
							sound = "coin1",
							timer = "REAL",
						})
						play_sound("coin2")
					end
				end
				area:emplace(card1)
			end
		end
	end

	local hand_area = Handy.UI.utils.card_area({
		w = CAI.hand_W,
		h = CAI.hand_H,
		card_limit = 3,
		highlight_limit = 0,
		on_create = create_cards(false),
	})
	local shop_area = Handy.UI.utils.card_area({
		w = CAI.shop_W,
		h = CAI.shop_H,
		card_limit = 3,
		highlight_limit = 0,
		on_create = create_cards(true),
	})
	local example_hand_row = {
		n = G.UIT.R,
		config = { align = "cm", padding = 0.125 },
		nodes = {
			{
				n = G.UIT.C,
				nodes = {
					{
						n = G.UIT.R,
						config = {
							colour = { 0, 0, 0, 0.1 },
							r = 0.1,
							padding = 0.1,
						},
						nodes = {
							{
								n = G.UIT.C,
								config = {
									minw = 0.5,
									align = "cm",
								},
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = "SLOTS",
											scale = 0.6,
											colour = G.C.L_BLACK,
											vert = true,
										},
									},
								},
							},
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
			{
				n = G.UIT.C,
				nodes = {
					{
						n = G.UIT.R,
						config = {
							colour = { 0, 0, 0, 0.1 },
							r = 0.1,
							padding = 0.1,
						},
						nodes = {
							{
								n = G.UIT.C,
								config = {
									minw = 0.5,
									align = "cm",
								},
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = "SHOP",
											scale = 0.6,
											colour = G.C.L_BLACK,
											vert = true,
										},
									},
								},
							},
							{
								n = G.UIT.O,
								config = {
									object = shop_area,
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
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.insta_actions, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.insta_actions_trigger_mode),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.insta_actions_buy_or_sell),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.insta_actions_buy_n_sell),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.insta_actions_use),
							Handy.UI.CP.dictionary_item(
								Handy.D.dictionary.insta_actions_cryptid_code_use_last_interaction
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
function Handy.UI.insta_actions_page_UIBox()
	return create_UIBox_generic_options({
		contents = {
			Handy.UI.insta_actions_page_definition(),
		},
		back_func = "handy_back_to_options",
	})
end

function Handy.UI.insta_actions_page()
	Handy.UI.data.rerender_uibox_func = Handy.UI.insta_actions_page_UIBox
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = Handy.UI.insta_actions_page_UIBox(),
		is_handy_config = true,
	})
	Handy.UI.CHAR.rerender()
	Handy.UI.attach_side_panel()
	G.OVERLAY_MENU:recalculate()
end

G.FUNCS.handy_insta_actions = function(e)
	Handy.UI.insta_actions_page()
end
