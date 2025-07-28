Handy.show_deck_preview = {
	is_hold = false,

	get_is_hold = function()
		if Handy.is_mod_active() and Handy.controller.is_module_enabled(Handy.cc.show_deck_preview) then
			return G.STAGE == G.STAGES.RUN and Handy.controller.is_module_key_down(Handy.cc.show_deck_preview)
		else
			return not not G.CONTROLLER.held_buttons.triggerleft
		end
	end,

	update = function(dt)
		Handy.show_deck_preview.is_hold = Handy.show_deck_preview.get_is_hold()
	end,
}

Handy.register_module("show_deck_preview", Handy.show_deck_preview)
