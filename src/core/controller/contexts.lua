local PreventableContext = Object:extend()

function PreventableContext:init()
	self.default_prevented = false
	self.propagation_stopped = false

	self.is_default_prevented = function(self)
		return self.default_prevented or false
	end
	self.is_propagation_stopped = function(self)
		return self.propagation_stopped or false
	end

	self.prevent_default = function(self)
		self.default_prevented = true
	end
	self.stop_propagation = function(self)
		self.propagation_stopped = true
	end

	self.is_empty = function(self)
		return self.none
	end

	return self
end

---

local input_context

local function create_empty_input_context()
	local context = PreventableContext.init({
		type = "input",
		input = true,
		none = true,

		raw_key = nil,
		key = nil,

		input_type = "none",
		action = "none",

		hold_duration = 0,
		real_hold_duration = 0,
	})
	return context
end
local function create_input_context(input_type, raw_key, released, starting_hold_duration)
	local action = released and "release" or "press"
	local key = Handy.controller.keys.raw_to_key(input_type, raw_key)

	local trigger = Handy.controller.key_states.is_key_trigger(key, released)

	local back = Handy.controller.keys.is_back_key(key)
	local safe = Handy.controller.keys.is_safe_key(key)
	local holdable = Handy.controller.keys.is_holdable_key(key)

	if released and not holdable then
		return create_empty_input_context()
	end

	local context = PreventableContext.init({
		type = "input",
		input = true,

		input_type = input_type,
		action = action,
		trigger = trigger,

		raw_key = raw_key,
		key = key,

		hold_duration = holdable and starting_hold_duration or 0,
		real_hold_duration = holdable and starting_hold_duration or 0,

		back = back,
		safe = safe,
		holdable = holdable,

		[action] = true,
		[input_type] = true,
		[input_type .. "_" .. action] = true,
		[input_type .. "_trigger"] = trigger and true or nil,
	})
	return context
end

input_context = create_empty_input_context()

local function get_input_context()
	return input_context
end
local function set_input_context(ctx)
	input_context = ctx or create_empty_input_context()
	return input_context
end

local controller_input = {
	get_context = get_input_context,
	set_context = set_input_context,

	create_empty_context = create_empty_input_context,
	create_context = create_input_context,

	update_context = function(input_type, raw_key, released, starting_hold_duration)
		if not input_type or input_type == "none" then
			return set_input_context()
		else
			return set_input_context(create_input_context(input_type, raw_key, released, starting_hold_duration or 0))
		end
	end,
}

---

local card_context

local function create_empty_card_context()
	local context = PreventableContext.init({
		type = "card",
		card = true,

		action = "none",
		none = true,

		hovered_current = nil,
		hovered_previous = nil,

		clicked_current = nil,
		clicked_previous = nil,

		target = nil,
	})
	return context
end
local function create_card_context(action, card)
	action = action or "none"

	local context = PreventableContext.init({
		type = "card",
		card = true,

		action = action,
		[action] = true,

		hovered_current = card_context.hovered_current,
		hovered_previous = card_context.hovered_previous,

		clicked_current = card_context.clicked_current,
		clicked_previous = card_context.clicked_previous,

		target = card,
	})

	if action == "hover" then
		context.hovered_previous = context.hovered_current or context.hovered_previous
		context.hovered_current = card
	elseif action == "stop_hover" then
		if context.hovered_current == card then
			context.hovered_previous = context.hovered_current or context.hovered_previous
			context.hovered_current = nil
		end
	elseif action == "click" then
		context.clicked_previous = context.clicked_current or context.clicked_previous
		context.clicked_current = card
	elseif action == "stop_click" or action == "none" then
		context.clicked_previous = context.clicked_current or context.clicked_previous
		context.clicked_current = nil
	end

	return context
end

card_context = create_empty_card_context()

local function get_card_context()
	return card_context
end
local function set_card_context(ctx)
	card_context = ctx or card_context or create_empty_card_context()
	return card_context
end

local controller_card = {
	get_context = get_card_context,
	set_context = set_card_context,

	create_empty_context = create_empty_card_context,
	create_context = create_card_context,

	update_context = function(action, card)
		return set_card_context(create_card_context(action, card))
	end,
	post_update_context = function(action, card)
		return set_card_context(create_card_context(action == "click" and "stop_click" or "none"))
	end,
}

---

local tag_context

local function create_empty_tag_context()
	local context = PreventableContext.init({
		type = "tag",
		tag = true,

		action = "none",
		none = true,

		hovered_current = nil,
		hovered_previous = nil,

		clicked_current = nil,
		clicked_previous = nil,

		target = nil,
	})
	return context
end
local function create_tag_context(action, tag)
	action = action or "none"

	local context = PreventableContext.init({
		type = "tag",
		tag = true,

		action = action,
		[action] = true,

		hovered_current = tag_context.hovered_current,
		hovered_previous = tag_context.hovered_previous,

		clicked_current = tag_context.clicked_current,
		clicked_previous = tag_context.clicked_previous,

		target = tag,
	})

	if action == "hover" then
		context.hovered_previous = context.hovered_current or context.hovered_previous
		context.hovered_current = tag
	elseif action == "stop_hover" then
		if context.hovered_current == tag then
			context.hovered_previous = context.hovered_current or context.hovered_previous
			context.hovered_current = nil
		end
	elseif action == "click" then
		context.clicked_previous = context.clicked_current or context.clicked_previous
		context.clicked_current = tag
	elseif action == "stop_click" or action == "none" then
		context.clicked_previous = context.clicked_current or context.clicked_previous
		context.clicked_current = nil
	end

	return context
end

tag_context = create_empty_tag_context()

local function get_tag_context()
	return tag_context
end
local function set_tag_context(ctx)
	tag_context = ctx or tag_context or create_empty_tag_context()
	return tag_context
end

local controller_tag = {
	get_context = get_tag_context,
	set_context = set_tag_context,

	create_empty_context = create_empty_tag_context,
	create_context = create_tag_context,

	update_context = function(action, tag)
		return set_tag_context(create_tag_context(action, tag))
	end,
	post_update_context = function(action, tag)
		return set_tag_context(create_tag_context(action == "click" and "stop_click" or "none"))
	end,
}

---

local hold_context

local function create_empty_hold_context()
	local context = PreventableContext.init({
		type = "hold",
		hold = true,
		none = true,

		dt = 0,
		holded_size = 0,

		keeped_alive = false,
	})
	return context
end
local function create_hold_context(dt, size, keep_alive)
	size = size or 0

	local context = PreventableContext.init({
		type = "hold",
		hold = true,
		none = not keep_alive and size == 0,

		dt = size > 0 and dt or 0,
		read_dt = size > 0 and dt or 0,
		holded_size = size,

		keeped_alive = keep_alive and size == 0,
	})
	return context
end

hold_context = create_empty_hold_context()

local function get_hold_context()
	return hold_context
end
local function set_hold_context(ctx)
	hold_context = ctx or create_empty_hold_context()
	return hold_context
end

local controller_hold = {
	get_context = get_hold_context,
	set_context = set_hold_context,

	create_empty_context = create_empty_hold_context,
	create_context = create_hold_context,

	update_context = function(dt, size, keep_alive)
		return set_hold_context(create_hold_context(dt, size, keep_alive))
	end,
}

---

local function non_empty_context(ctx)
	return ctx and not ctx:is_empty() and ctx or nil
end

---

local move_context

local function create_empty_move_context()
	local context = PreventableContext.init({
		type = "move",
		move = true,
		none = true,

		dx = 0,
		dy = 0,

		sdx = 0,
		sdy = 0,
	})
	return context
end
local function create_move_context(dx, dy)
	dx = dx or 0
	dy = dy or 0
	local scale = G.TILESCALE and G.TILESCALE * G.TILESIZE or nil
	local context = PreventableContext.init({
		type = "move",
		move = true,
		none = not scale or (dx == 0 and dy == 0),

		dx = dx,
		dy = dy,

		sdx = dx * (scale or 1),
		sdy = dy * (scale or 1),
	})
	return context
end

move_context = create_empty_move_context()

local function get_move_context()
	return move_context
end
local function set_move_context(ctx)
	move_context = ctx or create_empty_move_context()
	return move_context
end

local controller_move = {
	get_context = get_move_context,
	set_context = set_move_context,

	create_empty_context = create_empty_move_context,
	create_context = create_move_context,

	update_context = function(dx, dy)
		return set_move_context(create_move_context(dx, dy))
	end,
}

---

Handy.controller.input = controller_input
Handy.controller.card = controller_card
Handy.controller.tag = controller_tag
Handy.controller.hold = controller_hold
Handy.controller.move = controller_move

Handy.controller.non_empty_context = non_empty_context
