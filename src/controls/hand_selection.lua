Handy.hand_selection = {
	first_card_highlighted = nil,
	first_card_travel_distance = 0,

	should_prevent_deselect = function()
		return Handy.b_is_mod_active() and Handy.controls.is_module_enabled(Handy.cc.hand_selection)
	end,
}
