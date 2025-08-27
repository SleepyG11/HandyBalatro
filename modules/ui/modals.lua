G.handy_config_storage = {}

local function handy_draw_from_to(from, to)
	G.E_MANAGER:add_event(
		Event({
			trigger = "after",
			delay = 0.08,
			blocking = not Handy.animation_skip.should_skip_everything(),
			func = function()
				if to and from then
					local card = from:remove_card()
					if card then
						to:emplace(card)
						play_sound("card1", 0.85 + 50 * 0.2 / 100, 0.6 * (vol or 1))
					end
				end
				return true
			end,
		}),
		"handy_config"
	)
end
local function handy_delay(delay)
	G.E_MANAGER:add_event(
		Event({
			trigger = "after",
			delay = delay or 0.1,
			func = function()
				return true
			end,
		}),
		"handy_config"
	)
end
local function handy_juice_card(card)
	if Handy.animation_skip.should_skip_animation() then
		return
	end
	G.E_MANAGER:add_event(
		Event({
			trigger = "immediate",
			func = function()
				card:juice_up(0.7)
				return true
			end,
		}),
		"handy_config"
	)
end
local function handy_attention_text(args)
	if Handy.animation_skip.should_skip_animation() then
		return
	end
	args = args or {}
	args.text = args.text or "test"
	args.scale = args.scale or 1
	args.colour = copy_table(args.colour or G.C.WHITE)
	args.hold = (args.hold or 0) + 0.1
	args.pos = args.pos or { x = 0, y = 0 }
	args.align = args.align or "cm"
	args.emboss = args.emboss or nil

	args.fade = 1

	if args.cover then
		args.cover_colour = copy_table(args.cover_colour or G.C.RED)
		args.cover_colour_l = copy_table(lighten(args.cover_colour, 0.2))
		args.cover_colour_d = copy_table(darken(args.cover_colour, 0.2))
	else
		args.cover_colour = copy_table(G.C.CLEAR)
	end

	args.uibox_config = {
		align = args.align or "cm",
		offset = args.offset or { x = 0, y = 0 },
		major = args.cover or args.major or nil,
		instance_type = "POPUP",
	}

	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0,
		blockable = false,
		blocking = false,
		func = function()
			args.AT = UIBox({
				T = { args.pos.x, args.pos.y, 0, 0 },
				definition = {
					n = G.UIT.ROOT,
					config = {
						align = args.cover_align or "cm",
						minw = (args.cover and args.cover.T.w or 0.001) + (args.cover_padding or 0),
						minh = (args.cover and args.cover.T.h or 0.001) + (args.cover_padding or 0),
						padding = 0.03,
						r = 0.1,
						emboss = args.emboss,
						colour = args.cover_colour,
					},
					nodes = {
						{
							n = G.UIT.O,
							config = {
								draw_layer = 1,
								object = DynaText({
									scale = args.scale,
									string = args.text,
									maxw = args.maxw,
									colours = { args.colour },
									float = true,
									shadow = true,
									silent = not args.noisy,
									args.scale,
									pop_in = 0,
									pop_in_rate = 6,
									rotate = args.rotate or nil,
								}),
							},
						},
					},
				},
				config = args.uibox_config,
			})
			args.AT.attention_text = true

			args.text = args.AT.UIRoot.children[1].config.object
			args.text:pulse(0.5)

			if args.cover then
				local a = Particles(args.pos.x, args.pos.y, 0, 0, {
					timer_type = "TOTAL",
					timer = 0.01,
					pulse_max = 15,
					max = 0,
					scale = 0.3,
					vel_variation = 0.2,
					padding = 0.1,
					fill = true,
					lifespan = 0.5,
					speed = 2.5,
					attach = args.AT.UIRoot,
					colours = { args.cover_colour, args.cover_colour_l, args.cover_colour_d },
				})
				a.created_on_pause = true
			end
			if args.backdrop_colour then
				args.backdrop_colour = copy_table(args.backdrop_colour)
				local a = Particles(args.pos.x, args.pos.y, 0, 0, {
					timer_type = "TOTAL",
					timer = 5,
					scale = 2.4 * (args.backdrop_scale or 1),
					lifespan = 5,
					speed = 0,
					attach = args.AT,
					colours = { args.backdrop_colour },
				})
				a.created_on_pause = true
			end
			return true
		end,
	}))

	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = args.hold,
		blockable = false,
		blocking = false,
		no_delete = true,
		func = function()
			if not args.start_time then
				args.start_time = G.TIMERS.TOTAL
				args.text:pop_out(3)
			else
				--args.AT:align_to_attach()
				args.fade = math.max(0, 1 - 3 * (G.TIMERS.TOTAL - args.start_time))
				if args.cover_colour then
					args.cover_colour[4] = math.min(args.cover_colour[4], 2 * args.fade)
				end
				if args.cover_colour_l then
					args.cover_colour_l[4] = math.min(args.cover_colour_l[4], args.fade)
				end
				if args.cover_colour_d then
					args.cover_colour_d[4] = math.min(args.cover_colour_d[4], args.fade)
				end
				if args.backdrop_colour then
					args.backdrop_colour[4] = math.min(args.backdrop_colour[4], args.fade)
				end
				args.colour[4] = math.min(args.colour[4], args.fade)
				if args.fade <= 0 then
					args.AT:remove()
					return true
				end
			end
		end,
	}))
end
local function handy_card_eval_status_text(card, eval_type, amt, percent, dir, extra)
	if Handy.animation_skip.should_skip_animation() then
		return
	end
	if Handy.animation_skip.should_skip_messages() then
		extra = extra or {}
		if not extra.no_juice then
			if extra.instant then
				card:juice_up(0.6, 0.1)
				-- G.ROOM.jiggle = G.ROOM.jiggle + 0.7
			else
				G.E_MANAGER:add_event(Event({
					func = function()
						card:juice_up(0.6, 0.1)
						-- G.ROOM.jiggle = G.ROOM.jiggle + 0.7
						return true
					end,
				}))
			end
		end
		return
	end
	percent = percent or (0.9 + 0.2 * math.random())
	if dir == "down" then
		percent = 1 - percent
	end

	if extra and extra.focus then
		card = extra.focus
	end

	local text = ""
	local sound = nil
	local volume = 1
	local card_aligned = "bm"
	local y_off = 0.15 * G.CARD_H
	if card.area == G.jokers or card.area == G.consumeables then
		y_off = 0.05 * card.T.h
	elseif card.area == G.hand then
		y_off = -0.05 * G.CARD_H
		card_aligned = "tm"
	elseif card.area == G.play then
		y_off = -0.05 * G.CARD_H
		card_aligned = "tm"
	elseif card.jimbo then
		y_off = -0.05 * G.CARD_H
		card_aligned = "tm"
	end
	local config = {}
	local delay = 0.65
	local colour = config.colour or (extra and extra.colour) or G.C.FILTER
	local extrafunc = nil

	if eval_type == "debuff" then
		sound = "cancel"
		amt = 1
		colour = G.C.RED
		config.scale = 0.6
		text = localize("k_debuffed")
	elseif eval_type == "chips" then
		sound = "chips1"
		amt = amt
		colour = G.C.CHIPS
		text = localize({ type = "variable", key = "a_chips", vars = { amt } })
		delay = 0.6
	elseif eval_type == "mult" then
		sound = "multhit1" --'other1'
		amt = amt
		text = localize({ type = "variable", key = "a_mult", vars = { amt } })
		colour = G.C.MULT
		config.type = "fade"
		config.scale = 0.7
	elseif (eval_type == "x_mult") or (eval_type == "h_x_mult") then
		sound = "multhit2"
		volume = 0.7
		amt = amt
		text = localize({ type = "variable", key = "a_xmult", vars = { amt } })
		colour = G.C.XMULT
		config.type = "fade"
		config.scale = 0.7
	elseif eval_type == "h_mult" then
		sound = "multhit1"
		amt = amt
		text = localize({ type = "variable", key = "a_mult", vars = { amt } })
		colour = G.C.MULT
		config.type = "fade"
		config.scale = 0.7
	elseif eval_type == "dollars" then
		sound = "coin3"
		amt = amt
		text = (amt < -0.01 and "-" or "") .. localize("$") .. tostring(math.abs(amt))
		colour = amt < -0.01 and G.C.RED or G.C.MONEY
	elseif eval_type == "swap" then
		sound = "generic1"
		amt = amt
		text = localize("k_swapped_ex")
		colour = G.C.PURPLE
	elseif eval_type == "extra" or eval_type == "jokers" then
		sound = extra.edition and "foil2"
			or extra.mult_mod and "multhit1"
			or extra.Xmult_mod and "multhit2"
			or "generic1"
		if extra.edition then
			colour = G.C.DARK_EDITION
		end
		volume = extra.edition and 0.3 or sound == "multhit2" and 0.7 or 1
		delay = extra.delay or 0.75
		amt = 1
		text = extra.message or text
		if not extra.edition and (extra.mult_mod or extra.Xmult_mod) then
			colour = G.C.MULT
		end
		if extra.chip_mod then
			config.type = "fall"
			colour = G.C.CHIPS
			config.scale = 0.7
		elseif extra.swap then
			config.type = "fall"
			colour = G.C.PURPLE
			config.scale = 0.7
		else
			config.type = "fall"
			config.scale = 0.7
		end
	end
	delay = delay * 1.25

	if amt > 0 or amt < 0 then
		if extra and extra.instant then
			if extrafunc then
				extrafunc()
			end
			handy_attention_text({
				text = text,
				scale = config.scale or 1,
				hold = delay - 0.2,
				backdrop_colour = colour,
				align = card_aligned,
				major = card,
				offset = { x = 0, y = y_off },
			})
			play_sound(sound, 0.8 + percent * 0.2, volume)
			if not extra or not extra.no_juice then
				card:juice_up(0.6, 0.1)
				G.ROOM.jiggle = G.ROOM.jiggle + 0.7
			end
		else
			G.E_MANAGER:add_event(Event({ --Add bonus chips from this card
				trigger = "before",
				delay = delay,
				func = function()
					if extrafunc then
						extrafunc()
					end
					handy_attention_text({
						text = text,
						scale = config.scale or 1,
						hold = delay - 0.2,
						backdrop_colour = colour,
						align = card_aligned,
						major = card,
						offset = { x = 0, y = y_off },
					})
					play_sound(sound, 0.8 + percent * 0.2, volume)
					if not extra or not extra.no_juice then
						card:juice_up(0.6, 0.1)
						G.ROOM.jiggle = G.ROOM.jiggle + 0.7
					end
					return true
				end,
			}))
		end
	end
end
local function calculate(deck, hand, jokers)
	Handy.__override_event_queue = "handy_config"
	Handy.__use_gamespeed = true
	G.SETTINGS.paused = false
	for i = 1, 5 do
		handy_draw_from_to(deck, hand)
	end
	delay(1)
	local total_triggers = 80
	local current_trigger = 1
	G.E_MANAGER:add_event(Event({
		func = function()
			local again = function(card)
				handy_card_eval_status_text(card, "extra", nil, 0.75, nil, {
					message = localize("k_again_ex"),
				})
			end
			for i, king in ipairs(hand.cards) do
				local juice = function(baron)
					if baron then
						handy_juice_card(baron)
					end
					handy_card_eval_status_text(king, "x_mult", 1.5, current_trigger / total_triggers + 0.5)
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
			delay(1.5)
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

function G.UIDEF.handy_speed_n_animations_modal()
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

	G.handy_config_storage.jokers = jokers_area
	G.handy_config_storage.hand = hand_area
	G.handy_config_storage.deck = deck_area

	G.handy_config_storage.rerender = function()
		local speed_text_container = G.OVERLAY_MENU:get_UIE_by_ID("handy_speed_n_animations_speed_desc")
		speed_text_container.config.object:remove()
		speed_text_container.config.object = UIBox({
			definition = {
				n = G.UIT.ROOT,
				config = { colour = G.C.CLEAR },
				nodes = {
					Handy.UI.CD.speed_multiplier.checkbox({
						only_description = true,
					}),
				},
			},
			config = {
				parent = speed_text_container,
			},
		})

		local animation_text_container = G.OVERLAY_MENU:get_UIE_by_ID("handy_speed_n_animations_animations_desc")
		animation_text_container.config.object:remove()
		animation_text_container.config.object = UIBox({
			definition = {
				n = G.UIT.ROOT,
				config = { colour = G.C.CLEAR },
				nodes = {
					Handy.UI.CD.animation_skip.checkbox({
						only_description = true,
					}),
				},
			},
			config = {
				parent = animation_text_container,
			},
		})
		G.OVERLAY_MENU:recalculate()
	end

	G.E_MANAGER:add_event(
		Event({
			timer = "REAL",
			func = function()
				for i = 1, 2 do
					local card = Card(
						jokers_area.T.x + jokers_area.T.w / 2 - G.CARD_W / 2,
						jokers_area.T.y,
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
						hand_area.T.x + hand_area.T.w / 2 - G.CARD_W / 2,
						hand_area.T.y,
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

	local example_calc_row = {
		n = G.UIT.R,
		config = {
			padding = 0.25,
			align = "cm",
		},
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
							object = jokers_area,
						},
					},
				},
			},
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
							object = deck_area,
						},
					},
				},
			},
			{
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = {
					UIBox_button({
						label = {
							"Start calculation",
						},
						scale = 0.4,
						colour = G.C.CHIPS,
						button = "handy_speed_n_animations_calculate",
					}),
					{ n = G.UIT.R, config = { minh = 0.25 } },
					UIBox_button({
						label = {
							"Stop calculation",
						},
						scale = 0.4,
						colour = G.C.MULT,
						button = "handy_speed_n_animations_stop_calculation",
					}),
				},
			},
		},
	}

	local content = {
		n = G.UIT.C,
		config = { colour = G.C.CLEAR },
		nodes = {
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = {
							minw = 5,
						},
					},
					{
						n = G.UIT.C,
						config = { minw = 7 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.C,
										config = { minw = 1.3, align = "cm" },
										nodes = {
											Handy.UI.CD.speed_multiplier.checkbox({ only_toggle = true }),
										},
									},
									{
										n = G.UIT.C,
										nodes = {
											{
												n = G.UIT.R,
												nodes = {
													{
														n = G.UIT.T,
														config = {
															text = "Speed multiplier",
															colour = G.C.WHITE,
															scale = 0.5,
														},
													},
												},
											},
											{
												n = G.UIT.R,
												config = { minh = 0.05 },
											},
											{
												n = G.UIT.R,
												nodes = {
													{
														n = G.UIT.T,
														config = {
															text = "Increase speed of animations",
															colour = adjust_alpha(G.C.WHITE, 0.75),
															scale = 0.35,
														},
													},
												},
											},
										},
									},
								},
							},
						},
					},
					{
						n = G.UIT.C,
						config = { minw = 7 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.C,
										config = { minw = 1.3, align = "cm" },
										nodes = {
											Handy.UI.CD.animation_skip.checkbox({ only_toggle = true }),
										},
									},
									{
										n = G.UIT.C,
										nodes = {
											{
												n = G.UIT.R,
												nodes = {
													{
														n = G.UIT.T,
														config = {
															text = "Animation skip",
															colour = G.C.WHITE,
															scale = 0.5,
														},
													},
												},
											},
											{
												n = G.UIT.R,
												config = { minh = 0.05 },
											},
											{
												n = G.UIT.R,
												nodes = {
													{
														n = G.UIT.T,
														config = {
															text = "Remove animations",
															colour = adjust_alpha(G.C.WHITE, 0.75),
															scale = 0.35,
														},
													},
												},
											},
										},
									},
								},
							},
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { minh = 0.25 },
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = {
							minw = 5,
							align = "cm",
						},
						nodes = {
							{
								n = G.UIT.R,
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = "Current value",
											colour = G.C.WHITE,
											scale = 0.4,
										},
									},
								},
							},
						},
					},
					{
						n = G.UIT.C,
						config = { padding = 0.1, align = "cm", minw = 7 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									Handy.UI.CD.speed_multiplier_default_value.option_cycle({
										no_label = true,
									}),
								},
							},
						},
					},
					{
						n = G.UIT.C,
						config = { padding = 0.1, align = "cm", minw = 7 },
						nodes = {

							{
								n = G.UIT.R,
								nodes = {
									Handy.UI.CD.animation_skip_default_value.option_cycle({
										no_label = true,
									}),
								},
							},
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = {
							minw = 5,
							align = "cm",
						},
						nodes = {
							{
								n = G.UIT.R,
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = "Default value",
											colour = G.C.WHITE,
											scale = 0.4,
										},
									},
								},
							},
						},
					},
					{
						n = G.UIT.C,
						config = { padding = 0.1, align = "cm", minw = 7 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									Handy.UI.CD.speed_multiplier_default_value.option_cycle({
										no_label = true,
									}),
								},
							},
						},
					},
					{
						n = G.UIT.C,
						config = { padding = 0.1, align = "cm", minw = 7 },
						nodes = {

							{
								n = G.UIT.R,
								nodes = {
									Handy.UI.CD.animation_skip_default_value.option_cycle({
										no_label = true,
									}),
								},
							},
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = {
							minw = 5,

							align = "cm",
						},
						nodes = {
							{
								n = G.UIT.R,
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = "No hold / Usage",
											colour = G.C.WHITE,
											scale = 0.4,
										},
									},
								},
							},
						},
					},
					{
						n = G.UIT.C,
						config = { padding = 0.1, minw = 7 },
						nodes = {
							{
								n = G.UIT.R,
								config = {},
								nodes = {
									{
										n = G.UIT.C,
										config = { minw = 1.1, align = "cm" },
										nodes = {
											Handy.UI.CD.speed_multiplier_no_hold.checkbox({
												only_toggle = true,
											}),
										},
									},
									{
										n = G.UIT.C,
										config = { minw = 0.075 },
									},
									{
										n = G.UIT.C,
										nodes = {
											{
												n = G.UIT.O,
												config = {
													id = "handy_speed_n_animations_speed_desc",
													object = UIBox({
														definition = {
															n = G.UIT.ROOT,
															config = { colour = G.C.CLEAR },
															nodes = {
																Handy.UI.CD.speed_multiplier.checkbox({
																	only_description = true,
																}),
															},
														},
														config = {},
													}),
												},
											},
										},
									},
								},
							},
						},
					},
					{
						n = G.UIT.C,
						config = { padding = 0.1, minw = 7 },
						nodes = {
							{
								n = G.UIT.R,
								config = {},
								nodes = {
									{
										n = G.UIT.C,
										config = { minw = 1.1, align = "cm" },
										nodes = {
											Handy.UI.CD.animation_skip_no_hold.checkbox({
												only_toggle = true,
											}),
										},
									},
									{
										n = G.UIT.C,
										config = { minw = 0.075 },
									},
									{
										n = G.UIT.C,
										nodes = {
											{
												n = G.UIT.O,
												config = {
													id = "handy_speed_n_animations_animations_desc",
													object = UIBox({
														definition = {
															n = G.UIT.ROOT,
															config = { colour = G.C.CLEAR },
															nodes = {
																Handy.UI.CD.animation_skip.checkbox({
																	only_description = true,
																}),
															},
														},
														config = {},
													}),
												},
											},
										},
									},
								},
							},
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { minh = 0.25 },
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = {
							minw = 5,

							align = "cm",
						},
						nodes = {
							{
								n = G.UIT.R,
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = "Hold button",
											colour = G.C.WHITE,
											scale = 0.4,
										},
									},
								},
							},
						},
					},
					{
						n = G.UIT.C,
						config = { padding = 0.1, align = "cm", minw = 7 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									Handy.UI.CD.speed_multiplier.keybind({
										no_label = true,
										compress = true,
										rerender = true,
									}),
								},
							},
						},
					},
					{
						n = G.UIT.C,
						config = { padding = 0.1, align = "cm", minw = 7 },
						nodes = {

							{
								n = G.UIT.R,
								nodes = {
									Handy.UI.CD.animation_skip.keybind({
										no_label = true,
										compress = true,
										rerender = true,
									}),
								},
							},
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = {
							minw = 5,

							align = "cm",
						},
						nodes = {
							{
								n = G.UIT.R,
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = "Increase button",
											colour = G.C.WHITE,
											scale = 0.4,
										},
									},
								},
							},
						},
					},
					{
						n = G.UIT.C,
						config = { padding = 0.1, align = "cm", minw = 7 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									Handy.UI.CD.speed_multiplier_multiply.keybind({
										no_label = true,
										compress = true,
										rerender = true,
									}),
								},
							},
						},
					},
					{
						n = G.UIT.C,
						config = { padding = 0.1, align = "cm", minw = 7 },
						nodes = {

							{
								n = G.UIT.R,
								nodes = {
									Handy.UI.CD.animation_skip_increase.keybind({
										no_label = true,
										compress = true,
										rerender = true,
									}),
								},
							},
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = {
							minw = 5,

							align = "cm",
						},
						nodes = {
							{
								n = G.UIT.R,
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = "Decrease button",
											colour = G.C.WHITE,
											scale = 0.4,
										},
									},
								},
							},
						},
					},
					{
						n = G.UIT.C,
						config = { padding = 0.1, align = "cm", minw = 7 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									Handy.UI.CD.speed_multiplier_divide.keybind({
										no_label = true,
										compress = true,
										rerender = true,
									}),
								},
							},
						},
					},
					{
						n = G.UIT.C,
						config = { padding = 0.1, align = "cm", minw = 7 },
						nodes = {

							{
								n = G.UIT.R,
								nodes = {
									Handy.UI.CD.animation_skip_decrease.keybind({
										no_label = true,
										compress = true,
										rerender = true,
									}),
								},
							},
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { minh = 0.25 },
			},
			example_calc_row,
		},
	}
	return create_UIBox_generic_options({
		back_func = "handy_speed_n_animations_back",
		contents = {
			content,
		},
	})
end

function G.FUNCS.handy_speed_n_animations_stop_calculation(e, without_cleanup)
	G.E_MANAGER:clear_queue("handy_config")
	Handy.__override_event_queue = "handy_config"
	Handy.__use_gamespeed = true
	for i = 1, #G.handy_config_storage.hand.cards + 1 do
		handy_draw_from_to(G.handy_config_storage.hand, G.handy_config_storage.deck)
	end
	if not without_cleanup then
		G.E_MANAGER:add_event(Event({
			func = function()
				Handy.__override_event_queue = nil
				Handy.__use_gamespeed = nil
				return true
			end,
		}))
	end
end
function G.FUNCS.handy_speed_n_animations_calculate(e)
	G.FUNCS.handy_speed_n_animations_stop_calculation(e, true)
	Handy.__use_gamespeed = true
	delay(0.2)
	G.E_MANAGER:add_event(Event({
		func = function()
			calculate(G.handy_config_storage.deck, G.handy_config_storage.hand, G.handy_config_storage.jokers)
			return true
		end,
	}))
end
function G.FUNCS.handy_speed_n_animations_back()
	G.E_MANAGER:clear_queue("handy_config")
	Handy.__override_event_queue = nil
	Handy.__use_gamespeed = nil
	G.FUNCS.handy_open_options()
end

function G.FUNCS.handy_speed_n_animations_modal()
	G.SETTINGS.paused = true
	Handy.UI.modal_opened = "speed_n_animations"
	G.FUNCS.overlay_menu({
		definition = G.UIDEF.handy_speed_n_animations_modal(),
	})
end
