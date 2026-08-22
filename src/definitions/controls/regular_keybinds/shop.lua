Handy.API.Control({
	key = "regular_keybinds_reroll_shop",
	get_module = function(self)
		return Handy.cc.regular_keybinds_reroll_shop
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
		return not Handy.regular_keybinds.shop_reroll_blocker
			and Handy.regular_keybinds.shop_loaded
			and G.STATE == G.STATES.SHOP
			and Handy.controls.can_execute_control(self, ctx, args)
			and Handy.fake_events.check_button(function()
				return G.shop:get_UIE_by_ID("next_round_button").parent.children[2]
			end, { visible = true, require_exact_func = "can_reroll" })
	end,
	execute = function(self, ctx, args)
		Handy.regular_keybinds.shop_reroll_blocker = true
		Handy.fake_events.execute_button(function()
			return G.shop:get_UIE_by_ID("next_round_button").parent.children[2]
		end)
		G.E_MANAGER:add_event(Event({
			no_delete = true,
			blocking = false,
			func = function()
				Handy.regular_keybinds.shop_reroll_blocker = false
				return true
			end,
		}))
		return true
	end,
})
Handy.API.Control({
	key = "regular_keybinds_leave_shop",
	get_module = function(self)
		return Handy.cc.regular_keybinds_leave_shop
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
		return Handy.regular_keybinds.shop_loaded
			and G.STATE == G.STATES.SHOP
			and Handy.controls.can_execute_control(self, ctx, args)
			and Handy.fake_events.check_button(function()
				return G.shop:get_UIE_by_ID("next_round_button")
			end, { visible = true })
	end,
	execute = function(self, args)
		Handy.regular_keybinds.shop_loaded = false
		Handy.fake_events.execute_button(function()
			return G.shop:get_UIE_by_ID("next_round_button")
		end)
		return true
	end,
})
Handy.API.Control({
	key = "regular_keybinds_skip_booster",
	get_module = function()
		return Handy.cc.regular_keybinds_skip_booster
	end,
	get_deps = function(self)
		return { Handy.cc.regular_keybinds }
	end,

	contexts = {
		input_press = true,
		hold = true,
	},

	only_in_run = true,
	no_stop_use = true,

	can_execute = function(self, ctx, args)
		return not Handy.regular_keybinds.booster_pack_skipped
			and G.booster_pack
			and G.pack_cards
			and G.pack_cards.cards
			and G.pack_cards.cards[1]
			and Handy.controls.can_execute_control(self, ctx, args)
			and Handy.fake_events.check({
				func = G.FUNCS.can_skip_booster,
			})
	end,
	execute = function(self, ctx, args)
		Handy.regular_keybinds.booster_pack_skipped = true
		G.E_MANAGER:add_event(Event({
			func = function()
				G.E_MANAGER:add_event(Event({
					func = function()
						Handy.fake_events.execute({
							func = G.FUNCS.skip_booster,
						})
						return true
					end,
				}))
				return true
			end,
		}))
		return true
	end,
})
