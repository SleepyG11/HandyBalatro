Handy.misc_controls = {
	can_crash = function(key, released)
		return Handy.is_dangerous_actions_active()
			and not Handy.is_in_multiplayer()
			and Handy.controller.is_module_key(Handy.cc.misc.crash, key)
	end,
	crash = function(key, released)
		error(
			'Crashed by "Crash a game" keybind in Handy mod '
				.. Handy.UI.PARTS.format_new_module_keys(Handy.cc.misc.crash)
		)
		return true
	end,

	can_open_mod_settings = function(key, released)
		return not G.OVERLAY_MENU and Handy.controller.is_module_key(Handy.cc.misc.open_mod_settings, key)
	end,
	open_mod_settings = function(key, released)
		G.FUNCS.handy_open_options()
		return true
	end,

	save_run_blocker = false,
	can_save_run = function(key, released, check)
		if check then
			return not not (
				not Handy.is_in_multiplayer()
				and G.GAME
				and G.STAGE == G.STAGES.RUN
				and (G.STATE == G.STATES.SHOP or G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.BLIND_SELECT or G.STATE == G.STATES.ROUND_EVAL)
				and not (G.CONTROLLER.locked or G.CONTROLLER.locks.frame or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))
				and not (G.SETTINGS.paused or G.OVERLAY_MENU)
				and #G.E_MANAGER.queues.base < 3 -- One more because event callback called before it removed from queue
			)
		end
		return not not (
			not Handy.misc_controls.save_run_blocker
			and not Handy.is_in_multiplayer()
			and G.GAME
			and G.STAGE == G.STAGES.RUN
			and (G.STATE == G.STATES.SHOP or G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.BLIND_SELECT or G.STATE == G.STATES.ROUND_EVAL)
			and not (G.CONTROLLER.locked or G.CONTROLLER.locks.frame or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))
			and not (G.SETTINGS.paused or G.OVERLAY_MENU)
			and #G.E_MANAGER.queues.base < 2
			and Handy.controller.is_module_key(Handy.cc.misc.save_run, key)
		)
	end,
	save_run = function(key, released)
		Handy.misc_controls.save_run_blocker = true
		Handy.UI.state_panel.display(function(state)
			state.items.misc_save_run = {
				text = localize("ph_handy_notif_misc_save_run_start"),
				order = 20,
			}
			return true
		end)
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
								if Handy.misc_controls.can_save_run(key, released, true) then
									save_run()
									Handy.UI.state_panel.display(function(state)
										state.items.misc_save_run = {
											text = localize("ph_handy_notif_misc_save_run_saving"),
											order = 20,
										}
										return true
									end)
									G.E_MANAGER:add_event(Event({
										trigger = "after",
										delay = 0.5,
										timer = "REAL",
										blocking = false,
										blockable = false,
										force_pause = true,
										func = function()
											Handy.UI.state_panel.display(function(state)
												state.items.misc_save_run = {
													text = localize("ph_handy_notif_misc_save_run_saved"),
													order = 20,
												}
												return true
											end)
											Handy.misc_controls.save_run_blocker = false
											return true
										end,
									}))
								else
									Handy.UI.state_panel.display(function(state)
										state.items.misc_save_run = {
											text = localize("ph_handy_notif_misc_save_run_interrupt"),
											order = 20,
										}
										return true
									end)
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

	can_restart_run = function(key, released)
		return G.STAGE == G.STAGES.RUN
			and not G.SETTINGS.paused
			and not Handy.is_in_multiplayer()
			and Handy.controller.is_module_key(Handy.cc.misc.quick_restart, key)
	end,
	restart_fun = function(key, released)
		local old_hold_value = G.CONTROLLER.held_key_times.r
		G.CONTROLLER.held_key_times.r = 999
		Handy.animation_skip.skip_wipe_screen = true
		Handy.animation_skip.force_non_blocking = true
		G.CONTROLLER:key_hold_update("r", 0)
		G.CONTROLLER.held_key_times.r = old_hold_value
		Handy.animation_skip.skip_wipe_screen = false
		Handy.animation_skip.force_non_blocking = false
		return true
	end,

	use = function(key, released)
		if released then
			return false
		end
		if Handy.misc_controls.can_crash(key, released) then
			return Handy.misc_controls.crash(key, released)
		elseif Handy.misc_controls.can_restart_run(key, released) then
			return Handy.misc_controls.restart_fun(key, released)
		elseif Handy.misc_controls.can_open_mod_settings(key, released) then
			return Handy.misc_controls.open_mod_settings(key, released)
		elseif Handy.misc_controls.can_save_run(key, released) then
			return Handy.misc_controls.save_run(key, released)
		end
		return false
	end,
}

Handy.register_module("misc_controls", Handy.misc_controls)
