function Handy.EXT.UI.mp_lobby_tab_UIBox()
	local speed_options = {
		Handy.L.dictionary("handy_disabled"),
		"x2",
		"x4",
		"x8",
		"x16",
		"x32",
		"x64",
		"x128",
		"x256",
		"x512",
	}
	local animation_options = Handy.utils.table_shallow_copy(Handy.L.dictionary("handy_animation_skip_levels"))
	table.remove(animation_options, #animation_options)

	return {
		n = G.UIT.C,
		config = {
			emboss = 0.05,
			minh = 6,
			r = 0.1,
			minw = 10,
			align = "tm",
			padding = 0.2,
			colour = G.C.BLACK,
		},
		nodes = {
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					MP.UI.Disableable_Option_Cycle({
						enabled_ref_table = MP.LOBBY,
						enabled_ref_value = "is_host",
						label = Handy.L.dictionary("handy_mp_speed_multiplier_mode"),
						options = speed_options,
						scale = 0.85,
						w = 5,
						current_option = MP.LOBBY.config.handy_speed_multiplier_mode,
						colour = G.C.CHIPS,
						focus_args = { nav = "wide" },
						opt_callback = "handy_set_mp_option_cycle",
						handy_ref_table = MP.LOBBY.config,
						handy_ref_value = "handy_speed_multiplier_mode",
					}),
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					MP.UI.Disableable_Option_Cycle({
						enabled_ref_table = MP.LOBBY,
						enabled_ref_value = "is_host",
						label = Handy.L.dictionary("handy_mp_animation_skip_mode"),
						options = animation_options,
						scale = 0.85,
						w = 5,
						current_option = MP.LOBBY.config.handy_animation_skip_mode,
						colour = G.C.ORANGE,
						focus_args = { nav = "wide" },
						opt_callback = "handy_set_mp_option_cycle",
						handy_ref_table = MP.LOBBY.config,
						handy_ref_value = "handy_animation_skip_mode",
					}),
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					MP.UI.Disableable_Option_Cycle({
						enabled_ref_table = MP.LOBBY,
						enabled_ref_value = "is_host",
						label = "Dangerous Actions: lobby mode",
						options = Handy.L.dictionary("handy_mp_dangerous_actions_modes"),
						scale = 0.85,
						w = 5,
						current_option = MP.LOBBY.config.handy_dangerous_actions_mode,
						colour = G.C.MULT,
						focus_args = { nav = "wide" },
						opt_callback = "handy_set_mp_option_cycle",
						handy_ref_table = MP.LOBBY.config,
						handy_ref_value = "handy_dangerous_actions_mode",
					}),
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					Handy.L.description("Handy_Other", "mp_lobby_require_all_hint", {
						default_col = adjust_alpha(G.C.UI.TEXT_LIGHT, 0.8),
						align = "cm",
					}),
				},
			},
		},
	}
end
function Handy.EXT.UI.mp_lobby_tab()
	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			Handy.EXT.UI.mp_lobby_tab_UIBox(),
		},
	}
end

--

local old_lobby_options = G.UIDEF.create_UIBox_lobby_options
function G.UIDEF.create_UIBox_lobby_options(...)
	Handy.__insert_mp_lobby_tab = true
	local r = old_lobby_options(...)
	Handy.__insert_mp_lobby_tab = nil
	return r
end

local old_create_tabs = create_tabs
function create_tabs(args, ...)
	if Handy.__insert_mp_lobby_tab then
		Handy.__insert_mp_lobby_tab = nil
		if MP.LOBBY.config.handy_allow_mp_extension then
			table.insert(args.tabs, {
				label = "Handy",
				tab_definition_function = function()
					return Handy.EXT.UI.mp_lobby_tab()
				end,
			})
		end
	end
	return old_create_tabs(args, ...)
end

--

G.FUNCS.handy_set_mp_option_cycle = function(arg)
	arg.cycle_config.handy_ref_table[arg.cycle_config.handy_ref_value] = arg.to_key
	send_lobby_options()
end
