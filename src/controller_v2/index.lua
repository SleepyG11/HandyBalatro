Handy.controller_v2 = {}

---

function Handy.controller_v2.process_input(input_type, raw_key, released)
	local input_context = Handy.controller_v2.key_states.pre_action(input_type, raw_key, released)
	if not input_context.none then
		-- start processing controls here
	end
	input_context = Handy.controller_v2.key_states.post_action(released)
	return input_context.default_prevented
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

Handy.e_mitter.on("update", function(dt)
	local size = Handy.controller_v2.key_states.update(dt)
	local hold_context = Handy.controller_v2.hold.update_context(dt, size)
	if not hold_context.none then
		-- start processing hold here
	end
end)
