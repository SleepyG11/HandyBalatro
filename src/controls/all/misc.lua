Handy.misc_controls = {
	save_run_blocker = false,
	can_save_run = function(item, context, check)
		if check then
			return not not (
				Handy.b_is_mod_active()
				and Handy.b_is_in_run()
				and not Handy.b_is_stop_use()
				and not Handy.b_is_in_multiplayer()
				and (G.STATE == G.STATES.SHOP or G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.BLIND_SELECT or G.STATE == G.STATES.ROUND_EVAL)
				and #G.E_MANAGER.queues.base < 3 -- One more because event callback called before it removed from queue
			)
		end
		return not not (
			not Handy.misc_controls.save_run_blocker
			and (G.STATE == G.STATES.SHOP or G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.BLIND_SELECT or G.STATE == G.STATES.ROUND_EVAL)
			and #G.E_MANAGER.queues.base < 2
			and Handy.controls.default_can_execute(item, context)
		)
	end,
	save_run = function(item, context)
		Handy.misc_controls.save_run_blocker = true
		Handy.UI.state_panel.display(function(state)
			state.items.misc_save_run = {
				text = Handy.L.dictionary("ph_handy_notif_misc_save_run_start"),
				order = 20,
			}
			return true
		end, nil, 3)
		G.E_MANAGER:add_event(Event({
			timer = "REAL",
			func = function()
				G.E_MANAGER:add_event(Event({
					timer = "REAL",
					func = function()
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							timer = "REAL",
							func = function()
								if Handy.misc_controls.can_save_run(item, context, true) then
									save_run()
									Handy.UI.state_panel.display(function(state)
										state.items.misc_save_run = {
											text = Handy.L.dictionary("ph_handy_notif_misc_save_run_saving"),
											order = 20,
										}
										return true
									end, nil, 3)
									G.E_MANAGER:add_event(Event({
										trigger = "after",
										delay = 0.5,
										timer = "REAL",
										blocking = false,
										blockable = false,
										pause_force = true,
										func = function()
											Handy.UI.state_panel.display(function(state)
												state.items.misc_save_run = {
													text = Handy.L.dictionary("ph_handy_notif_misc_save_run_saved"),
													order = 20,
												}
												return true
											end, nil, 3)
											Handy.misc_controls.save_run_blocker = false
											return true
										end,
									}))
								else
									Handy.UI.state_panel.display(function(state)
										state.items.misc_save_run = {
											text = Handy.L.dictionary("ph_handy_notif_misc_save_run_interrupt"),
											order = 20,
										}
										return true
									end, nil, 3)
									Handy.misc_controls.save_run_blocker = false
								end
								return true
							end,
						}))
						return true
					end,
				}))
				return true
			end,
		}))
		return true
	end,
}

--

Handy.controls.register("misc_crash", {
	get_module = function()
		return Handy.cc.misc_crash, { Handy.cc.misc }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	only_safe = true,
	no_mp = true,
	require_exact_keys = true,

	execute = function()
		local key_1, key_2 = "keys_1", "keys_2"
		if Handy.controller.is_gamepad() then
			key_1, key_2 = "keys_1_gamepad", "keys_2_gamepad"
		end
		error(
			'Crashed by "Crash a game" keybind in Handy mod '
				.. Handy.L.with_brackets(Handy.L.keys(Handy.cc.misc_crash[key_1]), true)
				.. " or "
				.. Handy.L.with_brackets(Handy.L.keys(Handy.cc.misc_crash[key_2]), true)
		)
		return true
	end,
})
Handy.controls.register("misc_quick_restart", {
	get_module = function()
		return Handy.cc.misc_quick_restart, { Handy.cc.misc }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	require_exact_keys = true,
	no_mp = true,

	can_execute = function(self, context)
		return G.STAGE == G.STAGES.RUN
			and (not G.SETTINGS.paused or G.STATE == G.STATES.GAME_OVER)
			and Handy.controls.default_can_execute(self, context)
	end,
	execute = function()
		local old_hold_value = G.CONTROLLER.held_key_times.r
		G.CONTROLLER.held_key_times.r = 999
		Handy.animation_skip.skip_wipe_screen = true
		Handy.animation_skip.force_non_blocking = true
		Handy.__restart_from_game_over = G.STATE == G.STATES.GAME_OVER
		G.CONTROLLER:key_hold_update("r", 0)
		Handy.__restart_from_game_over = nil
		G.CONTROLLER.held_key_times.r = old_hold_value
		Handy.animation_skip.skip_wipe_screen = false
		Handy.animation_skip.force_non_blocking = false
		return true
	end,
})

Handy.controls.register("misc_start_fantoms_preview", {
	get_module = function()
		return Handy.cc.misc_start_fantoms_preview, { Handy.cc.misc }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,

	can_execute = function(self, context)
		return FN
			and FN.SIM
			and FN.SIM.run
			and Handy.controls.default_can_execute(self, context)
			and Handy.fake_events.check_button(function()
				return G.HUD:get_UIE_by_ID("calculate_score_button")
			end)
	end,
	execute = function()
		Handy.fake_events.execute_button(function()
			return G.HUD:get_UIE_by_ID("calculate_score_button")
		end)
		return true
	end,
})
Handy.controls.register("misc_save_run", {
	get_module = function()
		return Handy.cc.misc_save_run, { Handy.cc.misc }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,
	no_mp = true,
	require_exact_keys = true,

	can_execute = function(self, context)
		return Handy.misc_controls.can_save_run(self, context, false)
	end,
	execute = function(self, context)
		Handy.misc_controls.save_run(self, context)
		return true
	end,
})
