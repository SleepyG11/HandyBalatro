Handy.load_file("src/controls/controls/presets_switch/logic.lua")

for _, index in ipairs({ 1, 2, 3, "next" }) do
	Handy.controls.register("presets_switch_load_" .. index, {
		get_module = function(self)
			return Handy.cc["presets_load_" .. index], { Handy.cc.presets }
		end,

		context_types = {
			input = true,
		},
		trigger = "trigger",
		require_exact_keys = true,

		execute = function(self, context)
			return Handy.presets_switch.execute(index)
		end,
	})
end
