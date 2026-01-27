Handy.controls_v2 = {}

local controls_sorted = false
local controls_layer = {
	layer = true,
	key = "global",
	order = 0,
	operator = "first",

	stack = {
		{
			layer = true,
			key = "presets",
			operator = "first",
			order = 0,

			stack = {
				{
					control = true,
					key = "presets_switch_load_1",
					stack_path = "presets",
					order = 0,
				},
				{
					control = true,
					key = "presets_switch_load_2",
					stack_path = "presets",
					order = 1,
				},
				{
					control = true,
					key = "presets_switch_load_3",
					stack_path = "presets",
					order = 2,
				},
				{
					control = true,
					key = "presets_switch_load_next",
					stack_path = "presets",
					order = 3,
				},
			},
		},
		{
			layer = true,
			key = "speed_n_animations",
			operator = "first",

			stack = {
				{
					layer = true,
					key = "temp_disabled",
					operator = "any",
					order = 0,

					stack = {
						{
							control = true,
							key = "speed_multiplier_toggle_temp_disabled",
							stack_path = "speed_n_animations.temp_disabled",
							order = 0,
						},
						{
							control = true,
							key = "animation_skip_toggle_temp_disabled",
							stack_path = "speed_n_animations.temp_disabled",
							order = 1,
						},
					},
				},
				{
					layer = true,
					key = "increase",
					operator = "any",
					order = 0,

					stack = {
						{
							control = true,
							key = "speed_multiplier_increase",
							stack_path = "speed_n_animations.increase",
							order = 0,
						},
						{
							control = true,
							key = "animation_skip_increase",
							stack_path = "speed_n_animations.increase",
							order = 1,
						},
					},
				},
				{
					layer = true,
					key = "decrease",
					operator = "any",
					order = 0,

					stack = {
						{
							control = true,
							key = "speed_multiplier_decrease",
							stack_path = "speed_n_animations.decrease",
							order = 0,
						},
						{
							control = true,
							key = "animation_skip_decrease",
							stack_path = "speed_n_animations.decrease",
							order = 1,
						},
					},
				},
			},
		},
	},
}

function Handy.controls_v2.crawl(path)
	local target_stack = controls_layer
	if path and path ~= "" then
		for _, part in string.gmatch(path, "[^%.]+") do
			if not target_stack or not target_stack.layer then
				break
			end
			local is_found = false
			for _, item in ipairs(target_stack.stack) do
				if item.key == part then
					target_stack = item
					is_found = true
					break
				end
			end
			if not is_found then
				return nil
			end
		end
	end
	return target_stack
end

function Handy.controls_v2.register_layer(layer)
	local target_stack = Handy.controls_v2.crawl(layer.stack_path)
	if not target_stack then
		return
	end
end

---

function Handy.controls_v2.sort_controls(item)
	table.sort(item.stack, function(a, b)
		return (a.order or 0) > (b.order or 0)
	end)
	for _, child in ipairs(item.stack) do
		if child.layer then
			Handy.controls_v2.sort_controls(child)
		end
	end
end

---

function Handy.controls_v2.call_control(ctx, control)
	if control and control.execute and ctx and not ctx.none then
		return control:execute(ctx) or false
	end
end

function Handy.controls_v2.call_controls_layer(ctx, layer)
	local operator = layer.operator or "all"
	local should_stop = false

	for _, item in ipairs(layer.stack) do
		if operator == "first" and should_stop then
			return true
		end
		if item.layer then
			should_stop = Handy.controls_v2.call_controls_layer(ctx, item) or false
		elseif item.control then
			should_stop = Handy.controls_v2.call_control(ctx, item) or false
		end
	end
	if operator == "all" then
		return false
	else
		return should_stop or false
	end
end

---

Handy.e_mitter.on("controller_input", function(ctx)
	if not controls_sorted then
		Handy.controls_v2.sort_controls(controls_layer)
		controls_sorted = true
	end
	Handy.controls_v2.call_controls_layer(ctx, controls_layer)
end)
