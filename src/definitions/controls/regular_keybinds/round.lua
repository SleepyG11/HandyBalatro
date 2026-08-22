Handy.API.Control({
	key = "regular_keybinds_start_fantoms_preview",
	get_module = function()
		return Handy.cc.regular_keybinds_start_fantoms_preview
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
		return FN
			and FN.SIM
			and FN.SIM.run
			and Handy.controls.can_execute_control(self, ctx, args)
			and Handy.fake_events.check_button(function()
				return G.HUD:get_UIE_by_ID("calculate_score_button")
			end)
	end,
	execute = function()
		Handy.fake_events.execute_button(function()
			return G.HUD:get_UIE_by_ID("calculate_score_button")
		end)
		return true
	end,
})
Handy.API.Control({
	key = "regular_keybinds_cash_out",
	get_module = function()
		return Handy.cc.regular_keybinds_cash_out
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input_trigger = true,
		hold = true,
	},

	only_in_run = true,

	can_execute = function(self, ctx, args)
		return Handy.regular_keybinds.can_skip_cashout
			and not Handy.regular_keybinds.cashout_skipped
			and G.STATE == G.STATES.ROUND_EVAL
			and not G.TAROT_INTERRUPT
			and not G.PACK_INTERRUPT
			and G.round_eval
			and Handy.controls.can_execute_control(self, ctx, args)
	end,
	execute = function(self, ctx, args)
		Handy.regular_keybinds.cashout_skipped = true
		stop_use()
		G.E_MANAGER:add_event(Event({
			func = function()
				G.E_MANAGER:add_event(Event({
					func = function()
						stop_use()
						G.E_MANAGER:add_event(Event({
							func = function()
								Handy.fake_events.execute({
									func = G.FUNCS.cash_out,
									id = "cash_out_button",
								})
								return true
							end,
						}))
						return true
					end,
				}))
				return true
			end,
		}))
		return true
	end,
})
Handy.API.Control({
	key = "regular_keybinds_not_just_yet_interaction",
	get_module = function()
		return Handy.cc.regular_keybinds_not_just_yet_interaction
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		hold = true,
		input_press = true,
	},

	no_stop_use = true,
	only_in_run = true,

	can_execute = function(self, ctx, args)
		return G.FUNCS.njy_endround
			and G.STATE == G.STATES.SELECTING_HAND
			and G.buttons
			and G.buttons.states.visible
			and G.GAME.chips
			and G.GAME.blind
			and G.GAME.blind.chips
			and to_big(G.GAME.chips) >= to_big(G.GAME.blind.chips)
			and Handy.controls.can_execute_control(self, ctx, args)
	end,
	execute = function(self, args)
		stop_use()
		G.STATE = G.STATES.NEW_ROUND
		end_round()
		return true
	end,
})
