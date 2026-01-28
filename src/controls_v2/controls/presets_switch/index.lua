Handy.load_file("src/controls_v2/controls/presets_switch/logic.lua")

for _, index in ipairs({ 1, 2, 3, "next" }) do
	Handy.controls_v2.register("presets_switch_load_" .. index, {
		get_module = function(self)
			return Handy.cc["presets_load_" .. index], { Handy.cc.presets }
		end,

		context_type = {
			input = true,
		},
		trigger = "trigger",
		require_exact = true,

		execute = function(self, context)
			return Handy.presets_switch.execute(index)
		end,
	})
end
