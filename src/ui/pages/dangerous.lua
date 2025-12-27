function Handy.UI.dangerous_page_definition()
	local content = {
		n = G.UIT.R,
		config = { align = "cm", colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.1 },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					colour = adjust_alpha(G.C.MULT, 0.1),
					align = "cm",
					r = 0.5,
				},
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm", r = 0.1 },
						nodes = {
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.dangerous_actions, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.dangerous_actions_sell_one),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.dangerous_actions_remove_one),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.dangerous_actions_sell_all_same),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.dangerous_actions_remove_all_same),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.dangerous_actions_sell_all),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.dangerous_actions_remove_all),
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
			Handy.UI.CP.r_sep(0.3),
			{
				n = G.UIT.R,
				config = {
					align = "cm",
					padding = 0.5,
					colour = { 0, 0, 0, 0.1 },
					r = 0.1,
				},
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = "Stuff to test controls on will be here",
							scale = 0.5,
							colour = G.C.UI.TEXT_LIGHT,
						},
					},
				},
			},
		},
	}
end
function Handy.UI.dangerous_page_UIBox()
	return create_UIBox_generic_options({
		contents = {
			Handy.UI.dangerous_page_definition(),
		},
		back_func = "handy_back_to_options",
	})
end

function Handy.UI.dangerous_page()
	Handy.UI.data.rerender_uibox_func = Handy.UI.dangerous_page_UIBox
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = Handy.UI.dangerous_page_UIBox(),
		is_handy_config = true,
	})
	Handy.UI.CHAR.rerender()
	Handy.UI.attach_side_panel()
	G.OVERLAY_MENU:recalculate()
end

G.FUNCS.handy_dangerous = function(e)
	Handy.UI.dangerous_page()
end
