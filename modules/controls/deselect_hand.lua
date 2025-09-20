Handy.deselect_hand = {
	should_prevent = function()
		return Handy.buffered_is_mod_active() and Handy.controller.is_module_enabled(Handy.cc.deselect_hand)
	end,

	can_execute = function(key, released)
		if G.handy_config_storage.insta_highlight_area then
			return Handy.controller.is_triggered(released)
				and Handy.controller.is_module_key(Handy.cc.deselect_hand, key)
				and not Handy.insta_highlight.can_execute(Handy.last_hovered_card)
		end
		return not not (
			Handy.buffered_is_in_run()
			and Handy.buffered_is_mod_active()
			and not Handy.buffered_is_stop_use()
			and G.STATE ~= G.STATES.HAND_PLAYED
			and Handy.controller.is_triggered(released)
			and G.hand
			and G.hand.states.visible
			and G.hand.highlighted[1]
			and G.play
			and G.play.cards
			and #G.play.cards == 0
			and Handy.controller.is_module_key(Handy.cc.deselect_hand, key)
			-- Selecting cards over hand deselection
			and not Handy.insta_highlight.can_execute(Handy.last_hovered_card)
		)
	end,
	execute = function()
		local area = G.handy_config_storage.insta_highlight_area or G.hand
		area:unhighlight_all()
		return true
	end,

	use = function(key, released)
		return Handy.deselect_hand.can_execute(key, released) and Handy.deselect_hand.execute() or false
	end,
}

Handy.register_module("deselect_hand", Handy.deselect_hand)
