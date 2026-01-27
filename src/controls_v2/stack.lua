local order_counter = 10000000000

---

local input_layer = {
	layer = true,
	global = true,
	key = "input",
	order = -1,
	operator = "first",

	stack = {},
}
local card_layer = {
	layer = true,
	global = true,
	key = "card",
	order = -1,
	operator = "first",

	stack = {},
}
local tag_layer = {
	layer = true,
	global = true,
	key = "tag",
	order = -1,
	operator = "first",

	stack = {},
}
local hold_layer = {
	layer = true,
	global = true,
	key = "hold",
	order = -1,
	operator = "first",

	stack = {},
}

Handy.controls_v2.global_layers = {
	input = input_layer,
	card = card_layer,
	tag = tag_layer,
	hold = hold_layer,
}
Handy.controls_v2.global_layer = {
	layer = true,
	global = true,
	key = "global",

	order = -1,
	operator = "first",

	stack = {
		input_layer,
		card_layer,
		tag_layer,
		hold_layer,
	},
}

---

function Handy.controls_v2.crawl(path)
	local target_layer = Handy.controls_v2.global_layer
	if path and path ~= "" then
		for part in string.gmatch(path, "[^%.]+") do
			if not target_layer or not target_layer.layer then
				return nil
			end
			local is_found = false
			for _, item in ipairs(target_layer.stack) do
				if item.key == part then
					target_layer = item
					is_found = true
					break
				end
			end
			if not is_found then
				return nil
			end
		end
	else
		return nil
	end
	return target_layer
end
function Handy.controls_v2.insert_into_stack(item, path)
	local target_layer = Handy.controls_v2.crawl(path)
	if not target_layer then
		return
	end

	Handy.controls_v2.controls_sorted = false

	item.parent = target_layer
	table.insert(target_layer.stack, item)

	return item
end

---

function Handy.controls_v2.register_layer(layer)
	if not layer then
		return
	end

	layer.layer = true
	layer.stack = layer.stack or {}
	layer.stack_path = layer.stack_path or ""

	layer.operator = layer.operator or "all"

	if not layer.order then
		layer.order = order_counter
		order_counter = order_counter + 1
	end

	Handy.controls_v2.insert_into_stack(layer, layer.stack_path)

	return layer
end
function Handy.controls_v2.register_control(control)
	if not control then
		return
	end

	control.control = true
	control.stack_path = control.stack_path or ""

	if not control.order then
		control.order = order_counter
		order_counter = order_counter + 1
	end

	Handy.controls_v2.insert_into_stack(control, control.stack_path)

	return control
end

function Handy.controls_v2.sort_controls(layer)
	table.sort(layer.stack, function(a, b)
		return (a.order or 0) < (b.order or 0)
	end)
	for _, child in ipairs(layer.stack) do
		if child.layer then
			Handy.controls_v2.sort_controls(child)
		end
	end
end

function Handy.controls_v2.call_control(ctx, control)
	ctx = Handy.controller_v2.non_empty_context(ctx)
	if control and ctx then
		local r = Handy.controls_v2.execute_control(control.key, { ctx = ctx }) or false
		return r
	end
	return false
end
function Handy.controls_v2.call_layer(ctx, layer)
	local operator = layer.operator or "all"
	local should_stop = false

	for _, item in ipairs(layer.stack) do
		if operator == "first" and should_stop then
			break
		end
		if item.layer then
			should_stop = Handy.controls_v2.call_layer(ctx, item) or should_stop or false
		elseif item.control then
			should_stop = Handy.controls_v2.call_control(ctx, item) or should_stop or false
		end
	end

	if operator == "all" then
		return false
	else
		return should_stop or false
	end
end
