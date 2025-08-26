Handy.insta_booster_skip = {
	is_hold = false,
	is_skipped = false,
	previou_pack_cards = nil,
	throttle_thing = 0,

	can_execute = function()
		return not not (
			Handy.insta_booster_skip.is_hold
			and not Handy.insta_booster_skip.is_skipped
			and not G.SETTINGS.paused
			and not G.OVERLAY_MENU
			and G.booster_pack
			and G.pack_cards
			and G.pack_cards.cards[1]
			and not Handy.is_stop_use()
			and Handy.fake_events.check({
				func = G.FUNCS.can_skip_booster,
			})
		)
	end,
	execute = function()
		Handy.insta_booster_skip.is_skipped = true
		G.E_MANAGER:add_event(Event({
			func = function()
				Handy.fake_events.execute({
					func = G.FUNCS.skip_booster,
				})
				return true
			end,
		}))
		if Handy.cc.notifications_level >= 4 then
			Handy.UI.state_panel.display(function(state)
				state.items.insta_booster_skip = {
					text = localize({
						type = "variable",
						key = "Handy_skip_booster_pack",
						vars = {},
					}),
					hold = false,
					order = 10,
				}
				return true
			end)
		end
		return true
	end,

	update = function(dt)
		Handy.insta_booster_skip.is_hold = (
			G.STAGE == G.STAGES.RUN
			and Handy.is_mod_active()
			and not Handy.controller.is_debugplus_console_opened()
			and Handy.controller.is_module_key_down(Handy.cc.insta_booster_skip)
		)
		return Handy.insta_booster_skip.can_execute() and Handy.insta_booster_skip.execute() or false
	end,
}

Handy.register_module("insta_booster_skip", Handy.insta_booster_skip)
