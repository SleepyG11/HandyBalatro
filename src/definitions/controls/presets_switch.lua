for _, index in ipairs({ 1, 2, 3, "next" }) do
	Handy.controls.register({
		key = "presets_switch_load_" .. index,
		get_module = function(self)
			return Handy.cc["presets_load_" .. index], { Handy.cc.presets }
		end,

		contexts = {
			input_trigger = true,
		},
		require_exact_keys = true,

		execute = function(self, ctx, args, data)
			return Handy.presets_switch.load_index(index)
		end,
	})
end
