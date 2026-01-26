local keys_hold = {}
local keys_press = {}
local keys_release = {}

local real_keys_hold = {}
local real_keys_press = {}
local real_keys_release = {}

local keys_hold_size = nil
local function get_keys_hold_size()
	if not keys_hold_size then
		keys_hold_size = Handy.utils.table_keys_count(keys_hold)
	end
	return keys_hold_size
end
local function update_hold(dt, only_real)
	dt = dt or 0
	if not only_real then
		for key, value in pairs(keys_hold) do
			keys_hold[key] = value + dt
		end
	end
	local result = 0
	for key, value in pairs(real_keys_hold) do
		result = result + 1
		real_keys_hold[key] = value + dt
	end
	return result
end

---

local function pre_press_key(input_type, raw_key)
	local input_ctx = Handy.controller_v2.input.update_context(input_type, raw_key, false, 0)

	if input_ctx.key then
		keys_hold[input_ctx.key] = input_ctx.hold_duration or 0
		keys_press[input_ctx.key] = input_ctx.hold_duration or 0
		keys_release[input_ctx.key] = nil
		real_keys_hold[input_ctx.key] = input_ctx.real_hold_duration or 0
		real_keys_press[input_ctx.key] = input_ctx.real_hold_duration or 0
		real_keys_release[input_ctx.key] = nil
	end

	keys_hold_size = nil

	return input_ctx
end
local function post_press_key()
	local input_ctx = Handy.controller_v2.input.get_context()

	if input_ctx.key then
		local hold_duration = input_ctx.holdable and (input_ctx.hold_duration or 0) or nil
		local real_hold_duration = input_ctx.holdable and (input_ctx.real_hold_duration or 0) or nil

		keys_hold[input_ctx.key] = hold_duration
		keys_press[input_ctx.key] = nil
		keys_release[input_ctx.key] = nil
		real_keys_hold[input_ctx.key] = real_hold_duration
		real_keys_press[input_ctx.key] = nil
		real_keys_release[input_ctx.key] = nil
	end

	Handy.controller_v2.input.update_context()
	keys_hold_size = nil

	return input_ctx
end

local function pre_release_key(input_type, raw_key)
	local input_ctx = Handy.controller_v2.input.update_context(input_type, raw_key, true)

	if input_ctx.key then
		local hold_duration = keys_hold[input_ctx.key]
		local real_hold_duration = real_keys_hold[input_ctx.key]

		input_ctx.hold_duration = hold_duration
		input_ctx.real_hold_duration = real_hold_duration

		keys_hold[input_ctx.key] = nil
		keys_press[input_ctx.key] = nil
		keys_release[input_ctx.key] = hold_duration
		real_keys_hold[input_ctx.key] = nil
		real_keys_press[input_ctx.key] = nil
		real_keys_release[input_ctx.key] = real_hold_duration
	end

	keys_hold_size = nil

	return input_ctx
end
local function post_release_key()
	local input_ctx = Handy.controller_v2.input.get_context()

	if input_ctx.key then
		keys_hold[input_ctx.key] = nil
		keys_press[input_ctx.key] = nil
		keys_release[input_ctx.key] = nil
		real_keys_hold[input_ctx.key] = nil
		real_keys_press[input_ctx.key] = nil
		real_keys_release[input_ctx.key] = nil
	end

	Handy.controller_v2.input.update_context()
	keys_hold_size = nil

	return input_ctx
end

local function pre_key_action(input_type, raw_key, released)
	if not released then
		return pre_press_key(input_type, raw_key)
	else
		return pre_release_key(input_type, raw_key)
	end
end
local function post_key_action(released)
	if not released then
		return post_press_key()
	else
		return post_release_key()
	end
end

---

local function is_trigger(released)
	if Handy.cc.keybinds_trigger_mode.value == 2 then
		return released
	else
		return not released
	end
end

local function is_key_press(key)
	return key and keys_press[key] and true or nil
end
local function is_key_release(key)
	return key and keys_release[key] and true or nil
end
local function is_key_trigger(key, released)
	if not key then
		return false
	elseif not Handy.controller_v2.keys.is_holdable_key(key) then
		return not released
	else
		return is_trigger(released)
	end
end

---

local function get_key_hold_duration(key, args)
	if not key then
		return nil
	end
	args = args or {}

	local hold_d = args.real and real_keys_hold[key] or keys_hold[key]
	if not hold_d and args.include_release then
		hold_d = args.real and real_keys_release[key] or keys_release[key]
	end
	return hold_d
end
local function get_keys_hold_duration(keys, args)
	local max_value = 0
	local is_empty = true
	for _, key in ipairs(keys or {}) do
		is_empty = false
		local hold_d = get_key_hold_duration(key, args)
		if not hold_d then
			return nil
		end
		max_value = math.max(max_value, hold_d)
	end
	return not is_empty and max_value or nil
end

local function is_key_hold(keys, args)
	local d = get_key_hold_duration(keys, args)
	return d ~= nil, d or 0
end
local function is_keys_hold(keys, args)
	local d = get_keys_hold_duration(keys, args)
	return d ~= nil, d or 0
end

---

local key_states = {
	hold = keys_hold,
	press = keys_press,
	release = keys_release,

	real_hold = real_keys_hold,
	real_press = real_keys_press,
	real_release = real_keys_release,

	get_hold_size = get_keys_hold_size,

	pre_press = pre_press_key,
	post_press = post_press_key,
	pre_release = pre_release_key,
	post_release = post_release_key,

	pre_action = pre_key_action,
	post_action = post_key_action,

	is_press = is_key_press,
	is_hold = is_key_hold,
	is_release = is_key_release,
	is_trigger = is_trigger,
	is_key_trigger = is_key_trigger,

	get_key_hold_duration = get_keys_hold_duration,
	get_keys_hold_duration = get_keys_hold_duration,
	is_keys_hold = is_keys_hold,

	update = update_hold,
}

---

Handy.controller_v2.key_states = key_states

Handy.controller_v2.is_key_press = is_key_press
Handy.controller_v2.is_key_release = is_key_release
Handy.controller_v2.is_key_trigger = is_key_trigger

Handy.controller_v2.is_key_hold = is_key_hold
Handy.controller_v2.is_keys_hold = is_keys_hold
