Handy.API.Control({
	key = "regular_keybinds_run_info",
	get_module = function(self)
		return Handy.cc.regular_keybinds_run_info
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input = true,
	},

	can_execute = function(self, ctx, args)
		return Handy.regular_keybinds.can_execute_swappable_overlay()
			and Handy.controls.can_execute_control(self, ctx, args)
	end,
	execute = Handy.regular_keybinds.create_swappable_overlay_execute("run_info_poker_hands", function()
		Handy.fake_events.execute({
			func = G.FUNCS.run_info,
		})
	end),
})
Handy.API.Control({
	key = "regular_keybinds_run_info_blinds",
	get_module = function(self)
		return Handy.cc.regular_keybinds_run_info_blinds
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input = true,
	},

	can_execute = function(self, ctx, args)
		return Handy.regular_keybinds.can_execute_swappable_overlay()
			and Handy.controls.can_execute_control(self, ctx, args)
	end,
	execute = Handy.regular_keybinds.create_swappable_overlay_execute("run_info_blinds", function()
		Handy.ARGS.override_create_tabs_chosen_by_label = localize("b_blinds")
		Handy.fake_events.execute({
			func = G.FUNCS.run_info,
		})
		Handy.ARGS.override_create_tabs_chosen_by_label = nil
	end),
})
Handy.API.Control({
	key = "regular_keybinds_run_info_vouchers",
	get_module = function(self)
		return Handy.cc.regular_keybinds_run_info_vouchers
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input = true,
	},

	can_execute = function(self, ctx, args)
		return Handy.regular_keybinds.can_execute_swappable_overlay()
			and Handy.controls.can_execute_control(self, ctx, args)
	end,
	execute = Handy.regular_keybinds.create_swappable_overlay_execute("run_info_vouchers", function()
		Handy.ARGS.override_create_tabs_chosen_by_label = localize("b_vouchers")
		Handy.fake_events.execute({
			func = G.FUNCS.run_info,
		})
		Handy.ARGS.override_create_tabs_chosen_by_label = nil
	end),
})
Handy.API.Control({
	key = "regular_keybinds_view_deck",
	get_module = function(self)
		return Handy.cc.regular_keybinds_view_deck
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input = true,
	},

	can_execute = function(self, ctx, args)
		return Handy.regular_keybinds.can_execute_swappable_overlay()
			and Handy.controls.can_execute_control(self, ctx, args)
	end,
	execute = Handy.regular_keybinds.create_swappable_overlay_execute("deck", function()
		Handy.fake_events.execute({
			func = G.FUNCS.deck_info,
		})
	end),
})
Handy.API.Control({
	key = "regular_keybinds_view_lobby_info",
	get_module = function(self)
		return Handy.cc.regular_keybinds_lobby_info
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input = true,
	},

	can_execute = function(self, ctx, args)
		return (G.FUNCS.mpapi_show_lobby_info or G.FUNCS.lobby_info)
			and Handy.b_is_in_multiplayer()
			and Handy.regular_keybinds.can_execute_swappable_overlay()
			and Handy.controls.can_execute_control(self, ctx, args)
	end,
	execute = Handy.regular_keybinds.create_swappable_overlay_execute("lobby_info", function()
		Handy.fake_events.execute({
			func = (G.FUNCS.mpapi_show_lobby_info or G.FUNCS.lobby_info),
		})
	end),
})
