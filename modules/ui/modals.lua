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
	args = args or {}
	if not args.no_skip and Handy.animation_skip.should_skip_animation() then
		return
	end
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

	local timer = args.timer or "TOTAL"

	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0,
		blockable = false,
		blocking = false,
		timer = timer,
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
					timer_type = timer,
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
					timer_type = timer,
					timer = 5,
					scale = 2.4 * (args.backdrop_scale or 1),
					lifespan = 5,
					speed = 0,
					attach = args.AT,
					colours = { args.backdrop_colour },
				})
				a.created_on_pause = true
			end

			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = args.hold,
				blockable = false,
				blocking = false,
				no_delete = true,
				timer = timer,
				func = function()
					if not args.start_time then
						args.start_time = G.TIMERS[timer]
						args.text:pop_out(3)
					else
						--args.AT:align_to_attach()
						args.fade = math.max(0, 1 - 3 * (G.TIMERS[timer] - args.start_time))
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
			return true
		end,
	}))
end
local function handy_card_eval_status_text(card, eval_type, amt, percent, dir, extra)
	extra = extra or {}
	if not extra.no_skip then
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
		sound = extra.sound
			or extra.edition and "foil2"
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

	local _result = function()
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
			timer = extra.timer,
			no_skip = extra.no_skip,
		})
		play_sound(sound, 0.8 + percent * 0.2, volume)
		if not extra or not extra.no_juice then
			card:juice_up(0.6, 0.1)
			G.ROOM.jiggle = G.ROOM.jiggle + 0.7
		end
	end

	if amt > 0 or amt < 0 then
		if extra and extra.instant then
			_result()
		else
			G.E_MANAGER:add_event(Event({ --Add bonus chips from this card
				trigger = "before",
				delay = delay,
				func = function()
					_result()
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

local function rerender_objects(list)
	for id, selector in pairs(list) do
		local container = G.OVERLAY_MENU:get_UIE_by_ID(id)
		container.config.object:remove()
		container.config.object = UIBox({
			definition = {
				n = G.UIT.ROOT,
				config = { colour = G.C.CLEAR },
				nodes = {
					selector(),
				},
			},
			config = {
				parent = container,
			},
		})
		container.UIBox:recalculate()
	end
end
local function rerender_container(list, id)
	return {
		n = G.UIT.O,
		config = {
			id = id,
			object = UIBox({
				definition = {
					n = G.UIT.ROOT,
					config = { colour = G.C.CLEAR },
					nodes = {
						list[id](),
					},
				},
				config = {},
			}),
		},
	}
end
local function handy_fake_config_tab(content)
	return {
		n = G.UIT.R,
		config = { align = "cm", padding = 0 },
		nodes = {
			{
				n = G.UIT.R,
				config = { padding = 0.0, align = "cm", colour = G.C.CLEAR },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							padding = 0.1,
							no_fill = true,
						},
						nodes = {
							{
								n = G.UIT.O,
								config = {
									id = "tab_contents",
									object = UIBox({
										definition = content,
										config = { offset = { x = 0, y = 0 } },
									}),
								},
							},
						},
					},
				},
			},
		},
	}
end

--

local function handy_hand_card_area(options)
	local area = CardArea(
		G.ROOM.T.x + G.ROOM.T.w / 2,
		G.ROOM.T.h,
		options.w,
		options.h,
		{ card_limit = options.card_limit or 5, type = "hand", highlight_limit = options.highlight_limit or 1 }
	)
	area.draw = function(self)
		if not self.states.visible then
			return
		end

		self:draw_boundingrect()
		add_to_drawhash(self)

		self.ARGS.draw_layers = self.ARGS.draw_layers or self.config.draw_layers or { "shadow", "card" }
		for k, v in ipairs(self.ARGS.draw_layers) do
			for i = 1, #self.cards do
				if self.cards[i] ~= G.CONTROLLER.focused.target then
					if G.CONTROLLER.dragging.target ~= self.cards[i] then
						self.cards[i]:draw(v)
					end
				end
			end
		end
	end
	area.align_cards = function(self)
		for k, card in ipairs(self.cards) do
			if not card.states.drag.is then
				card.T.r = 0.2 * (-#self.cards / 2 - 0.5 + k) / #self.cards
					+ (G.SETTINGS.reduced_motion and 0 or 1) * 0.02 * math.sin(2 * G.TIMERS.REAL + card.T.x)
				local max_cards = math.max(#self.cards, self.config.temp_limit)
				card.T.x = self.T.x
					+ (self.T.w - self.card_w) * ((k - 1) / math.max(max_cards - 1, 1) - 0.5 * (#self.cards - max_cards) / math.max(
						max_cards - 1,
						1
					))
					+ 0.5 * (self.card_w - card.T.w)

				local highlight_height = G.HIGHLIGHT_H
				if not card.highlighted then
					highlight_height = 0
				end
				card.T.y = self.T.y
					+ self.T.h / 2
					- card.T.h / 2
					- highlight_height
					+ (G.SETTINGS.reduced_motion and 0 or 1) * 0.03 * math.sin(0.666 * G.TIMERS.REAL + card.T.x)
					+ math.abs(0.5 * (-#self.cards / 2 + k - 0.5) / #self.cards)
					- 0.2
				card.T.x = card.T.x + card.shadow_parrallax.x / 30
			end
		end
		table.sort(self.cards, function(a, b)
			return a.T.x + a.T.w / 2 < b.T.x + b.T.w / 2
		end)
		for k, card in ipairs(self.cards) do
			card.rank = k
		end
	end

	if options.on_create then
		G.E_MANAGER:add_event(
			Event({
				timer = "REAL",
				blocking = false,
				blockable = false,
				func = function()
					if area.REMOVED then
						return true
					end
					options.on_create(area)
					return true
				end,
			}),
			"handy_config"
		)
	end

	return area
end

--

local row = function(opt)
	return {
		n = G.UIT.R,
		config = { align = "cm", padding = 0.025 },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					minw = 4,
					maxw = 4,
					align = "cm",
				},
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = opt.label,
					},
				},
			},
			Handy.UI.PARTS.create_separator_c(),
			{
				n = G.UIT.C,
				config = { maxw = 6.5, minw = 6.5, align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = opt.speed,
					},
				},
			},
			Handy.UI.PARTS.create_separator_c(),
			{
				n = G.UIT.C,
				config = { maxw = 6.5, minw = 6.5, align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = opt.animations,
					},
				},
			},
		},
	}
end

--

function G.UIDEF.handy_speed_n_animations_info()
	Handy.UI.modal_opened = "speed_n_animations_info"

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
	G.handy_config_storage.rerender = nil

	G.E_MANAGER:add_event(
		Event({
			timer = "REAL",
			func = function()
				if jokers_area.REMOVED then
					return true
				end
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
						deck_area.T.x + deck_area.T.w / 2 - G.CARD_W / 2,
						deck_area.T.y,
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
						},
					},
				},
			},
			{
				n = G.UIT.C,
				config = { align = "cm", maxw = 2.1 },
				nodes = {
					UIBox_button({
						label = Handy.L.dictionary("handy_modals_start_calculation"),
						scale = 0.5,
						colour = G.C.CHIPS,
						button = "handy_speed_n_animations_calculate",
					}),
					{ n = G.UIT.R, config = { minh = 0.25 } },
					UIBox_button({
						label = Handy.L.dictionary("handy_modals_stop_calculation"),
						scale = 0.5,
						colour = G.C.MULT,
						button = "handy_speed_n_animations_stop_calculation",
					}),
				},
			},
		},
	}

	local left_column = {
		{
			n = G.UIT.R,
			config = { align = "cm", padding = 0.1 },
			nodes = {
				{
					n = G.UIT.C,
					config = { minw = 1 },
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
										text = Handy.L.dictionary("handy_modals_speed_title"),
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
										text = Handy.L.dictionary("handy_modals_speed_description"),
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
		Handy.UI.PARTS.create_separator_r(),
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				Handy.UI.CD.speed_multiplier.option_cycle({
					no_label = true,
				}),
			},
		},
		Handy.UI.PARTS.create_separator_r(),
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = Handy.L.multiline_description("Handy_Other", "modal_speed", nil, {
						padding = 0.025,
						align = "cm",
					}),
				},
			},
		},
	}

	local right_column = {
		{
			n = G.UIT.R,
			config = { align = "cm", padding = 0.1 },
			nodes = {
				{
					n = G.UIT.C,
					config = { minw = 1 },
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
										text = Handy.L.dictionary("handy_modals_animations_title"),
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
										text = Handy.L.dictionary("handy_modals_animations_description"),
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
		Handy.UI.PARTS.create_separator_r(),
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				Handy.UI.CD.animation_skip.option_cycle({
					no_label = true,
				}),
			},
		},
		Handy.UI.PARTS.create_separator_r(),
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = Handy.L.multiline_description("Handy_Other", "modal_animation_skip", nil, {
						padding = 0.025,
						align = "cm",
					}),
				},
			},
		},
		{
			n = G.UIT.R,
			nodes = {
				{
					n = G.UIT.C,
					nodes = Handy.L.multiline_description("Handy_Other", "modal_animation_skip_levels", nil, {
						padding = 0.025,
					}),
				},
			},
		},
	}

	local content = {
		n = G.UIT.R,
		config = { align = "m" },
		nodes = {
			{
				n = G.UIT.C,
				config = { minw = 7, align = "m" },
				nodes = left_column,
			},
			{
				n = G.UIT.C,
				config = { minw = 7, align = "m" },
				nodes = right_column,
			},
		},
	}

	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			{
				n = G.UIT.C,
				nodes = {
					content,
					Handy.UI.PARTS.create_separator_r(),
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
			},
		},
	}
end
function G.UIDEF.handy_speed_n_animations_controls()
	Handy.UI.modal_opened = "speed_n_animations_controls"

	G.E_MANAGER:clear_queue("handy_config")
	Handy.__override_event_queue = nil
	Handy.__use_gamespeed = nil
	G.handy_config_storage.jokers = nil
	G.handy_config_storage.hand = nil
	G.handy_config_storage.deck = nil

	local rerender_list = {
		handy_speed_n_animations_speed_desc = function()
			return Handy.UI.CD.speed_multiplier.checkbox({
				only_description = true,
			})
		end,
		handy_speed_n_animations_animations_desc = function()
			return Handy.UI.CD.animation_skip.checkbox({
				only_description = true,
			})
		end,
	}

	G.handy_config_storage.rerender = function()
		rerender_objects(rerender_list)
	end

	local name_row = row({
		label = {},
		speed = {
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = Handy.L.dictionary("handy_modals_speed_title"),
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
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = Handy.L.dictionary("handy_modals_speed_description"),
							colour = adjust_alpha(G.C.WHITE, 0.75),
							scale = 0.35,
						},
					},
				},
			},
		},
		animations = {
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = Handy.L.dictionary("handy_modals_animations_title"),
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
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = Handy.L.dictionary("handy_modals_animations_description"),
							colour = adjust_alpha(G.C.WHITE, 0.75),
							scale = 0.35,
						},
					},
				},
			},
		},
	})

	local default_value_row = row({
		label = {
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = Handy.L.dictionary("handy_modals_default_value_title"),
							colour = G.C.WHITE,
							scale = 0.35,
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { minh = 0.025 },
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = Handy.L.dictionary("handy_modals_default_value_description"),
							colour = { 1, 1, 1, 0.6 },
							scale = 0.3,
						},
					},
				},
			},
		},
		speed = {
			Handy.UI.CD.speed_multiplier_default_value.option_cycle({
				no_label = true,
			}),
		},
		animations = {
			Handy.UI.CD.animation_skip_default_value.option_cycle({
				no_label = true,
			}),
		},
	})

	local no_hold_row = row({
		label = {
			{
				n = G.UIT.T,
				config = {
					text = Handy.L.dictionary("handy_modals_no_hold_n_usage_title"),
					colour = G.C.WHITE,
					scale = 0.35,
				},
			},
		},
		speed = {
			{
				n = G.UIT.C,
				config = { minw = 1.1, align = "cm" },
				nodes = {
					Handy.UI.CD.speed_multiplier_no_hold.checkbox({
						only_toggle = true,
						rerender = true,
					}),
				},
			},
			{
				n = G.UIT.C,
				config = { minw = 0.075 },
			},
			{
				n = G.UIT.C,
				config = { align = "cm", minh = 1.1 },
				nodes = {
					rerender_container(rerender_list, "handy_speed_n_animations_speed_desc"),
				},
			},
		},
		animations = {
			{
				n = G.UIT.C,
				config = { minw = 1.1, align = "cm" },
				nodes = {
					Handy.UI.CD.animation_skip_no_hold.checkbox({
						only_toggle = true,
						rerender = true,
					}),
				},
			},
			{
				n = G.UIT.C,
				config = { minw = 0.075 },
			},
			{
				n = G.UIT.C,
				config = { align = "cm", minh = 1.1 },
				nodes = {
					rerender_container(rerender_list, "handy_speed_n_animations_animations_desc"),
				},
			},
		},
	})

	local hold_keybind_row = row({
		label = {
			{
				n = G.UIT.T,
				config = {
					text = Handy.L.dictionary("handy_modals_hold_button"),
					colour = G.C.WHITE,
					scale = 0.3,
				},
			},
		},
		speed = {
			Handy.UI.CD.speed_multiplier.keybind({
				no_label = true,
				compress = true,
				rerender = true,
			}),
		},
		animations = {
			Handy.UI.CD.animation_skip.keybind({
				no_label = true,
				compress = true,
				rerender = true,
			}),
		},
	})
	local increase_keybind_row = row({
		label = {
			{
				n = G.UIT.T,
				config = {
					text = Handy.L.dictionary("handy_modals_increase_button"),
					colour = G.C.WHITE,
					scale = 0.3,
				},
			},
		},
		speed = {
			Handy.UI.CD.speed_multiplier_multiply.keybind({
				no_label = true,
				compress = true,
				rerender = true,
			}),
		},
		animations = {
			Handy.UI.CD.animation_skip_increase.keybind({
				no_label = true,
				compress = true,
				rerender = true,
			}),
		},
	})
	local decrease_keybind_row = row({
		label = {
			{
				n = G.UIT.T,
				config = {
					text = Handy.L.dictionary("handy_modals_decrease_button"),
					colour = G.C.WHITE,
					scale = 0.3,
				},
			},
		},
		speed = {
			Handy.UI.CD.speed_multiplier_divide.keybind({
				no_label = true,
				compress = true,
				rerender = true,
			}),
		},
		animations = {
			Handy.UI.CD.animation_skip_decrease.keybind({
				no_label = true,
				compress = true,
				rerender = true,
			}),
		},
	})

	local dangerous_row = row({
		label = {
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = Handy.L.dictionary("handy_modals_dangerous_options_title"),
							colour = G.C.WHITE,
							scale = 0.35,
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { minh = 0.025 },
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = Handy.L.dictionary("handy_modals_dangerous_options_description"),
							colour = adjust_alpha(G.C.MULT, 0.75),
							scale = 0.3,
						},
					},
				},
			},
		},
		speed = {
			{
				n = G.UIT.C,
				config = { minw = 1.1, align = "cm" },
				nodes = {
					Handy.UI.CD.dangerous_speed_multiplier_uncap.checkbox({
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
				config = { align = "cm", minh = 1.1 },
				nodes = {
					Handy.UI.CD.dangerous_speed_multiplier_uncap.checkbox({
						only_description = true,
					}),
				},
			},
		},
		animations = {
			{
				n = G.UIT.C,
				config = { minw = 1.1, align = "cm" },
				nodes = {
					Handy.UI.CD.dangerous_animation_skip_unsafe.checkbox({
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
				config = { align = "cm", minh = 1.1 },
				nodes = {
					Handy.UI.CD.dangerous_animation_skip_unsafe.checkbox({
						only_description = true,
					}),
				},
			},
		},
	})

	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			{
				n = G.UIT.C,
				nodes = {
					name_row,
					Handy.UI.PARTS.create_separator_r(),
					default_value_row,
					no_hold_row,
					Handy.UI.PARTS.create_separator_r(0.3),
					{
						n = G.UIT.R,
						config = { padding = 0.25, r = 0.5, colour = { 0, 0, 0, 0.1 } },
						nodes = {
							{
								n = G.UIT.C,
								nodes = {
									hold_keybind_row,
									increase_keybind_row,
									decrease_keybind_row,
								},
							},
						},
					},
					Handy.UI.PARTS.create_separator_r(0.2),
					{
						n = G.UIT.R,
						config = { padding = 0.25, r = 0.5, colour = adjust_alpha(G.C.MULT, 0.15) },
						nodes = {
							dangerous_row,
						},
					},
				},
			},
		},
	}
end

function G.FUNCS.handy_speed_n_animations_modal()
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = create_UIBox_generic_options({
			back_func = "handy_back_to_config",
			contents = {
				{
					n = G.UIT.R,
					config = { align = "cm", padding = 0 },
					nodes = {
						create_tabs({
							snap_to_nav = true,
							colour = G.C.BOOSTER,
							no_shoulders = true,
							tabs = {
								{
									label = "Info",
									tab_definition_function = G.UIDEF.handy_speed_n_animations_info,
									chosen = true,
								},
								{
									label = "Controls",
									tab_definition_function = G.UIDEF.handy_speed_n_animations_controls,
								},
							},
						}),
					},
				},
			},
		}),
	})
end

--

function G.UIDEF.handy_move_highlight_info()
	local CAI = {
		hand_W = 4 * G.CARD_W,
		hand_H = 0.95 * G.CARD_H,
	}

	local hand_area = handy_hand_card_area({
		w = CAI.hand_W,
		h = CAI.hand_H,
		card_limit = 4,
		highlight_limit = 1,
		on_create = function(area)
			for index, center in ipairs({
				"j_greedy_joker",
				"j_lusty_joker",
				"j_wrathful_joker",
				"j_gluttenous_joker",
			}) do
				local card1 = Card(
					area.T.x + area.T.w / 2 - G.CARD_W / 2,
					area.T.y,
					G.CARD_W,
					G.CARD_H,
					nil,
					G.P_CENTERS[center],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				area:emplace(card1)
				if index == 1 then
					area:add_to_highlighted(card1, true)
					Handy.last_clicked_card = card1
					Handy.last_clicked_area = card1.area
				end
			end
		end,
	})
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
	G.handy_config_storage.move_highlight_hand = hand_area

	local rerender_list = {
		handy_move_highlight_desc = function()
			return Handy.UI.CD.move_highlight.checkbox({
				no_tooltip = true,
			})
		end,
	}
	G.handy_config_storage.rerender = function()
		rerender_objects(rerender_list)
	end

	local content = {
		n = G.UIT.R,
		config = { align = "m" },
		nodes = {
			{
				n = G.UIT.R,
				config = { minw = 7, align = "m" },
				nodes = {
					rerender_container(rerender_list, "handy_move_highlight_desc"),
				},
			},
			Handy.UI.PARTS.create_separator_r(),
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm" },
						nodes = Handy.L.multiline_description("Handy_Other", "modal_move_highlight", nil, {
							padding = 0.025,
							align = "cm",
						}),
					},
				},
			},
			Handy.UI.PARTS.create_separator_r(),
			{
				n = G.UIT.R,
				config = { padding = 0.25, r = 0.5, colour = { 0, 0, 0, 0.1 } },
				nodes = {
					{
						n = G.UIT.C,
						config = { padding = 0.05 },
						nodes = {
							Handy.UI.CD.move_highlight_one_left.keybind({
								rerender = true,
							}),
							Handy.UI.CD.move_highlight_one_right.keybind({
								rerender = true,
							}),
							Handy.UI.CD.move_highlight_move_card.keybind({
								rerender = true,
							}),
							Handy.UI.CD.move_highlight_to_end.keybind({
								rerender = true,
							}),
						},
					},
				},
			},
		},
	}

	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			{
				n = G.UIT.C,
				nodes = {
					content,
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
											text = Handy.L.dictionary(
												"handy_modals_move_highlight_preview_description"
											),
											colour = { 1, 1, 1, 0.6 },
											scale = 0.3,
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

function G.FUNCS.handy_move_highlight_modal()
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = create_UIBox_generic_options({
			back_func = "handy_back_to_config",
			contents = {
				handy_fake_config_tab(G.UIDEF.handy_move_highlight_info()),
			},
		}),
	})
end

--

function G.UIDEF.handy_insta_actions_info()
	local CAI = {
		hand_W = 2.5 * G.CARD_W,
		hand_H = 0.95 * G.CARD_H,
		shop_W = 2.5 * G.CARD_W,
		shop_H = 0.95 * G.CARD_H,
	}

	local create_cards = function(is_shop)
		return function(area)
			for _, center in ipairs({ "j_joker", "c_earth" }) do
				local card1 = Card(
					area.T.x + area.T.w / 2 - G.CARD_W / 2,
					area.T.y,
					G.CARD_W,
					G.CARD_H,
					nil,
					G.P_CENTERS[center],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card1.handy_config_insta_actions_preview = "hand"
				card1.handy_config_insta_actions_preview_sell_msg = "Sell"
				card1.handy_config_insta_actions_preview_use_msg = "Use"

				function card1:handy_preview_buy_or_sell()
					handy_card_eval_status_text(self, "extra", nil, nil, nil, {
						message = card1.handy_config_insta_actions_preview_sell_msg,
						no_skip = true,
						colour = G.C.MULT,
						instant = true,
						sound = "coin1",
						timer = "REAL",
					})
				end
				function card1:handy_preview_use()
					if self.config.center.key ~= "c_earth" then
						return
					end
					handy_card_eval_status_text(self, "extra", nil, nil, nil, {
						message = card1.handy_config_insta_actions_preview_use_msg,
						no_skip = true,
						colour = G.C.SECONDARY_SET.Tarot,
						instant = true,
						sound = "tarot1",
						timer = "REAL",
					})
				end
				function card1:handy_preview_buy_n_sell() end

				if is_shop then
					card1.handy_config_insta_actions_preview = "shop"
					card1.handy_config_insta_actions_preview_sell_msg = "Buy"
					card1.handy_config_insta_actions_preview_use_msg = "Buy & Use"
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
							bond = "Weak",
							parent = card1,
						},
					})
					function card1:handy_preview_buy_n_sell()
						handy_card_eval_status_text(self, "extra", nil, nil, nil, {
							message = "Buy & Sell",
							no_skip = true,
							colour = G.C.CHIPS,
							instant = true,
							sound = "coin1",
							timer = "REAL",
						})
					end
				end
				area:emplace(card1)
			end
		end
	end

	local hand_area = handy_hand_card_area({
		w = CAI.hand_W,
		h = CAI.hand_H,
		card_limit = 3,
		highlight_limit = 0,
		on_create = create_cards(false),
	})
	local shop_area = handy_hand_card_area({
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

	local rerender_list = {
		handy_insta_actions_buy_or_sell = function()
			return Handy.UI.CD.insta_buy_or_sell.checkbox({
				desc_width = 3.5,
			})
		end,
		handy_insta_actions_use = function()
			return Handy.UI.CD.insta_use.checkbox({
				desc_width = 3.5,
			})
		end,
		handy_insta_actions_buy_n_sell = function()
			return Handy.UI.CD.insta_buy_n_sell.checkbox({
				desc_width = 3.5,
			})
		end,
		handy_insta_actions_cryptid_previous_input = function()
			return Handy.UI.CD.cryptid_code_use_last_interaction.checkbox({
				desc_width = 3.5,
			})
		end,
	}
	G.handy_config_storage.rerender = function()
		rerender_objects(rerender_list)
	end

	local content = {
		n = G.UIT.R,
		nodes = {
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					Handy.UI.CD.buy_sell_use_mode.option_cycle(),
				},
			},
			Handy.UI.PARTS.create_separator_r(),
			{
				n = G.UIT.R,
				nodes = {
					{
						n = G.UIT.C,
						nodes = {
							{
								n = G.UIT.C,
								config = { padding = 0.1 },
								nodes = {
									{
										n = G.UIT.R,
										nodes = {
											rerender_container(rerender_list, "handy_insta_actions_buy_or_sell"),
										},
									},
									{
										n = G.UIT.R,
										nodes = {
											rerender_container(rerender_list, "handy_insta_actions_buy_n_sell"),
										},
									},
								},
							},
							{
								n = G.UIT.C,
								config = { padding = 0.1 },
								nodes = {
									{
										n = G.UIT.R,
										nodes = {
											rerender_container(rerender_list, "handy_insta_actions_use"),
										},
									},
									{
										n = G.UIT.R,
										nodes = {
											rerender_container(
												rerender_list,
												"handy_insta_actions_cryptid_previous_input"
											),
										},
									},
								},
							},
						},
					},
				},
			},
			Handy.UI.PARTS.create_separator_r(),
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = { padding = 0.25, r = 0.5, colour = { 0, 0, 0, 0.1 }, align = "cm" },
						nodes = {
							{
								n = G.UIT.C,
								config = { padding = 0.05, align = "cm" },
								nodes = {
									Handy.UI.CD.insta_buy_or_sell.keybind({
										rerender = true,
									}),
									Handy.UI.CD.insta_buy_n_sell.keybind({
										rerender = true,
									}),
									Handy.UI.CD.insta_use.keybind({
										rerender = true,
									}),
									Handy.UI.CD.cryptid_code_use_last_interaction.keybind({
										rerender = true,
									}),
								},
							},
						},
					},
				},
			},
		},
	}

	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			{
				n = G.UIT.C,
				nodes = {
					content,
					Handy.UI.PARTS.create_separator_r(0.4),
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
											text = Handy.L.dictionary(
												"handy_modals_move_highlight_preview_description"
											),
											colour = { 1, 1, 1, 0.6 },
											scale = 0.3,
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

function G.FUNCS.handy_insta_actions_modal()
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = create_UIBox_generic_options({
			back_func = "handy_back_to_config",
			contents = {
				handy_fake_config_tab(G.UIDEF.handy_insta_actions_info()),
			},
		}),
	})
end

--

function G.UIDEF.handy_insta_highlight_info()
	local CAI = {
		hand_W = 3.5 * G.CARD_W,
		hand_H = 0.95 * G.CARD_H,
	}

	local hand_area = handy_hand_card_area({
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
				local card1 = Card(
					area.T.x + area.T.w / 2 - G.CARD_W / 2,
					area.T.y,
					G.CARD_W,
					G.CARD_H,
					G.P_CARDS[front],
					G.P_CENTERS.c_base,
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card1.handy_can_insta_highlight = true
				area:emplace(card1)
			end
		end,
	})
	G.handy_config_storage.insta_highlight_area = hand_area
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

	local rerender_list = {
		handy_insta_highlight = function()
			return Handy.UI.CD.insta_highlight.checkbox({
				desc_width = 4,
			})
		end,
		handy_insta_unhighligt = function()
			return Handy.UI.CD.insta_unhighlight.checkbox({
				desc_width = 4,
			})
		end,
		handy_deselect_hand = function()
			return Handy.UI.CD.deselect_hand.checkbox({
				desc_width = 4,
			})
		end,
		handy_entire_f_hand = function()
			return Handy.UI.CD.insta_highlight_entire_f_hand.checkbox({
				desc_width = 4,
			})
		end,
	}
	G.handy_config_storage.rerender = function()
		rerender_objects(rerender_list)
	end

	local content = {
		n = G.UIT.R,
		nodes = {
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						nodes = Handy.L.multiline_description("Handy_Other", "modal_insta_highlight", {
							Handy.L.keybind("Left Mouse", true),
							Handy.L.keybind("Right Mouse", true),
						}, {
							padding = 0.025,
							align = "cm",
						}),
					},
				},
			},
			Handy.UI.PARTS.create_separator_r(),
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.C,
								config = { padding = 0.1, align = "cm" },
								nodes = {
									{
										n = G.UIT.R,
										config = { align = "cm" },
										nodes = {
											rerender_container(rerender_list, "handy_insta_highlight"),
										},
									},
									{
										n = G.UIT.R,
										config = { align = "cm" },
										nodes = {
											rerender_container(rerender_list, "handy_insta_unhighligt"),
										},
									},
								},
							},
							{
								n = G.UIT.C,
								config = { padding = 0.1 },
								nodes = {
									{
										n = G.UIT.R,
										config = { align = "cm" },
										nodes = {
											rerender_container(rerender_list, "handy_deselect_hand"),
										},
									},
									{
										n = G.UIT.R,
										config = { align = "cm" },
										nodes = {
											rerender_container(rerender_list, "handy_entire_f_hand"),
										},
									},
								},
							},
						},
					},
				},
			},
			Handy.UI.PARTS.create_separator_r(),
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = { padding = 0.25, r = 0.5, colour = { 0, 0, 0, 0.1 }, align = "cm" },
						nodes = {
							{
								n = G.UIT.C,
								config = { padding = 0.05, align = "cm" },
								nodes = {
									Handy.UI.CD.insta_highlight.keybind({
										rerender = true,
									}),
									Handy.UI.CD.insta_highlight_entire_f_hand.keybind({
										rerender = true,
									}),
									Handy.UI.CD.deselect_hand.keybind({
										rerender = true,
									}),
								},
							},
						},
					},
				},
			},
		},
	}

	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			{
				n = G.UIT.C,
				nodes = {
					content,
					Handy.UI.PARTS.create_separator_r(0.4),
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
											text = Handy.L.dictionary(
												"handy_modals_move_highlight_preview_description"
											),
											colour = { 1, 1, 1, 0.6 },
											scale = 0.3,
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

function G.FUNCS.handy_insta_highlight_modal()
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = create_UIBox_generic_options({
			back_func = "handy_back_to_config",
			contents = {
				handy_fake_config_tab(G.UIDEF.handy_insta_highlight_info()),
			},
		}),
	})
end

--

function G.UIDEF.handy_appearance_info()
	local content = {
		n = G.UIT.R,
		nodes = {
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					Handy.UI.CD.info_popups_level.option_cycle(),
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm" },
						nodes = Handy.L.multiline_description("Handy_Other", "modal_appearance_description", {}, {
							padding = 0.025,
						}),
					},
				},
			},
			Handy.UI.PARTS.create_separator_r(0.4),
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					Handy.UI.CD.hide_options_button.checkbox(),
				},
			},
			Handy.UI.PARTS.create_separator_r(),
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					Handy.UI.CD.speed_multiplier_settings_toggle.checkbox(),
				},
			},
			Handy.UI.PARTS.create_separator_r(),
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					Handy.UI.CD.animation_skip_settings_toggle.checkbox(),
				},
			},
		},
	}

	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			{
				n = G.UIT.C,
				nodes = {
					content,
				},
			},
		},
	}
end

function G.FUNCS.handy_appearance_modal()
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = create_UIBox_generic_options({
			back_func = "handy_back_to_config",
			contents = {
				handy_fake_config_tab(G.UIDEF.handy_appearance_info()),
			},
		}),
	})
end

--

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
function G.FUNCS.handy_back_to_config()
	G.E_MANAGER:clear_queue("handy_config")
	Handy.__override_event_queue = nil
	Handy.__use_gamespeed = nil
	G.handy_config_storage = {}
	G.FUNCS.handy_open_options()
end
