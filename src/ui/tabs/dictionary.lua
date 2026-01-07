Handy.UI.__global_d_counter = 1

local keybinds_per_page = 7

--

function Handy.UI.CP.dictionary_item_info(item)
	local success, loc_table = pcall(function()
		return G.localization.descriptions["Handy_ConfigDictionary"][item.key].unlock_parsed
	end)
	local is_loc_loaded = success and loc_table and #loc_table > 0
	if not (item.info_func or is_loc_loaded) then
		return nil
	end

	return {
		n = G.UIT.C,
		config = {
			colour = G.C.CHIPS,
			outline = 0.5,
			line_emboss = 0.125,
			outline_colour = G.C.WHITE,
			minh = 0.325,
			maxh = 0.325,
			minw = 0.325,
			maxw = 0.325,
			r = 0.1,
			align = "cm",

			hover = true,
			func = item.info_func or "hand_setup_hover_popups",
			handy_item = item,

			focus_args = { type = "handy_dictionary_item" },
			group = "handy_dictionary_item" .. Handy.UI.__global_d_counter,
		},
		nodes = {
			{
				n = G.UIT.T,
				config = {
					text = "?",
					scale = 0.3,
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
	-- If checkbox in advanced mode, display if we are in advanced more or module is not enabled
	-- So user can enable it without toggling advanced mode
	if item.checkbox.advanced and not (Handy.cc.advanced_mode.enabled or not module.enabled) then
		opacity = true
	end

	local check = Sprite(0, 0, 0.2, 0.2, G.ASSET_ATLAS["icons"], { x = 1, y = 0 })
	check.states.drag.can = false
	check.states.visible = module.enabled

	local opacity_mod = opacity and 0.2 or 1

	if opacity then
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
			group = "handy_dictionary_item" .. Handy.UI.__global_d_counter,
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
							minw = 0.325,
							minh = 0.325,
							maxh = 0.325,
							maxw = 0.325,
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
							button = not opacity and "toggle_button" or nil,
							button_dist = not opacity and 0.2 or nil,
							hover = true,
							toggle_callback = function(b)
								module.enabled = b
								Handy.config.request_save()
								if item.checkbox.callback then
									item.checkbox.callback(b)
								end
							end,
							func = "toggle",
							focus_args = {
								funnel_to = true,
								type = "handy_dictionary_item",
								handy_group = "handy_dictionary_item" .. Handy.UI.__global_d_counter,
							},
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
			Handy.UI.CP.module_keybind_button(module, key_1, options, { dangerous = item.dangerous }),
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
			Handy.UI.CP.module_keybind_button(module, key_2, options, { dangerous = item.dangerous }),
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
	args.focus_args.type = "cycle"
	args.focus_args.handy_cycle = true

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
			group = "handy_dictionary_item" .. Handy.UI.__global_d_counter,
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
		handy_callback = oc_values.callback,
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
			group = "handy_dictionary_item" .. Handy.UI.__global_d_counter,
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
	args.w = args.w or 1
	args.h = args.h or 0.35
	args.label_scale = args.label_scale or 0.45
	args.text_scale = args.text_scale or 0.25
	args.min = args.min or 0
	args.max = args.max or 1
	args.decimal_places = args.decimal_places or 0
	args.text = string.format("%." .. tostring(args.decimal_places) .. "f", args.ref_table[args.ref_value])
	local startval = args.w * (args.ref_table[args.ref_value] - args.min) / (args.max - args.min)

	-- TODO: fix overshot
	local t = {
		n = G.UIT.C,
		config = {
			align = "cm",
			minw = args.w,
			min_h = args.h,
			r = 0.1,
			colour = G.C.CLEAR,
			focus_args = { type = "slider", handy_cycle = true },
			group = "handy_dictionary_item" .. Handy.UI.__global_d_counter,
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					align = "cl",
					minw = args.w - 0.9,
					r = 0.1,
					min_h = args.h,
					collideable = true,
					hover = true,
					colour = G.C.BLACK,
					emboss = 0.05,
					func = "slider",
					refresh_movement = true,
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
	if options.bg then
		colour = item.dangerous and adjust_alpha(G.C.MULT, 0.2) or adjust_alpha(HEX("000000"), 0.1)
	elseif options.dangerous_bg and item.dangerous or (item.checkbox and item.checkbox.dangerous) then
		colour = adjust_alpha(G.C.MULT, 0.1)
	end

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
		config = {
			colour = colour,
			r = 0.05,
			padding = 0.075,
		},
		nodes = {
			{
				n = G.UIT.R,
				nodes = {
					{
						n = G.UIT.C,
						config = { minw = 0.4, align = "c" },
						nodes = {
							item.checkbox and Handy.UI.CP.dictionary_item_checkbox(item) or nil,
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
									maxw = 5.5,
								},
								nodes = {
									Handy.L.description(res.set, res.key, {
										align = "c",
										default_col = adjust_alpha(G.C.UI.TEXT_LIGHT, 0.7),
										maxw = 4,
										scale = 0.7,
										minh = 0.3 * 0.7,
										vars = res.vars or {},
									}),
								},
							},
						},
					},
					Handy.UI.CP.c_sep(0.75),
					{
						n = G.UIT.C,
						config = {
							minw = 7.15,
							align = "cm",
						},
						nodes = {
							item.keybind and {
								n = G.UIT.R,
								nodes = {
									Handy.UI.CP.dictionary_item_keybind(item) or nil,
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
						},
					},
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

--

function Handy.UI.dictionary_tab_page_UIBox()
	local page = Handy.UI.data.dictionary.page or 1
	local initial_items = Handy.UI.data.dictionary.items or {}

	local group_keys = {}
	local group_rows = {
		n = G.UIT.R,
		config = {
			handy_level = 1,
			padding = 0,
		},
		nodes = {},
	}

	local new_index = 1
	for _, item in
		ipairs(
			Handy.utils.table_slice(
				initial_items,
				1 + (keybinds_per_page * (page - 1)),
				math.min(#initial_items, (keybinds_per_page * page))
			)
		)
	do
		local current_target = group_rows
		local target_insert
		if not item.parents or #item.parents == 0 then
			new_index = new_index + 1
			target_insert = {
				n = G.UIT.R,
				config = {
					level = current_target.config.handy_level + 1,
					colour = adjust_alpha(HEX("000000"), 0.1),
					r = 0,
				},
				nodes = {},
			}
			group_keys[new_index] = target_insert
			if current_target.config.handy_level == 1 and current_target.nodes[1] then
				table.insert(current_target.nodes, Handy.UI.CP.r_sep(0.1))
			end
			table.insert(current_target.nodes, target_insert)
			current_target = target_insert
		else
			for _, parent in ipairs(item.parents or {}) do
				target_insert = group_keys[parent.key]
				if not target_insert then
					local colour = parent.dangerous and adjust_alpha(G.C.MULT, 0.2) or adjust_alpha(HEX("000000"), 0.1)
					target_insert = {
						n = G.UIT.R,
						config = {
							handy_parent = parent.key,
							handy_dangerous = parent.dangerous,
							handy_level = current_target.config.handy_level + 1,
							colour = colour,
							r = 0,
						},
						nodes = {
							Handy.UI.CP.dictionary_item(parent, { bg = true }),
						},
					}
					group_keys[parent.key] = target_insert
					if current_target.config.handy_level == 1 and current_target.nodes[1] then
						table.insert(current_target.nodes, Handy.UI.CP.r_sep(0.1))
					end
					table.insert(current_target.nodes, target_insert)
					current_target = target_insert
				else
					current_target = target_insert
				end
			end
		end
		if current_target.config.handy_level == 1 and current_target.nodes[1] then
			table.insert(current_target.nodes, Handy.UI.CP.r_sep(0.1))
		end
		table.insert(
			current_target.nodes,
			Handy.UI.CP.dictionary_item(item, { dangerous_bg = not target_insert.config.handy_dangerous })
		)
	end

	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					align = "cm",
					minh = 6.5,
				},
				nodes = {
					{
						n = G.UIT.C,
						nodes = {
							group_rows,
						},
					},
				},
			},
		},
	}
end
function Handy.UI.dictionary_tab_UIBox()
	local initial_items = Handy.UI.data.dictionary.items or {}

	local options = {}
	local max_page = math.max(1, math.ceil(#initial_items / keybinds_per_page))
	for i = 1, max_page do
		table.insert(options, localize("k_page") .. " " .. tostring(i) .. "/" .. tostring(max_page))
	end

	local definition_render = UIBox({
		definition = Handy.UI.dictionary_tab_page_UIBox(),
		config = {
			colour = G.C.CLEAR,
			align = "cm",
		},
	})

	local footer = {
		n = G.UIT.R,
		config = { align = "cm", padding = 0.1, colour = { 0, 0, 0, 0.1 }, r = 0.25 },
		nodes = {
			{
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = {
					create_option_cycle({
						options = options,
						w = 3.5,
						current_option = math.min(Handy.UI.data.dictionary.page or 1, max_page),
						colour = G.C.RED,
						no_pips = true,
						focus_args = { nav = "wide" },
						scale = 0.7,

						opt_callback = "handy_change_ui_page",
						handy_container_id = "handy_keybinds_dictionary_render",
						handy_ref_table = Handy.UI.data.dictionary,
						handy_ref_value = "page",
						handy_page_definition = Handy.UI.dictionary_tab_page_UIBox,
					}),
				},
			},
			{
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							padding = 0.1,
						},
						nodes = {
							{
								n = G.UIT.O,
								config = {
									object = UIBox({
										definition = {
											n = G.UIT.ROOT,
											config = { colour = G.C.CLEAR },
											nodes = {
												create_text_input({
													w = 4,
													max_length = 32,
													ref_table = Handy.UI.data.dictionary,
													ref_value = "search",
													extended_corpus = true,
													id = "handy_dictionary_search",
													prompt_text = localize("b_handy_search_placeholder"),
													callback = function()
														if not Handy.controller.is_gamepad() then
															G.FUNCS.handy_apply_dictionary_search()
														end
													end,
												}),
											},
										},
										config = {
											align = "cm",
										},
									}),
								},
							},
							UIBox_button({
								label = { localize("b_handy_clear") },
								col = true,
								colour = G.C.MULT,
								scale = 0.35,
								minh = 0.6,
								maxh = 0.6,
								minw = 1.75,
								maxw = 1.75,
								button = "handy_clear_dictionary_search",
							}),

							UIBox_button({
								label = { localize("b_handy_search") },
								col = true,
								colour = G.C.CHIPS,
								scale = 0.35,
								minh = 0.6,
								maxh = 0.6,
								minw = 1.75,
								maxw = 1.75,
								button = "handy_apply_dictionary_search",
							}),
						},
					},
				},
			},
		},
	}

	return {
		n = G.UIT.C,
		config = { colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.1 },
		nodes = {
			{
				n = G.UIT.R,
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
						},
						nodes = {
							{
								n = G.UIT.O,
								config = {
									id = "handy_keybinds_dictionary_render",
									object = definition_render,
								},
							},
						},
					},
					Handy.UI.CP.r_sep(0.1),
					footer,
				},
			},
		},
	}
end

function Handy.UI.dictionary_tab()
	Handy.UI.data.dictionary = Handy.utils.table_shallow_merge({
		search = "",
		page = 1,
		items = Handy.D.items,
	}, Handy.UI.data.dictionary or {})

	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			Handy.UI.dictionary_tab_UIBox(),
		},
	}
end

--

G.FUNCS.handy_clear_dictionary_search = function(e)
	Handy.UI.data.dictionary = {
		items = Handy.D.items,
		search = "",
		page = 1,
	}
	Handy.UI.rerender(true)
end
G.FUNCS.handy_apply_dictionary_search = function(e)
	Handy.UI.data.dictionary.items = Handy.D.search(Handy.UI.data.dictionary.search, {
		remove_parents = true,
	})
	Handy.UI.data.dictionary.page = 1
	Handy.UI.rerender(true)
end

local function is_deps_resolved(item, quick)
	local module, deps = item:get_module()
	if not deps and not item.dangerous then
		return true, {}
	end
	local missing_list = {}
	local is_missing = false
	if module.enabled then
		if item.dangerous and not Handy.cc.dangerous_actions.enabled then
			is_missing = true
			if quick then
				return false, {}
			end
			table.insert(missing_list, Handy.D.dictionary.dangerous_actions)
		end
		if deps then
			for _, dep in ipairs(deps) do
				local _module = dep:get_module()
				if not _module.enabled then
					is_missing = true
					if quick then
						return false, {}
					end
					table.insert(missing_list, dep)
				end
			end
		end
	end
	return not is_missing, missing_list
end

-- this function is so ass, but it works ig
G.FUNCS.handy_setup_dictionary_checkbox_alert = function(e)
	local item = e.config.handy_item
	if not e.handy_alert_popup_setup then
		e.handy_alert_popup_setup = true

		local module, deps = item:get_module()
		if not deps and not item.dangerous and not item.no_mp then
			e.config.func = nil
			return
		end

		local old_e = e
		e = e.children[1].children[1]
		local old_hover = e.hover
		e.states.hover.can = true
		e.states.collide.can = true
		function e:hover(...)
			if not self.children.handy_h_popup then
				local lines = { n = G.UIT.C, config = { align = "cm" }, nodes = {} }

				if (item.no_mp or item.dangerous) and Handy.b_is_in_multiplayer() then
					local lines_col = Handy.L.description("Handy_Other", "cant_use_in_mp", {
						align = "cm",
					})
					for _, l in ipairs(lines_col.nodes) do
						table.insert(lines.nodes, l)
					end
				end

				local is_resolved, missing_list = is_deps_resolved(item)
				if not is_resolved then
					local lines_col = Handy.L.description("Handy_Other", "missing_deps", {
						align = "cm",
					})
					for _, dep in ipairs(missing_list) do
						local res = {
							set = "Handy_ConfigDictionary",
							key = dep.key,
						}
						if dep.loc_vars and type(dep.loc_vars) == "function" then
							local r = dep:loc_vars()
							res.vars = r.vars or res.vars
							res.set = r.set or res.set
							res.key = r.key or res.key
						end
						table.insert(lines_col.nodes, {
							n = G.UIT.R,
							config = { align = "cm" },
							nodes = {
								{
									n = G.UIT.T,
									config = {
										text = Handy.L.name_text(res.set, res.key, res.vars or {}),
										scale = 0.32,
										colour = dep.dangerous and G.C.MULT or G.C.CHIPS,
									},
								},
							},
						})
					end
					if #lines.nodes > 0 then
						table.insert(lines.nodes, { n = G.UIT.R, config = { minh = 0.32 } })
					end
					for _, l in ipairs(lines_col.nodes) do
						table.insert(lines.nodes, l)
					end
				end
				if #lines.nodes > 0 then
					self.children.handy_h_popup = UIBox(Handy.UI.CP.popup_render(self, lines))
				end
			end
			return old_hover(self, ...)
		end
		local old_stop_hover = e.stop_hover
		function e:stop_hover(...)
			if self.children.handy_h_popup then
				self.children.handy_h_popup:remove()
				self.children.handy_h_popup = nil
			end
			return old_stop_hover(self, ...)
		end
		e = old_e
	end

	local is_mp_fail = (item.no_mp or item.dangerous) and Handy.b_is_in_multiplayer()
	local is_resolve_fail = not is_deps_resolved(item, true)
	local is_fail = is_mp_fail or is_resolve_fail
	if not is_fail and e.children.handy_alert then
		e.children.handy_alert:remove()
		e.children.handy_alert = nil
	elseif is_fail and not e.children.handy_alert then
		e.children.handy_alert = UIBox({
			definition = Handy.UI.CP.alert_definition({
				scale_mod = 0.45,
				no_rotate = true,
				text_rot = 0,
				bump_rate = 7,
			}),
			config = {
				align = "tri",
				offset = {
					x = 0.065,
					y = -0.065,
				},
				major = e,
				instance_type = "ALERT",
			},
		})
		e.children.handy_alert.states.collide.can = false
	end
end
