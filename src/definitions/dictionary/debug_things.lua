Handy.API.Dictionary({
	key = "debug_things",
	order = 15,

	keywords = { "debug dev developer" },
	get_module = function(self)
		return Handy.cc.debug_things
	end,

	checkbox = {
		get_values = function()
			return {
				disabled = not Handy.debug_things.can_use_debug(),
			}
		end,
	},
	mod_deps = {
		["DebugPlus"] = "required",
	},
})

Handy.API.Dictionary({
	key = "debug_things_reload_localization",
	parent = "debug_things",
	order = 1,

	keywords = { "reload localization" },
	no_gamepad = true,
	get_module = function(self)
		return Handy.cc.debug_things_reload_localization
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	keybind = {
		allow_multiple = true,
	},
	checkbox = {
		get_values = function()
			return {
				disabled = not Handy.debug_things.can_use_debug(),
			}
		end,
	},
	mod_deps = {
		["DebugPlus"] = "required",
	},
})
Handy.API.Dictionary({
	key = "debug_things_reload_prototypes",
	parent = "debug_things",
	order = 1,

	keywords = { "reload item prototypes" },
	no_gamepad = true,
	get_module = function(self)
		return Handy.cc.debug_things_reload_prototypes
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	keybind = {
		allow_multiple = true,
	},
	checkbox = {
		get_values = function()
			return {
				disabled = not Handy.debug_things.can_use_debug(),
			}
		end,
	},
	mod_deps = {
		["DebugPlus"] = "required",
	},
})
