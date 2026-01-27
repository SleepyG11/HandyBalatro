Handy.controls_v2.register("animation_skip_toggle_temp_disabled", {
	get_module = function(self)
		return Handy.cc.animation_skip_toggle_temp_disabled, { Handy.cc.animation_skip }
	end,

	context_type = {
		input = true,
	},
	trigger = "trigger",

	execute = function(self, args, leftover_data)
		Handy.animation_skip.toggle_temp_disabled()
		return true
	end,
})
Handy.controls_v2.register("animation_skip_increase", {
	get_module = function(self)
		return Handy.cc.animation_skip_increase, { Handy.cc.animation_skip }
	end,

	context_type = {
		input = true,
	},
	trigger = "trigger",

	execute = function(self, args, leftover_data)
		Handy.animation_skip.change(1)
		return true
	end,
})
Handy.controls_v2.register("animation_skip_decrease", {
	get_module = function(self)
		return Handy.cc.animation_skip_decrease, { Handy.cc.animation_skip }
	end,

	context_type = {
		input = true,
	},
	trigger = "trigger",

	execute = function(self, args, leftover_data)
		Handy.animation_skip.change(-1)
		return true
	end,
})
