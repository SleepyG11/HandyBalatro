Handy.controls.register("regular_keybinds_run_info", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_run_info, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	can_execute = function(self, args)
		return (Handy.regular_keybinds.swappable_overlay or (not G.SETTINGS.paused and not G.OVERLAY_MENU))
			and G.STAGE == G.STAGES.RUN
			and Handy.controls.can_execute_control(self, args)
	end,
	execute = function(self, args)
		Handy.fake_events.execute({
			func = G.FUNCS.run_info,
		})
		return true
	end,
})
Handy.controls.register("regular_keybinds_run_info_binds", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_run_info_blinds, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	can_execute = function(self, args)
		return (Handy.regular_keybinds.swappable_overlay or (not G.SETTINGS.paused and not G.OVERLAY_MENU))
			and G.STAGE == G.STAGES.RUN
			and Handy.controls.can_execute_control(self, args)
	end,
	execute = function(self, args)
		Handy.override_create_tabs_chosen_by_label = localize("b_blinds")
		Handy.fake_events.execute({
			func = G.FUNCS.run_info,
		})
		Handy.override_create_tabs_chosen_by_label = nil
		return true
	end,
})
Handy.controls.register("regular_keybinds_collection", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_collection, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	can_execute = function(self, args)
		return not G.OVERLAY_MENU and Handy.controls.can_execute_control(self, args)
	end,
	execute = function(self, args)
		Handy.fake_events.execute({
			func = G.FUNCS.your_collection,
		})
		return true
	end,
})
Handy.controls.register("regular_keybinds_options", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_options, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	can_execute = function(self, args)
		return not G.OVERLAY_MENU and Handy.controls.can_execute_control(self, args)
	end,
	execute = function(self, args)
		Handy.fake_events.execute({
			func = G.FUNCS.options,
		})
		return true
	end,
})
Handy.controls.register("regular_keybinds_view_deck", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_view_deck, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	can_execute = function(self, args)
		return (Handy.regular_keybinds.swappable_overlay or (not G.SETTINGS.paused and not G.OVERLAY_MENU))
			and G.STAGE == G.STAGES.RUN
			and Handy.controls.can_execute_control(self, args)
	end,
	execute = function(self, args)
		Handy.fake_events.execute({
			func = G.FUNCS.deck_info,
		})
		return true
	end,
})
Handy.controls.register("regular_keybinds_view_lobby_info", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_lobby_info, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	can_execute = function(self, args)
		return MP
			and G.FUNCS.lobby_info
			and Handy.b_is_in_multiplayer()
			and (Handy.regular_keybinds.swappable_overlay or (not G.SETTINGS.paused and not G.OVERLAY_MENU))
			and G.STAGE == G.STAGES.RUN
			and Handy.controls.can_execute_control(self, args)
	end,
	execute = function(self, args)
		Handy.fake_events.execute({
			func = G.FUNCS.lobby_info,
		})
		return true
	end,
})
Handy.controls.register("regular_keybinds_mod_settings", {
	get_module = function()
		return Handy.cc.regular_keybinds_mod_settings, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	can_execute = function(self, args)
		return not G.OVERLAY_MENU and Handy.controls.can_execute_control(self, args)
	end,
	execute = function()
		G.FUNCS.handy_options()
		return true
	end,
})
