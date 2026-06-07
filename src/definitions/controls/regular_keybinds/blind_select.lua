Handy.controls.register({
	key = "regular_keybinds_skip_blind",
	get_module = function(self)
		return Handy.cc.regular_keybinds_skip_blind, { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input_trigger = true,
	},

	require_exact_keys = true,
	no_stop_use = true,
	only_in_run = true,

	can_execute = function(self, ctx, args)
		return G.GAME
			and G.GAME.blind_on_deck
			and G.blind_select
			and G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck]
			and G.STATE == G.STATES.BLIND_SELECT
			and Handy.controls.can_execute_control(self, ctx, args)
			and Handy.fake_events.check_button(function()
				local container = G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID(
					"tag_" .. G.GAME.blind_on_deck
				)
				return container.states.visible and container.children[2]
			end, { visible = true })
	end,
	execute = function(self, ctx, args)
		Handy.fake_events.execute_button(function()
			return G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID("tag_" .. G.GAME.blind_on_deck).children[2]
		end)
		return true
	end,
})
Handy.controls.register({
	key = "regular_keybinds_select_blind",
	get_module = function(self)
		return Handy.cc.regular_keybinds_select_blind, { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input_trigger = true,
	},

	require_exact_keys = true,
	no_stop_use = true,
	only_in_run = true,

	can_execute = function(self, ctx, args)
		return G.GAME
			and G.GAME.blind_on_deck
			and G.blind_select
			and G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck]
			and G.STATE == G.STATES.BLIND_SELECT
			and Handy.controls.can_execute_control(self, ctx, args)
			and Handy.fake_events.check_button(function()
				return G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID("select_blind_button")
			end)
	end,
	execute = function(self, ctx, args)
		Handy.fake_events.execute_button(function()
			return G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID("select_blind_button")
		end)
		return true
	end,
})
Handy.controls.register({
	key = "regular_keybinds_reroll_boss",
	get_module = function(self)
		return Handy.cc.regular_keybinds_reroll_boss, { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input_trigger = true,
	},

	require_exact_keys = true,
	no_stop_use = true,
	only_in_run = true,

	can_execute = function(self, ctx, args)
		return G.GAME
			and G.GAME.blind_on_deck
			and G.blind_select
			and G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck]
			and G.STATE == G.STATES.BLIND_SELECT
			and Handy.controls.can_execute_control(self, ctx, args)
			and Handy.fake_events.check_button(function()
				return G.blind_prompt_box.UIRoot.children[3].children[1]
			end, {
				visible = true,
				require_exact_func = "reroll_boss_button",
			})
	end,
	execute = function(self, ctx, args)
		Handy.fake_events.execute_button(function()
			return G.blind_prompt_box.UIRoot.children[3].children[1]
		end)
		return true
	end,
})
