Handy.controls.register({
	key = "regular_keybinds_play",
	get_module = function(self)
		return Handy.cc.regular_keybinds_play
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input_trigger = true,
	},

	require_exact_keys_input = true,
	no_stop_use = true,
	only_in_run = true,

	can_execute = function(self, ctx, args)
		return not Handy.regular_keybinds.play_blocker
			and G.STATE == G.STATES.SELECTING_HAND
			and Handy.controls.can_execute_control(self, ctx, args)
			and Handy.fake_events.check_button(function()
				return G.buttons.states.visible and G.buttons:get_UIE_by_ID("play_button")
			end, { visible = true })
	end,
	execute = function(self, ctx, args)
		Handy.regular_keybinds.play_blocker = true
		Handy.fake_events.execute_button(function()
			return G.buttons:get_UIE_by_ID("play_button")
		end)
		G.E_MANAGER:add_event(Event({
			no_delete = true,
			blocking = false,
			func = function()
				Handy.regular_keybinds.play_blocker = false
				return true
			end,
		}))
		return true
	end,
})
Handy.controls.register({
	key = "regular_keybinds_discard",
	get_module = function(self)
		return Handy.cc.regular_keybinds_discard
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input_trigger = true,
	},

	require_exact_keys_input = true,
	no_stop_use = true,
	only_in_run = true,

	can_execute = function(self, ctx, args)
		return not Handy.regular_keybinds.discard_blocker
			and G.STATE == G.STATES.SELECTING_HAND
			and Handy.controls.can_execute_control(self, ctx, args)
			and Handy.fake_events.check_button(function()
				return G.buttons.states.visible and G.buttons:get_UIE_by_ID("discard_button")
			end, { visible = true })
	end,
	execute = function(self, ctx, args)
		Handy.regular_keybinds.discard_blocker = true
		Handy.fake_events.execute_button(function()
			return G.buttons:get_UIE_by_ID("discard_button")
		end)
		G.E_MANAGER:add_event(Event({
			no_delete = true,
			blocking = false,
			func = function()
				Handy.regular_keybinds.discard_blocker = false
				return true
			end,
		}))
		return true
	end,
})

Handy.controls.register({
	key = "regular_keybinds_change_sort_rank",
	get_module = function(self)
		return Handy.cc.regular_keybinds_sort_by_rank
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input_trigger = true,
	},

	no_stop_use = true,
	only_in_run = true,

	can_execute = function(self, ctx, args)
		return Handy.regular_keybinds.can_change_sorting(G.hand) and Handy.controls.can_execute_control(self, ctx, args)
	end,

	execute = function(self, ctx, args)
		Handy.regular_keybinds.set_sorting(G.hand, "rank")
		return true
	end,
})
Handy.controls.register({
	key = "regular_keybinds_change_sort_suit",
	get_module = function(self)
		return Handy.cc.regular_keybinds_sort_by_suit
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input_trigger = true,
	},

	no_stop_use = true,
	only_in_run = true,

	can_execute = function(self, ctx, args)
		return Handy.regular_keybinds.can_change_sorting(G.hand) and Handy.controls.can_execute_control(self, ctx, args)
	end,

	execute = function(self, ctx, args)
		Handy.regular_keybinds.set_sorting(G.hand, "suit")
		return true
	end,
})
Handy.controls.register({
	key = "regular_keybinds_toggle_sort",
	get_module = function(self)
		return Handy.cc.regular_keybinds_toggle_sort
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input_trigger = true,
	},

	no_stop_use = true,
	only_in_run = true,

	can_execute = function(self, ctx, args)
		return Handy.regular_keybinds.can_change_sorting(G.hand) and Handy.controls.can_execute_control(self, ctx, args)
	end,

	execute = function(self, ctx, args)
		Handy.regular_keybinds.set_next_sorting(G.hand)
		return true
	end,
})
