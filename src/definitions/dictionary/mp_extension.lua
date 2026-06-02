Handy.dictionary.register({
	key = "mp_extension",
	order = 15,

	keywords = { "multiplayer extension mp lobby bmp" },
})

--

Handy.dictionary.register({
	key = "mp_extension_current_lobby",
	parent = "mp_extension",
	order = 1,

	keywords = { "current lobby" },
})

Handy.dictionary.register({
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
			Handy.EXT.Multiplayer.send_action_setEnabled()
		end,
	},
})
Handy.dictionary.register({
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
				local lobby = Handy.get_mp_lobby()
				if not lobby or not Handy.EXT.Multiplayer.can_change_lobby_settings() then
					return
				end
				(lobby.config or {}).handy_speed_multiplier_mode = v
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
				options = {
					"1x",
					"1.5x",
					"2x",
					"4x",
					"8x",
					"16x",
					"32x",
					"64x",
					"128x",
					"256x",
					"512x",
				},
				disabled = is_forced or not Handy.EXT.Multiplayer.can_change_lobby_settings(),
			}
		end,
		callback = function()
			MP.ACTIONS.lobby_options()
		end,
		colour = G.C.CHIPS,
	},
})
Handy.dictionary.register({
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
				local lobby = Handy.get_mp_lobby()
				if not lobby or not Handy.EXT.Multiplayer.can_change_lobby_settings() then
					return
				end
				(lobby.config or {}).handy_animation_skip_mode = v
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
				disabled = is_forced or not Handy.EXT.Multiplayer.can_change_lobby_settings(),
			}
		end,
		callback = function()
			MP.ACTIONS.lobby_options()
		end,
		colour = G.C.ORANGE,
	},
})
Handy.dictionary.register({
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
				local lobby = Handy.get_mp_lobby()
				if not lobby or not Handy.EXT.Multiplayer.can_change_lobby_settings() then
					return
				end
				(lobby.config or {}).handy_dangerous_actions_mode = v
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
				disabled = is_forced or not Handy.EXT.Multiplayer.can_change_lobby_settings(),
			}
		end,
		callback = function()
			MP.ACTIONS.lobby_options()
		end,
		colour = G.C.MULT,
	},
})

--

Handy.dictionary.register({
	key = "mp_extension_default_values",
	parent = "mp_extension",
	order = 2,

	keywords = { "default lobby values" },
})

Handy.dictionary.register({
	key = "mp_extension_enabled_default_value",
	parent = "mp_extension_default_values",
	order = 1,

	get_module = function(self)
		return Handy.cc.mp_extension_enabled_default_value
	end,

	checkbox = true,
})
Handy.dictionary.register({
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
				options = {
					"1x",
					"2x",
					"4x",
					"8x",
					"16x",
					"32x",
					"64x",
					"128x",
					"256x",
					"512x",
				},
			}
		end,
		colour = G.C.CHIPS,
	},
})
Handy.dictionary.register({
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
Handy.dictionary.register({
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
