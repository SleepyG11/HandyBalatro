--- Taken from SMODS

local V_MT = {
	__eq = function(a, b)
		local minorWildcard = a.minor == -2 or b.minor == -2
		local patchWildcard = a.patch == -2 or b.patch == -2
		local betaWildcard = a.rev == "~" or b.rev == "~"
		return a.major == b.major
			and (a.minor == b.minor or minorWildcard)
			and (a.patch == b.patch or minorWildcard or patchWildcard)
			and (a.rev == b.rev or minorWildcard or patchWildcard or betaWildcard)
			and (betaWildcard or a.beta == b.beta)
	end,
	__le = function(a, b)
		local b = {
			major = b.major + (b.minor == -2 and 1 or 0),
			minor = b.minor == -2 and 0 or (b.minor + (b.patch == -2 and 1 or 0)),
			patch = b.patch == -2 and 0 or b.patch,
			beta = b.beta,
			rev = b.rev,
		}
		if a.major ~= b.major then
			return a.major < b.major
		end
		if a.minor ~= b.minor then
			return a.minor < b.minor
		end
		if a.patch ~= b.patch then
			return a.patch < b.patch
		end
		if a.beta ~= b.beta then
			return a.beta < b.beta
		end
		return a.rev <= b.rev
	end,
	__lt = function(a, b)
		return a <= b and not (a == b)
	end,
	__call = function(_, str)
		str = str or "0.0.0"
		local _, _, major, minorFull, minor, patchFull, patch, rev =
			string.find(str, "^(%d+)(%.?([%d%*]*))(%.?([%d%*]*))(.*)$")
		local minorWildcard = string.match(minor, "%*")
		local patchWildcard = string.match(patch, "%*")
		if (minorFull ~= "" and minor == "") or (patchFull ~= "" and patch == "") then
			sendWarnMessage('Trailing dot found in version "' .. str .. '".', "Utils")
			major, minor, patch = -1, 0, 0
		end
		local t = {
			major = tonumber(major),
			minor = minorWildcard and -2 or tonumber(minor) or 0,
			patch = patchWildcard and -2 or tonumber(patch) or 0,
			rev = rev or "",
			beta = rev and rev:sub(1, 1) == "~" and -1 or 0,
		}
		return setmetatable(t, V_MT)
	end,
}
local V = setmetatable({}, V_MT)
V_MT.__index = V
function V.is_valid(v, allow_wildcard)
	if getmetatable(v) ~= V_MT then
		return false
	end
	return (
		pcall(function()
			return V() <= v and (allow_wildcard or (v.minor ~= -2 and v.patch ~= -2 and v.rev ~= "~"))
		end)
	)
end

V.is_newer = function(a, b)
	return V_MT.__le(b, a) and not V_MT.__eq(b, a)
end

Handy.updater.V = V
