Handy.insta_highlight = {
	first_card_highlighted = nil,
}

Handy.deselect_hand = {
	should_prevent = function()
		return Handy.b_is_mod_active()
	end,
}
Handy.insta_highlight_entire_f_hand = {}

--

Handy.controls.register("hand_selection_insta_highlight", {
	get_module = function(self)
		return Handy.cc.hand_selection_insta_highlight, { Handy.cc.hand_selection }
	end,

	context_types = {
		input = true,
		card = {
			hover = true,
		},
	},

	trigger = "press",

	only_holdable = true,
	in_run = true,
	no_stop_use = true,

	can_execute = function(self, context)
		if context.input_context and (context.key == "Left Mouse" or context.key == "(A)") then
			return false
		end

		local card_context = Handy.controller.get_card_context()
		local card = card_context.card or card_context.hovered_current

		if card and card.handy_insta_highlight_preview then
			return not G.CONTROLLER.dragging.target
				and Handy.controls.default_can_execute(self, context, {
					allow_not_in_run = true,
					allow_stop_use = true,
					allow_mod_inactive = true,
				})
		end

		return G.STATE ~= G.STATES.HAND_PLAYED
			and card
			and G.hand
			and G.hand.states.visible
			and card.area == G.hand
			and not G.CONTROLLER.dragging.target
			and Handy.controls.default_can_execute(self, context)
	end,
	execute = function(self, context)
		local card_context = Handy.controller.get_card_context()
		local card = card_context.card or card_context.hovered_current

		if Handy.insta_highlight.first_card_highlighted == nil then
			Handy.insta_highlight.first_card_highlighted = card.highlighted
				and Handy.controls.is_module_enabled(Handy.cc.hand_selection_insta_highlight_allow_deselect)
		end

		G.E_MANAGER:add_event(Event({
			trigger = "immediate",
			blocking = false,
			blockable = false,
			no_delete = true,
			func = function()
				if
					not G.CONTROLLER.dragging.target
					and (not not card.highlighted == not not Handy.insta_highlight.first_card_highlighted)
				then
					card:click()
				end
				return true
			end,
		}))
		return true
	end,

	update = function(self, dt)
		if Handy.insta_highlight.first_card_highlighted ~= nil then
			if not Handy.controls.is_module_keys_activated(Handy.cc.hand_selection_insta_highlight) then
				Handy.insta_highlight.first_card_highlighted = nil
			end
		end
	end,
})
Handy.controls.register("hand_selection_deselect_hand", {
	get_module = function(self)
		return Handy.cc.hand_selection_deselect_hand, { Handy.cc.hand_selection }
	end,

	trigger = "trigger",
	in_run = true,
	no_stop_use = true,

	can_execute = function(self, context)
		local preview_area = Handy.UI.data.hand_selection_preview_area
		if preview_area and not preview_area.REMOVED then
			return preview_area.highlighted[1]
				and Handy.controls.default_can_execute(self, context, {
					allow_not_in_run = true,
					allow_stop_use = true,
					allow_mod_inactive = true,
				})
		end
		return not not (
			G.STATE ~= G.STATES.HAND_PLAYED
			and G.hand
			and G.hand.states.visible
			and G.hand.highlighted[1]
			and G.play
			and G.play.cards
			and #G.play.cards == 0
			and Handy.controls.default_can_execute(self, context)
		)
	end,
	execute = function(self, context)
		-- local area = G.handy_config_storage.insta_highlight_area or G.hand
		local area = G.hand
		local preview_area = Handy.UI.data.hand_selection_preview_area
		if preview_area and not preview_area.REMOVED then
			area = preview_area
		end
		area:unhighlight_all()
		return true
	end,
})
Handy.controls.register("hand_selection_entire_f_hand", {
	get_module = function(self)
		return Handy.cc.hand_selection_entire_f_hand, { Handy.cc.hand_selection }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",
	in_run = true,
	no_stop_use = true,

	can_execute = function(self, context)
		local preview_area = Handy.UI.data.hand_selection_preview_area
		if preview_area and not preview_area.REMOVED then
			return Handy.controls.default_can_execute(self, context, {
				allow_not_in_run = true,
				allow_stop_use = true,
				allow_mod_inactive = true,
			})
		end
		return G.STATE ~= G.STATES.HAND_PLAYED
			and G.hand
			and G.hand.states.visible
			and Handy.controls.default_can_execute(self, context)
	end,
	execute = function(self, context)
		local area = G.hand
		local preview_area = Handy.UI.data.hand_selection_preview_area
		if preview_area and not preview_area.REMOVED then
			area = preview_area
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
