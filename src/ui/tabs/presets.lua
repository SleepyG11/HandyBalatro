function Handy.UI.CP.example_preset(key)
	return {
		n = G.UIT.R,
		config = {
			align = "cm",
		},
		nodes = {
			UIBox_button({
				label = { Handy.L.name_text("Handy_Preset", key) },
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
			Handy.UI.CP.c_sep(0.1),
			Handy.L.description("Handy_Preset", key, {
				default_col = G.C.UI.TEXT_LIGHT,
			}, {
				padding = 0.025,
				minw = 6,
				maxw = 6,
				align = "c",
			}),
		},
	}
end
function Handy.UI.CP.user_preset(index)
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
							return G.FUNCS.handy_toggle_preset_enabled(index, b)
						end,
						label_scale = 0.35,
						label = "",
						ref_table = preset,
						ref_value = "enabled",
						w = 0,
						scale = 0.8,
						focus_args = { nav = "wide" },
					}),
				},
			},
			Handy.UI.CP.c_sep(0.05),
			create_text_input({
				id = "handy_preset_name_" .. tostring(index),
				prompt_text = Handy.L.dictionary("handy_preset_name_placeholder"),
				extended_corpus = true,
				ref_table = name_object,
				ref_value = "name",
				text_scale = 0.35,
				max_length = 16,
				w = 3.5,
				h = 0.15,
				callback = function()
					G.FUNCS.handy_save_preset_name(index, name_object.name)
				end,
			}),
			Handy.UI.CP.c_sep(0.2),
			UIBox_button({
				label = { Handy.L.dictionary("b_handy_preset_save") },
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
			Handy.UI.CP.c_sep(0.1),
			UIBox_button({
				label = { Handy.L.dictionary("b_handy_preset_load") },
				col = true,
				colour = G.C.GREEN,
				scale = 0.3,
				minw = 1.75,
				maxw = 1.75,
				minh = 0.5,
				maxh = 0.5,
				ref_table = {
					index = index,
				},
				button = "handy_load_preset_index",
				func = "handy_can_load_preset_index",
			}),
			Handy.UI.CP.c_sep(0.1),
			UIBox_button({
				label = { Handy.L.dictionary("b_handy_preset_clear") },
				col = true,
				colour = G.C.MULT,
				scale = 0.3,
				minw = 1.75,
				maxw = 1.75,
				minh = 0.5,
				maxh = 0.5,
				ref_table = {
					index = index,
				},
				button = "handy_clear_preset_index",
				func = "handy_can_clear_preset_index",
			}),
		},
	}
end

--

function Handy.UI.presets_tab_UIBox()
	local premade = {
		n = G.UIT.R,
		config = { align = "cm", colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.15 },
		nodes = {
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = Handy.L.dictionary("ph_handy_premade_presets"),
							scale = 0.4,
							colour = G.C.WHITE,
							align = "cm",
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = {
							-- colour = adjust_alpha(HEX("000000"), 0.1),
							r = 0.5,
							align = "cm",
						},
						nodes = {
							{
								n = G.UIT.C,
								config = { padding = 0.075 },
								nodes = {
									Handy.UI.CP.example_preset("default"),
									Handy.UI.CP.example_preset("better_mouse_and_gamepad"),
								},
							},
						},
					},
				},
			},
		},
	}
	local custom = {
		n = G.UIT.R,
		config = { align = "cm", colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.15 },
		nodes = {
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = Handy.L.dictionary("ph_handy_custom_presets"),
							scale = 0.4,
							colour = G.C.WHITE,
							align = "cm",
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = { padding = 0.075, align = "cm" },
						nodes = {
							Handy.UI.CP.user_preset(1),
							Handy.UI.CP.user_preset(2),
							Handy.UI.CP.user_preset(3),
						},
					},
				},
			},
		},
	}
	local keybinds = {
		n = G.UIT.R,
		config = { align = "cm" },
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
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.presets, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.presets_load_1),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.presets_load_2),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.presets_load_3),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.presets_load_next),
						},
					},
				},
			},
		},
	}

	return {
		n = G.UIT.C,
		config = { align = "cm", padding = 0.1, colour = { 0, 0, 0, 0.1 }, r = 0.25 },
		nodes = {
			premade,
			custom,
			keybinds,
		},
	}
end

function Handy.UI.presets_tab()
	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			Handy.UI.presets_tab_UIBox(),
		},
	}
end

--

G.FUNCS.handy_toggle_preset_enabled = function(index, b)
	Handy.presets.save_index(index, { enabled = b })
end
G.FUNCS.handy_save_preset_name = function(index, name)
	Handy.presets.save_index(index, { name = name })
end
G.FUNCS.handy_save_preset_index_with_name = function(e)
	local index = e.config.ref_table.index
	local new_name = e.config.ref_table.name_object.name
	Handy.presets.save_index(index, { name = new_name, apply = true })
	local preset = Handy.presets.current.user[index]
	Handy.UI.state_panel.display(function(state)
		state.items.presets_change = {
			text = Handy.L.variable("Handy_preset_saved", { index, preset.name or "" }),
			hold = false,
			order = 15,
		}
		return true
	end)
end
G.FUNCS.handy_load_preset_index = function(e)
	local index = e.config.ref_table.index
	Handy.presets.apply_index(index)
	local preset = Handy.presets.current.user[index]
	Handy.UI.state_panel.display(function(state)
		state.items.presets_change = {
			text = Handy.L.variable("Handy_preset_loaded", { index, preset.name or "" }),
			hold = false,
			order = 15,
		}
		return true
	end)
end
G.FUNCS.handy_clear_preset_index = function(e)
	local index = e.config.ref_table.index
	Handy.presets.clear_index(index)
end

G.FUNCS.handy_apply_preset_key = function(e)
	local key = e.config.ref_table.key
	Handy.presets.apply_example(key)
	Handy.UI.state_panel.display(function(state)
		state.items.presets_change = {
			text = Handy.L.variable("Handy_preset_example_loaded", { Handy.L.name_text("Handy_Preset", key) }),
			hold = false,
			order = 15,
		}
		return true
	end)

	if key == "better_mouse_and_gamepad" then
		G.E_MANAGER:clear_queue("handy_chars")
		Handy.UI.CHAR.set_sprite_pos("me", "happy")
		Handy.UI.CHAR.jump("me")
		delay(0.2, "handy_chars")
		Handy.UI.CHAR.set_sprite_pos("me", "default", true)
	end
end

G.FUNCS.handy_can_load_preset_index = function(e)
	local index = e.config.ref_table.index
	local preset = Handy.presets.current.user[index]
	if preset and preset.config then
		e.config.button = "handy_load_preset_index"
		e.config.colour = G.C.GREEN
	else
		e.config.button = "handy_noop"
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
	end
end
G.FUNCS.handy_can_clear_preset_index = function(e)
	local index = e.config.ref_table.index
	local preset = Handy.presets.current.user[index]
	if preset and preset.config then
		e.config.button = "handy_clear_preset_index"
		e.config.colour = G.C.MULT
	else
		e.config.button = "handy_noop"
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
	end
end
