Handy.controls = {
	controls_sorted = false,
}

Handy.load_file("src/controls/stack.lua")
Handy.load_file("src/controls/controls.lua")

Handy.load_files({
	"input.lua",
	"card.lua",
	"hold.lua",
	"tag.lua",
}, "src/controls/stacks/")

Handy.load_files({
	"speed_multiplier/index.lua",
	"animation_skip/index.lua",
	"presets_switch/index.lua",
	"regular_keybinds/index.lua",
	"move_highlight/index.lua",
	"insta_actions/index.lua",
	"dangerous_actions/index.lua",
	"controller_sensitivity.lua",
	"scoring_hold.lua",
	"hand_selection.lua",
}, "src/controls/controls/")

---

local function process_controller_context(ctx)
	if not Handy.controls.controls_sorted then
		Handy.controls.sort_controls(Handy.controls.global_layer)
		Handy.controls.controls_sorted = true
	end
	Handy.controls.call_layer(ctx, Handy.controls.global_layers[ctx.type])
end

Handy.e_mitter.on("controller_input", process_controller_context)
Handy.e_mitter.on("controller_hold", process_controller_context)
Handy.e_mitter.on("controller_card", process_controller_context)
Handy.e_mitter.on("controller_tag", process_controller_context)
