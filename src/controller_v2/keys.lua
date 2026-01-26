local keyboard_raw_to_key = {
	["lshift"] = "Shift",
	["rshift"] = "Shift",
	["lctrl"] = "Ctrl",
	["rctrl"] = "Ctrl",
	["lalt"] = "Alt",
	["ralt"] = "Alt",
	["lgui"] = "GUI",
	["rgui"] = "GUI",
	["return"] = "Enter",
	["kpenter"] = "NUM Enter",
	["pageup"] = "Page Up",
	["pagedown"] = "Page Down",
	["numlock"] = "Num Lock",
	["capslock"] = "Caps Lock",
	["scrolllock"] = "Scroll Lock",
	["`"] = "Backquote",
	["'"] = "Singlequote",
	['"'] = "Quote",
	["["] = "Left Bracket",
	["]"] = "Right Bracket",
}
local keyboard_key_to_raws = {
	["Wheel Up"] = { "wheelup" },
	["Wheel Down"] = { "wheeldown" },
	["Shift"] = { "lshift", "rshift" },
	["Ctrl"] = { "lctrl", "rctrl" },
	["Alt"] = { "lalt", "ralt" },
	["GUI"] = { "lgui", "rgui" },
	["Enter"] = { "return" },
	["NUM Enter"] = { "kpenter" },
	["Page Up"] = { "pageup" },
	["Page Down"] = { "pagedown" },
	["Num Lock"] = { "numlock" },
	["Caps Lock"] = { "capslock" },
	["Scroll Lock"] = { "scrolllock" },
	["Backquote"] = { "`" },
	["Singlequote"] = { "'" },
	["Quote"] = { '"' },
	["Left Bracket"] = { "[" },
	["Right Bracket"] = { "]" },
	["["] = { "[" },
	["]"] = { "]" },
}

local gamepad_raw_to_key = {
	["a"] = "(A)",
	["b"] = "(B)",
	["x"] = "(X)",
	["y"] = "(Y)",
	["back"] = "(Back)",
	["guide"] = "(Guide)",
	["start"] = "(Start)",
	["leftstick"] = "Left Stick",
	["rightstick"] = "Right Stick",
	["leftshoulder"] = "Left Bumper",
	["rightshoulder"] = "Right Bumper",
	["dpup"] = "(Up)",
	["dpdown"] = "(Down)",
	["dpleft"] = "(Left)",
	["dpright"] = "(Right)",
	-- Not present in current Love version (11.5.0)
	["misc1"] = "(Misc. Button)",
	["paddle1"] = "First Paddle",
	["paddle2"] = "Second Paddle",
	["paddle3"] = "Third Paddle",
	["paddle4"] = "Fourth Paddle",
	["touchpad"] = "Touchpad Press",
	-- Axis as button
	["triggerleft"] = "Left Trigger",
	["triggerright"] = "Right Trigger",
}
local gamepad_key_to_raws = {
	["(A)"] = { "a" },
	["(B)"] = { "b" },
	["(X)"] = { "x" },
	["(Y)"] = { "y" },
	["(Back)"] = { "back" },
	["(Guide)"] = { "guide" },
	["(Start)"] = { "start" },
	["Left Stick"] = { "leftstick" },
	["Right Stick"] = { "rightstick" },
	["Left Bumper"] = { "leftshoulder" },
	["Right Bumper"] = { "rightshoulder" },
	["(Up)"] = { "dpup" },
	["(Down)"] = { "dpdown" },
	["(Left)"] = { "dpleft" },
	["(Right)"] = { "dpright" },
	-- Not present in current Love version (11.5.0)
	["(Misc. Button)"] = { "misc1" },
	["First Paddle"] = { "paddle1" },
	["Second Paddle"] = { "paddle2" },
	["Third Paddle"] = { "paddle3" },
	["Fourth Paddle"] = { "paddle4" },
	["Touchpad Press"] = { "touchpad" },
	-- Axis as button
	["Left Trigger"] = {
		"triggerleft",
		axis_check = function()
			return G.CONTROLLER.axis_buttons.l_trig.current == "triggerleft"
		end,
	},
	["Right Trigger"] = {
		"triggerright",
		axis_check = function()
			return G.CONTROLLER.axis_buttons.r_trig.current == "triggerright"
		end,
	},
}

local mouse_raw_to_key = {
	[1] = "Left Mouse",
	[2] = "Right Mouse",
	[3] = "Middle Mouse",
	[4] = "Mouse 4",
	[5] = "Mouse 5",
}
local mouse_key_to_raws = {
	["Left Mouse"] = { 1 },
	["Right Mouse"] = { 2 },
	["Middle Mouse"] = { 3 },
	["Mouse 4"] = { 4 },
	["Mouse 5"] = { 5 },
}

local wheel_raw_to_key = {
	[1] = "Wheel Up",
	[2] = "Wheel Down",
}
local wheel_key_to_raws = {
	["Wheel Up"] = { 1 },
	["Wheel Down"] = { 2 },
}

local non_holdable_keys = {
	["Wheel Up"] = true,
	["Wheel Down"] = true,
}
local non_safe_keys = {
	["Left Mouse"] = true,
	["Right Mouse"] = true,
	["(Left)"] = true,
	["(Right)"] = true,
	["(Up)"] = true,
	["(Down)"] = true,
	["(X)"] = true,
	["(Y)"] = true,
	["(A)"] = true,
	["(B)"] = true,
}

local back_keys = {
	["Escape"] = true,
	["(Back)"] = true,
}

---

local function is_back_key(input)
	return input and back_keys[input] or false
end
local function is_safe_key(input)
	return input and not non_safe_keys[input] or false
end
local function is_holdable_key(input)
	return input and not non_holdable_keys[input] or false
end

---

local from_raw_buffer = {}
local function raw_to_key(input_type, raw_key)
	if not input_type or not raw_key then
		return nil, false
	end
	local b = from_raw_buffer[input_type .. raw_key]
	if b then
		return b[1]
	end

	local buff = function(r)
		from_raw_buffer[input_type .. raw_key] = { r }
		return r
	end

	if input_type == "mouse" or input_type == "touch" then
		return buff(mouse_raw_to_key[raw_key])
	elseif input_type == "gamepad" then
		return buff(gamepad_raw_to_key[raw_key])
	elseif input_type == "wheel" then
		return buff(wheel_raw_to_key[raw_key])
	elseif input_type == "keyboard" then
		local result = keyboard_raw_to_key[raw_key]
		if result then
		elseif string.sub(raw_key, 1, 2) == "kp" then
			result = "NUM " .. string.sub(raw_key, 3)
		else
			result = string.upper(string.sub(raw_key, 1, 1)) .. string.sub(raw_key, 2)
		end
		return buff(result)
	end
	return nil, false
end

local to_raw_buffer = {}
local function key_to_raws(input_type, key)
	if not input_type or not key or key == "None" or key == "Unknown" then
		return nil
	end

	local b = to_raw_buffer[input_type .. key]
	if b then
		return unpack(b)
	end

	local buff = function(r)
		r = r or { nil }
		to_raw_buffer[input_type .. key] = r
		return unpack(r)
	end

	if input_type == "mouse" or input_type == "touch" then
		return buff(mouse_key_to_raws[key])
	elseif input_type == "gamepad" then
		return buff(gamepad_key_to_raws[key])
	elseif input_type == "wheel" then
		return buff(wheel_key_to_raws[key])
	elseif input_type == "keyboard" then
		local result = keyboard_key_to_raws[key]
		if result then
		elseif string.sub(key, 1, 4) == "NUM " then
			result = { "kp" .. string.sub(key, 5) }
		else
			local t_result = string.gsub(string.lower(key), "%s+", "")
			result = { t_result }
		end
		return buff(result or { nil })
	end
	return nil
end

---

local keys = {
	RAW_TO_KEYBOARD = keyboard_raw_to_key,
	KEYBOARD_TO_RAWS = keyboard_key_to_raws,

	RAW_TO_GAMEPAD = gamepad_raw_to_key,
	GAMEPAD_TO_RAWS = gamepad_key_to_raws,

	RAW_TO_MOUSE = mouse_raw_to_key,
	MOUSE_TO_RAWS = mouse_key_to_raws,

	RAW_TO_WHEEL = wheel_raw_to_key,
	WHEEL_TO_RAWS = wheel_key_to_raws,

	NON_HOLDABLE_KEYS = non_holdable_keys,
	NON_SAFE_KEYS = non_safe_keys,
	BACK_KEYS = back_keys,
}

keys.is_back_key = is_back_key
keys.is_safe_key = is_safe_key
keys.is_holdable_key = is_holdable_key

keys.raw_to_key = raw_to_key
keys.key_to_raws = key_to_raws

---

Handy.controller_v2.keys = keys
