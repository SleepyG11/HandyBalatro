local mp_pre_release = {}
Handy.MP.current = mp_pre_release

-- Internal functions

function mp_pre_release.can_change_lobby_settings()
	return G.STAGE == G.STAGES.MAIN_MENU
		and MP
		and MP.LOBBY
		and MP.LOBBY.code
		and MP.LOBBY.is_host
		and MP.LOBBY.config
		and MP.LOBBY.config.handy_allow_mp_extension
end
function mp_pre_release.process_action_setLobbyEnabled(enabled)
	if not MP.LOBBY then
		return
	end

	MP.LOBBY.handy_mp_extension_all_players_enabled = not not enabled

	Handy.UI.rerender(true)
end
function mp_pre_release.send_action_setEnabled()
	if not MP.LOBBY then
		return
	end

	local enabled = MP.LOBBY.handy_mp_extension_local_player_enabled

	Client.send({
		action = enabled and "handyMPExtensionEnable" or "handyMPExtensionDisable",
	})

	Handy.UI.rerender(true)
end
function mp_pre_release.set_local_enabled()
	MP.LOBBY.handy_mp_extension_local_player_enabled =
		Handy.controls.is_module_enabled(Handy.cc.mp_extension_enabled_default_value)
	mp_pre_release.send_action_setEnabled()
end

function mp_pre_release.lobby_tab_UIBox()
	return Handy.UI.mp_extension_page_definition()
end
function mp_pre_release.lobby_tab()
	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			mp_pre_release.lobby_tab_UIBox(),
		},
	}
end

-- Hooks

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
		MP.LOBBY.config.handy_speed_multiplier_mode = Handy.cc.mp_extension_speed_multiplier_mode_default_value.value
	end
	if Handy.controls.is_module_enabled(Handy.cc.mp_extension_animation_skip_mode_default_value) then
		MP.LOBBY.config.handy_animation_skip_mode = Handy.cc.mp_extension_animation_skip_mode_default_value.value
	end
	if Handy.controls.is_module_enabled(Handy.cc.mp_extension_dangerous_actions_mode_default_value) then
		MP.LOBBY.config.handy_dangerous_actions_mode = Handy.cc.mp_extension_dangerous_actions_mode_default_value.value
	end
	return r
end

G.FUNCS.handy_set_mp_option_cycle = function(arg)
	arg.cycle_config.handy_ref_table[arg.cycle_config.handy_ref_value] = arg.to_key
	send_lobby_options()
end

if MP.register_action then
	MP.register_action("handyMPExtensionLobbyEnabled", function(parsedAction)
		mp_pre_release.process_action_setLobbyEnabled(parsedAction.enabled)
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
				return mp_pre_release.lobby_tab()
			end,
		})
	end
	return old_create_tabs(args, ...)
end

-- Api

function mp_pre_release.is_in_lobby()
	return not not (MP.LOBBY and MP.LOBBY.code)
end

function mp_pre_release.get_lobby()
	return mp_pre_release.is_in_lobby() and MP.LOBBY or nil
end
function mp_pre_release.get_config(lobby)
	return lobby and lobby.config
end
function mp_pre_release.get_game_state(lobby)
	return lobby and MP.GAME
end

function mp_pre_release.get_current()
	local lobby = mp_pre_release.get_lobby()
	return lobby, mp_pre_release.get_config(lobby), mp_pre_release.get_game_state(lobby)
end

function mp_pre_release.is_extension_active()
	local lobby, config, state = mp_pre_release.get_current()
	return lobby
			and config
			and config.handy_mp_extension
			and config.handy_allow_mp_extension
			and lobby.handy_mp_extension_all_players_enabled
		or false
end

-- Events

Handy.e_mitter.on("update", function()
	if not MP.LOBBY.code then
		MP.LOBBY.handy_mp_extension_local_player_enabled = nil
	end
end)

-- Dictionary

Handy.API.Dictionary({
	key = "mp_extension",
	order = 15,

	keywords = { "multiplayer extension mp lobby bmp" },
})

Handy.API.Dictionary({
	key = "mp_extension_enabled",
	parent = "mp_extension_current_lobby",
	order = 1,

	loc_vars = function()
		return {
			vars = {
				Handy.L.brackets(Handy.L.name_text("Handy_ConfigDictionary", "speed_multiplier")),
				Handy.L.brackets(Handy.L.name_text("Handy_ConfigDictionary", "animation_skip")),
			},
		}
	end,
	get_module = function(self)
		return setmetatable({}, {
			__index = function(t, k)
				local lobby = Handy.get_mp_lobby()
				return lobby and lobby.handy_mp_extension_local_player_enabled
			end,
			__newindex = function(t, k, v)
				local lobby = Handy.get_mp_lobby()
				if not lobby or G.STAGE == G.STAGES.RUN then
					return
				end
				lobby.handy_mp_extension_local_player_enabled = v
			end,
		})
	end,

	checkbox = {
		get_values = function()
			return {
				disabled = not Handy.b_is_in_multiplayer() or G.STAGE ~= G.STAGES.MAIN_MENU,
			}
		end,
		callback = function()
			Handy.mp_extension.send_action_setEnabled()
		end,
	},
})
Handy.API.Dictionary({
	key = "mp_extension_speed_multiplier_mode",
	parent = "mp_extension_current_lobby",
	order = 2,

	get_module = function()
		return setmetatable({}, {
			__index = function(t, k)
				local r = Handy.get_mp_lobby_config_value("handy_speed_multiplier_mode", {
					default_value = 1,
					force = true,
					bypass_active = G.STAGE == G.STAGES.MAIN_MENU,
				})
				return r
			end,
			__newindex = function(t, k, v)
				local lobby, config = Handy.get_mp_lobby()
				if not config or not Handy.mp_extension.can_change_lobby_settings() then
					return
				end
				config.handy_speed_multiplier_mode = v
			end,
		})
	end,

	option_cycle = {
		get_values = function()
			local _, is_forced = Handy.get_mp_lobby_config_value("handy_speed_multiplier_mode", {
				default_value = 1,
				force = true,
			})
			return {
				options = Handy.utils.table_shallow_copy(Handy.speed_multiplier.selectable_options),
				disabled = is_forced or not Handy.mp_extension.can_change_lobby_settings(),
			}
		end,
		callback = function()
			MP.ACTIONS.lobby_options()
		end,
		colour = G.C.CHIPS,
	},
})
Handy.API.Dictionary({
	key = "mp_extension_animation_skip_mode",
	parent = "mp_extension_current_lobby",
	order = 3,

	get_module = function()
		return setmetatable({}, {
			__index = function(t, k)
				local r = Handy.get_mp_lobby_config_value("handy_animation_skip_mode", {
					force = true,
					default_value = 1,
					bypass_active = G.STAGE == G.STAGES.MAIN_MENU,
				})
				return r
			end,
			__newindex = function(t, k, v)
				local lobby, config = Handy.get_mp_lobby()
				if not config or not Handy.mp_extension.can_change_lobby_settings() then
					return
				end
				config.handy_animation_skip_mode = v
			end,
		})
	end,

	option_cycle = {
		get_values = function()
			local _, is_forced = Handy.get_mp_lobby_config_value("handy_animation_skip_mode", {
				default_value = 1,
				force = true,
			})
			return {
				options = {
					Handy.L.dictionary("handy_animation_skip_levels", 1),
					Handy.L.dictionary("handy_animation_skip_levels", 2),
					Handy.L.dictionary("handy_animation_skip_levels", 3),
					Handy.L.dictionary("handy_animation_skip_levels", 4),
				},
				disabled = is_forced or not Handy.mp_extension.can_change_lobby_settings(),
			}
		end,
		callback = function()
			MP.ACTIONS.lobby_options()
		end,
		colour = G.C.ORANGE,
	},
})
Handy.API.Dictionary({
	key = "mp_extension_dangerous_actions_mode",
	parent = "mp_extension_current_lobby",
	order = 4,

	get_module = function()
		return setmetatable({}, {
			__index = function(t, k)
				local r = Handy.get_mp_lobby_config_value("handy_dangerous_actions_mode", {
					force = true,
					default_value = 1,
					bypass_active = G.STAGE == G.STAGES.MAIN_MENU,
				})
				return r
			end,
			__newindex = function(t, k, v)
				local lobby, config = Handy.get_mp_lobby()
				if not config or not Handy.mp_extension.can_change_lobby_settings() then
					return
				end
				config.handy_dangerous_actions_mode = v
			end,
		})
	end,

	option_cycle = {
		get_values = function()
			local _, is_forced = Handy.get_mp_lobby_config_value("handy_dangerous_actions_mode", {
				default_value = 1,
				force = true,
			})
			return {
				options = {
					Handy.L.dictionary("handy_mp_dangerous_actions_modes", 1),
					Handy.L.dictionary("handy_mp_dangerous_actions_modes", 2),
					-- Handy.L.dictionary("handy_mp_dangerous_actions_modes", 3),
				},
				disabled = is_forced or not Handy.mp_extension.can_change_lobby_settings(),
			}
		end,
		callback = function()
			MP.ACTIONS.lobby_options()
		end,
		colour = G.C.MULT,
	},
})

Handy.API.Dictionary({
	key = "mp_extension_default_values",
	parent = "mp_extension",
	order = 2,

	keywords = { "default lobby values" },
})
Handy.API.Dictionary({
	key = "mp_extension_speed_multiplier_mode_default_value",
	parent = "mp_extension_default_values",
	order = 2,

	get_module = function()
		return Handy.cc.mp_extension_speed_multiplier_mode_default_value
	end,

	checkbox = true,
	option_cycle = {
		get_values = function()
			return {
				options = Handy.utils.table_shallow_copy(Handy.speed_multiplier.selectable_options),
			}
		end,
		colour = G.C.CHIPS,
	},
})
Handy.API.Dictionary({
	key = "mp_extension_animation_skip_mode_default_value",
	parent = "mp_extension_default_values",
	order = 3,

	get_module = function()
		return Handy.cc.mp_extension_animation_skip_mode_default_value
	end,

	checkbox = true,
	option_cycle = {
		get_values = function()
			return {
				options = {
					Handy.L.dictionary("handy_animation_skip_levels", 1),
					Handy.L.dictionary("handy_animation_skip_levels", 2),
					Handy.L.dictionary("handy_animation_skip_levels", 3),
					Handy.L.dictionary("handy_animation_skip_levels", 4),
				},
			}
		end,
		colour = G.C.ORANGE,
	},
})
Handy.API.Dictionary({
	key = "mp_extension_dangerous_actions_mode_default_value",
	parent = "mp_extension_default_values",
	order = 4,

	get_module = function()
		return Handy.cc.mp_extension_dangerous_actions_mode_default_value
	end,

	checkbox = true,
	option_cycle = {
		get_values = function()
			return {
				options = {
					Handy.L.dictionary("handy_mp_dangerous_actions_modes", 1),
					Handy.L.dictionary("handy_mp_dangerous_actions_modes", 2),
					-- Handy.L.dictionary("handy_mp_dangerous_actions_modes", 3),
				},
			}
		end,
		colour = G.C.MULT,
	},
})

-- UI

function Handy.UI.mp_extension_page_definition()
	local status_colour = G.C.RED
	local status_key = "handy_mp_extension_status_disabled"
	local lobby, config = Handy.get_mp_lobby()
	if lobby and config then
		if not config.handy_mp_extension then
			status_key = "handy_mp_extension_status_not_initialized"
			status_colour = G.C.RED
		elseif not config.handy_allow_mp_extension then
			status_key = "handy_mp_extension_status_disabled_by_ruleset"
			status_colour = G.C.RED
		elseif lobby.handy_mp_extension_all_players_enabled then
			status_key = "handy_mp_extension_status_enabled"
			status_colour = G.C.CHIPS
		elseif lobby.handy_mp_extension_local_player_enabled then
			status_key = "handy_mp_extension_status_disabled_by_other_player"
			status_colour = mix_colours(G.C.RED, G.C.ORANGE, 0.75)
		else
			status_key = "handy_mp_extension_status_disabled"
			status_colour = G.C.RED
		end
	end

	local content = {
		n = G.UIT.R,
		config = { align = "cm", colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.1 },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					colour = adjust_alpha(HEX("000000"), 0.1),
					align = "cm",
					r = 0.5,
				},
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm", r = 0.1 },
						nodes = {
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.mp_extension, { bg = true }),
							lobby and {
								n = G.UIT.R,
								config = {
									colour = adjust_alpha(status_colour, 0.2),
									align = "cm",
									r = 0.15,
									padding = 0.15,
								},
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = Handy.L.dictionary(status_key),
											scale = 0.35,
											colour = G.C.UI.TEXT_LIGHT,
											shadow = true,
										},
									},
								},
							} or Handy.UI.CP.r_sep(0.1),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.mp_extension_current_lobby, { bg = true }),
							Handy.UI.CP.dictionary_item(
								Handy.D.dictionary.mp_extension_enabled,
								{ colour = Handy.UI.C.DARK_EDITION_WEAK }
							),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.mp_extension_speed_multiplier_mode),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.mp_extension_animation_skip_mode),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.mp_extension_dangerous_actions_mode),
							Handy.UI.CP.r_sep(0.1),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.mp_extension_default_values, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.mp_extension_enabled_default_value),
							Handy.UI.CP.dictionary_item(
								Handy.D.dictionary.mp_extension_speed_multiplier_mode_default_value
							),
							Handy.UI.CP.dictionary_item(
								Handy.D.dictionary.mp_extension_animation_skip_mode_default_value
							),
							Handy.UI.CP.dictionary_item(
								Handy.D.dictionary.mp_extension_dangerous_actions_mode_default_value
							),
						},
					},
				},
			},
		},
	}

	return {
		n = G.UIT.C,
		nodes = {
			content,
		},
	}
end
