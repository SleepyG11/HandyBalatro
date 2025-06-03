Handy.insta_highlight = {
	first_card_highlighted = nil,

	can_execute = function(card)
		return G.STATE ~= G.STATES.HAND_PLAYED
			and card
			and card.area == G.hand
			and not G.CONTROLLER.dragging.target
			and Handy.controller.is_module_key_down(Handy.cc.insta_highlight)
	end,
	execute = function(card)
		if Handy.insta_highlight.first_card_highlighted == nil then
			Handy.insta_highlight.first_card_highlighted = card.highlighted
				and Handy.controller.is_module_enabled(Handy.cc.insta_highlight.allow_deselect)
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
		return false
	end,

	use = function(card)
		return Handy.insta_highlight.can_execute(card) and Handy.insta_highlight.execute(card) or false
	end,

	use_on_hovered = function(key)
		if key == "mouse1" then
			return false
		end
		G.E_MANAGER:add_event(Event({
			type = "immediate",
			func = function()
				Handy.insta_highlight.use(G.CONTROLLER.hovering.target)
				return true
			end,
		}))
		return false
	end,

	update = function(dt)
		if not Handy.controller.is_module_key_down(Handy.cc.insta_highlight, true) then
			Handy.insta_highlight.first_card_highlighted = nil
		end
	end,
}

Handy.register_module("insta_highlight", Handy.insta_highlight)
