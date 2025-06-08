Handy.utils = {}

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
				target[k] = target[k] or {}
				target[k] = Handy.utils.table_merge(target[k], v)
			else
				target[k] = v
			end
		end
	end

	return target
end

function Handy.utils.table_contains(t, value)
	for i = #t, 1, -1 do
		if t[i] and t[i] == value then
			return true
		end
	end
	return false
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

function Handy.utils.cleanup_dead_elements(ref_table, ref_key)
	local new_values = {}
	local target = ref_table[ref_key]
	if not target then
		return
	end
	for k, v in pairs(target) do
		if not v.REMOVED and not v.removed then
			new_values[#new_values + 1] = v
		end
	end
	ref_table[ref_key] = new_values
	return new_values
end

function Handy.utils.string_words_split(str)
	local result = {}
	for word in str:gsub("[%p%c%d]", ""):gmatch("%S+") do
		table.insert(result, word)
	end
	return result
end

function Handy.utils.table_concat_string(table)
	local result = ""
	for _, part in ipairs(table) do
		result = result .. " " .. tostring(part)
	end
	return result
end

function Handy.utils.string_remove_balatro_formatting(str)
	str = str:gsub("#%d+#", "")
	str = str .. "{}"
	str = str:gsub("{[^}]*}", "")
	str = str:gsub("%b{}", "")
	return str
end

function Handy.utils.as_array(t)
	return type(t) == "table" and t or { t }
end

function Handy.utils.split_loc_table_into_words(t)
	return Handy.utils.string_words_split(
		Handy.utils.string_remove_balatro_formatting(Handy.utils.table_concat_string(Handy.utils.as_array(t)))
	)
end
