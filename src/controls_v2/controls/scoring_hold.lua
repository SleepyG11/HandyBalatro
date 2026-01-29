Handy.scoring_hold = {
	is_hold = false,
	is_hand_played = false,

	preview_is_hold = false,
	preview_is_hand_played = false,

	hold_event = nil,
	preview_hold_event = nil,

	create_hold_event = function(prepend, is_preview)
		local event_key = is_preview and "preview_hold_event" or "hold_event"
		local is_hold_key = is_preview and "preview_is_hold" or "is_hold"

		if prepend and Handy.scoring_hold[event_key] then
			return
		end
		local event = Event({
			no_delete = true,
			func = function()
				if not Handy.scoring_hold[is_hold_key] then
					Handy.scoring_hold[event_key] = nil
					return true
				end
			end,
		})
		event.handy_never_modify = true
		if prepend then
			Handy.scoring_hold[event_key] = event
		end
		G.E_MANAGER:add_event(event, is_preview and "handy_config" or nil, prepend)
	end,
}

Handy.controls_v2.register("scoring_hold", {
	get_module = function()
		return Handy.cc.scoring_hold
	end,

	can_execute = function(self, args)
		if Handy.UI.data.is_speed_n_animations_calculate then
			return Handy.controls_v2.can_execute_control(self, {
				allow_mod_inactive = true,
			})
		else
			if G.STAGE == G.STAGES.RUN and (G.STATE == G.STATES.HAND_PLAYED or G.STATE == G.STATES.SELECTING_HAND) then
				return Handy.controls_v2.can_execute_control(self)
			end
		end
	end,

	update = function(self, dt)
		local is_preview = Handy.UI.data.speed_n_animations_preview
		local new_value, new_hand_played_value = false, false

		if Handy.controller_v2.should_prevent() then
			new_value = false
		elseif is_preview then
			new_value = self:can_execute()
			new_hand_played_value = Handy.UI.data.is_speed_n_animations_calculate

			Handy.scoring_hold.preview_is_hold = new_value
			Handy.scoring_hold.preview_is_hand_played = new_hand_played_value
		else
			new_value = self:can_execute()
			new_hand_played_value = G.STATE == G.STATES.HAND_PLAYED

			Handy.scoring_hold.is_hold = new_value
			Handy.scoring_hold.is_hand_played = new_hand_played_value
		end

		if
			new_value
			and new_hand_played_value
			and Handy.controls_v2.is_module_enabled(Handy.cc.scoring_hold_any_moment)
		then
			Handy.scoring_hold.create_hold_event(true, is_preview)
		end

		Handy.UI.state_panel.display(function(state)
			local can_display = is_preview or (not G.SETTINGS.paused and not G.OVERLAY_MENU)
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
		end, "update", is_preview and 1 or 3)
	end,
})
