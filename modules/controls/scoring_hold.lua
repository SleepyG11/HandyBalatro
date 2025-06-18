Handy.scoring_hold = {
	is_hold = false,
	is_hand_played = false,

	create_hold_event = function(prepend)
		local event = Event({
			func = function()
				return not Handy.scoring_hold.is_hold
			end,
		})
		event.handy_never_modify = true
		G.E_MANAGER:add_event(event, nil, prepend)
	end,

	get_is_hold = function()
		if Handy.is_mod_active() and Handy.controller.is_module_enabled(Handy.cc.scoring_hold) then
			return G.STAGE == G.STAGES.RUN
				and (G.STATE == G.STATES.HAND_PLAYED or G.STATE == G.STATES.SELECTING_HAND)
				and Handy.controller.is_module_key_down(Handy.cc.scoring_hold)
		else
			return false
		end
	end,

	update = function(dt)
		local old_value = Handy.scoring_hold.is_hold
		local new_value = Handy.scoring_hold.get_is_hold()
		local old_hand_played_value = Handy.scoring_hold.is_hand_played
		local new_hand_played_value = G.STATE == G.STATES.HAND_PLAYED
		Handy.scoring_hold.is_hold = new_value
		Handy.scoring_hold.is_hand_played = new_hand_played_value
		if new_value and new_hand_played_value then
			if (old_hand_played_value ~= new_hand_played_value) or (old_value ~= new_value) then
				if Handy.controller.is_module_enabled(Handy.cc.scoring_hold.any_moment) then
					Handy.scoring_hold.create_hold_event(true)
				end
			end
		end
		Handy.UI.state_panel.display(function(state)
			if state.items.scoring_hold and state.items.scoring_hold.hold ~= new_value then
				state.items.scoring_hold.hold = new_value and not G.SETTINGS.paused and not G.OVERLAY_MENU
				return true
			elseif new_value then
				if Handy.cc.notifications_level < 3 or G.SETTINGS.paused or G.OVERLAY_MENU then
					return false
				end
				state.items.scoring_hold = {
					text = localize({
						type = "variable",
						key = "Handy_scoring_hold",
						vars = {},
					}),
					order = 7,
					hold = Handy.scoring_hold.is_hold,
				}
				return true
			end
		end, "update")
	end,
}

Handy.register_module("scoring_hold", Handy.scoring_hold)
