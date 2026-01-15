local function check_mp_player(player)
	return not player or not player.username or (player.config or {}).handy_mp_extension_loaded
end

function Handy.is_stop_use()
	return G.CONTROLLER.locked or G.CONTROLLER.locks.frame or (G.GAME and (G.GAME.STOP_USE or 0) > 0) or false
end
function Handy.b_is_stop_use()
	return Handy.buffered("is_stop_use", Handy.is_stop_use)
end

function Handy.is_in_multiplayer()
	return not not (MP and MP.LOBBY and MP.LOBBY.code)
end
function Handy.is_mp_lobby_extenstion_active()
	return #(MP.LOBBY.players or {}) == 0 and check_mp_player(MP.LOBBY.host) and check_mp_player(MP.LOBBY.guest)
end
function Handy.b_is_in_multiplayer(check_type, check_arg)
	local is_in_mp = Handy.buffered("is_in_multiplayer", Handy.is_in_multiplayer)
	if not is_in_mp then
		return false
	end
	if check_type == "extension_speed" or check_type == "extension_animations" then
		local is_extension_active = Handy.buffered("is_mp_lobby_extenstion_active", Handy.is_mp_lobby_extenstion_active)
		if not is_extension_active then
			return true
		end
		check_arg = check_arg or 1
		if check_type == "extension_speed" and MP.LOBBY.config.handy_speed_multiplier_mode <= check_arg then
			return true
		end
		if check_type == "extension_animations" and MP.LOBBY.config.handy_animation_skip_mode <= check_arg then
			return true
		end
		return false
	end
	return is_in_mp
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
	return Handy.cc.dangerous_actions.enabled and not Handy.b_is_in_multiplayer() or false
end
function Handy.b_is_dangerous_actions_active()
	return Handy.buffered("is_dangerous_actions_active", Handy.is_dangerous_actions_active)
end

function Handy.is_input_prevented()
	return not not Handy.controller.dp.b_is_console_opened() or G.TMJUI
end
