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
		ctx.default_prevented = true
		ctx.propagation_stopped = true
	elseif Handy.controller_v2.should_prevent() then
		ctx.propagation_stopped = true
	elseif Handy.controller_v2.dp.should_prevent_input() then
		ctx.propagation_stopped = true
		if not ctx.hold then
			Handy.controller_v2.dp.notify_about_prevented_input()
		end
	end
end

---

function Handy.controller_v2.process_input(input_type, raw_key, released)
	local input_context = Handy.controller_v2.key_states.pre_action(input_type, raw_key, released)
	Handy.controller_v2.device.update_type(input_context)

	if not input_context.none then
		Handy.controller_v2.binding.process_binding(input_context)

		if not input_context.propagation_stopped then
			Handy.controller_v2.filter_context(input_context)
		end
		if not input_context.propagation_stopped then
			-- start processing controls here
		end
	end

	local is_default_prevented = input_context.default_prevented
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

function Handy.controller_v2.process_card(input_type, card)
	local card_context = Handy.controller_v2.card.update_context(input_type, card)

	if not card_context.none then
		if not card_context.propagation_stopped then
			Handy.controller_v2.filter_context(card_context)
		end
		if not card_context.propagation_stopped then
			-- start processing card here
		end
	end

	local is_default_prevented = card_context.default_prevented
	if card_context.input_type == "click" then
		Handy.controller_v2.card.update_context("stop_click", card)
	end
	return is_default_prevented
end

function Handy.controller_v2.handle_card_click(card)
	return Handy.controller_v2.process_card("click", card)
end
function Handy.controller_v2.handle_card_hover(card)
	return Handy.controller_v2.process_card("hover", card)
end
function Handy.controller_v2.handle_card_stop_hover(card)
	return Handy.controller_v2.process_card("stop_hover", card)
end

---

function Handy.controller_v2.process_tag(input_type, tag)
	local tag_context = Handy.controller_v2.tag.update_context(input_type, tag)

	if not tag_context.none then
		if not tag_context.propagation_stopped then
			Handy.controller_v2.filter_context(tag_context)
		end
		if not tag_context.propagation_stopped then
			-- start processing tag here
		end
	end

	local is_default_prevented = tag_context.default_prevented
	if tag_context.input_type == "click" then
		Handy.controller_v2.tag.update_context("stop_click", tag)
	end
	return is_default_prevented
end

function Handy.controller_v2.handle_tag_click(tag)
	return Handy.controller_v2.process_tag("click", tag)
end
function Handy.controller_v2.handle_tag_hover(tag)
	return Handy.controller_v2.process_tag("hover", tag)
end
function Handy.controller_v2.handle_tag_stop_hover(tag)
	return Handy.controller_v2.process_tag("stop_hover", tag)
end

---

function Handy.controller_v2.process_hold(dt)
	local size = Handy.controller_v2.key_states.update(dt)
	local hold_context = Handy.controller_v2.hold.update_context(dt, size)
	local deducted = false

	if not hold_context.none then
		Handy.controller_v2.filter_context(hold_context)

		if hold_context.default_prevented or hold_context.propagation_stopped then
			hold_context.dt = 0
			if not deducted then
				Handy.controller_v2.key_states.update(-dt, true)
				deducted = true
			end
		else
			-- start processing hold here
		end

		if hold_context.default_prevented or hold_context.propagation_stopped then
			hold_context.dt = 0
			if not deducted then
				deducted = true
				Handy.controller_v2.key_states.update(-dt, true)
			end
		end
	end

	local is_default_prevented = hold_context.default_prevented
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
-- 	if Handy.controller.handle_input("wheel", y > 0 and 1 or 2) then
-- 		return
-- 	end
-- 	return wheel_moved_ref(x, y)
-- end

-- local controller_button_press_ref = Controller.button_press
-- function Controller:button_press(button, ...)
-- 	if Handy.controller.handle_input("gamepad", button, false) then
-- 		return
-- 	end
-- 	return controller_button_press_ref(self, button, ...)
-- end

-- local controller_button_release_ref = Controller.button_release
-- function Controller:button_release(button, ...)
-- 	if Handy.controller.handle_input("gamepad", button, true) then
-- 		return
-- 	end
-- 	return controller_button_release_ref(self, button, ...)
-- end
