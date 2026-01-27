local l = Handy.controls_v2.register_layer
local c = Handy.controls_v2.register_control

l({
	key = "presets",
	operator = "first",
	stack_path = "input",
})

c({
	key = "presets_switch_load_1",
	stack_path = "input.presets",
})
c({
	key = "presets_switch_load_2",
	stack_path = "input.presets",
})
c({
	key = "presets_switch_load_3",
	stack_path = "input.presets",
})
c({
	key = "presets_switch_load_next",
	stack_path = "input.presets",
})

---

l({
	key = "speed_n_animations",
	operator = "first",
	stack_path = "input",
})

l({
	key = "temp_disable",
	operator = "any",
	stack_path = "input.speed_n_animations",
})
l({
	key = "increase",
	operator = "any",
	stack_path = "input.speed_n_animations",
})
l({
	key = "decrease",
	operator = "any",
	stack_path = "input.speed_n_animations",
})

c({
	key = "speed_multiplier_toggle_temp_disabled",
	stack_path = "input.speed_n_animations.temp_disable",
})
c({
	key = "animation_skip_toggle_temp_disabled",
	stack_path = "input.speed_n_animations.temp_disable",
})
c({
	key = "speed_multiplier_increase",
	stack_path = "input.speed_n_animations.increase",
})
c({
	key = "animation_skip_increase",
	stack_path = "input.speed_n_animations.increase",
})
c({
	key = "speed_multiplier_decrease",
	stack_path = "input.speed_n_animations.decrease",
})
c({
	key = "animation_skip_decrease",
	stack_path = "input.speed_n_animations.decrease",
})
