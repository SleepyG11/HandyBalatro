local device_module = {
	current = "keyboard",
	previous = "keyboard",
	real = "keyboard",

	match_real = true,
}

local function update_device_type(ctx)
	ctx = Handy.controller_v2.non_empty_context(ctx)
	if not ctx or not ctx.input or ctx.touch then
		-- perform just check
	elseif ctx.gamepad or G.CONTROLLER.HID.controller then
		device_module.real = "gamepad"
	elseif ctx.mouse or ctx.keyboard then
		device_module.real = "keyboard"
	end
	local old_device = device_module.current
	if Handy.cc.current_device.value == 2 then
		device_module.current = "keyboard"
	elseif Handy.cc.current_device.value == 3 then
		device_module.current = "gamepad"
	elseif Handy.cc.current_device.value == 1 then
		device_module.current = device_module.real
	end
	device_module.match_real = device_module.current == device_module.real

	if device_module.current ~= old_device then
		Handy.e_mitter.emit("device_change")
	end
end
local function get_device_type()
	return device_module.current
end

local function is_gamepad()
	return get_device_type() == "gamepad"
end
local function is_keyboard()
	return get_device_type() == "keyboard"
end

---

device_module.get_type = get_device_type
device_module.update_type = update_device_type

device_module.is_gamepad = is_gamepad
device_module.is_keyboard = is_keyboard

Handy.controller_v2.device = device_module
Handy.controller_v2.is_gamepad = is_gamepad
Handy.controller_v2.is_keyboard = is_gamepad
