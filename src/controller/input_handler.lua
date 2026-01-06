Handy.controller.input_context = nil

function Handy.controller.set_input_context(type, raw_key, released)
	if type == "none" or not raw_key then
		Handy.controller.input_context = {
			input_context = true,
			context_type = "input",

			raw_key = nil,
			key = nil,

			type = "none",
		}
		return Handy.controller.input_context
	end
	local new_context = {
		input_context = true,
		context_type = "input",

		raw_key = raw_key,
		type = type,
		released = released,
		triggered = Handy.controller.is_triggered(released),
	}
	if type == "gamepad" then
		new_context.key, new_context.back = Handy.controller.from_raw(raw_key, { gamepad = true })
		new_context.gamepad = true
	elseif type == "wheel" then
		new_context.key = Handy.controller.from_raw(Handy.controller.D.RAW_TO_WHEEL[raw_key], { wheel = true })
		new_context.released = false
		new_context.triggered = true
		new_context.back = false
		new_context.wheel = true
	elseif type == "keyboard" then
		new_context.key, new_context.back = Handy.controller.from_raw(raw_key, { keyboard = true })
		new_context.keyboard = true
	elseif type == "touch" then
		new_context.key, new_context.back =
			Handy.controller.from_raw(Handy.controller.D.RAW_TO_MOUSE[raw_key], { touch = true })
		new_context.touch = true
	elseif type == "mouse" then
		new_context.key, new_context.back =
			Handy.controller.from_raw(Handy.controller.D.RAW_TO_MOUSE[raw_key], { mouse = true })
		new_context.mouse = true
	end
	new_context.safe = not not (new_context.key and not Handy.controller.D.NON_SAFE_INPUTS[new_context.key])
	new_context.holdable = not not (new_context.key and not Handy.controller.D.NON_HOLDABLE_INPUTS[new_context.key])
	Handy.controller.input_context = new_context
	return Handy.controller.input_context
end

function Handy.controller.get_input_context()
	return Handy.controller.input_context or {}
end

--

Handy.controller.card_context = {
	card_context = true,
	context_type = "card",
	type = "none",

	hovered_current = nil,
	hovered_previous = nil,

	clicked_current = nil,
	clicked_previous = nil,

	card = nil,
}
function Handy.controller.set_card_context(type, card)
	local ctx = Handy.utils.table_shallow_copy(Handy.controller.card_context)
	if type == "hover" then
		ctx.type = "hover"
		ctx.hovered_previous = ctx.hovered_current or ctx.hovered_previous
		ctx.hovered_current = card
		ctx.card = card
	elseif type == "stop_hover" then
		ctx.type = "stop_hover"
		if ctx.hovered_current == card then
			ctx.hovered_previous = ctx.hovered_current or ctx.hovered_previous
			ctx.hovered_current = nil
		end
		ctx.card = card
	elseif type == "click" then
		ctx.type = card and "click" or "none"
		ctx.clicked_previous = ctx.clicked_current or ctx.clicked_previous
		ctx.clicked_current = card
		ctx.card = card
	elseif type == "none" then
		ctx.type = "none"
		ctx.card = nil
	end
	Handy.controller.card_context = ctx
	return ctx
end

function Handy.controller.get_card_context()
	return Handy.controller.card_context
end

Handy.e_mitter.on("update", function()
	local ctx = Handy.controller.card_context
	if ctx.hovered_current and ctx.hovered_current.REMOVED then
		Handy.controller.set_card_context("stop_hover", ctx.hovered_current)
	end
	if ctx.clicked_current and ctx.clicked_current.REMOVED then
		Handy.controller.set_card_context("click", nil)
	end
end)

--

Handy.controller.tag_context = {
	tag_context = true,
	context_type = "tag",
	type = "none",

	hovered_current = nil,
	hovered_previous = nil,

	clicked_current = nil,
	clicked_previous = nil,

	tag = nil,
}
function Handy.controller.set_tag_context(type, tag)
	local ctx = Handy.utils.table_shallow_copy(Handy.controller.tag_context)
	if type == "hover" then
		ctx.type = "hover"
		ctx.hovered_previous = ctx.hovered_current or ctx.hovered_previous
		ctx.hovered_current = tag
		ctx.tag = tag
	elseif type == "stop_hover" then
		ctx.type = "stop_hover"
		if ctx.tag == tag then
			ctx.hovered_previous = ctx.hovered_current or ctx.hovered_previous
			ctx.hovered_current = nil
		end
		ctx.tag = tag
	elseif type == "click" then
		ctx.type = tag and "click" or "none"
		ctx.clicked_previous = ctx.clicked_current or ctx.clicked_previous
		ctx.clicked_current = tag
		ctx.tag = tag
	elseif type == "none" then
		ctx.type = "none"
		ctx.tag = nil
	end
	Handy.controller.tag_context = ctx
	return ctx
end

function Handy.controller.get_tag_context()
	return Handy.controller.tag_context
end

Handy.e_mitter.on("update", function()
	local ctx = Handy.controller.tag_context
	if ctx.hovered_current and (not ctx.hovered_current.HUD_tag or ctx.hovered_current.HUD_tag.REMOVED) then
		Handy.controller.set_tag_context("stop_hover", ctx.hovered_current)
	end
	if ctx.clicked_current and (not ctx.clicked_current.HUD_tag or ctx.clicked_current.HUD_tag.REMOVED) then
		Handy.controller.set_tag_context("click", nil)
	end
end)

--

-- TODO: integrate itself properly in G.CONTROLLER, so you will not break vanilla game controls tracking and prevent other executions at the same time
-- It's 100% possible, but will require a lot of patches, oh well
-- For now keep current implementation

Handy.controller.held_keys = {}
Handy.controller.held_keys_pre = {}
Handy.e_mitter.on("update", function(dt)
	for _, t in ipairs({ Handy.controller.held_keys, Handy.controller.held_keys_pre }) do
		for key, value in pairs(t) do
			t[key] = value + dt
		end
	end
end)

function Handy.controller.handle_input(type, key, released)
	Handy.controller.reset_prevents()
	local context = Handy.controller.set_input_context(type, key, released)
	if not released then
		Handy.controller.held_keys[context.key] = 0
		Handy.controller.held_keys_pre[context.key] = 0
	else
		Handy.controller.held_keys_pre[context.key] = nil
	end
	Handy.e_mitter.emit("raw_input", type, key, released)
	if context.wheel or released then
		Handy.controller.held_keys[context.key] = nil
		Handy.controller.held_keys_pre[context.key] = nil
	end
	Handy.controller.set_input_context("none")
	return Handy.controller.is_default_prevented()
end

function Handy.controller.handle_card_click(card)
	Handy.controller.reset_prevents()
	Handy.controller.set_card_context("click", card)
	Handy.e_mitter.emit("raw_card_click", card)
	Handy.controller.set_card_context("click")
	return Handy.controller.is_default_prevented()
end

function Handy.controller.handle_card_hover(card)
	Handy.controller.reset_prevents()
	Handy.controller.set_card_context("hover", card)
	Handy.e_mitter.emit("raw_card_hover", card)
	Handy.controller.set_card_context("hover")
	return Handy.controller.is_default_prevented()
end

function Handy.controller.handle_card_stop_hover(card)
	Handy.controller.reset_prevents()
	Handy.controller.set_card_context("stop_hover", card)
	Handy.e_mitter.emit("raw_card_stop_hover", card)
	Handy.controller.set_card_context("none")
	return Handy.controller.is_default_prevented()
end

function Handy.controller.handle_tag_click(tag)
	Handy.controller.reset_prevents()
	Handy.controller.set_tag_context("click", tag)
	Handy.e_mitter.emit("raw_tag_click", tag)
	Handy.controller.set_tag_context("click")
	return Handy.controller.is_default_prevented()
end

function Handy.controller.handle_tag_hover(tag)
	Handy.controller.reset_prevents()
	Handy.controller.set_tag_context("hover", tag)
	Handy.e_mitter.emit("raw_tag_hover", tag)
	Handy.controller.set_tag_context("hover")
	return Handy.controller.is_default_prevented()
end

function Handy.controller.handle_tag_stop_hover(tag)
	Handy.controller.reset_prevents()
	Handy.controller.set_tag_context("stop_hover", tag)
	Handy.e_mitter.emit("raw_tag_stop_hover", tag)
	Handy.controller.set_tag_context("none")
	return Handy.controller.is_default_prevented()
end

-- TODO: update device on gamepad axis
-- TODO: node buttons override (problem: it supports only one button, not combinations, need to deal with it somehow)
-- solution: do not display button on them, handle controls by yourself

--

local wheel_moved_ref = love.wheelmoved or function() end
function love.wheelmoved(x, y)
	if Handy.controller.handle_input("wheel", y > 0 and 1 or 2) then
		return
	end
	return wheel_moved_ref(x, y)
end

local controller_button_press_ref = Controller.button_press
function Controller:button_press(button, ...)
	if Handy.controller.handle_input("gamepad", button, false) then
		return
	end
	return controller_button_press_ref(self, button, ...)
end

local controller_button_release_ref = Controller.button_release
function Controller:button_release(button, ...)
	if Handy.controller.handle_input("gamepad", button, true) then
		return
	end
	return controller_button_release_ref(self, button, ...)
end
