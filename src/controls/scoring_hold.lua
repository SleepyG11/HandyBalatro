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
