Handy.controls_v2 = {
	controls_sorted = false,
}

Handy.load_file("src/controls_v2/stack.lua")
Handy.load_file("src/controls_v2/controls.lua")

Handy.load_file("src/controls_v2/stacks/input.lua")

Handy.load_files({
	"speed_multiplier/index.lua",
	"animation_skip/index.lua",
	"presets_switch/index.lua",
	"controller_sensitivity.lua",
	"scoring_hold.lua",
}, "src/controls_v2/controls/")

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
