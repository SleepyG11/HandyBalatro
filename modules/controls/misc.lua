Handy.misc_controls = {
	can_crash = function(key, released)
		return Handy.is_dangerous_actions_active() and Handy.controller.is_module_key(Handy.cc.misc.crash, key)
	end,
	crash = function(key)
		error(
			'Crashed by "Crash a game" keybind in Handy mod '
				.. Handy.UI.PARTS.format_new_module_keys(Handy.cc.misc.crash)
		)
	end,

	can_open_mod_settings = function(key, released)
		return not G.OVERLAY_MENU and Handy.controller.is_module_key(Handy.cc.misc.open_mod_settings, key)
	end,
	open_mod_settings = function()
		G.FUNCS.handy_open_options()
		return true
	end,

	use = function(key, released)
		if released then
			return false
		end
		if Handy.misc_controls.can_crash(key, released) then
			return Handy.misc_controls.crash()
		elseif Handy.misc_controls.can_open_mod_settings(key, released) then
			return Handy.misc_controls.open_mod_settings()
		else
		end
		return false
	end,
}

Handy.register_module("misc_controls", Handy.misc_controls)
