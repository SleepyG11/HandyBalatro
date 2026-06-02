Handy.controller_sensitivity = {
	saved_axis_cursor_speed = nil,
	apply = function()
		if not Handy.controller_sensitivity.saved_axis_cursor_speed then
			Handy.controller_sensitivity.saved_axis_cursor_speed = G.CONTROLLER.axis_cursor_speed
		end
		if Handy.b_is_mod_active() and Handy.controls.is_module_enabled(Handy.cc.controller_sensitivity) then
			G.CONTROLLER.axis_cursor_speed = Handy.controller_sensitivity.saved_axis_cursor_speed
				* Handy.cc.controller_sensitivity.value
		else
			G.CONTROLLER.axis_cursor_speed = Handy.controller_sensitivity.saved_axis_cursor_speed
		end
	end,
}

Handy.e_mitter.on("game_start", Handy.controller_sensitivity.apply)
Handy.e_mitter.on("settings_save", Handy.controller_sensitivity.apply)
