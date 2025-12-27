function Handy.UI.appearance_page_definition()
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
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.appearance, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.notifications_level),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.hide_options_button),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.speed_multiplier_settings_toggle),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.animation_skip_settings_toggle),
							Handy.UI.CP.r_sep(0.1),
							{
								n = G.UIT.R,
								config = { align = "cm", padding = 1, colour = { 0, 0, 0, 0.1 }, r = 0.1 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = "Some stuff will be here",
											scale = 0.5,
											colour = G.C.UI.TEXT_LIGHT,
										},
									},
								},
							},
							-- TODO: me
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
function Handy.UI.appearance_page_UIBox()
	return create_UIBox_generic_options({
		contents = {
			Handy.UI.appearance_page_definition(),
		},
		back_func = "handy_back_to_options",
	})
end

function Handy.UI.appearance_page()
	Handy.UI.data.rerender_uibox_func = Handy.UI.appearance_page_UIBox
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = Handy.UI.appearance_page_UIBox(),
		is_handy_config = true,
	})
	Handy.UI.CHAR.rerender()
	Handy.UI.attach_side_panel()
	G.OVERLAY_MENU:recalculate()
end

G.FUNCS.handy_appearance = function(e)
	Handy.UI.appearance_page()
end
