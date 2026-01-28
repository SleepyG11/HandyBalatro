Handy.load_file("src/controls_v2/controls/speed_multiplier/logic.lua")

---

Handy.controls_v2.register("speed_multiplier_toggle_temp_disabled", {
	get_module = function(self)
		return Handy.cc.speed_multiplier_toggle_temp_disabled, { Handy.cc.speed_multiplier }
	end,

	context_type = {
		input = true,
	},
	trigger = "trigger",

	execute = function(self, args, leftover_data)
		Handy.speed_multiplier.toggle_temp_disabled()
		return true
	end,
})
Handy.controls_v2.register("speed_multiplier_increase", {
	get_module = function(self)
		return Handy.cc.speed_multiplier_multiply, { Handy.cc.speed_multiplier }
	end,

	context_type = {
		input = true,
	},
	trigger = "trigger",

	execute = function(self, args, leftover_data)
		Handy.speed_multiplier.change(1)
		return true
	end,
})
Handy.controls_v2.register("speed_multiplier_decrease", {
	get_module = function(self)
		return Handy.cc.speed_multiplier_divide, { Handy.cc.speed_multiplier }
	end,

	context_type = {
		input = true,
	},
	trigger = "trigger",

	execute = function(self, args, leftover_data)
		Handy.speed_multiplier.change(-1)
		return true
	end,
})
