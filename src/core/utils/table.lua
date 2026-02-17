--- @generic T
--- @generic S
--- @param target T
--- @param source S
--- @param ... any
--- @return T | S
function Handy.utils.table_merge(target, source, ...)
	assert(type(target) == "table", "Target is not a table")
	local tables_to_merge = { source, ... }
	if #tables_to_merge == 0 then
		return target
	end

	for k, t in ipairs(tables_to_merge) do
		assert(type(t) == "table", string.format("Expected a table as parameter %d", k))
	end

	for i = 1, #tables_to_merge do
		local from = tables_to_merge[i]
		for k, v in pairs(from) do
			if type(v) == "table" then
				target[k] = Handy.utils.table_merge(target[k] or {}, v)
			else
				target[k] = v
			end
		end
	end

	return target
end

--- @generic T
--- @generic S
--- @param target T
--- @param source S
--- @param ... any
--- @return T | S
function Handy.utils.table_merge_limit(limit, target, source, ...)
	assert(type(target) == "table", "Target is not a table")
	limit = limit or 1
	if type(limit) == "number" then
		limit = {
			limit = limit,
			current = 0,
		}
	end
	local tables_to_merge = { source, ... }
	if #tables_to_merge == 0 then
		return target
	end

	for k, t in ipairs(tables_to_merge) do
		assert(type(t) == "table", string.format("Expected a table as parameter %d", k))
	end

	for i = 1, #tables_to_merge do
		local from = tables_to_merge[i]
		for k, v in pairs(from) do
			if limit.current < limit.limit and type(v) == "table" then
				target[k] = Handy.utils.table_merge_limit(
					{ limit = limit.limit, current = limit.current + 1 },
					target[k] or {},
					v
				)
			else
				target[k] = v
			end
		end
	end

	return target
end

--- @generic T
--- @generic S
--- @param target T
--- @param source S
--- @param ... any
--- @return T | S
function Handy.utils.table_shallow_merge(target, source, ...)
	assert(type(target) == "table", "Target is not a table")
	local tables_to_merge = { source, ... }
	if #tables_to_merge == 0 then
		return target
	end

	for k, t in ipairs(tables_to_merge) do
		assert(type(t) == "table", string.format("Expected a table as parameter %d", k))
	end

	for i = 1, #tables_to_merge do
		local from = tables_to_merge[i]
		for k, v in pairs(from) do
			target[k] = v
		end
	end

	return target
end

function Handy.utils.serialize_string(s)
	return string.format("%q", s)
end

function Handy.utils.serialize(t, indent)
	indent = indent or ""
	local str = "{\n"
	for k, v in ipairs(t) do
		str = str .. indent .. "\t"
		if type(v) == "number" then
			str = str .. v
		elseif type(v) == "boolean" then
			str = str .. (v and "true" or "false")
		elseif type(v) == "string" then
			str = str .. Handy.utils.serialize_string(v)
		elseif type(v) == "table" then
			str = str .. Handy.utils.serialize(v, indent .. "\t")
		else
			-- not serializable
			str = str .. "nil"
		end
		str = str .. ",\n"
	end
	for k, v in pairs(t) do
		if type(k) == "string" then
			str = str .. indent .. "\t" .. "[" .. Handy.utils.serialize_string(k) .. "] = "

			if type(v) == "number" then
				str = str .. v
			elseif type(v) == "boolean" then
				str = str .. (v and "true" or "false")
			elseif type(v) == "string" then
				str = str .. Handy.utils.serialize_string(v)
			elseif type(v) == "table" then
				str = str .. Handy.utils.serialize(v, indent .. "\t")
			else
				-- not serializable
				str = str .. "nil"
			end
			str = str .. ",\n"
		end
	end
	str = str .. indent .. "}"
	return str
end

function Handy.utils.table_shallow_copy(t)
	local res = {}
	if not t or type(t) ~= "table" then
		return res
	end
	for k, v in pairs(t) do
		res[k] = v
	end
	return res
end

function Handy.utils.table_contains(t, value)
	for i = #t, 1, -1 do
		if t[i] and t[i] == value then
			return true
		end
	end
	return false
end

function Handy.utils.table_keys_count(t)
	local r = 0
	for k, v in pairs(t or {}) do
		r = r + 1
	end
	return r
end

function Handy.utils.as_array(t)
	return type(t) == "table" and t or { t }
end

function Handy.utils.table_concat(t1, t2)
	local result = Handy.utils.table_shallow_copy(t1)
	for k, v in ipairs(t2) do
		result[#result + 1] = v
	end
	return result
end

function Handy.utils.table_slice(t, start, stop)
	local res = {}

	local len = #t
	start = start or 0
	stop = (stop ~= nil) and stop or len

	if start < 0 then
		start = len + start
	else
		start = start
	end
	if stop < 0 then
		stop = len + stop
	end

	if start < 1 then
		start = 1
	end
	if stop > len then
		stop = len
	end

	for i = start, stop do
		res[#res + 1] = t[i]
	end

	return res
end
