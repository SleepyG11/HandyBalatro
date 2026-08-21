Handy.API.Control({
	key = "debug_things_reload_localization",
	get_module = function(self)
		return Handy.cc.debug_things_reload_localization
	end,
	get_deps = function(self)
		return { Handy.cc.debug_things }
	end,

	contexts = {
		input_trigger = true,
	},

	can_execute = function(self, ctx, args)
		return Handy.debug_things.can_use_debug() and Handy.controls.can_execute_control(self, ctx, args)
	end,

	execute = function(self, ctx, args, data)
		return Handy.debug_things.reload_localization()
	end,
})

Handy.API.Control({
	key = "debug_things_reload_prototypes",
	get_module = function(self)
		return Handy.cc.debug_things_reload_prototypes
	end,
	get_deps = function(self)
		return { Handy.cc.debug_things }
	end,

	contexts = {
		input_trigger = true,
	},

	can_execute = function(self, ctx, args)
		return Handy.debug_things.can_use_debug() and Handy.controls.can_execute_control(self, ctx, args)
	end,

	execute = function(self, ctx, args, data)
		return Handy.debug_things.reload_prototypes()
	end,
})
