function Handy.UI.CP.small_option_cycle(item)
	local module = item:get_module()
	local item_oc = item.option_cycle
	local oc_values = item_oc:get_values()

	local args = {
		w = 3.5,
		h = 0.4,
		text_scale = 0.425,
		label = nil,
		scale = 0.51,
		colour = item_oc.colour,
		options = oc_values.options,
		opt_callback = "handy_option_cycle",
		current_option = oc_values.current_option,
		focus_args = { nav = "wide" },
		ref_table = oc_values.ref_table or module,
		ref_value = oc_values.ref_value or "value",
		handy_callback = item_oc.callback,
	}
	args.current_option = oc_values.current_option or args.ref_table[args.ref_value]

	args.colour = args.colour or G.C.RED
	args.options = args.options or {
		"ERROR",
	}
	args.current_option = args.current_option or 1
	args.current_option_val = args.options[args.current_option]
	args.opt_callback = args.opt_callback or nil
	args.scale = args.scale or 1
	args.ref_table = args.ref_table or nil
	args.ref_value = args.ref_value or nil
	args.w = (args.w or 2.5) * args.scale
	args.h = (args.h or 0.8) * args.scale
	args.text_scale = (args.text_scale or 0.45) * args.scale
	args.l = "<"
	args.r = ">"
	args.focus_args = args.focus_args or {}
	args.focus_args.type = "cycle"
	args.focus_args.handy_cycle = true

	local disabled = #args.options < 2
	local pips = {}
	for i = 1, #args.options do
		pips[#pips + 1] = {
			n = G.UIT.B,
			config = {
				w = 0.125 * args.scale,
				h = 0.125 * args.scale,
				r = 0.05,
				id = "pip_" .. i,
				colour = args.current_option == i and G.C.WHITE or G.C.BLACK,
			},
		}
	end

	local choice_pips = {
		n = G.UIT.R,
		config = { align = "cm", padding = 0.025 * args.scale },
		nodes = pips,
	}

	local t = {
		n = G.UIT.C,
		config = {
			align = "cm",
			r = 0.1,
			colour = G.C.CLEAR,
			id = args.id and (not args.label and args.id or nil) or nil,
			focus_args = args.focus_args,
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					align = "cm",
					r = 0.05,
					minw = 0.6 * args.scale,
					hover = not disabled,
					colour = not disabled and args.colour or G.C.BLACK,
					shadow = not disabled,
					button = not disabled and "option_cycle" or nil,
					ref_table = args,
					ref_value = "l",
					focus_args = { type = "none" },
				},
				nodes = {
					{
						n = G.UIT.T,
						config = {
							ref_table = args,
							ref_value = "l",
							scale = args.text_scale,
							colour = not disabled and G.C.UI.TEXT_LIGHT or G.C.UI.TEXT_INACTIVE,
						},
					},
				},
			},
			Handy.UI.CP.c_sep(0.1),
			{
				n = G.UIT.C,
				config = {
					id = "cycle_main",
					align = "cm",
					minw = args.w,
					minh = args.h,
					r = 0.1,
					padding = 0.05,
					colour = args.colour,
					emboss = 0.05,
					hover = true,
					can_collide = true,
					on_demand_tooltip = args.on_demand_tooltip,
				},
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.O,
										config = {
											object = DynaText({
												string = { { ref_table = args, ref_value = "current_option_val" } },
												colours = { G.C.UI.TEXT_LIGHT },
												pop_in = 0,
												pop_in_rate = 8,
												reset_pop_in = true,
												shadow = true,
												float = true,
												silent = true,
												bump = true,
												scale = args.text_scale,
												non_recalc = true,
											}),
										},
									},
								},
							},
							{ n = G.UIT.R, config = { align = "cm", minh = 0.025 }, nodes = {} },
							not disabled and choice_pips or nil,
						},
					},
				},
			},
			Handy.UI.CP.c_sep(0.1),
			{
				n = G.UIT.C,
				config = {
					align = "cm",
					r = 0.05,
					minw = 0.6 * args.scale,
					maxw = 0.6 * args.scale,
					hover = not disabled,
					colour = not disabled and args.colour or G.C.BLACK,
					shadow = not disabled,
					button = not disabled and "option_cycle" or nil,
					ref_table = args,
					ref_value = "r",
					focus_args = { type = "none" },
				},
				nodes = {
					{
						n = G.UIT.T,
						config = {
							ref_table = args,
							ref_value = "r",
							scale = args.text_scale,
							colour = not disabled and G.C.UI.TEXT_LIGHT or G.C.UI.TEXT_INACTIVE,
						},
					},
				},
			},
		},
	}

	local res = {
		set = "Handy_ConfigDictionary",
		key = item.key,
	}
	if item.loc_vars and type(item.loc_vars) == "function" then
		local r = item:loc_vars()
		res.vars = r.vars or res.vars
		res.set = r.set or res.set
		res.key = r.key or res.key
	end

	return {
		n = G.UIT.R,
		config = { align = "cm", colour = G.C.CLEAR, padding = 0.0 },
		nodes = {
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					Handy.L.name(res.set, res.key, {
						align = "cm",
						default_col = G.C.UI.TEXT_LIGHT,
						minw = 2.5,
						maxw = 2.5,
						vars = res.vars or {},
						scale = 0.75,
					}),
				},
			},
			Handy.UI.CP.r_sep(0.1),
			{
				n = G.UIT.R,
				nodes = { t },
			},
		},
	}
end

--

function Handy.UI.attach_side_panel_content()
	return {
		n = G.UIT.C,
		config = { align = "cm" },
		nodes = {
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					Handy.UI.CP.small_option_cycle(Handy.D.dictionary.current_device),
				},
			},
			Handy.UI.CP.r_sep(0.1),
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					Handy.UI.CP.small_option_cycle(Handy.D.dictionary.keybinds_trigger_mode),
				},
			},
			Handy.UI.CP.r_sep(0.1),
			{
				n = G.UIT.R,
				config = { align = "cm", maxw = 2.8 },
				nodes = {
					Handy.UI.CP.c_sep(0.1),
					{
						n = G.UIT.C,
						config = { align = "cl" },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cr", maxw = 2 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = Handy.L.dictionary("handy_advanced_mode"),
											scale = 0.25,
											colour = G.C.UI.TEXT_LIGHT,
										},
									},
								},
							},
							Handy.UI.CP.r_sep(0.05),
							{
								n = G.UIT.R,
								config = { align = "cr", maxw = 2 },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = Handy.L.dictionary("handy_advanced_mode_description"),
											scale = 0.185,
											colour = adjust_alpha(G.C.UI.TEXT_LIGHT, 0.7),
										},
									},
								},
							},
						},
					},
					{
						n = G.UIT.C,
						config = { align = "cr" },
						nodes = {
							create_toggle({
								scale = 0.5,
								ref_table = Handy.cc.advanced_mode,
								ref_value = "enabled",
								label = "",
								w = 0,
								label_scale = 0,
								callback = function()
									Handy.config.request_save()
									Handy.UI.rerender(true)
								end,
							}),
						},
					},
				},
			},
		},
	}
end
function Handy.UI.attach_side_panel()
	if not G.OVERLAY_MENU then
		return
	end
	local p, p_draw_parent
	pcall(function()
		p = G.OVERLAY_MENU.UIRoot.children[1]
		p_draw_parent = p.parent
	end)
	if not p or not p_draw_parent then
		return
	end

	local box = UIBox({
		definition = {
			n = G.UIT.ROOT,
			config = {
				align = "cm",
				r = 0.3,
				padding = 0.07,
				colour = G.C.JOKER_GREY,
				emboss = 0.1,
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						align = "cm",
						minh = 2.5,
						r = 0.2,
						padding = 0.1,
						minw = 2.85,
						colour = G.C.L_BLACK,
					},

					nodes = { Handy.UI.CP.c_sep(1), Handy.UI.attach_side_panel_content(), Handy.UI.CP.c_sep(0) },
				},
			},
		},
		config = {
			parent = p,
			major = p,
			align = "bri",
			offset = { x = 3, y = -0.2 },
		},
	})
	table.insert(p_draw_parent.children, 1, box)
end
