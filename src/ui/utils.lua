Handy.UI.utils = {}

function Handy.UI.utils.calc_card_pos(self, w, h, k, max_index)
	local card = {
		T = {
			x = 0,
			y = 0,
			w = w,
			h = h,
		},
	}
	card.T.r = 0.2 * (-max_index / 2 - 0.5 + k) / max_index
		+ (G.SETTINGS.reduced_motion and 0 or 1) * 0.02 * math.sin(2 * G.TIMERS.REAL + card.T.x)
	local max_cards = math.max(max_index, self.config.temp_limit)
	card.T.x = self.VT.x
		+ (self.VT.w - self.card_w) * ((k - 1) / math.max(max_cards - 1, 1) - 0.5 * (max_index - max_cards) / math.max(
			max_cards - 1,
			1
		))
		+ 0.5 * (self.card_w - card.T.w)

	local highlight_height = G.HIGHLIGHT_H
	if not card.highlighted then
		highlight_height = 0
	end
	card.T.y = self.VT.y
		+ self.VT.h / 2
		- card.T.h / 2
		- highlight_height
		+ (G.SETTINGS.reduced_motion and 0 or 1) * 0.03 * math.sin(0.666 * G.TIMERS.REAL + card.T.x)
		+ math.abs(0.5 * (-max_index / 2 + k - 0.5) / max_index)
		- 0.2
	return card.T
end

function Handy.UI.utils.card_area(options)
	local area = CardArea(G.ROOM.T.x + G.ROOM.T.w / 2, G.ROOM.T.h, options.w, options.h, {
		card_limit = options.card_limit or 5,
		type = options.type or "hand",
		highlight_limit = options.highlight_limit or 1,
	})
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

function Handy.UI.utils.attention_text(args)
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

	local timer = args.timer or "HANDY_TOTAL"

	if args.major and args.major.is and args.major:is(Card) then
		local old_remove = args.major.remove
		function args.major:remove(...)
			local r = old_remove(self, ...)
			if args.AT then
				args.AT:remove()
			end
			if args.text then
				args.text:remove()
			end
			return r
		end
	end

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

function Handy.UI.utils.card_eval_status_text(card, eval_type, amt, percent, dir, extra)
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
						timer = "HANDY_TOTAL",
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
		Handy.UI.utils.attention_text({
			text = text,
			scale = config.scale or 1,
			hold = delay - 0.2,
			backdrop_colour = colour,
			align = card_aligned,
			major = card,
			offset = { x = 0, y = y_off },
			timer = extra.timer or "HANDY_TOTAL",
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
				timer = "HANDY_TOTAL",
				func = function()
					_result()
					return true
				end,
			}))
		end
	end
end

function Handy.UI.utils.juice_card(card)
	if Handy.animation_skip.should_skip_animation() then
		return
	end
	G.E_MANAGER:add_event(
		Event({
			trigger = "immediate",
			timer = "HANDY_TOTAL",
			func = function()
				card:juice_up(0.7)
				return true
			end,
		}),
		"handy_config"
	)
end

function Handy.UI.utils.draw_from_to(from, to)
	G.E_MANAGER:add_event(
		Event({
			trigger = "after",
			delay = 0.08,
			blocking = not Handy.animation_skip.should_skip_everything(),
			timer = "HANDY_TOTAL",
			func = function()
				if to and from then
					local card = from:remove_card()
					if card then
						to:emplace(card)
						play_sound("card1", 0.85 + 50 * 0.2 / 100, 0.6 * 1)
					end
				end
				return true
			end,
		}),
		"handy_config"
	)
end

function Handy.UI.utils.delay(time, queue)
	G.E_MANAGER:add_event(
		Event({
			trigger = "after",
			delay = time or 1,
			timer = "HANDY_TOTAL",
			func = function()
				return true
			end,
		}),
		queue
	)
end
