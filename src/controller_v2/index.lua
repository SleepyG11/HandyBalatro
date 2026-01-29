Handy.controller_v2 = {}

---

Handy.load_file("src/controller_v2/keys.lua")
Handy.load_file("src/controller_v2/contexts.lua")
Handy.load_file("src/controller_v2/key_states.lua")
Handy.load_file("src/controller_v2/debugplus.lua")
Handy.load_file("src/controller_v2/binding.lua")
Handy.load_file("src/controller_v2/device.lua")

---

function Handy.controller_v2.should_prevent()
	return (Handy.controller_v2.dp.is_console_opened() or G.TMJUI or G.CONTROLLER.text_input_hook) and true or false
end

function Handy.controller_v2.filter_context(ctx)
	if Handy.controller_v2.binding.get_current() then
		ctx:prevent_default()
		ctx:stop_propagation()
	elseif Handy.controller_v2.should_prevent() then
		ctx:stop_propagation()
	elseif Handy.controller_v2.dp.should_prevent_input() then
		ctx:stop_propagation()
		if not ctx.hold then
			Handy.controller_v2.dp.notify_about_prevented_input()
		end
	end
end

---

function Handy.controller_v2.process_input(input_type, raw_key, released)
	local ctx = Handy.controller_v2.key_states.pre_action(input_type, raw_key, released)
	Handy.controller_v2.device.update_type(ctx)

	if Handy.controller_v2.non_empty_context(ctx) then
		Handy.controller_v2.binding.process_binding(ctx)

		if not ctx:is_propagation_stopped() then
			Handy.controller_v2.filter_context(ctx)
		end
		if not ctx:is_propagation_stopped() then
			Handy.e_mitter.emit("controller_input", ctx)
		end
	end

	local is_default_prevented = ctx:is_default_prevented()
	Handy.controller_v2.key_states.post_action(released)
	return is_default_prevented
end

function Handy.controller_v2.process_keyboard_input(raw_key, released)
	return Handy.controller_v2.process_input("keyboard", raw_key, released)
end
function Handy.controller_v2.process_mouse_input(raw_key, released)
	return Handy.controller_v2.process_input("mouse", raw_key, released)
end
function Handy.controller_v2.process_wheel_input(raw_key, released)
	return Handy.controller_v2.process_input("wheel", raw_key, released)
end
function Handy.controller_v2.process_gamepad_input(raw_key, released)
	return Handy.controller_v2.process_input("gamepad", raw_key, released)
end
function Handy.controller_v2.process_touch_input(raw_key, released)
	return Handy.controller_v2.process_input("touch", raw_key, released)
end

---

function Handy.controller_v2.process_card(action, card)
	local ctx = Handy.controller_v2.card.update_context(action, card)

	if Handy.controller_v2.non_empty_context(ctx) then
		if not ctx:is_propagation_stopped() then
			Handy.controller_v2.filter_context(ctx)
		end
		if not ctx:is_propagation_stopped() then
			Handy.e_mitter.emit("controller_card", ctx)
		end
	end

	local is_default_prevented = ctx:is_default_prevented()
	Handy.controller_v2.card.post_update_context(action, card)
	return is_default_prevented
end

function Handy.controller_v2.process_card_click(card)
	return Handy.controller_v2.process_card("click", card)
end
function Handy.controller_v2.process_card_hover(card)
	return Handy.controller_v2.process_card("hover", card)
end
function Handy.controller_v2.process_card_stop_hover(card)
	return Handy.controller_v2.process_card("stop_hover", card)
end

---

function Handy.controller_v2.process_tag(action, tag)
	local ctx = Handy.controller_v2.tag.update_context(action, tag)

	if Handy.controller_v2.non_empty_context(ctx) then
		if not ctx:is_propagation_stopped() then
			Handy.controller_v2.filter_context(ctx)
		end
		if not ctx:is_propagation_stopped() then
			Handy.e_mitter.emit("controller_tag", ctx)
		end
	end

	local is_default_prevented = ctx:is_default_prevented()
	Handy.controller_v2.tag.post_update_context(action, tag)
	return is_default_prevented
end

function Handy.controller_v2.process_tag_click(tag)
	return Handy.controller_v2.process_tag("click", tag)
end
function Handy.controller_v2.process_tag_hover(tag)
	return Handy.controller_v2.process_tag("hover", tag)
end
function Handy.controller_v2.process_tag_stop_hover(tag)
	return Handy.controller_v2.process_tag("stop_hover", tag)
end

---

function Handy.controller_v2.process_hold(dt)
	local size = Handy.controller_v2.key_states.update(dt)
	local ctx = Handy.controller_v2.hold.update_context(dt, size)
	local deducted = false

	if Handy.controller_v2.non_empty_context(ctx) then
		Handy.controller_v2.filter_context(ctx)

		if ctx:is_default_prevented() or ctx:is_propagation_stopped() then
			ctx.dt = 0
			if not deducted then
				Handy.controller_v2.key_states.update(-dt, true)
				deducted = true
			end
		else
			Handy.e_mitter.emit("controller_hold", ctx)
		end

		if ctx:is_default_prevented() or ctx:is_propagation_stopped() then
			ctx.dt = 0
			if not deducted then
				deducted = true
				Handy.controller_v2.key_states.update(-dt, true)
			end
		end
	end

	local is_default_prevented = ctx:is_default_prevented()
	Handy.controller_v2.hold.update_context()
	return is_default_prevented
end

---

Handy.e_mitter.on("update", function(dt)
	Handy.controller_v2.dp.update_console_opened()

	local card_context = Handy.controller_v2.card.get_context()
	if card_context.hovered_current and card_context.hovered_current.REMOVED then
		Handy.controller_v2.card.update_context("stop_hover", card_context.hovered_current)
	end

	local tag_context = Handy.controller_v2.tag.get_context()
	if
		tag_context.hovered_current
		and (not tag_context.hovered_current.HUD_tag or tag_context.hovered_current.HUD_tag.REMOVED)
	then
		Handy.controller_v2.tag.update_context("stop_hover", tag_context.hovered_current)
	end

	Handy.controller_v2.process_hold(dt)
end)

-- local wheel_moved_ref = love.wheelmoved or function() end
-- function love.wheelmoved(x, y)
-- 	if Handy.controller_v2.process_wheel_input(y > 0 and 1 or 2) then
-- 		return
-- 	end
-- 	return wheel_moved_ref(x, y)
-- end

-- local controller_button_press_ref = Controller.button_press
-- function Controller:button_press(button, ...)
-- 	if Handy.controller_v2.process_gamepad_input(button, false) then
-- 		return
-- 	end
-- 	return controller_button_press_ref(self, button, ...)
-- end

-- local controller_button_release_ref = Controller.button_release
-- function Controller:button_release(button, ...)
-- 	if Handy.controller_v2.process_gamepad_input(button, true) then
-- 		return
-- 	end
-- 	return controller_button_release_ref(self, button, ...)
-- end
