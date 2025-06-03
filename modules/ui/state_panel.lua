Handy.UI.state_panel = {
	element = nil,

	previous_state = {
		dangerous = false,
		title = {},
		items = {},
		sub_items = {},
		hold = false,
	},
	current_state = {
		dangerous = false,
		title = {},
		items = {},
		sub_items = {},
		hold = false,
	},

	get_definition = function()
		local state_panel = Handy.UI.state_panel

		local items_raw = {}
		for _, item in pairs(state_panel.current_state.items) do
			table.insert(items_raw, item)
		end

		table.sort(items_raw, function(a, b)
			return a.order < b.order
		end)

		local items = {}
		for _, item in ipairs(items_raw) do
			table.insert(items, {
				n = G.UIT.R,
				config = {
					align = "cm",
					padding = 0.035,
				},
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = item.text,
							scale = 0.225,
							colour = item.dangerous and Handy.UI.C.DYN.TEXT_DANGEROUS or Handy.UI.C.DYN.TEXT,
							shadow = true,
						},
					},
				},
			})
		end

		return {
			n = G.UIT.ROOT,
			config = { align = "cm", padding = 0.1, r = 0.1, colour = G.C.CLEAR, id = "handy_state_panel" },
			nodes = {
				{
					n = G.UIT.C,
					config = {
						align = "cm",
						padding = 0.125,
						r = 0.1,
						colour = Handy.UI.C.DYN.CONTAINER,
					},
					nodes = {
						{
							n = G.UIT.R,
							config = {
								align = "cm",
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										text = state_panel.current_state.title.text,
										scale = 0.3,
										colour = Handy.UI.C.DYN.TEXT,
										shadow = true,
										id = "handy_state_title",
									},
								},
							},
						},
						{
							n = G.UIT.R,
							config = {
								align = "cm",
							},
							nodes = {
								{
									n = G.UIT.C,
									config = {
										align = "cm",
										id = "handy_state_items",
									},
									nodes = items,
								},
							},
						},
					},
				},
			},
		}
	end,
	emplace = function()
		-- Need to remake it at some point
		-- Like come on, create new panel every keypress change?
		-- Well, if it was every frame that would be a problem, but every press is manageable.... right?
		if Handy.UI.state_panel.element then
			Handy.UI.state_panel.element:remove()
		end
		local element = UIBox({
			definition = Handy.UI.state_panel.get_definition(),
			config = {
				instance_type = "ALERT",
				align = "cm",
				major = G.ROOM_ATTACH,
				can_collide = false,
				offset = {
					x = 0,
					y = 3.5,
				},
			},
		})
		Handy.UI.state_panel.element = element
	end,

	render = function()
		local state_panel = Handy.UI.state_panel
		local state = state_panel.current_state

		if not state.title.text then
			if state.dangerous then
				state.title.text = localize("b_handy_notif_dangerous")
			else
				state.title.text = localize("b_handy_notif_quick")
			end
		end

		for _, item in pairs(state.items) do
			if item.hold then
				state.hold = true
			end
		end

		local color = Handy.UI.C.DYN.CONTAINER
		local target_color = state.dangerous and Handy.UI.C.RED or Handy.UI.C.BLACK
		color[1] = target_color[1]
		color[2] = target_color[2]
		color[3] = target_color[3]

		Handy.UI.counter = 0
		Handy.UI.update(0, true)
		state_panel.emplace()
	end,

	update = function(key, released)
		local state_panel = Handy.UI.state_panel

		local state = {
			dangerous = false,
			title = {},
			items = {},
			sub_items = {},
		}

		local is_changed = false

		for _, mod_module in pairs(Handy.modules) do
			if mod_module.update_state_panel then
				local temp_result = mod_module.update_state_panel(state, key, released)
				is_changed = is_changed or temp_result or false
			end
		end

		if is_changed then
			state_panel.previous_state = state_panel.current_state
			state_panel.current_state = state

			state_panel.render()
		else
			state_panel.current_state.hold = false
		end
	end,

	display = function(state_func, override)
		local state_panel = Handy.UI.state_panel

		local should_replace_state = override or not state_panel.current_state.hold
		local state_to_apply = should_replace_state
				and {
					dangerous = false,
					title = {},
					items = {},
					sub_items = {},
				}
			or state_panel.current_state
		local is_changed = state_func(state_to_apply)
		if is_changed then
			if should_replace_state then
				state_panel.previous_state = state_panel.current_state
				state_panel.current_state = state_to_apply
			end
			state_panel.render()
		end
	end,
}
