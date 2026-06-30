Handy.UI.__global_d_counter = 1

---

function Handy.UI.CP.dictionary_item_info(item)
	local res = Handy.L.loc_vars(item, {
		set = "Handy_ConfigDictionary",
		key = item.key,
	})

	local success, loc_table = pcall(function()
		return G.localization.descriptions[res.set][res.key].unlock_parsed
	end)
	local is_loc_loaded = success and loc_table and #loc_table > 0
	if not (item.info_func or is_loc_loaded) then
		return {
			n = G.UIT.C,
			config = {
				minh = 0.305,
				maxh = 0.305,
				minw = 0.305,
				maxw = 0.305,
				r = 0.1,
				align = "cm",

				focus_args = {
					type = "handy",
					handy_dictionary = "info",
				},
				group = "d" .. Handy.UI.__global_d_counter,
			},
		}
	end

	return {
		n = G.UIT.C,
		config = {
			colour = G.C.CHIPS,
			outline = 0.5,
			line_emboss = 0.125,
			outline_colour = G.C.WHITE,
			minh = 0.305,
			maxh = 0.305,
			minw = 0.305,
			maxw = 0.305,
			r = 0.1,
			align = "cm",

			hover = true,
			func = item.info_func or "handy_setup_hover_popups",
			handy_item = item,

			focus_args = {
				type = "handy",
				handy_dictionary = "info",
			},
			group = "d" .. Handy.UI.__global_d_counter,
		},
		nodes = {
			{
				n = G.UIT.T,
				config = {
					text = "?",
					scale = 0.25,
					colour = G.C.UI.TEXT_LIGHT,
				},
			},
		},
	}
end
function Handy.UI.CP.dictionary_item_checkbox(item)
	if not item.checkbox then
		return
	end

	local opacity = false

	local module = item:get_module()
	local oc_values = item.checkbox.get_values and item.checkbox:get_values() or {}
	local disabled = oc_values.disabled
	-- If checkbox in advanced mode, display if we are in advanced more or module is not enabled
	-- So user can enable it without toggling advanced mode
	-- if item.checkbox.advanced and not (Handy.cc.advanced_mode.enabled or not module.enabled) then
	-- 	opacity = true
	-- 	disabled = true
	-- end

	local check = Sprite(0, 0, 0.2, 0.2, G.ASSET_ATLAS["icons"], { x = 1, y = 0 })
	check.states.drag.can = false
	check.states.visible = module.enabled

	local opacity_mod = 1
	if disabled then
		opacity_mod = 0.25
	end
	if opacity then
		opacity_mod = 0.05
	end

	if opacity_mod ~= 1 then
		local old_draw = check.draw
		function check:draw(...)
			old_draw(self, { 1, 1, 1, opacity_mod })
		end
	end

	return {
		n = G.UIT.C,
		config = {
			align = "cl",
			focus_args = { funnel_from = true },
			func = "handy_setup_dictionary_checkbox_alert",
			handy_item = item,
		},
		nodes = {
			{
				n = G.UIT.C,
				config = { align = "cm", r = 0.05, colour = adjust_alpha(G.C.BLACK, opacity_mod) },
				nodes = {
					{
						n = G.UIT.C,
						config = {
							align = "cm",
							r = 0,
							minw = 0.305,
							minh = 0.305,
							maxh = 0.305,
							maxw = 0.305,
							outline_colour = adjust_alpha(G.C.WHITE, opacity_mod),
							outline = 0.5,
							line_emboss = 0.125,
							ref_table = {
								ref_table = module,
								ref_value = "enabled",
								active_colour = adjust_alpha(G.C.MULT, opacity_mod),
								inactive_colour = adjust_alpha(G.C.BLACK, opacity_mod),
							},
							colour = adjust_alpha(module.enabled and G.C.MULT or G.C.BLACK, opacity_mod),
							button = not disabled and "toggle_button" or nil,
							button_dist = not disabled and 0.2 or nil,
							hover = true,
							toggle_callback = function(b)
								Handy.config.request_save()
								if item.checkbox.callback then
									item.checkbox.callback(b)
								end
							end,
							func = "toggle",
							focus_args = {
								funnel_to = true,
								type = "handy",
								handy_dictionary = "toggle",
							},
							group = "d" .. Handy.UI.__global_d_counter,
						},
						nodes = {
							{ n = G.UIT.O, config = { object = check } },
						},
					},
				},
			},
		},
	}
end
function Handy.UI.CP.dictionary_item_keybind(item)
	local module = item:get_module()
	local options = type(item.keybind) == "table" and item.keybind or {}

	local key_1, key_2 = "keys_1", "keys_2"
	if Handy.controller.is_gamepad() then
		key_1, key_2 = "keys_1_gamepad", "keys_2_gamepad"
	end

	return {
		n = G.UIT.C,
		config = {},
		nodes = {
			Handy.UI.CP.module_keybind_button(module, key_1, options, {
				dangerous = item.dangerous,
				focus_args = { type = "handy", handy_dictionary = "control" },
				group = "d" .. Handy.UI.__global_d_counter,
			}),
			{
				n = G.UIT.C,
				config = { align = "cm", minw = 0.4, maxw = 0.4 },
				nodes = {
					{
						n = G.UIT.T,
						config = { text = Handy.L.dictionary("handy_or"), colour = G.C.WHITE, scale = 0.25 },
					},
				},
			} or nil,
			Handy.UI.CP.module_keybind_button(module, key_2, options, {
				dangerous = item.dangerous,
				focus_args = { type = "handy", handy_dictionary = "control_2" },
				group = "d" .. Handy.UI.__global_d_counter,
			}),
		},
	}
end
function Handy.UI.CP.dictionary_item_simple_option_cycle(item)
	local item_oc = item.simple_option_cycle
	local oc_values = item_oc:get_values()

	local args = {
		w = 8.7,
		label = nil,
		scale = 0.7,
		focus_args = { nav = "wide" },
		colour = item_oc.colour,
		ref_table = oc_values.ref_table,
		ref_value = oc_values.ref_value,
		prefix = nil,
	}

	args.colour = args.colour or G.C.RED
	args.scale = args.scale or 1
	args.w = (args.w or 2.5) * args.scale
	args.h = (args.h or 0.67) * args.scale
	args.text_scale = (args.text_scale or 0.425) * args.scale
	args.l = "<"
	args.r = ">"
	args.focus_args = args.focus_args or {}
	args.focus_args.type = "handy"
	args.focus_args.handy_cycle = true
	args.focus_args.handy_dictionary = "control"

	local disabled = args.disabled or false
	args.focus_args.handy_disabled = disabled

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
			group = "d" .. Handy.UI.__global_d_counter,
			func = not disabled and "handy_gamepad_2step_control" or nil,
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
												maxw = 5.5,
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

	return result
end
function Handy.UI.CP.dictionary_item_option_cycle(item)
	local module = item:get_module()
	local item_oc = item.option_cycle
	local oc_values = item_oc:get_values()

	local args = {
		w = 8.7,
		h = 0.4,
		text_scale = 0.425,
		label = nil,
		scale = 0.7,
		colour = item_oc.colour,
		options = oc_values.options,
		opt_callback = "handy_option_cycle",
		current_option = oc_values.current_option,
		focus_args = { nav = "wide" },
		ref_table = oc_values.ref_table or module,
		ref_value = oc_values.ref_value or "value",
		handy_callback = item_oc.callback,
		disabled = oc_values.disabled,
	}
	args.current_option = oc_values.current_option or args.ref_table[args.ref_value]
	if args.disabled then
		args.opt_callback = "handy_noop"
	end

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
	args.focus_args.handy_dictionary = "control"
	args.focus_args.handy_cycle = true

	local disabled = #args.options < 2 or args.disabled
	args.focus_args.handy_disabled = disabled

	local pips = {}
	for i = 1, #args.options do
		pips[#pips + 1] = {
			n = G.UIT.B,
			config = {
				w = 0.1 * args.scale,
				h = 0.1 * args.scale,
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
			group = "d" .. Handy.UI.__global_d_counter,
			func = not args.disabled and "handy_gamepad_2step_control" or nil,
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
												maxw = 5.5,
											}),
										},
									},
								},
							},
							{ n = G.UIT.R, config = { align = "cm", minh = 0.025 }, nodes = {} },
							choice_pips,
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
	return { n = G.UIT.R, config = { align = "cm", colour = G.C.CLEAR, padding = 0.0 }, nodes = {
		t,
	} }
end
function Handy.UI.CP.dictionary_item_slider(item)
	local module = item:get_module()
	local item_sl = item.slider
	local sl_values = item_sl.get_values and item_sl:get_values()

	local args = {
		label_scale = 0.35,
		ref_table = sl_values.ref_table or module,
		ref_value = sl_values.ref_table or "value",
		w = 7.5 - 0.375,
		min = item_sl.min or 1,
		max = item_sl.max or 1,
		decimal_places = item_sl.decimal_places,
		callback = "handy_slider",
		handy_callback = item_sl.callback,
	}

	args.colour = args.colour or G.C.RED
	args.w = (args.w or 1) - 0.9
	args.h = args.h or 0.35
	args.label_scale = args.label_scale or 0.45
	args.text_scale = args.text_scale or 0.25
	args.min = args.min or 0
	args.max = args.max or 1
	args.decimal_places = args.decimal_places or 0
	args.text = string.format("%." .. tostring(args.decimal_places) .. "f", args.ref_table[args.ref_value])
	local startval = args.w * (args.ref_table[args.ref_value] - args.min) / (args.max - args.min)

	local t = {
		n = G.UIT.C,
		config = {
			align = "cm",
			minw = args.w,
			min_h = args.h,
			r = 0.1,
			colour = G.C.CLEAR,
			focus_args = {
				type = "handy",
				handy_slider = true,
				handy_dictionary = "control",
				handy_disabled = args.disabled,
			},
			group = "d" .. Handy.UI.__global_d_counter,
			func = "handy_gamepad_2step_control",
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					align = "cl",
					minw = args.w,
					r = 0.1,
					min_h = args.h,
					collideable = Handy.controller.device.real ~= "gamepad",
					hover = Handy.controller.device.real ~= "gamepad",
					colour = G.C.BLACK,
					emboss = 0.05,
					func = "slider",
					refresh_movement = true,
					focus_args = { type = "none" },
				},
				nodes = {
					{
						n = G.UIT.B,
						config = {
							w = startval,
							h = args.h,
							r = 0.1,
							colour = args.colour,
							ref_table = args,
							refresh_movement = true,
							focus_args = { type = "none" },
						},
					},
				},
			},
			Handy.UI.CP.c_sep(0.1),
			{
				n = G.UIT.C,
				config = { align = "cm", minh = args.h, r = 0.1, minw = 0.8, colour = args.colour, shadow = true },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							ref_table = args,
							ref_value = "text",
							scale = args.text_scale,
							colour = G.C.UI.TEXT_LIGHT,
							decimal_places = args.decimal_places,
						},
					},
				},
			},
		},
	}

	return {
		n = G.UIT.C,
		config = { align = "cm" },
		nodes = {
			t,
		},
	}
end

function Handy.UI.CP.dictionary_item(item, options)
	Handy.UI.__global_d_counter = Handy.UI.__global_d_counter + 1
	options = options or {}
	local colour
	if options.colour then
		colour = options.colour
	elseif item.colour then
		colour = item.colour
	elseif options.bg then
		colour = item.dangerous and adjust_alpha(G.C.MULT, 0.2) or adjust_alpha(HEX("000000"), 0.1)
	elseif options.dangerous_bg and item.dangerous or (item.checkbox and item.checkbox.dangerous) then
		colour = adjust_alpha(G.C.MULT, 0.1)
	end

	local res = Handy.L.loc_vars(item, {
		set = "Handy_ConfigDictionary",
		key = item.key,
	})

	local left_side = {
		n = G.UIT.C,
		config = {
			align = "c",
			focus_args = {
				type = "handy",
				handy_dictionary = "name",
				nav = "wide",
			},
			group = "d" .. Handy.UI.__global_d_counter,
			hover = true,
			func = item.info_func or "handy_setup_hover_popups",
			handy_item = item,
		},
		nodes = {
			{
				n = G.UIT.C,
				config = { minw = 0.4, align = "c", minh = 0.305 },
				nodes = {
					item.checkbox and Handy.UI.CP.dictionary_item_checkbox(item) or {
						n = G.UIT.C,
						config = {
							hover = true,
							minw = 0.305,
							minh = 0.305,
							align = "cm",
							r = 0.25,
							focus_args = {
								type = "handy",
								handy_dictionary = "toggle",
								nav = "wide",
							},
							group = "d" .. Handy.UI.__global_d_counter,
						},
					},
				},
			},
			Handy.UI.CP.c_sep(0.1),
			{
				n = G.UIT.C,
				config = {
					align = "c",
				},
				nodes = {
					{
						n = G.UIT.R,
						config = {
							minw = 4,
							maxw = 4,
							align = "c",
						},
						nodes = {
							Handy.L.name(res.set, res.key, {
								align = "c",
								default_col = G.C.UI.TEXT_LIGHT,
								minw = 4,
								maxw = 4,
								vars = res.vars or {},
								scale = 0.85,
							}),
						},
					},
					{
						n = G.UIT.R,
						config = {
							minw = 4,
							maxw = 4,
						},
						nodes = {
							Handy.L.description(res.set, res.key, {
								align = "c",
								default_col = adjust_alpha(G.C.UI.TEXT_LIGHT, 0.6),
								maxw = 4,
								scale = 0.7,
								minh = 0.3 * 0.7,
								vars = res.vars or {},
							}),
						},
					},
				},
			},
		},
	}

	local has_any_content = item.keybind or item.simple_option_cycle or item.option_cycle or item.slider

	local right_side = {
		n = G.UIT.C,
		config = {
			minw = 7.15,
			align = "cm",
		},
		nodes = {
			item.keybind and {
				n = G.UIT.R,
				nodes = {
					Handy.UI.CP.dictionary_item_keybind(item),
				},
			} or nil,
			item.simple_option_cycle and {
				n = G.UIT.R,
				align = "m",
				nodes = {
					Handy.UI.CP.dictionary_item_simple_option_cycle(item),
				},
			} or nil,
			item.option_cycle and {
				n = G.UIT.R,
				align = "m",
				nodes = {
					Handy.UI.CP.dictionary_item_option_cycle(item),
				},
			} or nil,
			item.slider and {
				n = G.UIT.R,
				align = "m",
				nodes = {
					Handy.UI.CP.dictionary_item_slider(item),
				},
			} or nil,
			(not has_any_content) and {
				n = G.UIT.R,
				config = {
					align = "cm",
					minw = 7.1,
					minh = 0.305,
					r = 0.25,
					hover = true,
					focus_args = {
						type = "handy",
						handy_dictionary = "control",
					},
					group = "d" .. Handy.UI.__global_d_counter,
				},
			} or nil,
		},
	}

	return {
		n = G.UIT.R,
		config = {
			colour = colour,
			r = 0.05,
			padding = 0.075,
		},
		nodes = {
			{
				n = G.UIT.R,
				nodes = {
					left_side,
					Handy.UI.CP.c_sep(0.75),
					right_side,
					{
						n = G.UIT.C,
						config = {
							minw = 0.5,
							align = "cr",
						},
						nodes = {
							Handy.UI.CP.dictionary_item_info(item),
						},
					},
				},
			},
		},
	}
end
