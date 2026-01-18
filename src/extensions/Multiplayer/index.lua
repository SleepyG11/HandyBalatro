Handy.EXT.Multiplayer = {
	loaded = false,
}

function Handy.EXT.Multiplayer.can_change_lobby_settings()
	return G.STAGE == G.STAGES.MAIN_MENU
		and MP
		and MP.LOBBY
		and MP.LOBBY.code
		and MP.LOBBY.is_host
		and MP.LOBBY.config
		and MP.LOBBY.config.handy_allow_mp_extension
end
function Handy.EXT.Multiplayer.process_action_setLobbyEnabled(enabled)
	if not MP.LOBBY then
		return
	end

	MP.LOBBY.handy_mp_extension_all_players_enabled = not not enabled

	Handy.UI.rerender(true)
end
function Handy.EXT.Multiplayer.send_action_setEnabled(enabled)
	if not MP.LOBBY then
		return
	end

	MP.LOBBY.handy_mp_extension_local_player_enabled = enabled

	Client.send({
		action = enabled and "handyMPExtensionEnable" or "handyMPExtensionDisable",
	})

	Handy.UI.rerender(true)
end
function Handy.EXT.Multiplayer.set_local_enabled()
	Handy.EXT.Multiplayer.send_action_setEnabled(
		Handy.controls.is_module_enabled(Handy.cc.mp_extension_enabled_default_value)
	)
end

Handy.e_mitter.on("game_start", function()
	if not MP then
		return
	end

	Handy.EXT.Multiplayer.loaded = true

	Handy.load_file("src/extensions/Multiplayer/ui.lua")

	local reset_lobby_config = MP.reset_lobby_config
	function MP.reset_lobby_config(...)
		local r = reset_lobby_config(...)
		MP.LOBBY.handy_mp_extension_all_players_enabled = false
		MP.LOBBY.handy_mp_extension_local_player_enabled = false

		MP.LOBBY.config.handy_allow_mp_extension = true
		MP.LOBBY.config.handy_speed_multiplier_mode = 1
		MP.LOBBY.config.handy_animation_skip_mode = 1
		MP.LOBBY.config.handy_dangerous_actions_mode = 1

		if Handy.controls.is_module_enabled(Handy.cc.mp_extension_speed_multiplier_mode_default_value) then
			MP.LOBBY.config.handy_speed_multiplier_mode =
				Handy.cc.mp_extension_speed_multiplier_mode_default_value.value
		end
		if Handy.controls.is_module_enabled(Handy.cc.mp_extension_animation_skip_mode_default_value) then
			MP.LOBBY.config.handy_animation_skip_mode = Handy.cc.mp_extension_animation_skip_mode_default_value.value
		end
		if Handy.controls.is_module_enabled(Handy.cc.mp_extension_dangerous_actions_mode_default_value) then
			MP.LOBBY.config.handy_dangerous_actions_mode =
				Handy.cc.mp_extension_dangerous_actions_mode_default_value.value
		end
		return r
	end

	Handy.e_mitter.on("update", function()
		if not MP.LOBBY.code then
			MP.LOBBY.handy_mp_extension_local_player_enabled = nil
		end
	end)
end)
