Handy.insta_highlight_entire_f_hand = {
	can_execute = function(key, released)
		return Handy.buffered_is_in_run()
			and not Handy.buffered_is_stop_use()
			and Handy.controller.is_triggered(released)
			and G.STATE ~= G.STATES.HAND_PLAYED
			and G.hand
			and G.hand.states.visible
			and Handy.controller.is_module_key(Handy.cc.insta_highlight_entire_f_hand, key)
	end,
	execute = function(key, released)
		G.hand:unhighlight_all()
		local cards_count = math.min(G.hand.config.highlighted_limit, #G.hand.cards)
		for i = 1, cards_count do
			local card = G.hand.cards[i]
			if i ~= cards_count then
				G.hand.cards[i]:highlight(true)
				G.hand.highlighted[#G.hand.highlighted + 1] = card
			else
				G.hand:add_to_highlighted(card)
			end
		end
		return false
	end,

	use = function(key, released)
		return Handy.insta_highlight_entire_f_hand.can_execute(key, released)
				and Handy.insta_highlight_entire_f_hand.execute(key, released)
			or false
	end,
}

Handy.register_module("insta_highlight_entire_f_hand", Handy.insta_highlight_entire_f_hand)
