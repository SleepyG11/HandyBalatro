function Handy.UI.mp_extension_page_definition()
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
							{
								n = G.UIT.R,
								config = {
									align = "cm",
									r = 0.15,
									padding = 0.15,
									colour = { 0, 0, 0, 0.1 },
								},
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = "Install Multiplayer too see settings related to it",
											scale = 0.35,
											colour = G.C.UI.TEXT_LIGHT,
											shadow = true,
										},
									},
								},
							},
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
	if Handy.ARGS.mp_extension_back_to_options then
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
	Handy.ARGS.mp_extension_back_to_options = true
	Handy.UI.data.opened = true
	Handy.UI.mp_extension_page()
	Handy.ARGS.mp_extension_back_to_options = nil
end
