Handy.controller_v2 = {}

---

Handy.load_file("src/controller_v2/keys.lua")
Handy.load_file("src/controller_v2/contexts.lua")
Handy.load_file("src/controller_v2/key_states.lua")
Handy.load_file("src/controller_v2/debugplus.lua")

---

function Handy.controller_v2.should_stop()
	return (Handy.controller_v2.dp.is_console_opened() or G.TMJUI or G.CONTROLLER.text_input_hook) and true or false
end

function Handy.controller_v2.filter_context(ctx)
	if Handy.controller.binding.current then
		ctx.default_prevented = true
		ctx.propagation_stopped = true
	elseif Handy.controller_v2.should_stop() then
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
	if not input_context.none then
		Handy.controller_v2.filter_context(input_context)

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
	Handy.controller_v2.process_hold(dt)
end)
