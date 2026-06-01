function Handy.UI.CP.logo(scale)
	scale = scale or 1.2

	local tag_sprite = Sprite(0, 0, 1.205 * scale, 1.205 * scale, G.ASSET_ATLAS["handy_modicon"], { x = 0, y = 0 })
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
									lang = G.LANGUAGES["en-us"],
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
													lang = G.LANGUAGES["en-us"],
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
													lang = G.LANGUAGES["en-us"],
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

---

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

---

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
G.FUNCS.handy_setup_hover_popups = function(e)
	local item = e.config.handy_item
	local old_hover = e.hover
	e.states.hover.can = true
	e.states.collide.can = true
	function e:hover(...)
		local res = Handy.L.loc_vars(item, {
			set = "Handy_ConfigDictionary",
			key = item.key,
		})
		local success, loc_table = pcall(function()
			return G.localization.descriptions[res.set][res.key].unlock_parsed
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

G.FUNCS.handy_setup_point_arrows = function(e)
	e.config.func = nil
	for index, arrow in ipairs(e.config.ref_table or {}) do
		local sprite = AnimatedSprite(0, 0, 0.5, 1.5, G.ANIMATION_ATLAS["handy_hint_arrow"], { x = 0, y = 0 })
		local content = {
			{
				n = G.UIT.O,
				config = {
					object = sprite,
				},
			},
		}
		local text_node = {
			n = G.UIT.O,
			config = {
				object = UIBox({
					definition = {
						n = G.UIT.ROOT,
						config = { padding = 0.1, r = 0.25, colour = { 0, 0, 0, 0.5 } },
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = arrow.text,
									scale = 0.32,
									colour = G.C.UI.TEXT_LIGHT,
								},
							},
						},
					},
					config = {
						align = arrow.text_align or "cli",
						offset = { x = arrow.text_offset_x or 0, y = arrow.text_offset_y or 0 },
					},
				}),
			},
		}
		if arrow.prepend_text then
			table.insert(content, 1, text_node)
		else
			table.insert(content, text_node)
		end
		local box = UIBox({
			definition = {
				n = G.UIT.ROOT,
				config = { colour = G.C.CLEAR, padding = 0.1, align = "cm" },
				nodes = content,
			},
			config = {
				major = e,
				parent = e,
				align = arrow.align,
				offset = {
					x = arrow.offset_x or 0,
					y = arrow.offset_y or 0,
				},
			},
		})
		if arrow.prepend_text then
			function box.UIRoot:draw_children()
				if self.states.visible then
					-- Draw children in reverse order
					for k = #self.children, 1, -1 do
						local v = self.children[k]
						if not v.config.draw_layer and k ~= "h_popup" and k ~= "alert" then
							if v.draw_self and not v.config.draw_after then
								v:draw_self()
							else
								v:draw()
							end
							if v.draw_children then
								v:draw_children()
							end
							if v.draw_self and v.config.draw_after then
								v:draw_self()
							else
								v:draw()
							end
						end
					end
				end
			end
		end
		sprite.role.r_bond = "Weak"
		sprite.T.r = arrow.r or 0.25
		sprite.VT.r = sprite.T.r
		sprite.states.collide.can = false
		box.states.collide.can = false
		e.children["handy_arrow_" .. index] = box
	end
end
