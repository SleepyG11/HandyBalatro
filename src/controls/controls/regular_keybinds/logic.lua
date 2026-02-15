Handy.regular_keybinds = {
	shop_reroll_blocker = false,
	play_blocker = false,
	discard_blocker = false,
	reload_run_blocker = false,

	shop_loaded = false,

	swappable_overlay = false,
	current_swappable_overlay = nil,

	toggle_swappable_overlay = function(b)
		if b then
			G.E_MANAGER:add_event(Event({
				blockable = false,
				blocking = false,
				no_delete = true,
				pause_force = true,
				timer = "REAL",
				func = function()
					Handy.regular_keybinds.swappable_overlay = true
					return true
				end,
			}))
		else
			Handy.regular_keybinds.swappable_overlay = false
			Handy.regular_keybinds.current_swappable_overlay = nil
		end
	end,
	open_or_close_swappable_overlay = function(ctx, key, func)
		ctx = Handy.controller.non_empty_context(ctx)
		if not ctx or not ctx.input then
			return false
		end
		local swappable_mode = Handy.cc.regular_keybinds_swappable_overlays_mode.value
		local close = function()
			Handy.fake_events.execute({
				func = G.FUNCS.exit_overlay_menu,
			})
		end
		local open = function()
			func()
			if G.OVERLAY_MENU then
				Handy.regular_keybinds.current_swappable_overlay = key
			end
		end
		if swappable_mode == 1 then
			if ctx.trigger then
				open()
				return true
			end
		elseif swappable_mode == 2 then
			if ctx.trigger then
				if Handy.regular_keybinds.current_swappable_overlay == key then
					close()
				else
					open()
				end
				return true
			end
		elseif swappable_mode == 3 then
			if ctx.release then
				if Handy.regular_keybinds.current_swappable_overlay == key then
					close()
				end
			else
				open()
			end
			return true
		end
	end,

	get_current_sorting = function(opposite)
		local hand_sorting = G.hand and G.hand.config.sort or "suit desc"
		local sortings = { "rank", "suit" }
		local sort_index = 0
		if hand_sorting == "suit desc" then
			sort_index = 1
		elseif hand_sorting == "desc" then
			sort_index = 0
		end
		if opposite then
			sort_index = (sort_index + 1) % 2
		end
		return sortings[sort_index + 1]
	end,
	change_sort = function(sorter)
		if sorter == "rank" then
			Handy.fake_events.execute({
				func = G.FUNCS.sort_hand_value,
			})
		elseif sorter == "suit" then
			Handy.fake_events.execute({
				func = G.FUNCS.sort_hand_suit,
			})
		end
		if Handy.cc.notifications_level.value >= 3 then
			Handy.UI.state_panel.display(function(state)
				state.items.change_sort = {
					text = Handy.L.variable("Handy_hand_sorting", {
						Handy.L.dictionary("k_" .. Handy.regular_keybinds.get_current_sorting(false)),
					}),
					order = 30,
					hold = false,
				}
				return true
			end, nil, 3)
		end
		return true
	end,

	on_shop_loaded = function()
		if not G.shop then
			return
		end
		Handy.regular_keybinds.shop_loaded = true
		local remove_func_ref = G.shop.remove
		function G.shop:remove(...)
			Handy.regular_keybinds.shop_loaded = false
			return remove_func_ref(self, ...)
		end
	end,

	save_run_blocker = false,
	can_save_run = function(item, args, check)
		if check then
			return not not (
				Handy.b_is_mod_active()
				and Handy.b_is_in_run()
				and not Handy.b_is_stop_use()
				and not Handy.b_is_in_multiplayer()
				and (G.STATE == G.STATES.SHOP or G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.BLIND_SELECT or G.STATE == G.STATES.ROUND_EVAL)
				and #G.E_MANAGER.queues.base < 3 -- One more because event callback called before it removed from queue
			)
		end
		return not not (
			not Handy.regular_keybinds.save_run_blocker
			and (G.STATE == G.STATES.SHOP or G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.BLIND_SELECT or G.STATE == G.STATES.ROUND_EVAL)
			and #G.E_MANAGER.queues.base < 2
			and Handy.controls.can_execute_control(item, args)
		)
	end,
	save_run = function(item, args)
		Handy.regular_keybinds.save_run_blocker = true
		Handy.UI.state_panel.display(function(state)
			state.items.misc_save_run = {
				text = Handy.L.dictionary("ph_handy_notif_misc_save_run_start"),
				order = 20,
			}
			return true
		end, nil, 3)
		G.E_MANAGER:add_event(Event({
			timer = "REAL",
			func = function()
				G.E_MANAGER:add_event(Event({
					timer = "REAL",
					func = function()
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							timer = "REAL",
							func = function()
								if Handy.regular_keybinds.can_save_run(item, args, true) then
									save_run()
									Handy.UI.state_panel.display(function(state)
										state.items.misc_save_run = {
											text = Handy.L.dictionary("ph_handy_notif_misc_save_run_saving"),
											order = 20,
										}
										return true
									end, nil, 3)
									G.E_MANAGER:add_event(Event({
										trigger = "after",
										delay = 0.5,
										timer = "REAL",
										blocking = false,
										blockable = false,
										pause_force = true,
										func = function()
											Handy.UI.state_panel.display(function(state)
												state.items.misc_save_run = {
													text = Handy.L.dictionary("ph_handy_notif_misc_save_run_saved"),
													order = 20,
												}
												return true
											end, nil, 3)
											Handy.regular_keybinds.save_run_blocker = false
											return true
										end,
									}))
								else
									Handy.UI.state_panel.display(function(state)
										state.items.misc_save_run = {
											text = Handy.L.dictionary("ph_handy_notif_misc_save_run_interrupt"),
											order = 20,
										}
										return true
									end, nil, 3)
									Handy.regular_keybinds.save_run_blocker = false
								end
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

	restart_lock = nil,
	bypass_restart = false,
	can_restart = function()
		return not Handy.b_is_mod_active() or Handy.regular_keybinds.bypass_restart
	end,

	show_deck_preview_hold = false,
	booster_pack_skipped = false,

	can_skip_cashout = false,
	cashout_skipped = false,
}

--
