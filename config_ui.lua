Handy.UI.PARTS = {
	create_module_checkbox = function(module, label, text_prefix, text_lines, skip_keybinds)
		local desc_lines = {
			{ n = G.UIT.R, config = { minw = 5 } },
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
		return {
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				create_toggle({
					callback = function(b)
						return G.FUNCS.handy_toggle_module_enabled(b, module)
					end,
					label_scale = 0.4,
					label = label,
					ref_table = module,
					ref_value = "enabled",
					col = true,
				}),
				{
					n = G.UIT.C,
					nodes = desc_lines,
				},
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
					minw = 2,
					label = "Notifications level",
					scale = 0.8,
					options = {
						"None",
						"Dangerous",
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
						{ n = G.UIT.R, config = { minh = 0.2 } },
						Handy.UI.PARTS.create_module_checkbox(Handy.config.current.insta_use, "Quick use", "Hold", {
							"to",
							"use (if possible) card on Left-Click",
							"instead of selection",
							"(overrides Quick Buy/Sell)",
						}),
						{ n = G.UIT.R, config = { minh = 0.2 } },
						-- TODO: make it properly
						Handy.UI.PARTS.create_module_checkbox(
							Handy.config.current.move_highlight,
							"Move highlight",
							"Press",
							{
								"[Left Arrow] or [Right Arrow]",
								"to move highlight in card area.",
								"Hold [Shift] to move card instead.",
								"Hold [Ctrl] to move to first/last card.",
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
						{ n = G.UIT.R, config = { minh = 0.2 } },
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
						{ n = G.UIT.R, config = { minh = 0.2 } },
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
					},
				},
			},
		},
	}
end

Handy.UI.get_config_tab_dangerous = function()
	return {
		{
			n = G.UIT.R,
			config = { padding = 0.05, align = "cm" },
			nodes = {
				Handy.UI.PARTS.create_module_checkbox(
					Handy.config.current.dangerous_actions,
					"Dangerous actions",
					"Enable",
					{
						"unsafe controls. They're",
						"designed to be speed-first,",
						"which can cause bugs or crashes.",
					},
					true
				),
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
							Handy.config.current.dangerous_actions.immediate_buy_and_sell,
							"Instant Buy/Sell",
							"Hold",
							{
								"to",
								"buy or sell card on hover",
								"without any delay",
							}
						),
						-- { n = G.UIT.R, config = { minh = 0.2 } },
						-- Handy.UI.PARTS.create_module_checkbox(Handy.config.current.insta_use, "Quick use", "Hold", {
						-- 	"to",
						-- 	"use (if possible) card on Left-Click",
						-- 	"instead of selection.",
						-- 	"(overrides Quick Buy/Sell)",
						-- }),
					},
				},
				-- {
				-- 	n = G.UIT.C,
				-- 	config = { minw = 4 },
				-- 	nodes = {
				-- 		Handy.UI.PARTS.create_module_checkbox(
				-- 			Handy.config.current.insta_cash_out,
				-- 			"Quick Cash Out",
				-- 			"Press",
				-- 			{
				-- 				"to",
				-- 				"speedup animation and",
				-- 				"skip Cash Out stage.",
				-- 			}
				-- 		),
				-- 		{ n = G.UIT.R, config = { minh = 0.2 } },
				-- 		Handy.UI.PARTS.create_module_checkbox(
				-- 			Handy.config.current.insta_highlight,
				-- 			"Quick Highlight",
				-- 			"Hold [Left Mouse]",
				-- 			{
				-- 				"and",
				-- 				"hover cards in hand to highlight.",
				-- 			},
				-- 			true
				-- 		),
				-- 	},
				-- },
			},
		},
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
	elseif _tab == "Dangerous" then
		result.nodes = Handy.UI.get_config_tab_dangerous()
	end
	return result
end
