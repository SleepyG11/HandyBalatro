Handy.UI.PARTS = {
	localize_keybind = function(key, with_brackets)
		if not key then
			key = "None"
		end
		-- Backwards compatibility
		if key == "[" then
			key = "Left Bracket"
		elseif key == "]" then
			key = "Right Bracket"
		end
		local result = G.localization.misc.handy_keybinds[key] or key
		if with_brackets then
			result = "[" .. result .. "]"
		end
		return result
	end,
	localize_keybind_label = function(key, without_brackets)
		local result = localize(key, "handy_keybind_labels")
		if without_brackets then
			return result
		end
		return "[" .. result .. "]"
	end,

	format_new_module_keys = function(module, only_first)
		local key_1, key_2 = "key_1", "key_2"
		if Handy.controller.is_gamepad() then
			key_1, key_2 = "key_1_gamepad", "key_2_gamepad"
		end

		local keys_table = {
			[key_1] = module[key_1] ~= "None" and module[key_1] or nil,
			[key_2] = module[key_2] ~= "None" and module[key_2] or nil,
		}

		local keys_count = 0
		if keys_table[key_1] then
			keys_count = keys_count + 1
		end
		if keys_table[key_2] then
			keys_count = keys_count + 1
		end

		if only_first or keys_count < 2 then
			return localize({
				type = "variable",
				key = "Handy_module_keys_single",
				vars = { Handy.UI.PARTS.localize_keybind(keys_table[key_1] or keys_table[key_2] or "None") },
			})
		else
			return localize({
				type = "variable",
				key = "Handy_module_keys_or",
				vars = {
					Handy.UI.PARTS.localize_keybind(keys_table[key_1]),
					Handy.UI.PARTS.localize_keybind(keys_table[key_2]),
				},
			})
		end
	end,
	create_new_module_checkbox = function(module, loc_key, loc_vars, options, additional_options)
		options = Handy.utils.table_merge({}, additional_options or {}, options or {})
		local formatted_keys = Handy.UI.PARTS.format_new_module_keys(module, options.only_first)
		local result_loc_vars = { formatted_keys }
		for _, v in ipairs(loc_vars or {}) do
			table.insert(result_loc_vars, v)
		end
		local checkbox_name = {}
		localize({
			type = "unlocks",
			set = "Handy_ConfigCheckbox",
			key = loc_key,
			vars = result_loc_vars,
			nodes = checkbox_name,
			default_col = G.C.WHITE,
		})
		local checkbox_text = {}
		localize({
			type = "descriptions",
			set = "Handy_ConfigCheckbox",
			key = loc_key,
			vars = result_loc_vars,
			nodes = checkbox_text,
			default_col = G.C.UI.TEXT_LIGHT,
		})

		local name_lines = {}
		for _, line in ipairs(checkbox_name) do
			for _, line_part in ipairs(line) do
				line_part.config.scale = 0.4
			end
			table.insert(name_lines, {
				n = G.UIT.R,
				config = {
					minw = 2.75,
					maxw = (Handy.UI.is_in_search_result_page or not options.full_width) and 2.75 or nil,
				},
				nodes = line,
			})
		end
		local desc_lines = {
			{ n = G.UIT.R, config = { minw = 5 } },
		}
		for _, line in ipairs(checkbox_text) do
			table.insert(desc_lines, {
				n = G.UIT.R,
				config = {
					padding = 0.025,
					maxw = (Handy.UI.is_in_search_result_page or not options.full_width) and 4.5 or nil,
				},
				nodes = line,
			})
		end

		local result_toggle = create_toggle({
			callback = function(b)
				return G.FUNCS.handy_toggle_module_enabled(b, module)
			end,
			label_scale = 0.4,
			label = "",
			ref_table = module,
			ref_value = "enabled",
			w = 0,
		})
		result_toggle.config.focus_args.nav = "wide"

		return {
			n = G.UIT.R,
			config = {
				align = "cm",
				func = "handy_setup_config_popup",
				handy_loc_key = loc_key,
				handy_loc_vars = result_loc_vars,
				colour = (Handy.UI.is_in_search_result_page and options.dangerous) and adjust_alpha(G.C.MULT, 0.15)
					or G.C.CLEAR,
				padding = Handy.UI.is_in_search_result_page and 0.1 or 0,
				r = 0.1,
				hover = true,
				can_collide = true,
				focus_args = {
					funnel_from = true,
				},
			},
			nodes = {
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = name_lines,
				},
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = {
						result_toggle,
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 0.1 },
				},
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = desc_lines,
				},
			},
		}
	end,

	create_module_slider = function(module, ref_value, loc_key, loc_vars, options, additional_options)
		options = Handy.utils.table_merge({}, additional_options or {}, options or {})
		local result_loc_vars = { formatted_keys }
		for _, v in ipairs(loc_vars or {}) do
			table.insert(result_loc_vars, v)
		end

		local checkbox_name = {}
		localize({
			type = "unlocks",
			set = "Handy_ConfigCheckbox",
			key = loc_key,
			vars = result_loc_vars,
			nodes = checkbox_name,
			default_col = G.C.WHITE,
		})

		local name_lines = {}
		for _, line in ipairs(checkbox_name) do
			for _, line_part in ipairs(line) do
				line_part.config.scale = 0.4
			end
			table.insert(name_lines, {
				n = G.UIT.R,
				config = {
					minw = 2.75,
					maxw = (Handy.UI.is_in_search_result_page or not options.full_width) and 2.75 or nil,
				},
				nodes = line,
			})
		end

		G.handy_name_lines = name_lines

		local result_slider = create_slider({
			label_scale = 0.4,
			ref_table = module,
			ref_value = ref_value,
			w = 4.77,
			min = options.min or 1,
			max = options.max or 1,
			decimal_places = options.decimal_places,
			callback = options.callback,
		})

		return {
			n = G.UIT.R,
			config = {
				align = "cm",
				colour = (Handy.UI.is_in_search_result_page and options.dangerous) and adjust_alpha(G.C.MULT, 0.15)
					or G.C.CLEAR,
				padding = Handy.UI.is_in_search_result_page and 0.1 or 0,
				r = 0.1,
				focus_args = {
					funnel_from = true,
				},
			},
			nodes = {
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = name_lines,
				},
				{
					n = G.UIT.C,
					config = { minw = 0.2 },
				},
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = {
						result_slider,
					},
				},
			},
		}
	end,

	create_module_section = function(loc_key)
		return {
			n = G.UIT.R,
			config = { align = "cm", padding = 0.075 },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = localize(loc_key, "handy_keybind_sections"),
						colour = G.C.WHITE,
						scale = 0.35,
						align = "cm",
					},
				},
			},
		}
	end,
	create_module_keybind = function(module, loc_key, options, additional_options)
		options = Handy.utils.table_merge({}, additional_options or {}, options or {})
		local dangerous = options.dangerous
		local rerender = Handy.UI.is_in_search_result_page or options.rerender
		local disabled = options.disabled
		local only_holdable = options.only_holdable
		local only_safe = options.only_safe

		local key_1, key_2 = "key_1", "key_2"
		if Handy.controller.is_gamepad() then
			key_1, key_2 = "key_1_gamepad", "key_2_gamepad"
		end

		return {
			n = G.UIT.R,
			config = { align = "cm", padding = 0.01 },
			nodes = {
				{
					n = G.UIT.C,
					config = Handy.UI.is_in_search_result_page and { align = "c", minw = 3, maxw = 3 }
						or { align = "c", minw = 4, maxw = 4 },
					nodes = {
						{
							n = G.UIT.T,
							config = {
								text = localize(loc_key, "handy_keybind_labels"),
								colour = G.C.WHITE,
								scale = Handy.UI.is_in_search_result_page and 0.25 or 0.3,
							},
						},
					},
				},
				{
					n = G.UIT.C,
					config = { align = "cm", minw = 0.75 },
				},
				UIBox_button({
					label = { Handy.UI.PARTS.localize_keybind(module[key_1] or "None") },
					col = true,
					colour = (disabled and G.C.UI.BACKGROUND_INACTIVE) or (dangerous and G.C.MULT) or G.C.CHIPS,
					scale = 0.3,
					minw = 2.75,
					maxw = 2.75,
					minh = 0.4,
					maxh = 0.4,
					ref_table = {
						module = module,
						key = key_1,
						rerender = rerender,
						only_holdable = only_holdable,
						only_safe = only_safe,
					},
					focus_args = { nav = "wide" },
					button = disabled and "handy_empty" or "handy_init_keybind_change",
				}),
				{
					n = G.UIT.C,
					config = { align = "cm", minw = 0.6 },
					nodes = {
						{
							n = G.UIT.T,
							config = { text = localize("handy_or"), colour = G.C.WHITE, scale = 0.3 },
						},
					},
				} or nil,
				UIBox_button({
					label = { Handy.UI.PARTS.localize_keybind(module[key_2] or "None") },
					col = true,
					colour = (disabled and G.C.UI.BACKGROUND_INACTIVE) or (dangerous and G.C.MULT) or G.C.CHIPS,
					scale = 0.3,
					minw = 2.75,
					maxw = 2.75,
					minh = 0.4,
					maxh = 0.4,
					ref_table = {
						module = module,
						key = key_2,
						rerender = rerender,
						only_holdable = only_holdable,
						only_safe = only_safe,
					},
					-- focus_args = { nav = "wide" },
					button = disabled and "handy_empty" or "handy_init_keybind_change",
				}),
			},
		}
	end,

	create_option_cycle = function(label, values, current_value, callback_func, options)
		options = options or {}
		if options.compress then
			local new_values = {}
			for k, v in ipairs(values) do
				table.insert(new_values, label .. ": " .. v)
			end
			values = new_values
		end
		return create_option_cycle({
			w = options.compress and 10 or 6,
			label = not options.compress and label or nil,
			scale = 0.8,
			options = values,
			opt_callback = callback_func,
			current_option = current_value,
			focus_args = { nav = "wide" },
		})
	end,
	create_option_cycle_simple = function(label, ref_table, ref_value, left_callback, right_callback, options)
		options = options or {}
		if options.no_label then
			label = nil
		end

		local args = {
			w = options.w or options.compress and 10 or 6,
			label = not options.compress and label or nil,
			scale = 0.8,
			focus_args = { nav = "wide" },
			colour = options.colour,
			ref_table = ref_table,
			ref_value = ref_value,
			prefix = options.compress and label and label .. ": " or nil,
			num_pips = options.num_pips,
			current_pip_fn = options.current_pip_fn,
		}

		args.colour = args.colour or G.C.RED
		args.scale = args.scale or 1
		args.w = (args.w or 2.5) * args.scale
		args.h = (args.h or 0.8) * args.scale
		args.text_scale = (args.text_scale or 0.5) * args.scale
		args.l = "<"
		args.r = ">"
		args.focus_args = args.focus_args or {}
		args.focus_args.type = "cycle"

		local disabled = false

		local callbacks = {
			l = left_callback or function() end,
			r = right_callback or function() end,
		}

		local result = {
			n = G.UIT.R,
			config = {
				align = "cm",
				padding = 0.1,
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
						pip_update_info = args.num_pips and {
							num_pips = args.num_pips,
							current_pip_fn = args.current_pip_fn,
							scale = args.scale,
						} or nil,
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
						emboss = 0.1,
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
								{
									n = G.UIT.R,
									config = { align = "cm", minh = 0.05 },
									nodes = {},
								},
								args.num_pips and (function()
									local pips = {}
									local current_pip = args.current_pip_fn and args.current_pip_fn() or 1
									for i = 1, args.num_pips do
										pips[#pips + 1] = {
											n = G.UIT.B,
											config = {
												w = 0.1 * args.scale,
												h = 0.1 * args.scale,
												r = 0.05,
												id = "pip_" .. i,
												colour = current_pip == i and G.C.WHITE or G.C.BLACK,
											},
										}
									end
									return {
										n = G.UIT.R,
										config = {
											align = "cm",
											padding = (0.05 - (args.num_pips > 15 and 0.03 or 0)) * args.scale,
										},
										nodes = pips,
									}
								end)() or nil,
							},
						},
					},
				},
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
						pip_update_info = args.num_pips and {
							num_pips = args.num_pips,
							current_pip_fn = args.current_pip_fn,
							scale = args.scale,
						} or nil,
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

		if args.label then
			result = {
				n = G.UIT.R,
				config = { align = "cm", padding = 0.05, id = args.id or nil },
				nodes = {
					args.label and {
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.T,
								config = { text = args.label, scale = 0.5 * args.scale, colour = G.C.UI.TEXT_LIGHT },
							},
						},
					} or nil,
					result,
				},
			}
		end
		return result
	end,

	create_example_preset = function(key)
		local checkbox_text = {}
		localize({
			type = "descriptions",
			set = "Handy_Preset",
			key = key,
			vars = {},
			nodes = checkbox_text,
			default_col = G.C.UI.TEXT_LIGHT,
		})

		local desc_lines = {
			{ n = G.UIT.R, config = { minw = 6, maxw = 6 } },
		}
		for _, line in ipairs(checkbox_text) do
			table.insert(desc_lines, {
				n = G.UIT.R,
				config = { padding = 0.025, minw = 6, maxw = 6 },
				nodes = line,
			})
		end

		return {
			n = G.UIT.R,
			config = {
				align = "cm",
			},
			nodes = {
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = {
						UIBox_button({
							label = { localize({ type = "name_text", set = "Handy_Preset", key = key, vars = {} }) },
							col = true,
							colour = G.C.ORANGE,
							scale = 0.3,
							minw = 4,
							maxw = 4,
							minh = 0.4,
							maxh = 0.4,
							ref_table = {
								key = key,
							},
							button = "handy_apply_preset_key",
						}),
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 0.3 },
				},
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = desc_lines,
				},
			},
		}
	end,
	create_user_preset = function(index)
		local preset = Handy.presets.current.user[index]
		local name_object = {
			name = preset.name,
		}

		return {
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
					config = {},
					nodes = {
						create_toggle({
							callback = function(b)
								return G.FUNCS.handy_toggle_preset_enabled(b, index)
							end,
							label_scale = 0.4,
							label = "",
							ref_table = preset,
							ref_value = "enabled",
							w = 0,
							focus_args = { nav = "wide" },
						}),
					},
				},
				{
					n = G.UIT.C,
					config = { align = "cm", minw = 0.15 },
				},
				{
					n = G.UIT.C,
					config = { align = "c", minw = 2, maxw = 2 },
					nodes = {
						{
							n = G.UIT.T,
							config = {
								text = localize({
									type = "variable",
									key = "Handy_preset_index",
									vars = { index },
								}),
								colour = G.C.WHITE,
								scale = 0.4,
							},
						},
					},
				},
				{
					n = G.UIT.C,
					config = { align = "cm", minw = 0.75 },
				},
				create_text_input({
					id = "handy_preset_name_" .. tostring(index),
					prompt_text = localize("handy_preset_name_placeholder"),
					extended_corpus = true,
					ref_table = name_object,
					ref_value = "name",
					text_scale = 0.3,
					max_length = 16,
					w = 3.5,
					h = 0.4,
				}),
				{
					n = G.UIT.C,
					config = { align = "cm", minw = 0.4 },
				},
				UIBox_button({
					label = { localize("b_handy_preset_save") },
					col = true,
					colour = G.C.CHIPS,
					scale = 0.3,
					minw = 1.75,
					maxw = 1.75,
					minh = 0.5,
					maxh = 0.5,
					ref_table = {
						index = index,
						name_object = name_object,
					},
					button = "handy_save_preset_index_with_name",
				}),
				{
					n = G.UIT.C,
					config = { align = "cm", minw = 0.05 },
				},
				UIBox_button({
					label = { localize("b_handy_preset_load") },
					col = true,
					colour = preset.config and G.C.GREEN or G.C.UI.BACKGROUND_INACTIVE,
					scale = 0.3,
					minw = 1.75,
					maxw = 1.75,
					minh = 0.5,
					maxh = 0.5,
					ref_table = {
						index = index,
					},
					button = preset.config and "handy_load_preset_index" or "handy_empty",
				}),
				{
					n = G.UIT.C,
					config = { align = "cm", minw = 0.05 },
				},
				UIBox_button({
					label = { localize("b_handy_preset_clear") },
					col = true,
					colour = preset.config and G.C.MULT or G.C.UI.BACKGROUND_INACTIVE,
					scale = 0.3,
					minw = 1.75,
					maxw = 1.75,
					minh = 0.5,
					maxh = 0.5,
					ref_table = {
						index = index,
					},
					button = preset.config and "handy_clear_preset_index" or "handy_empty",
				}),
			},
		}
	end,

	create_separator_r = function(h)
		return { n = G.UIT.R, config = { minh = h or 0.25 } }
	end,
	create_separator_c = function(w)
		return { n = G.UIT.C, config = { minw = w or 0.25 } }
	end,
}
