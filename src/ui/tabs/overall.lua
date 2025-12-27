function Handy.UI.get_config_tab_overall()
	local logo = {
		n = G.UIT.R,
		config = { align = "cm", colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.2 },
		nodes = {
			{
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = {
					Handy.UI.CP.logo(0.8),
					Handy.UI.CP.r_sep(0.15),
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = Handy.L.variable("Handy_by", { Handy.version, "SleepyG11" }),
									scale = 0.28,
									colour = G.C.UI.TEXT_LIGHT,
								},
							},
						},
					},
					Handy.UI.CP.r_sep(0.3),
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							colour = Handy.cc.handy.enabled and G.C.CHIPS or G.C.MULT,
							r = 0.1,
							padding = 0.25,
							shadow = true,
							hover = true,
							button = "handy_overall_toggle_mod",
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									ref_table = {
										text = Handy.L.dictionary(
											Handy.cc.handy.enabled and "handy_mod_enabled" or "handy_mod_disabled"
										),
									},
									ref_value = "text",
									scale = 0.4,
									colour = G.C.UI.TEXT_LIGHT,
									shadow = true,
								},
							},
						},
					},
				},
			},
			{
				n = G.UIT.C,
				config = {},
				nodes = {
					Handy.L.description("Handy_Other", "overall_title", {
						vars = {},
						default_col = adjust_alpha(G.C.UI.TEXT_LIGHT, 0.9),
						scale = 0.25 / 0.32,
						minh = 0.25,
					}),
				},
			},
		},
	}

	local b = function(args)
		return {
			n = G.UIT.R,
			config = {
				align = "cm",
				colour = args.colour or G.C.CHIPS,
				r = 0.1,
				padding = 0.25,
				shadow = true,
				hover = true,
				button = args.button or "handy_noop",
				minw = 3,
				maxw = 3,
			},
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = Handy.L.tab(args.label),
						scale = 0.35,
						colour = G.C.UI.TEXT_LIGHT,
						shadow = true,
					},
				},
			},
		}
	end

	local buttons = {
		n = G.UIT.R,
		config = { align = "cm", padding = 0.15, r = 0.25, colour = { 0, 0, 0, 0.1 } },
		nodes = {
			{
				n = G.UIT.R,
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.C,
								config = { align = "cm" },
								nodes = {
									b({ label = "Appearance", button = "handy_appearance" }),
									Handy.UI.CP.r_sep(0.1),
									b({ label = "Vanilla keybinds", button = "handy_vanilla_keybinds" }),
								},
							},
							Handy.UI.CP.c_sep(0.1),
							{
								n = G.UIT.C,
								config = { align = "cm" },
								nodes = {
									b({
										label = "Fast hand selection",
										colour = G.C.DARK_EDITION,
										button = "handy_hand_selection",
									}),
									Handy.UI.CP.r_sep(0.1),
									b({ label = "Quick buy/sell/use", button = "handy_insta_actions" }),
								},
							},
							Handy.UI.CP.c_sep(0.1),
							{
								n = G.UIT.C,
								config = { align = "cm" },
								nodes = {
									b({ label = "Speed & Animations", button = "handy_speed_n_animations" }),
									Handy.UI.CP.r_sep(0.1),
									b({ label = "Highlight movement", button = "handy_move_highlight" }),
								},
							},
						},
					},
					Handy.UI.CP.r_sep(0.1),
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.C,
								nodes = {
									b({ label = "Misc", button = "handy_misc" }),
								},
							},
							Handy.UI.CP.c_sep(0.1),
							{
								n = G.UIT.C,
								nodes = {
									b({ label = "Dangerous", button = "handy_dangerous", colour = G.C.MULT }),
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
		config = { align = "cm", padding = 0.1, colour = { 0, 0, 0, 0.1 }, minh = 5, minw = 5, r = 0.25 },
		nodes = { logo, buttons },
	}
end
function Handy.UI.overall_tab_UIBox()
	return Handy.UI.get_config_tab_overall()
end

function Handy.UI.overall_tab()
	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			Handy.UI.overall_tab_UIBox(),
		},
	}
end

G.FUNCS.handy_overall_toggle_mod = function(e)
	Handy.cc.handy.enabled = not Handy.cc.handy.enabled
	Handy.config.request_save()

	if Handy.cc.handy.enabled then
		e.config.colour = G.C.CHIPS
		e.children[1].config.ref_table.text = Handy.L.dictionary("handy_mod_enabled")
	else
		e.config.colour = G.C.MULT
		e.children[1].config.ref_table.text = Handy.L.dictionary("handy_mod_disabled")
	end
end
