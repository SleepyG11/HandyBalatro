Handy.controller_sensitivity = {
	apply = function()
		if Handy.controls.is_module_enabled(Handy.cc.controller_sensitivity) then
			G.CONTROLLER.axis_cursor_speed = G.CONTROLLER.saved_axis_cursor_speed
				* Handy.cc.controller_sensitivity.value
		else
			G.CONTROLLER.axis_cursor_speed = G.CONTROLLER.saved_axis_cursor_speed
		end
	end,
}

Handy.e_mitter.on("game_start", function()
	G.CONTROLLER.saved_axis_cursor_speed = G.CONTROLLER.axis_cursor_speed
	Handy.controller_sensitivity.apply()
end)
