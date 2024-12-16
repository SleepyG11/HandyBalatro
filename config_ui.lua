Handy.UI.PARTS = {
	create_module_checkbox = function(module, label, text_prefix, text_lines, skip_keybinds)
		local desc_lines = {
			{ n = G.UIT.R, config = { minw = 5.25 } },
		}

		if skip_keybinds then
			table.insert(desc_lines, {
				n = G.UIT.R,
				config = { padding = 0.025 },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = text_prefix .. " " .. text_lines[1],
							scale = 0.3,
							colour = G.C.TEXT_LIGHT,
						},
					},
				},
			})
		else
			local key_desc = module.key_2
					and {
						{
							n = G.UIT.T,
							config = {
								text = text_prefix .. " [",
								scale = 0.3,
								colour = G.C.TEXT_LIGHT,
							},
						},
						{
							n = G.UIT.T,
							config = {
								ref_table = module,
								ref_value = "key_1",
								scale = 0.3,
								colour = G.C.TEXT_LIGHT,
							},
						},
						{
							n = G.UIT.T,
							config = {
								text = "] or [",
								scale = 0.3,
								colour = G.C.TEXT_LIGHT,
							},
						},
						{
							n = G.UIT.T,
							config = {
								ref_table = module,
								ref_value = "key_2",
								scale = 0.3,
								colour = G.C.TEXT_LIGHT,
							},
						},
						{
							n = G.UIT.T,
							config = {
								text = "] " .. text_lines[1],
								scale = 0.3,
								colour = G.C.TEXT_LIGHT,
							},
						},
					}
				or {
					{
						n = G.UIT.T,
						config = {
							text = text_prefix .. " [",
							scale = 0.3,
							colour = G.C.TEXT_LIGHT,
						},
					},
					{
						n = G.UIT.T,
						config = {
							ref_table = module,
							ref_value = "key_1",
							scale = 0.3,
							colour = G.C.TEXT_LIGHT,
						},
					},
					{
						n = G.UIT.T,
						config = {
							text = "] " .. text_lines[1],
							scale = 0.3,
							colour = G.C.TEXT_LIGHT,
						},
					},
				}
			table.insert(desc_lines, {
				n = G.UIT.R,
				config = { padding = 0.025 },
				nodes = key_desc,
			})
		end

		for i = 2, #text_lines do
			table.insert(desc_lines, {
				n = G.UIT.R,
				config = { padding = 0.025 },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = text_lines[i],
							scale = 0.3,
							colour = G.C.TEXT_LIGHT,
						},
					},
				},
			})
		end

		local label_lines = {}
		if type(label) == "string" then
			label = { label }
		end
		for i = 1, #label do
			table.insert(label_lines, {
				n = G.UIT.R,
				config = { minw = 2.75 },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = label[i],
							scale = 0.4,
							colour = G.C.WHITE,
						},
					},
				},
			})
		end

		return {
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = label_lines,
				},
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = {
						create_toggle({
							callback = function(b)
								return G.FUNCS.handy_toggle_module_enabled(b, module)
							end,
							label_scale = 0.4,
							label = "",
							ref_table = module,
							ref_value = "enabled",
							w = 0,
						}),
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

	create_module_section = function(label)
		return {
			n = G.UIT.R,
			config = { align = "cm", padding = 0.1 },
			nodes = {
				{
					n = G.UIT.T,
					config = { text = label, colour = G.C.WHITE, scale = 0.4, align = "cm" },
				},
			},
		}
	end,
	create_module_keybind = function(module, label, plus, dangerous)
		return {
			n = G.UIT.R,
			config = { align = "cm", padding = 0.05 },
			nodes = {
				{
					n = G.UIT.C,
					config = { align = "c", minw = 4 },
					nodes = {
						{
							n = G.UIT.T,
							config = { text = label, colour = G.C.WHITE, scale = 0.35 },
						},
					},
				},
				{
					n = G.UIT.C,
					config = { align = "cm", minw = 0.75 },
				},
				UIBox_button({
					label = { module.key_1 or "None" },
					col = true,
					colour = dangerous and G.C.MULT or G.C.CHIPS,
					scale = 0.35,
					minw = 2.75,
					minh = 0.45,
					ref_table = {
						module = module,
						key = "key_1",
					},
					button = "handy_init_keybind_change",
				}),
				{
					n = G.UIT.C,
					config = { align = "cm", minw = 0.6 },
					nodes = {
						{
							n = G.UIT.T,
							config = { text = plus and "+" or "or", colour = G.C.WHITE, scale = 0.3 },
						},
					},
				},
				UIBox_button({
					label = { module.key_2 or "None" },
					col = true,
					colour = dangerous and G.C.MULT or G.C.CHIPS,
					scale = 0.35,
					minw = 2.75,
					minh = 0.45,
					ref_table = {
						module = module,
						key = "key_2",
					},
					button = "handy_init_keybind_change",
				}),
			},
		}
	end,
}

Handy.UI.get_config_tab_overall = function()
	return {
		{
			n = G.UIT.R,
			config = { padding = 0.05, align = "cm" },
			nodes = {
				create_option_cycle({
					minw = 3,
					label = "Notifications level",
					scale = 0.8,
					options = {
						"None",
						"Dangerous",
						"Game state",
						"All",
					},
					opt_callback = "handy_change_notifications_level",
					current_option = Handy.config.current.notifications_level,
				}),
			},
		},
		{ n = G.UIT.R, config = { padding = 0.05 }, nodes = {} },
		{
			n = G.UIT.R,
			nodes = {
				{
					n = G.UIT.C,
					nodes = {
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.insta_buy_or_sell,
							"Quick Buy/Sell",
							"Hold",
							{
								"to",
								"buy or sell card on Left-Click",
								"instead of selection",
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(Handy.config.current.insta_use, "Quick use", "Hold", {
							"to",
							"use (if possible) card on Left-Click",
							"instead of selection",
							"(overrides Quick Buy/Sell)",
						}),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.move_highlight,
							"Move highlight",
							"Press",
							{
								"["
									.. tostring(Handy.config.current.move_highlight.dx.one_left.key_1)
									.. "] or ["
									.. tostring(Handy.config.current.move_highlight.dx.one_right.key_1)
									.. "]",
								"to move highlight in card area.",
								"Hold ["
									.. tostring(Handy.config.current.move_highlight.swap.key_1)
									.. "] to move card instead.",
								"Hold ["
									.. tostring(Handy.config.current.move_highlight.to_end.key_1)
									.. "] to move to first/last card",
							},
							true
						),
					},
				},
				{
					n = G.UIT.C,
					config = { minw = 4 },
					nodes = {
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.insta_cash_out,
							"Quick Cash Out",
							"Press",
							{
								"to",
								"speedup animation and",
								"skip Cash Out stage",
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.insta_highlight,
							"Quick Highlight",
							"Hold [Left Mouse]",
							{
								"and",
								"hover cards in hand to highlight",
							},
							true
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.speed_multiplier,
							"Speed Multiplier",
							"Hold",
							{
								"and",
								"[Wheel Up] to multiply or",
								"[Wheel Down] to divide game speed",
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.shop_reroll,
							"Shop Reroll",
							"Press",
							{
								"to",
								"reroll a shop",
							}
						),
						{ n = G.UIT.R, config = { minh = 0.25 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.play_and_discard,
							"Play/Discard",
							"Press",
							{
								"[" .. tostring(Handy.config.current.play_and_discard.play.key_1) .. "] to play a hand",
								"or ["
									.. tostring(Handy.config.current.play_and_discard.discard.key_1)
									.. "] to discard",
							},
							true
						),
					},
				},
			},
		},
	}
end

Handy.UI.get_config_tab_interactions = function()
	return {
		{
			n = G.UIT.R,
			nodes = {
				{
					n = G.UIT.C,
					nodes = {
						Handy.nopeus_interaction.is_present() and Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.nopeus_interaction,
							{ "Nopeus:", "fast-forward" },
							"Hold",
							{
								"and",
								"[Wheel Up] to increase or",
								"[Wheel Down] to decrease",
								"fast-forward setting",
							}
						) or nil,
						Handy.not_just_yet_interaction.is_present() and Handy.nopeus_interaction.is_present() and {
							n = G.UIT.R,
							config = { minh = 0.25 },
						} or nil,
						Handy.not_just_yet_interaction.is_present() and Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.not_just_yet_interaction,
							{ "NotJustYet:", "End round" },
							"Press",
							{
								"to",
								"end round",
							}
						) or nil,
					},
				},
			},
		},
	}
end

Handy.UI.get_config_tab_dangerous = function()
	return {
		-- {
		-- 	n = G.UIT.R,
		-- 	config = { padding = 0.05, align = "cm" },
		-- 	nodes = {

		-- 	},
		-- },
		-- { n = G.UIT.R, config = { padding = 0.05 }, nodes = {} },
		{
			n = G.UIT.R,
			nodes = {
				{
					n = G.UIT.C,
					nodes = {
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.dangerous_actions,
							{ "Dangerous", "actions" },
							"Enable",
							{
								"unsafe controls. They're",
								"designed to be speed-first,",
								"which can cause bugs or crashes",
							},
							true
						),
						{ n = G.UIT.R, config = { minh = 0.5 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.dangerous_actions.immediate_buy_and_sell,
							"Instant Sell",
							"Hold",
							{
								"to",
								"sell card on hover",
								"very fast",
							}
						),
						{ n = G.UIT.R, config = { minh = 0.1 } },
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.dangerous_actions.immediate_buy_and_sell.queue,
							"Sell Queue",
							"Start",
							{
								"selling cards only when",
								"keybind was released",
							},
							true
						),
						Handy.nopeus_interaction.is_present() and { n = G.UIT.R, config = { minh = 0.25 } } or nil,
						Handy.nopeus_interaction.is_present() and Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.dangerous_actions.nopeus_unsafe,
							{ "Nopeus: Unsafe", "fast-forward" },
							"Allow",
							{
								"increase fast-forward",
								'setting to "Unsafe"',
							},
							true
						) or nil,
					},
				},
			},
		},
	}
end

Handy.UI.get_config_tab_keybinds = function()
	return {
		Handy.UI.PARTS.create_module_section("Quick Actions"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.insta_buy_or_sell, "Quick Buy/Sell"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.insta_use, "Quick Use"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.insta_cash_out, "Quick Cash Out"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.shop_reroll, "Shop reroll"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.play_and_discard.play, "Play hand"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.play_and_discard.discard, "Discard"),
		Handy.UI.PARTS.create_module_keybind(
			Handy.config.current.dangerous_actions.immediate_buy_and_sell,
			"Instant Buy/Sell",
			false,
			true
		),
		Handy.not_just_yet_interaction.is_present() and Handy.UI.PARTS.create_module_keybind(
			Handy.config.current.not_just_yet_interaction,
			"NotJustYet: End round"
		) or nil,
	}
end

Handy.UI.get_config_tab_keybinds_2 = function()
	return {
		Handy.UI.PARTS.create_module_section("Game state"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.speed_multiplier, "Speed Multiplier"),
		Handy.nopeus_interaction.is_present() and Handy.UI.PARTS.create_module_keybind(
			Handy.config.current.nopeus_interaction,
			"Nopeus: fast-forward"
		) or nil,
		Handy.UI.PARTS.create_module_section("Move highlight"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.move_highlight.dx.one_left, "Move one left"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.move_highlight.dx.one_right, "Move one right"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.move_highlight.swap, "Move card"),
		Handy.UI.PARTS.create_module_keybind(Handy.config.current.move_highlight.to_end, "Move to end"),
	}
end

Handy.UI.get_config_tab = function(_tab)
	local result = {
		n = G.UIT.ROOT,
		config = { align = "cm", padding = 0.05, colour = G.C.CLEAR, minh = 5, minw = 5 },
		nodes = {},
	}
	if _tab == "Overall" then
		result.nodes = Handy.UI.get_config_tab_overall()
	elseif _tab == "Interactions" then
		result.nodes = Handy.UI.get_config_tab_interactions()
	elseif _tab == "Dangerous" then
		result.nodes = Handy.UI.get_config_tab_dangerous()
	elseif _tab == "Keybinds" then
		result.nodes = Handy.UI.get_config_tab_keybinds()
	elseif _tab == "Keybinds 2" then
		result.nodes = Handy.UI.get_config_tab_keybinds_2()
	end
	return result
end
