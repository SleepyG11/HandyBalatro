Handy.insta_cash_out = {
	is_hold = false,

	can_skip = false,
	is_skipped = false,

	can_execute = function()
		return not not (
			Handy.insta_cash_out.is_hold
			and G.STATE == G.STATES.ROUND_EVAL
			and Handy.insta_cash_out.can_skip
			and not Handy.insta_cash_out.is_skipped
			and G.round_eval
		)
	end,
	execute = function()
		Handy.insta_cash_out.is_skipped = true

		G.E_MANAGER:add_event(Event({
			trigger = "immediate",
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

	update = function(dt)
		Handy.insta_cash_out.is_hold = (
			G.STAGE == G.STAGES.RUN
			and Handy.is_mod_active()
			and Handy.controller.is_module_key_down(Handy.cc.insta_cash_out)
		)
		return Handy.insta_cash_out.can_execute() and Handy.insta_cash_out.execute() or false
	end,
}

Handy.register_module("insta_cash_out", Handy.insta_cash_out)
