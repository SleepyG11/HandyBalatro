function Handy.UI.get_button_offset_y()
	return G.CONTROLLER.GAMEPAD_CONSOLE == "Nintendo" and 2
		or G.CONTROLLER.GAMEPAD_CONSOLE == "Playstation" and (G.F_PS4_PLAYSTATION_GLYPHS and 3 or 1)
		or 0
end
function Handy.UI.get_button_offset(button)
	local y = Handy.UI.get_button_offset_y()
	G.ARGS.handy_button_sprite_map = G.ARGS.handy_button_sprite_map or {}
	G.ARGS.handy_button_sprite_map[y] = G.ARGS.handy_button_sprite_map[y]
		or {
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
	return G.ARGS.handy_button_sprite_map[y][button], y
end

function Handy.UI.create_gamepad_button_sprite(button, scale)
	local x, y = Handy.UI.get_button_offset(button)
	if x and y then
		return Sprite(0, 0, (scale or 0.45) * 0.65, (scale or 0.45) * 0.65, G.ASSET_ATLAS["gamepad_ui"], {
			x = x,
			y = y,
		})
	end
end

function Handy.UI.custom_button_pip(args)
	args = args or {}

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
		local button_sprite = Handy.UI.create_gamepad_button_sprite(button, args.scale or 0.45)
		if button_sprite then
			table.insert(cols, {
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.O,
						config = {
							object = button_sprite,
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

function Handy.UI.gamepad_2step_control_select()
	return {
		n = G.UIT.ROOT,
		config = {
			align = "cm",
			colour = { 0, 0, 0, 0.75 },
			r = 0.25,
			padding = 0.1,
		},
		nodes = {
			{
				n = G.UIT.O,
				config = {
					object = Handy.UI.create_gamepad_button_sprite("(A)", 0.6),
				},
			},
			{
				n = G.UIT.T,
				config = {
					text = Handy.L.dictionary("handy_gamepad_2step_select"),
					scale = 0.32,
					colour = G.C.UI.TEXT_LIGHT,
				},
			},
		},
	}
end
function Handy.UI.gamepad_2step_control_deselect()
	return {
		n = G.UIT.ROOT,
		config = {
			align = "cm",
			colour = { 0, 0, 0, 0.75 },
			r = 0.25,
			padding = 0.1,
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					align = "cm",
				},
				nodes = {
					{
						n = G.UIT.O,
						config = {
							object = Handy.UI.create_gamepad_button_sprite("(Left)", 0.6),
						},
					},
					{
						n = G.UIT.O,
						config = {
							object = Handy.UI.create_gamepad_button_sprite("(Right)", 0.6),
						},
					},
				},
			},
			{
				n = G.UIT.T,
				config = {
					text = Handy.L.dictionary("handy_gamepad_2step_adjust"),
					scale = 0.32,
					colour = G.C.UI.TEXT_LIGHT,
				},
			},
			{ n = G.UIT.C, config = { minw = 0.1 } },
			{
				n = G.UIT.O,
				config = {
					object = Handy.UI.create_gamepad_button_sprite("(A)", 0.6),
				},
			},
			{
				n = G.UIT.T,
				config = {
					text = Handy.L.dictionary("handy_gamepad_2step_deselect"),
					scale = 0.32,
					colour = G.C.UI.TEXT_LIGHT,
				},
			},
		},
	}
end

function G.FUNCS.handy_gamepad_2step_control(e)
	local should_display = e.states.focus.is and Handy.controller.is_gamepad()
	if should_display then
		local is_selected = Handy.UI.data.gamepad_focused_element == e
		local new_content
		if not e.children.handy_gamepad_2step then
			new_content = is_selected and Handy.UI.gamepad_2step_control_deselect()
				or Handy.UI.gamepad_2step_control_select()
		elseif is_selected and not e.children.handy_gamepad_2step.handy_display_selected then
			new_content = Handy.UI.gamepad_2step_control_deselect()
		elseif not is_selected and e.children.handy_gamepad_2step.handy_display_selected then
			new_content = Handy.UI.gamepad_2step_control_select()
		end
		if new_content then
			if e.children.handy_gamepad_2step then
				e.children.handy_gamepad_2step:remove()
			end
			local element = UIBox({
				definition = new_content,
				config = {
					align = "tm",
					offset = {
						x = 0,
						y = -0.1,
					},
					parent = e,
					major = e,
				},
			})
			element.handy_display_selected = is_selected
			e.children.handy_gamepad_2step = element
		end
	elseif not should_display and e.children.handy_gamepad_2step then
		e.children.handy_gamepad_2step:remove()
		e.children.handy_gamepad_2step = nil
	end
end
