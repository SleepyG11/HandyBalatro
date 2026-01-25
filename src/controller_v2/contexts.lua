local input_context

local function create_empty_input_context()
	local context = {
		type = "input",
		input = true,
		none = true,

		raw_key = nil,
		key = nil,

		input_type = "none",
		action = "none",

		hold_duration = 0,
		real_hold_duration = 0,

		default_prevented = false,
		propagation_stopped = false,
	}
	return context
end
local function create_input_context(input_type, raw_key, released, starting_hold_duration)
	local action = released and "release" or "press"
	local trigger = Handy.controller.is_triggered(released)

	local key, back
	if input_type == "mouse" or input_type == "touch" then
		key, back = Handy.controller.from_raw(Handy.controller.D.RAW_TO_MOUSE[raw_key], { [input_type] = true })
	elseif input_type == "wheel" then
		key, back = Handy.controller.from_raw(Handy.controller.D.RAW_TO_WHEEL[raw_key], { [input_type] = true })
	else
		key, back = Handy.controller.from_raw(raw_key, { [input_type or ""] = true })
	end

	local holdable = not Handy.controller.D.NON_HOLDABLE_INPUTS[key]
	local safe = not Handy.controller.D.NON_SAFE_INPUTS[key]

	if released and not holdable then
		return create_empty_input_context()
	end

	local context = {
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

		default_prevented = false,
		propagation_stopped = false,
	}
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
	local context = {
		type = "card",
		card = true,
		none = true,

		input_type = "none",

		hovered_current = nil,
		hovered_previous = nil,

		clicked_current = nil,
		clicked_previous = nil,

		target = nil,

		default_prevented = false,
		propagation_stopped = false,
	}
	return context
end
local function create_card_context(input_type, card)
	input_type = input_type or "none"

	local context = {
		type = "card",
		card = true,

		input_type = input_type,
		[input_type] = true,

		hovered_current = card_context.hovered_current,
		hovered_previous = card_context.hovered_previous,

		clicked_current = card_context.clicked_current,
		clicked_previous = card_context.clicked_previous,

		target = card,

		default_prevented = false,
		propagation_stopped = false,
	}

	if input_type == "hover" then
		context.hovered_previous = context.hovered_current or context.hovered_previous
		context.hovered_current = card
	elseif input_type == "stop_hover" then
		if context.hovered_current == card then
			context.hovered_previous = context.hovered_current or context.hovered_previous
			context.hovered_current = nil
		end
	elseif input_type == "click" then
		context.clicked_previous = context.clicked_current or context.clicked_previous
		context.clicked_current = card
	elseif input_type == "stop_click" or input_type == "none" then
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

	update_context = function(input_type, card)
		return set_card_context(create_input_context(input_type, card))
	end,
}

---

local tag_context

local function create_empty_tag_context()
	local context = {
		type = "tag",
		tag = true,
		none = true,

		input_type = "none",

		hovered_current = nil,
		hovered_previous = nil,

		clicked_current = nil,
		clicked_previous = nil,

		target = nil,

		default_prevented = false,
		propagation_stopped = false,
	}
	return context
end
local function create_tag_context(input_type, tag)
	input_type = input_type or "none"

	local context = {
		type = "tag",
		tag = true,

		input_type = input_type,
		[input_type] = true,

		hovered_current = tag_context.hovered_current,
		hovered_previous = tag_context.hovered_previous,

		clicked_current = tag_context.clicked_current,
		clicked_previous = tag_context.clicked_previous,

		target = tag,

		default_prevented = false,
		propagation_stopped = false,
	}

	if input_type == "hover" then
		context.hovered_previous = context.hovered_current or context.hovered_previous
		context.hovered_current = tag
	elseif input_type == "stop_hover" then
		if context.hovered_current == tag then
			context.hovered_previous = context.hovered_current or context.hovered_previous
			context.hovered_current = nil
		end
	elseif input_type == "click" then
		context.clicked_previous = context.clicked_current or context.clicked_previous
		context.clicked_current = tag
	elseif input_type == "stop_click" or input_type == "none" then
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

	update_context = function(input_type, tag)
		return set_tag_context(create_input_context(input_type, tag))
	end,
}

---

local hold_context

local function create_empty_hold_context()
	local context = {
		type = "hold",
		hold = true,
		none = true,

		dt = 0,
		holded_size = 0,

		default_prevented = false,
		propagation_stopped = false,
	}
	return context
end
local function create_hold_context(dt, size)
	size = size or 0

	local context = {
		type = "hold",
		hold = true,
		none = size == 0,

		dt = size > 0 and dt or 0,
		read_dt = size > 0 and dt or 0,
		holded_size = size,

		default_prevented = false,
		propagation_stopped = false,
	}

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

	update_context = function(dt, size)
		return set_hold_context(create_hold_context(dt, size))
	end,
}

---

Handy.controller_v2.input = controller_input
Handy.controller_v2.card = controller_card
Handy.controller_v2.tag = controller_tag
Handy.controller_v2.hold = controller_hold

Handy.controller_v2.is_input_context = function(ctx)
	return ctx and ctx.input or false
end
Handy.controller_v2.is_card_context = function(ctx)
	return ctx and ctx.card or false
end
Handy.controller_v2.is_tag_context = function(ctx)
	return ctx and ctx.tag or false
end
Handy.controller_v2.is_hold_context = function(ctx)
	return ctx and ctx.hold or false
end
