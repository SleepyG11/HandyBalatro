Handy.API.Control({
	key = "hand_selection_insta_highlight",
	get_module = function(self)
		return Handy.cc.hand_selection_insta_highlight
	end,
	get_deps = function(self)
		return { Handy.cc.hand_selection }
	end,

	contexts = {
		input = true,
		card_hover = true,
		move = true,
	},

	only_holdable_input = true,
	only_in_run = true,
	no_stop_use = true,
	no_mp = function(lobby, config, state)
		return Handy.MP.is_speedrun_mode(lobby, config, state)
	end,

	can_execute = function(self, ctx, args)
		ctx = Handy.controls.resolve_control_context(self, ctx)
		if not ctx then
			return false
		end

		if ctx.move then
			if Handy.cc.hand_selection_mode.value == 2 then
				if Handy.hand_selection.first_card_highlighted ~= nil then
					return false
				end
				local ds = math.sqrt(ctx.sdx * ctx.sdx + ctx.sdy * ctx.sdy)
				Handy.hand_selection.first_card_travel_distance = Handy.hand_selection.first_card_travel_distance + ds
				if
					Handy.hand_selection.first_card_travel_distance
					< Handy.hand_selection.first_card_travel_min_distance
				then
					return false
				end
			elseif Handy.hand_selection.should_interpolate() then
				local preview_area = Handy.hand_selection.get_preview_area()
				local area = preview_area or G.hand
				local is_any, touched_cards = Handy.hand_selection.interpolate(ctx, area)
				if
					is_any
					and Handy.controls.can_execute_control(self, ctx, {
						allow_any_context = true,
						allow_not_in_run = preview_area,
						allow_stop_use = preview_area,
						allow_mod_inactive = preview_area,
						allow_mp = preview_area,
					})
				then
					return true, { cards = touched_cards }
				end
			else
				return false
			end
		elseif
			ctx.input and (ctx.key == "Left Mouse" or ctx.key == "(A)" or Handy.cc.hand_selection_mode.value ~= 1)
		then
			return false
		end

		local card_ctx = Handy.controller.card.get_context()
		local card = card_ctx.target or card_ctx.hovered_current
		local is_preview = Handy.hand_selection.is_card_select_preview(card)

		if
			Handy.hand_selection.can_select_card(card)
			and Handy.controls.can_execute_control(self, ctx, {
				allow_not_in_run = is_preview,
				allow_stop_use = is_preview,
				allow_mod_inactive = is_preview,
				allow_mp = is_preview,
				allow_any_context = true,
			})
		then
			return true, { card = card }
		end
	end,
	execute = function(self, ctx, args, data)
		if data.cards then
			local r = false
			for _, card in ipairs(data.cards) do
				r = Handy.hand_selection.select_card(card) or r
			end
			return r
		end
		if data.card then
			return Handy.hand_selection.select_card(data.card)
		end
	end,

	update = function(self, dt)
		if not Handy.controls.is_module_keys_hold(Handy.cc.hand_selection_insta_highlight) then
			Handy.hand_selection.first_card_highlighted = nil
			Handy.hand_selection.first_card_travel_distance = 0
		end
	end,
})
Handy.API.Control({
	key = "hand_selection_deselect_hand",
	get_module = function(self)
		return Handy.cc.hand_selection_deselect_hand
	end,
	get_deps = function(self)
		return { Handy.cc.hand_selection }
	end,

	contexts = {
		input = true,
	},

	only_in_run = true,
	no_stop_use = true,

	can_execute = function(self, ctx, args)
		ctx = Handy.controls.resolve_control_context(self, ctx)
		if not ctx then
			return false
		end

		local preview_area = Handy.hand_selection.get_preview_area()
		local target_area = preview_area or G.hand

		if not target_area then
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
			local card = Handy.controller.card.get_context().hovered_current
			-- Edge-case: when input mode is "on key release", prevent deselection if we hover a card in hand
			if ctx.release and card and card.area == target_area then
				return false
			end
		end

		if
			Handy.hand_selection.can_deselect_hand(target_area)
			and Handy.controls.can_execute_control(self, ctx, {
				allow_any_context = true,
				allow_not_in_run = preview_area,
				allow_stop_use = preview_area,
				allow_mod_inactive = preview_area,
			})
		then
			return true, { area = target_area }
		end
	end,
	execute = function(self, ctx, args, data)
		return Handy.hand_selection.deselect_hand(data.area)
	end,
})
Handy.API.Control({
	key = "hand_selection_entire_f_hand",
	get_module = function(self)
		return Handy.cc.hand_selection_entire_f_hand
	end,
	get_deps = function(self)
		return { Handy.cc.hand_selection }
	end,

	contexts = {
		input_trigger = true,
	},

	only_in_run = true,
	no_stop_use = true,

	can_execute = function(self, ctx, args)
		local preview_area = Handy.hand_selection.get_preview_area()
		local target_area = preview_area or G.hand

		if
			Handy.hand_selection.can_select_entire_hand(target_area)
			and Handy.controls.can_execute_control(self, ctx, {
				allow_not_in_run = preview_area,
				allow_stop_use = preview_area,
				allow_mod_inactive = preview_area,
			})
		then
			return true, { area = target_area }
		end
	end,
	execute = function(self, ctx, args, data)
		return Handy.hand_selection.select_entire_hand(data.area)
	end,
	no_mp = function(lobby, config, state)
		return Handy.MP.is_speedrun_mode(lobby, config, state)
	end,
})
