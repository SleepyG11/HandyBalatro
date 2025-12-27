local state_panel = setmetatable({
	element = nil,

	-- current value in seconds
	duration = 2,
	-- duration in seconds from panel became visible to became full transparent
	full_duration = 1.4,
	-- duration in seconds when state panel is lose opacity
	fade_duration = 0.5,
}, {})
Handy.UI.state_panel = state_panel

--

function state_panel.get_new_state()
	return {
		dangerous = false,
		title = {},
		items = {},
		sub_items = {},
		hold = false,
	}
end

state_panel.current_state = state_panel.get_new_state()
state_panel.previous_state = state_panel.get_new_state()
state_panel.new_state = state_panel.get_new_state()
state_panel.new_state_changed = false

--

function state_panel.get_definition()
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
						colour = item.dangerous and state_panel.C.DYN.TEXT_DANGEROUS or state_panel.C.DYN.TEXT,
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
					colour = state_panel.C.DYN.CONTAINER,
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
									colour = state_panel.C.DYN.TEXT,
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
end

function state_panel.emplace()
	-- Need to remake it at some point
	-- Like come on, create new panel every keypress change?
	-- Well, if it was every frame that would be a problem, but every press is manageable.... right?
	if state_panel.element then
		state_panel.element:remove()
	end
	local element = UIBox({
		definition = state_panel.get_definition(),
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
	state_panel.element = element
end

function state_panel.render(no_reset)
	local state = state_panel.current_state
	local level = Handy.cc.notifications_level.value

	state.hold = false
	state.dangerous = false
	for _, item in pairs(state.items) do
		if item.hold and (not item.level or item.level <= level) then
			state.hold = true
		end
		if item.dangerous then
			state.dangerous = true
		end
	end

	if not state.title.text then
		if state.dangerous then
			state.title.text = Handy.L.dictionary("b_handy_notif_dangerous")
		else
			state.title.text = Handy.L.dictionary("b_handy_notif_quick")
		end
	end

	local color = state_panel.C.DYN.CONTAINER
	local target_color = state.dangerous and state_panel.C.RED or state_panel.C.BLACK
	color[1] = target_color[1]
	color[2] = target_color[2]
	color[3] = target_color[3]

	if not no_reset then
		state_panel.duration = 0
	end
	state_panel.update_opacity(0, true)
	state_panel.emplace()
end

--

-- TODO: implement some sort of opacity mask for element?
state_panel.C = {
	TEXT = HEX("FFFFFF"),
	BLACK = HEX("000000"),
	RED = HEX("FF0000"),

	DYN_BASE_APLHA = {
		CONTAINER = 0.7,

		TEXT = 1,
		TEXT_DANGEROUS = 1,
	},

	DYN = {
		CONTAINER = HEX("000000"),

		TEXT = HEX("FFFFFF"),
		TEXT_DANGEROUS = HEX("FFEEEE"),
	},
}
function state_panel.update_opacity(dt, force)
	local old_counter = state_panel.duration

	state_panel.current_state.hold = false
	for _, item in pairs(state_panel.current_state.items) do
		if item.hold then
			state_panel.current_state.hold = true
			break
		end
	end

	if state_panel.current_state.hold then
		state_panel.duration = 0
	elseif state_panel.duration < state_panel.full_duration then
		state_panel.duration = state_panel.duration + dt
	end
	if force or old_counter ~= state_panel.duration then
		local opacity =
			math.min(1, math.max(0, (state_panel.full_duration - state_panel.duration) / state_panel.fade_duration))
		for key, color in pairs(state_panel.C.DYN) do
			color[4] = (state_panel.C.DYN_BASE_APLHA[key] or 1) * opacity
		end
	end
end

state_panel.update_opacity(0, true)

--

function state_panel.display(state_func, mode, level)
	if level and Handy.cc.notifications_level.value < level then
		return
	end
	mode = mode or "update"
	local should_replace_state = not state_panel.current_state.hold
	if mode == "override" then
		should_replace_state = true
	end

	local state_to_apply = should_replace_state and state_panel.new_state or state_panel.current_state
	local temp_result = state_func(state_to_apply)

	if temp_result then
		if should_replace_state then
			state_panel.new_state = state_to_apply
			state_panel.new_state_changed = true
		else
			state_panel.render()
		end
	end
end

--

function state_panel.update_state()
	if state_panel.new_state_changed then
		state_panel.previous_state = state_panel.current_state
		state_panel.current_state = state_panel.new_state
		state_panel.render()
		state_panel.new_state = state_panel.get_new_state()
		state_panel.new_state_changed = false
	end
end

--

Handy.e_mitter.on("update", function(dt)
	state_panel.update_opacity(dt)
end)
