Handy.controller.device = setmetatable({
	current = "keyboard",
	previous = "keyboard",
	real = "keyboard",
}, {})

function Handy.controller.device.update_type(args)
	args = args or {}
	if args.touch or args.check then
	elseif args.joystick or args.gamepad or G.CONTROLLER.HID.controller then
		Handy.controller.device.real = "gamepad"
	elseif args.mouse or args.keyboard then
		Handy.controller.device.real = "keyboard"
	end
	local old_device = Handy.controller.device.current
	if Handy.cc.current_device.value == 2 then
		Handy.controller.device.current = "keyboard"
	elseif Handy.cc.current_device.value == 3 then
		Handy.controller.device.current = "gamepad"
	elseif Handy.cc.current_device.value == 1 then
		Handy.controller.device.current = Handy.controller.device.real
	end
	if Handy.controller.device.current ~= old_device then
		Handy.e_mitter.emit("device_change")
	end
end
function Handy.controller.device.get_type()
	return Handy.controller.device.current
end

function Handy.controller.is_gamepad()
	return Handy.controller.device.get_type() == "gamepad"
end
function Handy.controller.is_keyboard()
	return Handy.controller.device.get_type() == "keyboard"
end
