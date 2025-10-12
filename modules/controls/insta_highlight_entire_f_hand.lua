Handy.insta_highlight_entire_f_hand = {
	can_execute = function(key, released)
		if G.handy_config_storage.insta_highlight_area then
			return Handy.controller.is_triggered(released)
				and Handy.controller.is_module_key(Handy.cc.insta_highlight_entire_f_hand, key)
		end
		return Handy.buffered_is_in_run()
			and not Handy.buffered_is_stop_use()
			and Handy.buffered_is_mod_active()
			and Handy.controller.is_triggered(released)
			and G.STATE ~= G.STATES.HAND_PLAYED
			and G.hand
			and G.hand.states.visible
			and Handy.controller.is_module_key(Handy.cc.insta_highlight_entire_f_hand, key)
	end,
	execute = function(key, released)
		local area = G.handy_config_storage.insta_highlight_area or G.hand
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
		return false
	end,

	use = function(key, released)
		return Handy.insta_highlight_entire_f_hand.can_execute(key, released)
				and Handy.insta_highlight_entire_f_hand.execute(key, released)
			or false
	end,
}

Handy.register_module("insta_highlight_entire_f_hand", Handy.insta_highlight_entire_f_hand)
