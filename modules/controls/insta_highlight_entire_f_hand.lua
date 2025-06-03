Handy.insta_highlight_entire_f_hand = {
	can_execute = function(key)
		return G.hand and Handy.controller.is_module_key(Handy.cc.insta_highlight_entire_f_hand, key)
	end,
	execute = function(key)
		G.hand:unhighlight_all()
		local cards_count = math.min(G.hand.config.highlighted_limit, #G.hand.cards)
		for i = 1, cards_count do
			local card = G.hand.cards[i]
			G.hand.cards[i]:highlight(true)
			G.hand.highlighted[#G.hand.highlighted + 1] = card
		end
		if G.STATE == G.STATES.SELECTING_HAND then
			G.hand:parse_highlighted()
		end
		return false
	end,

	use = function(key)
		return Handy.insta_highlight_entire_f_hand.can_execute(key) and Handy.insta_highlight_entire_f_hand.execute(key)
			or false
	end,
}

Handy.register_module("insta_highlight_entire_f_hand", Handy.insta_highlight_entire_f_hand)
