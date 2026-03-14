Handy.hand_selection = {
	first_card_highlighted = nil,
	first_card_travel_distance = 0,

	should_prevent_deselect = function()
		return Handy.b_is_mod_active() and Handy.controls.is_module_enabled(Handy.cc.hand_selection)
	end,
}

--

Handy.controls.register({
	key = "hand_selection_insta_highlight",
	get_module = function(self)
		return Handy.cc.hand_selection_insta_highlight, { Handy.cc.hand_selection }
	end,

	context_types = {
		input = true,
		card = true,
		move = true,
	},

	only_holdable = true,
	in_run = true,
	no_stop_use = true,

	can_execute = function(self, args)
		local ctx = Handy.controls.resolve_control_context(self, args)
		if not ctx then
			return false
		end

		if ctx.card and not ctx.hover then
			return false
		end
		if ctx.input and (ctx.key == "Left Mouse" or ctx.key == "(A)" or Handy.cc.hand_selection_mode.value ~= 1) then
			return false
		end
		if ctx.move then
			if Handy.cc.hand_selection_mode.value == 2 then
				if Handy.hand_selection.first_card_highlighted ~= nil then
					return false
				end
				local ds = math.sqrt(ctx.sdx * ctx.sdx + ctx.sdy * ctx.sdy)
				Handy.hand_selection.first_card_travel_distance = Handy.hand_selection.first_card_travel_distance + ds
				if Handy.hand_selection.first_card_travel_distance < 0.1 then
					return false
				end
			else
				return false
			end
		end

		local card_ctx = Handy.controller.card.get_context()
		local card = card_ctx.target or card_ctx.hovered_current

		if not card then
			return false
		end

		if card.handy_insta_highlight_preview then
			if
				not (
					not G.CONTROLLER.dragging.target
					and Handy.controls.can_execute_control(self, {
						allow_not_in_run = true,
						allow_stop_use = true,
						allow_mod_inactive = true,
						ctx = ctx,
					})
				)
			then
				return false
			end
		else
			if
				not (
					G.STATE ~= G.STATES.HAND_PLAYED
					and card.area
					and card.area.states
					and card.area.states.visible
					and ((card.area.handy_allow_hand_selection or card.area.config.handy_allow_hand_selection) or (card.area == G.hand))
					and not G.CONTROLLER.dragging.target
					and Handy.controls.can_execute_control(self, {
						ctx = ctx,
					})
				)
			then
				return false
			end
		end

		return true, { card = card }
	end,
	execute = function(self, args, data)
		local card = data and data.card
		if not card then
			return false
		end

		if Handy.hand_selection.first_card_highlighted == nil then
			Handy.hand_selection.first_card_highlighted = card.highlighted
				and Handy.controls.is_module_enabled(Handy.cc.hand_selection_insta_highlight_allow_deselect)
		end

		if
			not G.CONTROLLER.dragging.target
			and (
				Handy.controls.is_module_enabled(Handy.cc.hand_selection_combine_select_deselect)
				or (not not card.highlighted == not not Handy.hand_selection.first_card_highlighted)
			)
		then
			card:click()
		end
		return true
	end,

	update = function(self, dt)
		if not Handy.controls.is_module_keys_hold(Handy.cc.hand_selection_insta_highlight) then
			Handy.hand_selection.first_card_highlighted = nil
			Handy.hand_selection.first_card_travel_distance = 0
		end
	end,
})
Handy.controls.register({
	key = "hand_selection_deselect_hand",
	get_module = function(self)
		return Handy.cc.hand_selection_deselect_hand, { Handy.cc.hand_selection }
	end,

	context_types = {
		input = true,
	},

	in_run = true,
	no_stop_use = true,

	can_execute = function(self, args)
		local ctx = Handy.controls.resolve_control_context(self, args)
		if not ctx then
			return false
		end

		if Handy.cc.hand_selection_mode.value == 2 then
			if not ctx.release or Handy.hand_selection.first_card_highlighted ~= nil then
				return false
			end
		else
			if not ctx.trigger then
				return false
			end
			local target_area = preview_area or G.hand
			local card_ctx = Handy.controller.card.get_context()
			local card = card_ctx.hovered_current
			-- Edge-case: when input mode is "on key release", prevent deselection if we hover a card in hand
			if ctx.release and card and card.area and card.area == target_area then
				return false
			end
		end

		local preview_area = Handy.utils.alive_element(Handy.UI.data.hand_selection_preview_area)

		if preview_area then
			if
				not (
					preview_area.highlighted[1]
					and Handy.controls.can_execute_control(self, {
						ctx = ctx,
						allow_not_in_run = true,
						allow_stop_use = true,
						allow_mod_inactive = true,
						allow_any_context = true,
					})
				)
			then
				return false
			end
		else
			if
				not (
					G.STATE ~= G.STATES.HAND_PLAYED
					and G.hand
					and G.hand.states.visible
					and G.hand.highlighted[1]
					and G.play
					and G.play.cards
					and #G.play.cards == 0
					and Handy.controls.can_execute_control(self, {
						ctx = ctx,
						allow_any_context = true,
					})
				)
			then
				return false
			end
		end

		return true, { area = preview_area or G.hand }
	end,
	execute = function(self, args, data)
		local area = data and data.area
		if not area then
			return false
		end
		area:unhighlight_all()
		return true
	end,
})
Handy.controls.register({
	key = "hand_selection_entire_f_hand",
	get_module = function(self)
		return Handy.cc.hand_selection_entire_f_hand, { Handy.cc.hand_selection }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",
	in_run = true,
	no_stop_use = true,

	can_execute = function(self, args)
		local preview_area = Handy.utils.alive_element(Handy.UI.data.hand_selection_preview_area)
		if preview_area then
			if
				not Handy.controls.can_execute_control(self, {
					ctx = args and args.ctx,
					allow_not_in_run = true,
					allow_stop_use = true,
					allow_mod_inactive = true,
				})
			then
				return false
			end
		else
			if
				not (
					G.STATE ~= G.STATES.HAND_PLAYED
					and G.hand
					and G.hand.states.visible
					and Handy.controls.can_execute_control(self, args)
				)
			then
				return false
			end
		end

		return true, { area = preview_area or G.hand }
	end,
	execute = function(self, args, data)
		local area = data and data.area
		if not area then
			return false
		end
		area:unhighlight_all()
		local cards_count = math.min(area.config.highlighted_limit, #area.cards)
		for i = 1, cards_count do
			local card = area.cards[i]
			if i ~= cards_count then
				area.cards[i]:highlight(true)
				area.highlighted[#area.highlighted + 1] = card
			else
				area:add_to_highlighted(card)
			end
		end
		return true
	end,
})
