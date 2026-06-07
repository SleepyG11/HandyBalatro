Handy.controls.register({
	key = "speed_multiplier_toggle_temp_disabled",
	get_module = function(self)
		return Handy.cc.speed_multiplier_toggle_temp_disabled
	end,
	get_deps = function(self)
		return { Handy.cc.speed_multiplier }
	end,

	contexts = {
		input_trigger = true,
	},

	execute = function(self, ctx, args)
		Handy.speed_multiplier.toggle_temp_disabled()
		return true
	end,
})
Handy.controls.register({
	key = "speed_multiplier_increase",
	get_module = function(self)
		return Handy.cc.speed_multiplier_multiply
	end,
	get_deps = function(self)
		return { Handy.cc.speed_multiplier }
	end,

	contexts = {
		input_trigger = true,
	},

	execute = function(self, ctx, args)
		Handy.speed_multiplier.change(1)
		return true
	end,
})
Handy.controls.register({
	key = "speed_multiplier_decrease",
	get_module = function(self)
		return Handy.cc.speed_multiplier_divide
	end,
	get_deps = function(self)
		return { Handy.cc.speed_multiplier }
	end,

	contexts = {
		input_trigger = true,
	},

	execute = function(self, ctx, args)
		Handy.speed_multiplier.change(-1)
		return true
	end,
})
