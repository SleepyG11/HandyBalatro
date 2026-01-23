function Handy.is_stop_use()
	return G.CONTROLLER.locked or G.CONTROLLER.locks.frame or (G.GAME and (G.GAME.STOP_USE or 0) > 0) or false
end
function Handy.b_is_stop_use()
	return Handy.buffered("is_stop_use", Handy.is_stop_use)
end

function Handy.is_in_multiplayer()
	return not not (MP and MP.LOBBY and MP.LOBBY.code)
end
function Handy.b_is_in_multiplayer()
	return Handy.buffered("is_in_multiplayer", Handy.is_in_multiplayer)
end
function Handy.is_mp_lobby_extension_active()
	return MP.LOBBY.config.handy_mp_extension
			and MP.LOBBY.config.handy_allow_mp_extension
			and MP.LOBBY.handy_mp_extension_all_players_enabled
		or false
end
function Handy.b_is_mp_lobby_extension_active()
	return Handy.buffered("is_mp_lobby_extension_active", Handy.is_mp_lobby_extension_active)
end

function Handy.is_in_run()
	return G.STAGE == G.STAGES.RUN and not G.SETTINGS.paused and not G.OVERLAY_MENU
end
function Handy.b_is_in_run()
	return Handy.buffered("is_in_run", Handy.is_in_run)
end

function Handy.is_mod_active()
	return Handy.cc.handy.enabled or false
end
function Handy.b_is_mod_active()
	return Handy.buffered("is_mod_enabled", Handy.is_mod_active)
end

function Handy.is_dangerous_actions_active()
	return Handy.cc.dangerous_actions.enabled or false
end
function Handy.b_is_dangerous_actions_active()
	return Handy.buffered("is_dangerous_actions_active", Handy.is_dangerous_actions_active)
end

function Handy.is_input_prevented()
	return not not (Handy.controller.dp.b_is_console_opened() or G.TMJUI or G.CONTROLLER.text_input_hook)
end

--

function Handy.get_mp_lobby()
	return Handy.b_is_in_multiplayer() and MP.LOBBY or nil
end
function Handy.disabled_in_mp_check(func, args)
	args = args or {}
	local lobby = Handy.get_mp_lobby()
	if not lobby or not lobby.config then
		return false
	end
	if not args.bypass_active and not Handy.b_is_mp_lobby_extension_active() then
		return true
	end
	if type(func) ~= "function" then
		return true
	end
	return func(lobby, lobby.config)
end
function Handy.get_mp_lobby_config_value(ref_value, args)
	args = args or {}
	local lobby = Handy.get_mp_lobby()

	-- no lobby - no value
	if not lobby or not lobby.config then
		return args.default_value, false
	end
	-- not enabled - no value
	if not args.bypass_active and not Handy.b_is_mp_lobby_extension_active() then
		return args.default_value, false
	end
	-- have forced value - use it
	if args.force and lobby.config[ref_value .. "_force"] then
		return lobby.config[ref_value .. "_force"], true
	end
	-- return actual value
	return lobby.config[ref_value] or default_value, false
end
