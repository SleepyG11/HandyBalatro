function Handy.UI.misc_page_definition()
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
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.gamepad, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.controller_sensitivity),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.swap_controller_cursor_stick),
							Handy.UI.CP.r_sep(0.1),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.prevent_if_debugplus, { bg = true }),
							Handy.UI.CP.r_sep(0.1),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.misc, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.misc_quick_restart),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.misc_start_fantoms_preview),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.misc_save_run),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.misc_crash, { bg = true }),
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
function Handy.UI.misc_page_UIBox()
	return create_UIBox_generic_options({
		contents = {
			Handy.UI.misc_page_definition(),
		},
		back_func = "handy_back_to_options",
	})
end

function Handy.UI.misc_page()
	Handy.UI.data.rerender_uibox_func = Handy.UI.misc_page_UIBox
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = Handy.UI.misc_page_UIBox(),
		is_handy_config = true,
	})
	Handy.UI.CHAR.rerender()
	Handy.UI.attach_side_panel()
	G.OVERLAY_MENU:recalculate()
end

G.FUNCS.handy_misc = function(e)
	Handy.UI.misc_page()
end
