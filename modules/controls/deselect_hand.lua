Handy.deselect_hand = {
	should_prevent = function()
		return Handy.is_mod_active() and Handy.controller.is_module_enabled(Handy.cc.deselect_hand)
	end,

	can_execute = function(key)
		return not not (
			G.STATE ~= G.STATES.HAND_PLAYED
			and G.hand
			and G.hand.states.visible
			and G.hand.highlighted[1]
			-- Vanilla check
			and not ((G.play and #G.play.cards > 0) or G.CONTROLLER.locked or G.CONTROLLER.locks.frame or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))
			and Handy.is_mod_active()
			and Handy.controller.is_module_key(Handy.cc.deselect_hand, key)
			-- Selecting cards over hand deselection
			and not Handy.insta_highlight.can_execute(Handy.last_hovered_card)
		)
	end,
	execute = function()
		G.hand:unhighlight_all()
		return true
	end,

	use = function(key)
		return Handy.deselect_hand.can_execute(key) and Handy.deselect_hand.execute() or false
	end,
}

Handy.register_module("deselect_hand", Handy.deselect_hand)
