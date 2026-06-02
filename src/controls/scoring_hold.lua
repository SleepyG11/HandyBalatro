Handy.scoring_hold = {
	game = {
		queue = nil,
		event = nil,
		is_hold = false,
		is_hand_played = false,
		can_display = false,
		can_display_score = false,
		score = nil,
	},
	preview = {
		preview = true,
		queue = "handy_config",
		event = nil,
		is_hold = false,
		is_hand_played = false,
		can_display = false,
		can_display_score = false,
		score = nil,
	},
}

function Handy.scoring_hold.is_preview()
	return Handy.UI.data.speed_n_animations_preview and true or false,
		Handy.UI.data.is_speed_n_animations_calculate and true or false
end

--

function Handy.scoring_hold.update_values(item)
	local is_preview, is_preview_hand_played = Handy.scoring_hold.is_preview()

	if is_preview then
		local t = Handy.scoring_hold.preview
		t.is_hold = Handy.controls.can_execute_control(item, nil, {
			allow_mod_inactive = true,
			allow_mp = true,
		})
		t.is_hand_played = is_preview_hand_played
		t.can_display = t.is_hold and not Handy.controller.should_prevent()
		t.can_display_score = false

		return t
	else
		local t = Handy.scoring_hold.game
		if not G.SETTINGS.paused then
			t.is_hold = G.STAGE == G.STAGES.RUN
				and (G.STATE == G.STATES.HAND_PLAYED or G.STATE == G.STATES.SELECTING_HAND)
				and Handy.controls.can_execute_control(item)
		end
		t.is_hand_played = G.STATE == G.STATES.HAND_PLAYED
		t.can_display = t.is_hold
			and (not G.SETTINGS.paused and not G.OVERLAY_MENU)
			and not Handy.controller.should_prevent()
		t.can_display_score = t.can_display
			and G.GAME
			and G.GAME.current_round
			and G.GAME.current_round.current_hand.chip_total
			and to_big(G.GAME.current_round.current_hand.chip_total) > to_big(0)
		t.score = t.can_display_score and G.GAME.current_round.current_hand.chip_total or nil

		Handy.scoring_hold.preview.is_hold = false
		Handy.scoring_hold.preview.is_hand_played = false
		Handy.scoring_hold.preview.can_display = false
		Handy.scoring_hold.preview.can_display_score = false

		return t
	end
end
function Handy.scoring_hold.create_hold_event(prepend, preview)
	local t = preview and Handy.scoring_hold.preview or Handy.scoring_hold.game

	if prepend and t.event then
		return
	end
	local event = Event({
		no_delete = true,
		func = function()
			if not t.is_hold then
				t.event = nil
				return true
			end
		end,
	})
	event.handy_never_modify = true
	if prepend then
		t.event = event
	end
	G.E_MANAGER:add_event(event, t.queue, prepend)
end

function Handy.scoring_hold.show_notif(t)
	Handy.UI.state_panel.display(function(state)
		local r = false

		if state.items.scoring_hold and state.items.scoring_hold.hold ~= t.is_hold then
			state.items.scoring_hold.hold = t.can_display
			r = true
		elseif not state.items.scoring_hold and t.can_display then
			state.items.scoring_hold = {
				text = Handy.L.variable("Handy_scoring_hold"),
				order = 7,
				hold = Handy.scoring_hold.is_hold,
				level = 3,
			}
			r = true
		end

		if state.items.scoring_hold_score and not t.can_display_score then
			state.items.scoring_hold_score = nil
			r = true
		elseif not state.items.scoring_hold_score and t.can_display_score then
			state.items.scoring_hold_score = {
				text = Handy.L.variable("Handy_scoring_hold_hand_score", { number_format(t.score) }),
				order = 7.01,
				hold = Handy.scoring_hold.is_hold,
				level = 3,
			}
			r = true
		end

		return r
	end, "update", t.preview and 1 or 3)
end
