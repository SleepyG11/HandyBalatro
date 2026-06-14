function Handy.UI.CP.module_keybind_button(module, key, options, additional_options)
	options = Handy.utils.table_shallow_merge({}, additional_options or {}, options or {})

	local dangerous = options.dangerous
	local rerender = Handy.UI.is_in_search_result_page or options.rerender
	local disabled = options.disabled
	local only_holdable = options.only_holdable
	local only_safe = options.only_safe
	local allow_multiple = options.allow_multiple

	local can_bind_multiple = not not allow_multiple
	-- or (allow_multiple == "advanced" and Handy.cc.advanced_mode.enabled)

	local colour = (disabled and G.C.UI.BACKGROUND_INACTIVE) or (dangerous and G.C.MULT) or G.C.CHIPS
	local button_text = Handy.L.keys(module[key])
	local is_none = button_text == Handy.L.keys()

	return {
		n = G.UIT.C,
		config = {
			colour = colour,
			minw = 3.3725,
			maxw = 3.3725,
			minh = 0.35,
			maxh = 0.35,
			padding = 0,
			r = 0.075,
			hover = true,
			shadow = true,
			align = "cm",
			ref_table = {
				module = module,
				key = key,
				rerender = rerender,
				only_holdable = only_holdable,
				only_safe = only_safe,
				allow_multiple = allow_multiple,
			},
			focus_args = options.focus_args,
			group = options.group,
			button = disabled and "handy_noop" or "handy_start_binding",
		},
		nodes = {
			{
				n = G.UIT.T,
				config = {
					text = button_text,
					scale = 0.25,
					colour = is_none and Handy.UI.C.NONE_KEYBIND or G.C.UI.TEXT_LIGHT,
				},
			},
		},
	}
end
G.FUNCS.handy_start_binding = function(e)
	Handy.controller.binding.start_binding(e.config.ref_table, e)
end
---

function Handy.UI.CP.settings_simple_option_cycle(item)
	local item_oc = item.simple_option_cycle
	local oc_values = item_oc:get_values()

	local args = {
		w = 6,
		label = nil,
		scale = 0.8,
		focus_args = { nav = "wide" },
		colour = item_oc.colour,
		ref_table = oc_values.ref_table,
		ref_value = oc_values.ref_value,
		prefix = oc_values.prefix,
	}

	args.colour = args.colour or G.C.RED
	args.scale = args.scale or 1
	args.w = (args.w or 2.5) * args.scale
	args.h = (args.h or 0.67) * args.scale
	args.text_scale = (args.text_scale or 0.4) * args.scale
	args.l = "<"
	args.r = ">"
	args.focus_args = args.focus_args or {}
	args.focus_args.type = "cycle"

	local disabled = false

	local callbacks = {
		l = item_oc.left_callback or function() end,
		r = item_oc.right_callback or function() end,
	}

	local result = {
		n = G.UIT.R,
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
					r = 0.1,
					minw = 0.6 * args.scale,
					hover = not disabled,
					colour = not disabled and args.colour or G.C.BLACK,
					shadow = not disabled,
					button = not disabled and "handy_option_cycle_simple" or nil,
					ref_table = callbacks,
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
					padding = 0.075,
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
												string = {
													{
														ref_table = args.ref_table,
														ref_value = args.ref_value,
														prefix = args.prefix,
													},
												},
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
						},
					},
				},
			},
			Handy.UI.CP.c_sep(0.1),
			{
				n = G.UIT.C,
				config = {
					align = "cm",
					r = 0.1,
					minw = 0.6 * args.scale,
					hover = not disabled,
					colour = not disabled and args.colour or G.C.BLACK,
					shadow = not disabled,
					button = not disabled and "handy_option_cycle_simple" or nil,
					ref_table = callbacks,
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

	return {
		n = G.UIT.R,
		config = { padding = 0.025, align = "cm" },
		nodes = { result },
	}
end
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
	args.focus_args.type = "handy"
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

	local res = Handy.L.loc_vars(item, {
		set = "Handy_ConfigDictionary",
		key = item.key,
	})

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

---

G.FUNCS.handy_option_cycle_simple = function(e)
	local callback = e.config.ref_table[e.config.ref_value]
	if callback then
		callback()
	end
end
G.FUNCS.handy_option_cycle = function(arg)
	arg.cycle_config.ref_table[arg.cycle_config.ref_value] = arg.to_key
	Handy.config.request_save()
	if arg.cycle_config.handy_callback then
		arg.cycle_config.handy_callback(arg)
	end
end
G.FUNCS.handy_slider = function(arg)
	Handy.config.request_save()
	if arg.handy_callback then
		arg.handy_callback(arg)
	end
end
local old_slider_descreet = G.FUNCS.slider_descreet
G.FUNCS.slider_descreet = function(e, ...)
	old_slider_descreet(e, ...)
	local c = e.children[1]
	local rt = c.config.ref_table
	if rt.callback then
		G.FUNCS[rt.callback](rt)
	end
end

---

function Handy.UI.change_ui_page(arg)
	if arg.ref_table then
		arg.ref_table[arg.ref_value] = arg.to_key
	end
	if G.OVERLAY_MENU then
		local object_container = G.OVERLAY_MENU:get_UIE_by_ID(arg.container_id)
		if object_container then
			if object_container.config.object then
				object_container.config.object:remove()
			end
			object_container.config.object = UIBox({
				definition = arg.definition(arg.to_key),
				config = {
					offset = { x = 0, y = 0 },
					parent = object_container,
					align = "cm",
				},
			})
			G.OVERLAY_MENU:recalculate()
		end
	end
	Handy.utils.cleanup_dead_elements(G, "MOVEABLES")
end
G.FUNCS.handy_change_ui_page = function(arg)
	Handy.UI.change_ui_page({
		ref_table = arg.cycle_config.handy_ref_table,
		ref_value = arg.cycle_config.handy_ref_value,
		container_id = arg.cycle_config.handy_container_id,
		definition = arg.cycle_config.handy_page_definition,
		to_key = arg.to_key,
	})
end
