Handy.stack = {}

---

Handy.stack.dictionary = {}
Handy.stack.list = {}

Handy.stack.global_layer = {
	global = true,
	key = "global",

	order = -1,
	global_order = -1,
	operator = "until",

	stack = {},
}

---

local order_counter = 1
function Handy.stack.register(item)
	item.stack_path = item.stack_path or ""
	item.full_path = (item.stack_path == "" or item.global) and item.key or (item.stack_path .. "." .. item.key)
	item.stack = item.stack or {}
	item.operator = item.operator or "all"

	if item.control == true then
		item.control = item.key
	end

	if not item.order then
		item.order = order_counter
		order_counter = order_counter + 1
	else
		order_counter = math.max(item.order + 1, order_counter)
	end

	local target_layer = item.global and Handy.stack.global_layer or Handy.stack.dictionary[item.stack_path]
	item.parent = target_layer
	table.insert(target_layer.stack, item)

	Handy.stack.dictionary[item.full_path] = item
	table.insert(Handy.stack.list, item)

	Handy.stack.sorted = false

	return item
end

--

function Handy.stack.sort_item(item)
	item.global_order = Handy.stack.global_order
	Handy.stack.global_order = Handy.stack.global_order + 1

	if item.stack then
		table.sort(item.stack, function(a, b)
			return (a.order or 0) < (b.order or 0)
		end)
		for _, child in ipairs(item.stack) do
			Handy.stack.sort_item(child)
		end
	end
end
function Handy.stack.sort()
	Handy.stack.global_order = 1
	local root_items = {}
	for _, item in ipairs(Handy.stack.list) do
		item.global_order = nil
		if not item.parent or item.parent == Handy.stack.global_layer then
			table.insert(root_items, item)
		end
	end
	table.sort(root_items, function(a, b)
		return (a.order or 0) < (b.order or 0)
	end)
	for _, item in ipairs(root_items) do
		Handy.stack.sort_item(item)
	end
	table.sort(Handy.stack.list, function(a, b)
		return a.global_order < b.global_order
	end)
	Handy.stack.sorted = true
end

--

function Handy.stack.call_control(ctx, item)
	ctx = Handy.controller.non_empty_context(ctx)
	if item and ctx then
		local r = Handy.controls.execute_control(item.control, ctx) or false
		return r
	end
	return false
end
function Handy.stack.call_layer(ctx, layer)
	-- Operators:
	-- free = call all, always false
	-- until = stop if one true, return true if so
	-- while = stop if one false, return true if so
	-- all = call all, return true if all true
	-- none = call all, return true if all false
	-- any = call all, return true if any true

	local operator = layer.operator or "free"
	local should_stop = (layer.operator == "all" or layer.operator == "while") and #layer.stack > 0

	for _, item in ipairs(layer.stack) do
		if operator == "until" and should_stop then
			return true
		elseif operator == "while" and not should_stop then
			return true
		end
		local new_value
		if item.control then
			new_value = Handy.stack.call_control(ctx, item) or should_stop or false
		else
			new_value = Handy.stack.call_layer(ctx, item) or should_stop or false
		end
		if operator == "all" or operator == "while" then
			should_stop = should_stop and new_value
		else
			should_stop = should_stop or new_value
		end
	end

	if operator == "free" then
		return false
	elseif operator == "none" then
		return not should_stop
	else
		return should_stop or false
	end
end

--

function Handy.stack.print_stack(key)
	local result = { "" }
	local format_item = function(item, indent)
		return string.format(
			"%s[%s] %s %s",
			indent,
			item.order,
			item.key,
			item.operator and ("(" .. item.operator .. ")") or ""
		)
	end
	local process_layer
	process_layer = function(item, indent)
		table.insert(result, format_item(item, indent))
		if item.stack then
			for _, subitem in ipairs(item.stack) do
				process_layer(subitem, indent .. "    ")
			end
		end
	end
	local layer = Handy.stack.dictionary[key]
	process_layer(layer, "")
	return table.concat(result, "\n")
end

--

local function process_controller_context(ctx)
	if not Handy.stack.sorted then
		Handy.stack.sort()
	end
	Handy.stack.call_layer(ctx, Handy.stack.dictionary[ctx.type])
end

Handy.e_mitter.on("controller_input", process_controller_context)
Handy.e_mitter.on("controller_hold", process_controller_context)
Handy.e_mitter.on("controller_card", process_controller_context)
Handy.e_mitter.on("controller_tag", process_controller_context)
Handy.e_mitter.on("controller_move", process_controller_context)
