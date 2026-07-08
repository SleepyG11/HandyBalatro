function Handy.is_stop_use()
	return G.CONTROLLER.locked or G.CONTROLLER.locks.frame or (G.GAME and (G.GAME.STOP_USE or 0) > 0) or false
end
Handy.b_is_stop_use = Handy.buffered("is_stop_use", Handy.is_stop_use)

-- function Handy.is_in_overlay()
-- 	return not not (G.SETTINGS.paused or G.OVERLAY_MENU)
-- end
-- function Handy.b_is_in_overlay()
-- 	return Handy.buffered("is_in_overlay", Handy.is_in_overlay)
-- end

function Handy.is_in_run()
	return G.STAGE == G.STAGES.RUN and not G.SETTINGS.paused and not G.OVERLAY_MENU
end
Handy.b_is_in_run = Handy.buffered("is_in_run", Handy.is_in_run)

function Handy.is_mod_active()
	return Handy.cc.handy.enabled or false
end
Handy.b_is_mod_active = Handy.buffered("is_mod_enabled", Handy.is_mod_active)

function Handy.is_dangerous_actions_active()
	return Handy.cc.dangerous_actions.enabled or false
end
Handy.b_is_dangerous_actions_active = Handy.buffered("is_dangerous_actions_active", Handy.is_dangerous_actions_active)

--

function Handy.is_in_multiplayer()
	return false
end
Handy.b_is_in_multiplayer = Handy.is_in_multiplayer

function Handy.is_mp_lobby_extension_active()
	return false
end
Handy.b_is_mp_lobby_extension_active = Handy.is_mp_lobby_extension_active

function Handy.get_mp_lobby()
	return nil, nil
end
function Handy.disabled_in_mp_check(func, args)
	return false
end
function Handy.get_mp_lobby_config_value(ref_value, args)
	return args and args.default_value, false
end
