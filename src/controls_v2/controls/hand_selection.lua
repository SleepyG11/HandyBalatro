Handy.hand_selection = {
	first_card_highlighted = nil,

	should_prevent_deselect = function()
		return Handy.b_is_mod_active()
	end,
}

--

Handy.controls_v2.register("hand_selection_insta_highlight", {
	get_module = function(self)
		return Handy.cc.hand_selection_insta_highlight, { Handy.cc.hand_selection }
	end,

	context_type = {
		input = true,
		card = true,
	},

	only_holdable = true,
	in_run = true,
	no_stop_use = true,

	can_execute = function(self, args)
		local ctx = Handy.controller_v2.non_empty_context(args and args.ctx)
		if not ctx then
			return false
		end
		if ctx.card and not ctx.hover then
			return false
		end
		if ctx.input and (ctx.key == "Left Mouse" or ctx.key == "(A)") then
			return false
		end

		local card_ctx = Handy.controller_v2.card.get_context()
		local card = card_ctx.target or card_ctx.hovered_current

		if card and card.handy_insta_highlight_preview then
			if not G.CONTROLLER.dragging.target then
				return Handy.controls_v2.can_execute_control(self, {
					allow_not_in_run = true,
					allow_stop_use = true,
					allow_mod_inactive = true,
					data = {
						card = card,
					},
				})
			end
		else
			if
				G.STATE ~= G.STATES.HAND_PLAYED
				and card
				and card.area
				and card.area.states
				and card.area.states.visible
				and ((card.area.handy_allow_hand_selection or card.area.config.handy_allow_hand_selection) or (card.area == G.hand))
				and not G.CONTROLLER.dragging.target
			then
				return Handy.controls_v2.can_execute_control(self, {
					data = {
						card = card,
					},
				})
			end
		end
	end,
	execute = function(self, args, data)
		local card = data and data.card
		if not card then
			return false
		end

		if Handy.hand_selection.first_card_highlighted == nil then
			Handy.hand_selection.first_card_highlighted = card.highlighted
				and Handy.controls_v2.is_module_enabled(Handy.cc.hand_selection_insta_highlight_allow_deselect)
		end

		G.E_MANAGER:add_event(Event({
			trigger = "immediate",
			blocking = false,
			blockable = false,
			no_delete = true,
			func = function()
				if
					not G.CONTROLLER.dragging.target
					and (not not card.highlighted == not not Handy.hand_selection.first_card_highlighted)
				then
					card:click()
				end
				return true
			end,
		}))
		return true
	end,

	update = function(self, dt)
		if Handy.hand_selection.first_card_highlighted ~= nil then
			if not Handy.controls_v2.is_module_keys_hold(Handy.cc.hand_selection_insta_highlight) then
				Handy.hand_selection.first_card_highlighted = nil
			end
		end
	end,
})
Handy.controls_v2.register("hand_selection_deselect_hand", {
	get_module = function(self)
		return Handy.cc.hand_selection_deselect_hand, { Handy.cc.hand_selection }
	end,

	context_type = {
		input = true,
	},
	trigger = "trigger",

	in_run = true,
	no_stop_use = true,

	can_execute = function(self, args)
		local preview_area = Handy.utils.alive_element(Handy.UI.data.hand_selection_preview_area)
		if preview_area then
			if preview_area.highlighted[1] then
				return Handy.controls_v2.can_execute_control(self, {
					ctx = args and args.ctx,
					allow_not_in_run = true,
					allow_stop_use = true,
					allow_mod_inactive = true,
					data = {
						area = preview_area,
					},
				})
			end
		else
			if
				G.STATE ~= G.STATES.HAND_PLAYED
				and G.hand
				and G.hand.states.visible
				and G.hand.highlighted[1]
				and G.play
				and G.play.cards
				and #G.play.cards == 0
			then
				return Handy.controls_v2.can_execute_control(self, {
					ctx = args and args.ctx,
					data = {
						area = G.hand,
					},
				})
			end
		end
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
Handy.controls_v2.register("hand_selection_entire_f_hand", {
	get_module = function(self)
		return Handy.cc.hand_selection_entire_f_hand, { Handy.cc.hand_selection }
	end,

	context_type = {
		input = true,
	},

	trigger = "trigger",
	in_run = true,
	no_stop_use = true,

	can_execute = function(self, args)
		local preview_area = Handy.utils.alive_element(Handy.UI.data.hand_selection_preview_area)
		if preview_area then
			return Handy.controls_v2.can_execute_control(self, {
				ctx = args and args.ctx,
				allow_not_in_run = true,
				allow_stop_use = true,
				allow_mod_inactive = true,
				data = {
					area = preview_area,
				},
			})
		else
			if G.STATE ~= G.STATES.HAND_PLAYED and G.hand and G.hand.states.visible then
				return Handy.controls_v2.can_execute_control(self, {
					ctx = args and args.ctx,
					data = {
						area = G.hand,
					},
				})
			end
		end
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
