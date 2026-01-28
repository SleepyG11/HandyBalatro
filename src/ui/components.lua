Handy.UI.CP = {}

local load_atlas = function(asset)
	local file_data =
		assert(Handy.NFS.newFileData(asset.path), ("Failed to collect file data for Atlas %s"):format(asset.name))
	local image_data =
		assert(love.image.newImageData(file_data), ("Failed to initialize image data for Atlas %s"):format(asset.name))
	local image = love.graphics.newImage(image_data, { mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling })

	G.ASSET_ATLAS[asset.name] = {
		name = asset.name,
		image = image,
		type = asset.type,
		px = asset.px,
		py = asset.py,
	}
end
load_atlas({
	name = "handy_mod_icon",
	px = 32,
	py = 32,
	path = Handy.PATH .. "/assets/" .. G.SETTINGS.GRAPHICS.texture_scaling .. "x/icon.png",
})

function Handy.UI.CP.logo(scale)
	scale = scale or 1.2

	local tag_sprite = Sprite(0, 0, 1.205 * scale, 1.205 * scale, G.ASSET_ATLAS["handy_mod_icon"], { x = 0, y = 0 })
	tag_sprite:define_draw_steps({
		{ shader = "dissolve", shadow_height = 0.05 },
		{ shader = "dissolve" },
	})
	tag_sprite.float = true
	tag_sprite.states.hover.can = true
	tag_sprite.states.drag.can = false
	tag_sprite.states.collide.can = true

	return {
		n = G.UIT.R,
		config = {
			align = "cm",
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					-- align = "cm",
				},
				nodes = {
					{
						n = G.UIT.R,
						config = {
							minh = 0.09 * scale,
						},
					},
					{
						n = G.UIT.O,
						config = {
							object = tag_sprite,
						},
					},
				},
			},
			{
				n = G.UIT.C,
				config = { minw = 0.1 * scale },
			},
			{
				n = G.UIT.C,
				config = {
					align = "cm",
				},
				nodes = {
					{
						n = G.UIT.R,
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = "Handy",
									scale = 1.01 * scale,
									colour = { 1, 1, 1, 1 },
								},
							},
						},
					},
					{
						n = G.UIT.R,
						nodes = {
							{
								n = G.UIT.C,
								config = {
									minw = 0.03 * scale,
								},
							},
							{
								n = G.UIT.C,
								nodes = {
									{
										n = G.UIT.R,
										nodes = {
											{
												n = G.UIT.T,
												config = {
													text = "Quality of Life",
													scale = 1 / 64 * 18.65 * scale,
													colour = { 1, 1, 1, 1 },
												},
											},
										},
									},
									{
										n = G.UIT.R,
										nodes = {
											{
												n = G.UIT.T,
												config = {
													text = "controls & keybinds",
													scale = 1 / 64 * 17.3 * scale,
													colour = { 1, 1, 1, 1 },
												},
											},
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
end

--

function Handy.UI.CP.alert_definition(args)
	args = args or {}
	args.scale_mod = args.scale_mod or 1
	return {
		n = G.UIT.ROOT,
		config = { align = "cm", colour = G.C.CLEAR, refresh_movement = true },
		nodes = {
			{
				n = G.UIT.R,
				config = {
					align = "cm",
					r = 0.15,
					minw = 0.42 * args.scale_mod,
					minh = 0.42 * args.scale_mod,
					colour = args.no_bg and G.C.CLEAR
						or args.bg_col
						or (args.red_bad and darken(G.C.RED, 0.1) or G.C.RED),
					draw_layer = 1,
					emboss = 0.05 * args.scale_mod,
					refresh_movement = true,
				},
				nodes = {
					{
						n = G.UIT.O,
						config = {
							object = DynaText({
								string = args.text or "!",
								colours = { G.C.WHITE },
								shadow = true,
								rotate = not args.no_rotate,
								H_offset = (args.y_offset or 0) * args.scale_mod,
								bump_rate = args.text and 3 or 7,
								bump_amount = (args.bump_amount or 3) * args.scale_mod,
								bump = not args.no_bump,
								maxw = args.maxw and (args.maxw * args.scale_mod),
								text_rot = args.text_rot or 0.2,
								spacing = (3 * (args.scale or 1)) * args.scale_mod,
								scale = (args.scale or 0.48) * args.scale_mod,
							}),
						},
					},
				},
			},
		},
	}
end
function Handy.UI.CP.popup_render(e, desc_lines)
	return {
		definition = {
			n = G.UIT.ROOT,
			config = { align = "cm", colour = G.C.CLEAR },
			nodes = {
				{
					n = G.UIT.C,
					config = {
						align = "cm",
					},
					nodes = {
						{
							n = G.UIT.R,
							config = {
								padding = 0.05,
								r = 0.12,
								colour = lighten(G.C.JOKER_GREY, 0.5),
								emboss = 0.07,
							},
							nodes = {
								{
									n = G.UIT.R,
									config = {
										align = "cm",
										padding = 0.07,
										r = 0.1,
										colour = adjust_alpha(darken(G.C.BLACK, 0.1), 0.8),
									},
									nodes = { desc_from_rows({ { desc_lines } }) },
								},
							},
						},
					},
				},
			},
		},
		config = {
			align = "mt",
			offset = { x = 0, y = -0.1 },
			major = e,
			instance_type = "POPUP",
		},
	}
end
G.FUNCS.hand_setup_hover_popups = function(e)
	local item = e.config.handy_item
	local old_hover = e.hover
	e.states.hover.can = true
	e.states.collide.can = true
	function e:hover(...)
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
		local success, loc_table = pcall(function()
			return G.localization.descriptions["Handy_ConfigDictionary"][item.key].unlock_parsed
		end)
		if success and loc_table and not self.children.handy_h_popup then
			local lines_col = Handy.L.unlock(res.set, res.key, {
				vars = res.vars or {},
				align = "cm",
			})
			self.children.handy_h_popup = UIBox(Handy.UI.CP.popup_render(self, lines_col))
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
	e.config.func = e.config.handy_func or "handy_noop"
end

--

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
			focus_args = options.nav_wide and { nav = "wide", type = "handy_dictionary_item" }
				or { type = "handy_dictionary_item" },
			button = disabled and "handy_noop" or "handy_start_binding",
			group = "handy_dictionary_item" .. Handy.UI.__global_d_counter,
		},
		nodes = {
			{
				n = G.UIT.T,
				config = {
					text = Handy.L.keys(module[key]),
					scale = 0.25,
					colour = G.C.UI.TEXT_LIGHT,
				},
			},
		},
	}
end
G.FUNCS.handy_start_binding = function(e)
	Handy.controller_v2.binding.start_binding(e.config.ref_table, e)
end

--

function Handy.UI.change_ui_page(arg)
	if arg.ref_table then
		arg.ref_table[arg.ref_value] = arg.to_key
	end
	if G.OVERLAY_MENU then
		-- G.UIT.O UIElement object basically
		local object_container = G.OVERLAY_MENU:get_UIE_by_ID(arg.container_id)
		if object_container then
			if object_container.config.object then
				object_container.config.object:remove()
			end
			object_container.config.object = UIBox({
				-- regular definition (G.UIT.ROOT)
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

--

function Handy.UI.CP.r_sep(minh)
	return {
		n = G.UIT.R,
		config = { minh = minh or 0.05 },
	}
end
function Handy.UI.CP.c_sep(minw)
	return {
		n = G.UIT.C,
		config = { minw = minw or 0.05 },
	}
end

--

G.FUNCS.handy_noop = function() end

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
