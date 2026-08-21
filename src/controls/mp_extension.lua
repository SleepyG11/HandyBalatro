Handy.mp_extension = {
	loaded = false,
}

function Handy.mp_extension.can_change_lobby_settings()
	return G.STAGE == G.STAGES.MAIN_MENU
		and MP
		and MP.LOBBY
		and MP.LOBBY.code
		and MP.LOBBY.is_host
		and MP.LOBBY.config
		and MP.LOBBY.config.handy_allow_mp_extension
end
function Handy.mp_extension.process_action_setLobbyEnabled(enabled)
	if not MP.LOBBY then
		return
	end

	MP.LOBBY.handy_mp_extension_all_players_enabled = not not enabled

	Handy.UI.rerender(true)
end
function Handy.mp_extension.send_action_setEnabled()
	if not MP.LOBBY then
		return
	end

	local enabled = MP.LOBBY.handy_mp_extension_local_player_enabled

	Client.send({
		action = enabled and "handyMPExtensionEnable" or "handyMPExtensionDisable",
	})

	Handy.UI.rerender(true)
end
function Handy.mp_extension.set_local_enabled()
	MP.LOBBY.handy_mp_extension_local_player_enabled =
		Handy.controls.is_module_enabled(Handy.cc.mp_extension_enabled_default_value)
	Handy.mp_extension.send_action_setEnabled()
end

function Handy.mp_extension.lobby_tab_UIBox()
	return Handy.UI.mp_extension_page_definition()
end
function Handy.mp_extension.lobby_tab()
	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			Handy.mp_extension.lobby_tab_UIBox(),
		},
	}
end

function Handy.mp_extension.init()
	local reset_lobby_config = MP.reset_lobby_config
	function MP.reset_lobby_config(...)
		local r = reset_lobby_config(...)
		MP.LOBBY.handy_mp_extension_all_players_enabled = false
		MP.LOBBY.handy_mp_extension_local_player_enabled = false

		-- TODO: make this system more versatile
		MP.LOBBY.config.handy_mp_extension = true
		MP.LOBBY.config.handy_allow_mp_extension = true

		MP.LOBBY.config.handy_speed_multiplier_mode = 1
		MP.LOBBY.config.handy_speed_multiplier_mode_force = nil
		MP.LOBBY.config.handy_animation_skip_mode = 1
		MP.LOBBY.config.handy_animation_skip_mode_force = nil
		MP.LOBBY.config.handy_dangerous_actions_mode = 1
		MP.LOBBY.config.handy_dangerous_actions_mode_force = nil

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

	G.FUNCS.handy_set_mp_option_cycle = function(arg)
		arg.cycle_config.handy_ref_table[arg.cycle_config.handy_ref_value] = arg.to_key
		send_lobby_options()
	end

	if MP.register_action then
		MP.register_action("handyMPExtensionLobbyEnabled", function(parsedAction)
			Handy.mp_extension.process_action_setLobbyEnabled(parsedAction.enabled)
		end)
	end

	local old_game_over = create_UIBox_game_over
	function create_UIBox_game_over(...)
		local ret = old_game_over(...)
		if MP and MP.LOBBY and MP.LOBBY.code then
			Handy.UI.CHAR.show_me_as_game_over()
		end
		return ret
	end

	local old_you_win = create_UIBox_win
	function create_UIBox_win(...)
		local ret = old_you_win(...)
		if MP and MP.LOBBY and MP.LOBBY.code then
			Handy.UI.CHAR.show_me_as_game_win()
		end
		return ret
	end

	-- TODO: decide what to do with this one: rerendr somehow or leave it as rest of MP lobby options behave like this basically
	local old_lobby_options = G.UIDEF.create_UIBox_lobby_options
	function G.UIDEF.create_UIBox_lobby_options(...)
		Handy.ARGS.insert_mp_lobby_tab = true
		local r = old_lobby_options(...)
		Handy.ARGS.insert_mp_lobby_tab = nil
		return r
	end

	local old_lobby_info = MP.UI.lobby_info
	function MP.UI.lobby_info(...)
		Handy.ARGS.insert_mp_lobby_tab = true
		local r = old_lobby_info(...)
		Handy.ARGS.insert_mp_lobby_tab = nil
		return r
	end

	local old_create_tabs = create_tabs
	function create_tabs(args, ...)
		if Handy.ARGS.insert_mp_lobby_tab then
			Handy.ARGS.insert_mp_lobby_tab = nil
			table.insert(args.tabs, {
				label = "Handy",
				tab_definition_function = function()
					return Handy.mp_extension.lobby_tab()
				end,
			})
		end
		return old_create_tabs(args, ...)
	end

	-- Load states

	function Handy.is_mp_lobby_extension_active()
		local lobby, config = Handy.get_mp_lobby()
		return lobby
				and config
				and config.handy_mp_extension
				and config.handy_allow_mp_extension
				and lobby.handy_mp_extension_all_players_enabled
			or false
	end
	Handy.b_is_mp_lobby_extension_active =
		Handy.buffered("is_mp_lobby_extension_active", Handy.is_mp_lobby_extension_active)

	function Handy.is_in_multiplayer()
		return not not (MP and MP.LOBBY and MP.LOBBY.code)
	end
	Handy.b_is_in_multiplayer = Handy.buffered("is_in_multiplayer", Handy.is_in_multiplayer)

	function Handy.get_mp_lobby()
		local lobby = Handy.b_is_in_multiplayer() and MP.LOBBY or nil
		if not lobby or not lobby.config then
			return nil, nil
		end
		return lobby, lobby.config
	end

	function Handy.disabled_in_mp_check(func, args)
		local lobby, config = Handy.get_mp_lobby()
		if not config then
			return false
		end

		args = args or Handy.ARGS.global_empty_table

		if not args.bypass_active and not Handy.b_is_mp_lobby_extension_active() then
			return true
		end
		if type(func) ~= "function" then
			return true
		end
		return func(lobby, config)
	end

	function Handy.get_mp_lobby_config_value(ref_value, args)
		local lobby, config = Handy.get_mp_lobby()

		-- no lobby - no value
		if not config then
			return args and args.default_value, false
		end

		args = args or Handy.ARGS.global_empty_table

		-- not enabled - no value
		if not args.bypass_active and not Handy.b_is_mp_lobby_extension_active() then
			return args.default_value, false
		end
		-- have forced value - use it
		if args.force and config[ref_value .. "_force"] then
			return config[ref_value .. "_force"], true
		end
		-- return actual value
		return config[ref_value] or default_value, false
	end
end

Handy.e_mitter.on("game_start", function()
	if not MP then
		return
	end

	-- Loading MP pre-1.0
	Handy.mp_extension.init()
	Handy.mp_extension.loaded = true

	Handy.e_mitter.on("update", function()
		if not MP.LOBBY.code then
			MP.LOBBY.handy_mp_extension_local_player_enabled = nil
		end
	end)
end)

Handy.e_mitter.on("game_start", function()
	if not MPAPI then
		return
	end

	-- Loading MP post-1.0
	if MPAPI.create_account_avatar then
		local old_create_avatar = MPAPI.create_account_avatar
		function MPAPI.create_account_avatar(...)
			local avatar_card = old_create_avatar(...)
			if avatar_card and Handy.me.is_mp_user(MPAPI.connection_state.player_id) then
				Handy.me.set_joker_center(avatar_card)
			end
			return avatar_card
		end
	end
end)
