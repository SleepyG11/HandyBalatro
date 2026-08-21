function Handy.UI.appearance_page_definition()
	local content = {
		n = G.UIT.R,
		config = { align = "cm", colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.1 },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					colour = adjust_alpha(HEX("000000"), 0.1),
					align = "cm",
					r = 0.5,
				},
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm", r = 0.1 },
						nodes = {
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.me, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.me_in_mod_config),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.me_in_game_over),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.me_in_game_win),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.me_in_screenswipe),
							Handy.UI.CP.r_sep(0.1),
							{
								n = G.UIT.R,
								config = {
									func = "handy_setup_me_in_appearance",
								},
								nodes = {
									Handy.UI.CP.dictionary_item(Handy.D.dictionary.appearance, { bg = true }),
								},
							},
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.hide_options_button),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.speed_multiplier_settings_toggle),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.animation_skip_settings_toggle),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.notifications_level),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.show_custom_pip),
							Handy.UI.CP.r_sep(0.1),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.gamepad, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.controller_sensitivity),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.swap_controller_cursor_stick),
							Handy.UI.CP.r_sep(0.1),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.prevent_if_debugplus, { bg = true }),
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
		},
	}
end
function Handy.UI.appearance_page_UIBox()
	return create_UIBox_generic_options({
		contents = {
			Handy.UI.appearance_page_definition(),
		},
		back_func = "handy_back_to_options",
	})
end

function Handy.UI.appearance_page()
	Handy.UI.data.rerender_uibox_func = Handy.UI.appearance_page_UIBox
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = Handy.UI.appearance_page_UIBox(),
		is_handy_config = true,
	})
	Handy.UI.CHAR.hide("me")
	Handy.UI.attach_side_panel()
	G.OVERLAY_MENU:recalculate()
end

G.FUNCS.handy_appearance = function(e)
	Handy.UI.appearance_page()
end
G.FUNCS.handy_setup_me_in_appearance = function(e)
	local atlas = G.ASSET_ATLAS["handy_me"]
	local pos = { x = 2, y = 2 }
	local ratio = atlas.py / atlas.px
	local h = 4.1
	local sprite = Sprite(0, 0, h / ratio, h, atlas, pos)
	local sprite_box = UIBox({
		definition = {
			n = G.UIT.ROOT,
			config = { colour = G.C.CLEAR },
			nodes = {
				{
					n = G.UIT.R,
					nodes = {
						{
							n = G.UIT.O,
							config = {
								object = sprite,
							},
						},
					},
				},
			},
		},
		config = {
			parent = e,
			major = e,
			align = "bri",
			offset = { x = 0.3, y = 0.6 },
		},
	})
	sprite.role.r_bond = "Strong"
	sprite.role.xy_bond = "Strong"
	sprite.role.scale_bond = "Strong"
	sprite_box.role.xy_bond = "Strong"
	sprite_box.role.r_bond = "Strong"
	sprite_box.role.scale_bond = "Strong"
	sprite_box.states.collide.can = true
	sprite.states.collide.can = false
	table.insert(e.children, sprite_box)

	function sprite_box:click()
		sprite_box.states.collide.can = false
		Handy.UI.CHAR.jump_container(self)
		if math.random() > 0.75 then
			sprite:set_sprite_pos({ x = 0, y = 2 })
		else
			sprite:set_sprite_pos({ x = 1, y = 2 })
		end
		G.E_MANAGER:add_event(
			Event({
				trigger = "after",
				delay = 0.25,
				func = function()
					sprite_box.states.collide.can = true
					sprite:set_sprite_pos({ x = 2, y = 2 })
					return true
				end,
			}),
			"handy_chars"
		)
	end

	e.config.func = nil
end
