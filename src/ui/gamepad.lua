function Handy.UI.get_button_sprites_map()
	local y = G.CONTROLLER.GAMEPAD_CONSOLE == "Nintendo" and 2
		or G.CONTROLLER.GAMEPAD_CONSOLE == "Playstation" and (G.F_PS4_PLAYSTATION_GLYPHS and 3 or 1)
		or 0
	local button_sprite_map = {
		["(A)"] = G.F_SWAP_AB_PIPS and 1 or 0,
		["(B)"] = G.F_SWAP_AB_PIPS and 0 or 1,
		["(X)"] = 2,
		["(Y)"] = 3,
		["Left Bumper"] = 4,
		["Right Bumper"] = 5,
		["Left Trigger"] = 6,
		["Right Trigger"] = 7,
		["(Start)"] = 8,
		["(Back)"] = 9,
		["(Up)"] = 10,
		["(Right)"] = 11,
		["(Down)"] = 12,
		["(Left)"] = 13,
		["left"] = 14, -- ?
		["right"] = 15, -- ?
		["Left Stick"] = 16,
		["Right Stick"] = 17,
		["(Guide)"] = (y == 1 or y == 3) and 19 or nil,
	}
	return button_sprite_map
end

function Handy.UI.custom_button_pip(args)
	args = args or {}

	local y = G.CONTROLLER.GAMEPAD_CONSOLE == "Nintendo" and 2
		or G.CONTROLLER.GAMEPAD_CONSOLE == "Playstation" and (G.F_PS4_PLAYSTATION_GLYPHS and 3 or 1)
		or 0
	local button_sprite_map = Handy.UI.get_button_sprites_map()

	local cols = {}
	for _, button in ipairs(args.override.prev_buttons_array) do
		if cols[1] then
			table.insert(cols, {
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = "+",
							scale = (args.scale or 0.45) * 0.4,
							colour = G.C.UI.TEXT_LIGHT,
						},
					},
				},
			})
		end
		if button_sprite_map[button] then
			table.insert(cols, {
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.O,
						config = {
							object = Sprite(
								0,
								0,
								(args.scale or 0.45) * 0.65,
								(args.scale or 0.45) * 0.65,
								G.ASSET_ATLAS["gamepad_ui"],
								{
									x = button_sprite_map[button],
									y = y,
								}
							),
						},
					},
				},
			})
		else
			table.insert(cols, {
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = button or "ERROR",
							scale = (args.scale or 0.45) * 0.5,
							colour = G.C.UI.TEXT_LIGHT,
						},
					},
				},
			})
		end
	end

	if #cols == 0 then
		return {
			n = G.UIT.ROOT,
			config = {
				colour = G.C.CLEAR,
			},
		}
	else
		table.insert(cols, 1, {
			n = G.UIT.C,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = "[",
						scale = (args.scale or 0.45) * 0.4,
						colour = G.C.UI.TEXT_LIGHT,
					},
				},
			},
		})
		table.insert(cols, 1, {
			n = G.UIT.B,
			config = { w = 0.025, h = 0 },
		})

		table.insert(cols, {
			n = G.UIT.C,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = "]",
						scale = (args.scale or 0.45) * 0.4,
						colour = G.C.UI.TEXT_LIGHT,
					},
				},
			},
		})
		table.insert(cols, {
			n = G.UIT.B,
			config = { w = 0.025, h = 0 },
		})
	end

	return {
		n = G.UIT.ROOT,
		config = {
			align = "cm",
			colour = { 0, 0, 0, 0.4 },
			padding = 0.04,
			r = 0.1,
			minw = 0.45,
			minh = 0.301,
		},
		nodes = {
			{
				n = G.UIT.R,
				config = { padding = 0.035, align = "cm" },
				nodes = cols,
			},
		},
	}
end
