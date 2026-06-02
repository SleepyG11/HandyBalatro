Handy.controls.register({
	key = "scoring_hold",
	get_module = function()
		return Handy.cc.scoring_hold
	end,

	only_holdable = true,
	no_mp = true,

	can_execute = function(self, ctx, args)
		if Handy.UI.data.speed_n_animations_preview then
			return Handy.controls.can_execute_control(self, ctx, {
				allow_mod_inactive = true,
			})
		else
			return G.STAGE == G.STAGES.RUN
				and (G.STATE == G.STATES.HAND_PLAYED or G.STATE == G.STATES.SELECTING_HAND)
				and Handy.controls.can_execute_control(self, ctx, args)
		end
	end,

	update = function(self, dt)
		local is_preview = Handy.UI.data.speed_n_animations_preview
		local new_value, new_hand_played_value = false, false

		if Handy.controller.should_prevent() then
			new_value = false
		elseif is_preview then
			new_value = self:can_execute()
			new_hand_played_value = Handy.UI.data.is_speed_n_animations_calculate

			Handy.scoring_hold.preview_is_hold = new_value
			Handy.scoring_hold.preview_is_hand_played = new_hand_played_value
		else
			new_value = self:can_execute()
			new_hand_played_value = G.STATE == G.STATES.HAND_PLAYED

			if not G.SETTINGS.paused then
				Handy.scoring_hold.is_hold = new_value
			end
			Handy.scoring_hold.is_hand_played = new_hand_played_value
		end

		if
			new_value
			and new_hand_played_value
			and Handy.controls.is_module_enabled(Handy.cc.scoring_hold_any_moment)
		then
			Handy.scoring_hold.create_hold_event(true, is_preview)
		end

		Handy.UI.state_panel.display(function(state)
			local r = false

			local can_display = is_preview or (not G.SETTINGS.paused and not G.OVERLAY_MENU)
			if state.items.scoring_hold and state.items.scoring_hold.hold ~= new_value then
				state.items.scoring_hold.hold = new_value and can_display
				r = true
			elseif not state.items.scoring_hold and new_value and can_display then
				state.items.scoring_hold = {
					text = Handy.L.variable("Handy_scoring_hold"),
					order = 7,
					hold = Handy.scoring_hold.is_hold,
					level = 3,
				}
				r = true
			end

			local can_display_score = can_display
				and G.GAME
				and G.GAME.current_round
				and to_big(G.GAME.current_round.current_hand.chip_total) > to_big(0)
			if state.items.scoring_hold_score and not (new_value and can_display_score) then
				state.items.scoring_hold_score = nil
				r = true
			elseif not state.items.scoring_hold_score and new_value and can_display_score then
				state.items.scoring_hold_score = {
					text = Handy.L.variable(
						"Handy_scoring_hold_hand_score",
						{ number_format(G.GAME.current_round.current_hand.chip_total) }
					),
					order = 7.01,
					hold = Handy.scoring_hold.is_hold,
					level = 3,
				}
				r = true
			end
			return r
		end, "update", is_preview and 1 or 3)
	end,
})
