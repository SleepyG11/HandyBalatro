Handy.e_mitter.on("game_start", function()
	if not MP then
		return
	end
	Handy.EXT.Multiplayer = {
		loaded = true,
	}
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
		return r
	end
end)
