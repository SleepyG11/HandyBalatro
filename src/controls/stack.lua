local order_counter = 10000000000

---

local input_layer = {
	layer = true,
	global = true,
	key = "input",
	order = 0,
	operator = "until",

	stack = {},
	dictionary = {},
}
local card_layer = {
	layer = true,
	global = true,
	key = "card",
	order = -0,
	operator = "until",

	stack = {},
	dictionary = {},
}
local tag_layer = {
	layer = true,
	global = true,
	key = "tag",
	order = 0,
	operator = "until",

	stack = {},
	dictionary = {},
}
local hold_layer = {
	layer = true,
	global = true,
	key = "hold",
	order = 0,
	operator = "until",

	stack = {},
	dictionary = {},
}
local move_layer = {
	layer = true,
	global = true,
	key = "move",
	order = 0,
	operator = "until",

	stack = {},
	dictionary = {},
}

Handy.controls.global_layers = {
	input = input_layer,
	card = card_layer,
	tag = tag_layer,
	hold = hold_layer,
	move = move_layer,
}
Handy.controls.global_layer = {
	layer = true,
	global = true,
	key = "global",

	order = -1,
	operator = "until",

	stack = {
		input_layer,
		card_layer,
		tag_layer,
		hold_layer,
		move_layer,
	},
	dictionary = Handy.controls.global_layers,
}

---

function Handy.controls.crawl(path)
	local target_layer = Handy.controls.global_layer
	if path and path ~= "" then
		for part in string.gmatch(path, "[^%.]+") do
			if not target_layer or not target_layer.layer then
				return nil
			end
			target_layer = target_layer.dictionary[part]
			if not target_layer then
				return nil
			end
		end
	else
		return nil
	end
	return target_layer
end
function Handy.controls.insert_into_stack(item, path)
	local target_layer = Handy.controls.crawl(path)
	if not target_layer then
		return
	end

	Handy.controls.controls_sorted = false

	item.parent = target_layer
	table.insert(target_layer.stack, item)
	target_layer.dictionary[item.key] = item

	return item
end

---

function Handy.controls.register_layer(layer)
	if not layer then
		return
	end

	layer.layer = true
	layer.stack = layer.stack or {}
	layer.dictionary = layer.dictionary or {}
	layer.stack_path = layer.stack_path or ""

	layer.operator = layer.operator or "all"

	if not layer.order then
		layer.order = order_counter
		order_counter = order_counter + 1
	end

	Handy.controls.insert_into_stack(layer, layer.stack_path)

	return layer
end
function Handy.controls.register_control(control)
	if not control then
		return
	end

	control.control = true
	control.stack_path = control.stack_path or ""

	if not control.order then
		control.order = order_counter
		order_counter = order_counter + 1
	end

	Handy.controls.insert_into_stack(control, control.stack_path)

	return control
end

function Handy.controls.sort_controls(layer)
	table.sort(layer.stack, function(a, b)
		return (a.order or 0) < (b.order or 0)
	end)
	for _, child in ipairs(layer.stack) do
		if child.layer then
			Handy.controls.sort_controls(child)
		end
	end
end

function Handy.controls.call_control(ctx, control)
	ctx = Handy.controller.non_empty_context(ctx)
	if control and ctx then
		local r = Handy.controls.execute_control(control.key, { ctx = ctx }) or false
		return r
	end
	return false
end
function Handy.controls.call_layer(ctx, layer)
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
		if item.layer then
			new_value = Handy.controls.call_layer(ctx, item) or should_stop or false
		elseif item.control then
			new_value = Handy.controls.call_control(ctx, item) or should_stop or false
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

function Handy.controls.print_stack(key)
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
	local layer = Handy.controls.global_layers[key]
	Handy.controls.sort_controls(layer)
	process_layer(layer, "")
	return table.concat(result, "\n")
end
