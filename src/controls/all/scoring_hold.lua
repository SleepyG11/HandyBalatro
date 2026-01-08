Handy.scoring_hold = {
	is_hold = false,
	is_hand_played = false,

	preview_is_hold = false,
	preview_is_hand_played = false,

	hold_event = nil,
	preview_hold_event = nil,

	create_hold_event = function(prepend)
		if prepend and Handy.scoring_hold.hold_event then
			return
		end
		local event = Event({
			no_delete = true,
			func = function()
				if not Handy.scoring_hold.is_hold then
					Handy.scoring_hold.hold_event = nil
					return true
				end
			end,
		})
		event.handy_never_modify = true
		if prepend then
			Handy.scoring_hold.hold_event = event
		end
		G.E_MANAGER:add_event(event, nil, prepend)
	end,
	preview_create_hold_event = function(prepend)
		if prepend and Handy.scoring_hold.preview_hold_event then
			return
		end
		local event = Event({
			no_delete = true,
			func = function()
				if not Handy.scoring_hold.preview_is_hold then
					Handy.scoring_hold.preview_hold_event = nil
					return true
				end
			end,
		})
		event.handy_never_modify = true
		if prepend then
			Handy.scoring_hold.preview_hold_event = event
		end
		G.E_MANAGER:add_event(event, "handy_config", prepend)
	end,

	get_is_hold = function()
		return Handy.b_is_mod_active()
			and G.STAGE == G.STAGES.RUN
			and (G.STATE == G.STATES.HAND_PLAYED or G.STATE == G.STATES.SELECTING_HAND)
			and Handy.controls.is_module_enabled(Handy.cc.scoring_hold)
			and Handy.controls.is_module_keys_activated(Handy.cc.scoring_hold)
	end,
	get_preview_is_hold = function()
		return Handy.UI.data.is_speed_n_animations_calculate
			and Handy.controls.is_module_keys_activated(Handy.cc.scoring_hold)
	end,
}

Handy.e_mitter.on("update", function(dt)
	local new_value
	if Handy.controller.binding.current then
		new_value = false
	elseif Handy.UI.data.speed_n_animations_preview then
		new_value = Handy.scoring_hold.get_preview_is_hold()
		local new_hand_played_value = Handy.UI.data.is_speed_n_animations_calculate

		Handy.scoring_hold.preview_is_hold = new_value
		Handy.scoring_hold.preview_is_hand_played = new_hand_played_value

		if
			new_value
			and new_hand_played_value
			and Handy.controls.is_module_enabled(Handy.cc.scoring_hold_any_moment)
		then
			Handy.scoring_hold.preview_create_hold_event(true)
		end
	else
		new_value = Handy.scoring_hold.get_is_hold()
		local new_hand_played_value = G.STATE == G.STATES.HAND_PLAYED

		Handy.scoring_hold.is_hold = new_value
		Handy.scoring_hold.is_hand_played = new_hand_played_value

		if
			new_value
			and new_hand_played_value
			and Handy.controls.is_module_enabled(Handy.cc.scoring_hold_any_moment)
		then
			Handy.scoring_hold.create_hold_event(true)
		end
	end

	Handy.UI.state_panel.display(function(state)
		local can_display = Handy.UI.data.speed_n_animations_preview or (not G.SETTINGS.paused and not G.OVERLAY_MENU)
		if state.items.scoring_hold and state.items.scoring_hold.hold ~= new_value then
			state.items.scoring_hold.hold = new_value and can_display
			return true
		elseif new_value then
			if not can_display then
				return false
			end
			state.items.scoring_hold = {
				text = Handy.L.variable("Handy_scoring_hold"),
				order = 7,
				hold = Handy.scoring_hold.is_hold,
				level = 3,
			}
			return true
		end
	end, "update", Handy.UI.data.speed_n_animations_preview and 1 or 3)
end)

--
