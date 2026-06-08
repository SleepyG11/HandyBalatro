function Handy.UI.attach_side_panel_content()
	return {
		n = G.UIT.C,
		config = { align = "cm" },
		nodes = {
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					Handy.UI.CP.small_option_cycle(Handy.D.dictionary.current_device),
				},
			},
			Handy.UI.CP.r_sep(0.1),
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					Handy.UI.CP.small_option_cycle(Handy.D.dictionary.keybinds_trigger_mode),
				},
			},
			-- Handy.UI.CP.r_sep(0.1),
			-- {
			-- 	n = G.UIT.R,
			-- 	config = { align = "cm", maxw = 2.8 },
			-- 	nodes = {
			-- 		Handy.UI.CP.c_sep(0.1),
			-- 		{
			-- 			n = G.UIT.C,
			-- 			config = { align = "cl" },
			-- 			nodes = {
			-- 				{
			-- 					n = G.UIT.R,
			-- 					config = { align = "cr", maxw = 2 },
			-- 					nodes = {
			-- 						{
			-- 							n = G.UIT.T,
			-- 							config = {
			-- 								text = Handy.L.dictionary("handy_advanced_mode"),
			-- 								scale = 0.25,
			-- 								colour = G.C.UI.TEXT_LIGHT,
			-- 							},
			-- 						},
			-- 					},
			-- 				},
			-- 				Handy.UI.CP.r_sep(0.05),
			-- 				{
			-- 					n = G.UIT.R,
			-- 					config = { align = "cr", maxw = 2 },
			-- 					nodes = {
			-- 						{
			-- 							n = G.UIT.T,
			-- 							config = {
			-- 								text = Handy.L.dictionary("handy_advanced_mode_description"),
			-- 								scale = 0.185,
			-- 								colour = adjust_alpha(G.C.UI.TEXT_LIGHT, 0.7),
			-- 							},
			-- 						},
			-- 					},
			-- 				},
			-- 			},
			-- 		},
			-- 		{
			-- 			n = G.UIT.C,
			-- 			config = { align = "cr" },
			-- 			nodes = {
			-- 				create_toggle({
			-- 					scale = 0.5,
			-- 					ref_table = Handy.cc.advanced_mode,
			-- 					ref_value = "enabled",
			-- 					label = "",
			-- 					w = 0,
			-- 					label_scale = 0,
			-- 					callback = function()
			-- 						Handy.config.request_save()
			-- 						Handy.UI.rerender(true)
			-- 					end,
			-- 				}),
			-- 			},
			-- 		},
			-- 	},
			-- },
		},
	}
end
function Handy.UI.attach_side_panel()
	if not G.OVERLAY_MENU then
		return
	end
	local p, p_draw_parent
	pcall(function()
		p = G.OVERLAY_MENU.UIRoot.children[1]
		p_draw_parent = p.parent
	end)
	if not p or not p_draw_parent then
		return
	end

	local box = UIBox({
		definition = {
			n = G.UIT.ROOT,
			config = {
				align = "cm",
				r = 0.3,
				padding = 0.07,
				colour = G.C.JOKER_GREY,
				emboss = 0.1,
			},
			nodes = {
				{
					n = G.UIT.R,
					config = {
						align = "cm",
						r = 0.2,
						padding = 0.25,
						minw = 2.85,
						colour = G.C.L_BLACK,
					},
					nodes = { Handy.UI.CP.c_sep(0.75), Handy.UI.attach_side_panel_content() },
				},
			},
		},
		config = {
			parent = p,
			major = p,
			align = "bri",
			offset = { x = 3.1, y = -0.2 },
		},
	})
	table.insert(p_draw_parent.children, 1, box)
end
