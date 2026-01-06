local modifier_order = {
	["Unknown"] = -1,
	["None"] = 0,
	["Ctrl"] = 1,
	["Shift"] = 2,
	["Alt"] = 3,
	["GUI"] = 4,
	["Caps Lock"] = 5,
	["Num Lock"] = 6,
	["Scroll Lock"] = 7,
}

local big_key_order = {
	["Backspace"] = 1,
	["Tab"] = 2,
	["Enter"] = 4,
	["Space"] = 5,
	["Delete"] = 7,
	["Insert"] = 8,
	["Home"] = 9,
	["End"] = 10,
	["Page Up"] = 11,
	["Page Down"] = 12,
}

local controller_order = {
	["Left Stick"] = 1,
	["Right Stick"] = 2,
	["Left Bumper"] = 3,
	["Right Bumper"] = 4,
	["Left Trigger"] = 5,
	["First Paddle"] = 6,
	["Second Paddle"] = 7,
	["Third Paddle"] = 8,
	["Fourth Paddle"] = 9,
	["(Up)"] = 10,
	["(Left)"] = 11,
	["(Down)"] = 12,
	["(Right)"] = 13,
	["(Guide)"] = 14,
	["(Start)"] = 15,
	["(Back)"] = 16,
	["(Misc. Button)"] = 17,
}

local mouse_order = {
	["Left Mouse"] = 1,
	["Right Mouse"] = 2,
	["Mouse 3"] = 3,
	["Mouse 4"] = 4,
	["Mouse 5"] = 5,
}

local function classify_key(key)
	local lower = key:lower()

	if mouse_order[key] then
		return 5, mouse_order[key], lower
	end

	if modifier_order[key] then
		return 1, modifier_order[key], lower
	end

	if big_key_order[key] then
		return 2, big_key_order[key], lower
	end

	if controller_order[key] then
		return 3, controller_order[key], lower
	end

	if string.sub(key, 1, 4) == "NUM " then
		key = string.sub(key, 5)
	end

	if #key == 1 then
		local byte = key:byte()
		local is_digit = (byte >= 48 and byte <= 57) -- '0'-'9'
		local is_upper = (byte >= 65 and byte <= 90) -- 'A'-'Z'
		local is_lower = (byte >= 97 and byte <= 122) -- 'a'-'z'

		if is_digit or is_upper or is_lower then
			return 4, byte, lower
		end
	end

	return 3, 1000, lower
end

local function key_sort(a, b)
	local g1, i1, s1 = classify_key(a)
	local g2, i2, s2 = classify_key(b)
	if g1 ~= g2 then
		return g1 < g2
	end
	if i1 ~= i2 then
		return i1 < i2
	end
	return s1 < s2
end

function Handy.utils.sort_keys(t)
	table.sort(t, key_sort)
	return t
end

function Handy.utils.normalize_keys(t)
	local duplicates = {}
	local result = {}
	for _, key in pairs(t) do
		if key == "None" or key == "Unknown" then
			return {}
		elseif not duplicates[key] then
			table.insert(result, key)
			duplicates[key] = true
		end
	end
	return Handy.utils.sort_keys(result)
end
