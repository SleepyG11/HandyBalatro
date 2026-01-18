function Handy.UI.mp_extension_page_definition()
	local status_colour = G.C.RED
	local status_key = "handy_mp_extension_status_disabled"
	local lobby = Handy.get_mp_lobby()
	if lobby then
		if not (lobby.config or {}).handy_mp_extension then
			status_key = "handy_mp_extension_status_not_initialized"
			status_colour = G.C.RED
		elseif not (lobby.config or {}).handy_allow_mp_extension then
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
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.mp_extension_enabled),
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
function Handy.UI.mp_extension_page_UIBox()
	return create_UIBox_generic_options({
		contents = {
			Handy.UI.mp_extension_page_definition(),
		},
		back_func = "handy_back_to_options",
	})
end
function Handy.UI.mp_extension_page_back_to_options_UIBox()
	return create_UIBox_generic_options({
		contents = {
			Handy.UI.mp_extension_page_definition(),
		},
		back_func = "options",
	})
end

function Handy.UI.mp_extension_page()
	local render = Handy.UI.mp_extension_page_UIBox
	if Handy.__mp_extension_back_to_options then
		render = Handy.UI.mp_extension_page_back_to_options_UIBox
	end
	Handy.UI.data.rerender_uibox_func = render
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = render(),
		is_handy_config = true,
	})
	Handy.UI.CHAR.rerender()
	Handy.UI.attach_side_panel()
	G.OVERLAY_MENU:recalculate()
end

G.FUNCS.handy_mp_extension = function(e)
	Handy.UI.data.opened = true
	Handy.UI.mp_extension_page()
end
G.FUNCS.handy_mp_extension_back_to_options = function(e)
	Handy.__mp_extension_back_to_options = true
	Handy.UI.data.opened = true
	Handy.UI.mp_extension_page()
	Handy.__mp_extension_back_to_options = nil
end
