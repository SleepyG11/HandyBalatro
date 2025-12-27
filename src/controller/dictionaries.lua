local key_from_raw_table = {
    ["mouse1"] = "Left Mouse",
    ["mouse2"] = "Right Mouse",
    ["mouse3"] = "Middle Mouse",
    ["mouse4"] = "Mouse 4",
    ["mouse5"] = "Mouse 5",
    ["wheelup"] = "Wheel Up",
    ["wheeldown"] = "Wheel Down",
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
local keys_to_raw_table = {
    ["Left Mouse"] = { "mouse1" },
    ["Right Mouse"] = { "mouse2" },
    ["Middle Mouse"] = { "mouse3" },
    ["Mouse 4"] = { "mouse4" },
    ["Mouse 5"] = { "mouse5" },
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

local gamepad_key_from_raw_table = {
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
local gamepad_keys_to_raw_table = {
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

local mouse_raw_from_index_table = {
    [1] = "mouse1",
    [2] = "mouse2",
    [3] = "mouse3",
    [4] = "mouse4",
    [5] = "mouse5",
}
local mouse_key_to_index_table = {
    ["Left Mouse"] = 1,
    ["Right Mouse"] = 2,
    ["Middle Mouse"] = 3,
    ["Mouse 4"] = 4,
    ["Mouse 5"] = 5,
}

local wheel_raw_from_index_table = {
    [1] = "wheelup",
    [2] = "wheeldown",
}
local wheel_key_to_index_table = {
    ["Wheel Up"] = 1,
    ["Wheel Down"] = 2,
}

local non_holdable_keys_table = {
    ["Wheel Up"] = true,
    ["Wheel Down"] = true,
}
local non_safe_keys_table = {
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

Handy.controller.D = {
    RAW_TO_KEY = key_from_raw_table,
    KEY_TO_RAWS = keys_to_raw_table,

    RAW_TO_BUTTON = gamepad_key_from_raw_table,
    BUTTON_TO_RAWS = gamepad_keys_to_raw_table,

    RAW_TO_MOUSE = mouse_raw_from_index_table,
    MOUSE_TO_RAW = mouse_key_to_index_table,

    RAW_TO_WHEEL = wheel_raw_from_index_table,
    WHEEL_TO_RAW = wheel_key_to_index_table,

    NON_HOLDABLE_INPUTS = non_holdable_keys_table,
    NON_SAFE_INPUTS = non_safe_keys_table,
}

local from_raw_buffer = {}
function Handy.controller.from_raw(raw_key, options)
    if not raw_key then
        return nil, false
    end
    options = options or {}

    if options.gamepad then
        local gamepad_result = Handy.controller.D.RAW_TO_BUTTON[raw_key]
        return gamepad_result, gamepad_result == "(Back)"
    end
    if options.keyboard or options.wheel or options.mouse or options.touch then
        local result = from_raw_buffer[raw_key] or Handy.controller.D.RAW_TO_KEY[raw_key]
        if result then
        elseif string.sub(raw_key, 1, 2) == "kp" then
            result = "NUM " .. string.sub(raw_key, 3)
            from_raw_buffer[raw_key] = result
        else
            result = string.upper(string.sub(raw_key, 1, 1)) .. string.sub(raw_key, 2)
            from_raw_buffer[raw_key] = result
        end
        return result, result == "Escape"
    end
    return nil, false
end

local to_raw_buffer = {}
function Handy.controller.to_raw(parsed_key, options)
    if not parsed_key or parsed_key == "None" then
        return nil
    end
    options = options or {}

    if options.gamepad then
        local result = Handy.controller.D.BUTTON_TO_RAWS[parsed_key]
        return unpack(result or { nil })
    end
    local result = to_raw_buffer[parsed_key] or Handy.controller.D.KEY_TO_RAWS[parsed_key]
    if result then
    elseif string.sub(parsed_key, 1, 4) == "NUM " then
        result = { "kp" .. string.sub(parsed_key, 5) }
        to_raw_buffer[parsed_key] = result
    else
        local t_result = string.gsub(string.lower(parsed_key), "%s+", "")
        result = { t_result }
        to_raw_buffer[parsed_key] = result
    end
    return unpack(result or { nil })
end
