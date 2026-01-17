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

function Handy.UI.settings_speed_multiplier()
	if
		Handy.b_is_mod_active()
		and not Handy.mp_check(function(lobby, lobby_info)
			return lobby_info.handy_speed_multiplier_mode == 1
		end)
		and Handy.controls.is_module_enabled(Handy.cc.speed_multiplier)
		and Handy.controls.is_module_enabled(Handy.cc.speed_multiplier_settings_toggle)
	then
		return {
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
					nodes = {
						create_toggle({
							scale = 0.65,
							ref_table = setmetatable({}, {
								__index = function()
									return not Handy.speed_multiplier.temp_disabled
								end,
							}),
							ref_value = "temp_disabled",
							label = "",
							w = 0,
							label_scale = 0,
							callback = function(b)
								Handy.speed_multiplier.toggle_temp_disabled(not b)
							end,
						}),
					},
				},
				{
					n = G.UIT.C,
					nodes = {
						Handy.UI.CP.settings_simple_option_cycle(Handy.D.dictionary.speed_multiplier),
					},
				},
				Handy.UI.CP.c_sep(0.8),
			},
		}
	end
end
function Handy.UI.settings_animation_skip()
	if
		Handy.b_is_mod_active()
		and not Handy.mp_check(function(lobby, lobby_info)
			return lobby_info.handy_animation_skip_mode == 1
		end)
		and Handy.controls.is_module_enabled(Handy.cc.animation_skip)
		and Handy.controls.is_module_enabled(Handy.cc.animation_skip_settings_toggle)
	then
		return {
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = {
						create_toggle({
							scale = 0.65,
							ref_table = setmetatable({}, {
								__index = function()
									return not Handy.animation_skip.temp_disabled
								end,
							}),
							ref_value = "temp_disabled",
							label = "",
							w = 0,
							label_scale = 0,
							callback = function(b)
								Handy.animation_skip.toggle_temp_disabled(not b)
							end,
						}),
					},
				},
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = {
						Handy.UI.CP.settings_simple_option_cycle(Handy.D.dictionary.animation_skip),
					},
				},
				Handy.UI.CP.c_sep(0.8),
			},
		}
	end
end
