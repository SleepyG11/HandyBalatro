Handy.controller_v2 = {}

---

function Handy.controller_v2.process_input(input_type, raw_key, released)
	local input_context = Handy.controller_v2.key_states.pre_action(input_type, raw_key, released)
	if not input_context.none then
		-- start filters here
	end
	if not input_context.none and not input_context.propagation_stopped then
		-- start processing controls here
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

Handy.e_mitter.on("update", function(dt)
	local size = Handy.controller_v2.key_states.update(dt, false)
	local hold_context = Handy.controller_v2.hold.update_context(dt, size)
	local deducted = false
	if not hold_context.none then
		-- start filters here
	end
	if not hold_context.none and hold_context.default_prevented or hold_context.propagation_stopped then
		hold_context.dt = 0
		if not deducted then
			deducted = true
			Handy.controller_v2.key_states.update(-dt, true)
		end
	end
	if not hold_context.none and not hold_context.default_prevented and not hold_context.propagation_stopped then
		-- start processing hold here
	end
	if not hold_context.none and hold_context.default_prevented or hold_context.propagation_stopped then
		hold_context.dt = 0
		if not deducted then
			deducted = true
			Handy.controller_v2.key_states.update(-dt, true)
		end
	end
end)
