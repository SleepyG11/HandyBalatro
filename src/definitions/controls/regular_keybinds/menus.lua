Handy.API.Control({
	key = "regular_keybinds_collection",
	get_module = function(self)
		return Handy.cc.regular_keybinds_collection
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input_trigger = true,
	},

	can_execute = function(self, ctx, args)
		return not G.OVERLAY_MENU and Handy.controls.can_execute_control(self, ctx, args)
	end,
	execute = function(self, ctx, args)
		Handy.fake_events.execute({
			func = G.FUNCS.your_collection,
		})
		return true
	end,
})
Handy.API.Control({
	key = "regular_keybinds_options",
	get_module = function(self)
		return Handy.cc.regular_keybinds_options
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input_trigger = true,
	},

	can_execute = function(self, ctx, args)
		return not G.OVERLAY_MENU and Handy.controls.can_execute_control(self, ctx, args)
	end,
	execute = function(self, ctx, args)
		Handy.fake_events.execute({
			func = G.FUNCS.options,
		})
		return true
	end,
})
Handy.API.Control({
	key = "regular_keybinds_mod_settings",
	get_module = function()
		return Handy.cc.regular_keybinds_mod_settings
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input_trigger = true,
	},

	can_execute = function(self, ctx, args)
		return not G.OVERLAY_MENU and Handy.controls.can_execute_control(self, ctx, args)
	end,
	execute = function(self, ctx, args)
		G.FUNCS.handy_options()
		return true
	end,
})
Handy.API.Control({
	key = "regular_keybinds_show_deck_preview",
	get_module = function(self)
		return Handy.cc.regular_keybinds_show_deck_preview
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	only_in_run = true,
	only_holdable_input = true,

	update = function(self, dt)
		if Handy.b_is_mod_active() and Handy.controls.is_module_enabled(Handy.cc.regular_keybinds) then
			Handy.regular_keybinds.show_deck_preview_hold = Handy.controls.can_execute_control(self)
		else
			Handy.regular_keybinds.show_deck_preview_hold = not not G.CONTROLLER.held_buttons.triggerleft
		end
	end,
})
