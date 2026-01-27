Handy.controls_v2 = {
	controls_sorted = false,
}

Handy.load_file("src/controls_v2/stack.lua")
Handy.load_file("src/controls_v2/controls.lua")

Handy.load_file("src/controls_v2/stacks/test.lua")

Handy.load_file("src/controls_v2/controls/speed_multiplier.lua")
Handy.load_file("src/controls_v2/controls/animation_skip.lua")
Handy.load_file("src/controls_v2/controls/presets_switch.lua")

---

local function process_controller_context(ctx)
	if not Handy.controls_v2.controls_sorted then
		Handy.controls_v2.sort_controls(Handy.controls_v2.global_layer)
		Handy.controls_v2.controls_sorted = true
	end
	Handy.controls_v2.call_layer(ctx, Handy.controls_v2.global_layers[ctx.type])
end

Handy.e_mitter.on("controller_input", process_controller_context)
Handy.e_mitter.on("controller_hold", process_controller_context)
Handy.e_mitter.on("controller_card", process_controller_context)
Handy.e_mitter.on("controller_tag", process_controller_context)
