Handy.regular_keybinds = {
	shop_reroll_blocker = false,
	play_blocker = false,
	discard_blocker = false,
	reload_run_blocker = false,

	shop_loaded = false,

	swappable_overlay = false,

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
	can_save_run = function(item, context, check)
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
			and Handy.controls.default_can_execute(item, context)
		)
	end,
	save_run = function(item, context)
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
								if Handy.regular_keybinds.can_save_run(item, context, true) then
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

local exit_overlay_menu_ref = G.FUNCS.exit_overlay_menu
function G.FUNCS.exit_overlay_menu(...)
	Handy.regular_keybinds.toggle_swappable_overlay(false)
	return exit_overlay_menu_ref(...)
end

local deck_info_ref = G.FUNCS.deck_info
function G.FUNCS.deck_info(...)
	Handy.regular_keybinds.toggle_swappable_overlay(true)
	return deck_info_ref(...)
end

local run_info_ref = G.FUNCS.run_info
function G.FUNCS.run_info(...)
	Handy.regular_keybinds.toggle_swappable_overlay(true)
	return run_info_ref(...)
end

Handy.e_mitter.on("steamodded_load", function()
	G.E_MANAGER:add_event(Event({
		blocking = false,
		func = function()
			G.njy_keybind = nil
			if MP and G.FUNCS.lobby_info then
				local lobby_info_ref = G.FUNCS.lobby_info
				function G.FUNCS.lobby_info(...)
					Handy.regular_keybinds.toggle_swappable_overlay(true)
					return lobby_info_ref(...)
				end
			end
			return true
		end,
	}))
end)

--

Handy.controls.register("regular_keybinds_play", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_play, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	require_exact_keys = true,
	no_stop_use = true,
	in_run = true,

	can_execute = function(self, context)
		return not Handy.regular_keybinds.play_blocker
			and G.STATE == G.STATES.SELECTING_HAND
			and Handy.controls.default_can_execute(self, context)
			and Handy.fake_events.check_button(function()
				return G.buttons.states.visible and G.buttons:get_UIE_by_ID("play_button")
			end, { visible = true })
	end,
	execute = function(self, context)
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
Handy.controls.register("regular_keybinds_discard", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_discard, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	require_exact_keys = true,
	no_stop_use = true,
	in_run = true,

	can_execute = function(self, context)
		return not Handy.regular_keybinds.discard_blocker
			and G.STATE == G.STATES.SELECTING_HAND
			and Handy.controls.default_can_execute(self, context)
			and Handy.fake_events.check_button(function()
				return G.buttons.states.visible and G.buttons:get_UIE_by_ID("discard_button")
			end, { visible = true })
	end,
	execute = function(self, context)
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

Handy.controls.register("regular_keybinds_change_sort_rank", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_sort_by_rank, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,

	can_execute = function(self, context)
		return G.STATE == G.STATES.SELECTING_HAND and Handy.controls.default_can_execute(self, context)
	end,

	execute = function(self, context)
		Handy.regular_keybinds.change_sort("rank")
		return true
	end,
})
Handy.controls.register("regular_keybinds_change_sort_suit", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_sort_by_suit, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,

	can_execute = function(self, context)
		return G.STATE == G.STATES.SELECTING_HAND and Handy.controls.default_can_execute(self, context)
	end,

	execute = function(self, context)
		Handy.regular_keybinds.change_sort("suit")
		return true
	end,
})
Handy.controls.register("regular_keybinds_toggle_sort", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_toggle_sort, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,

	can_execute = function(self, context)
		return G.STATE == G.STATES.SELECTING_HAND and Handy.controls.default_can_execute(self, context)
	end,

	execute = function(self, context)
		Handy.regular_keybinds.change_sort(Handy.regular_keybinds.get_current_sorting(true))
		return true
	end,
})

Handy.controls.register("regular_keybinds_reroll_shop", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_reroll_shop, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,

	can_execute = function(self, context)
		return not Handy.regular_keybinds.shop_reroll_blocker
			and Handy.regular_keybinds.shop_loaded
			and G.STATE == G.STATES.SHOP
			and Handy.controls.default_can_execute(self, context)
			and Handy.fake_events.check_button(function()
				return G.shop:get_UIE_by_ID("next_round_button").parent.children[2]
			end, { visible = true, require_exact_func = "can_reroll" })
	end,
	execute = function(self, context)
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
Handy.controls.register("regular_keybinds_leave_shop", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_leave_shop, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,

	can_execute = function(self, context)
		return Handy.regular_keybinds.shop_loaded
			and G.STATE == G.STATES.SHOP
			and Handy.controls.default_can_execute(self, context)
			and Handy.fake_events.check_button(function()
				return G.shop:get_UIE_by_ID("next_round_button")
			end, { visible = true })
	end,
	execute = function(self, context)
		Handy.regular_keybinds.shop_loaded = false
		Handy.fake_events.execute_button(function()
			return G.shop:get_UIE_by_ID("next_round_button")
		end)
		return true
	end,
})

Handy.controls.register("regular_keybinds_skip_blind", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_skip_blind, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,

	can_execute = function(self, context)
		return G.GAME
			and G.GAME.blind_on_deck
			and G.blind_select
			and G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck]
			and G.STATE == G.STATES.BLIND_SELECT
			and Handy.controls.default_can_execute(self, context)
			and Handy.fake_events.check_button(function()
				local container = G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID(
					"tag_" .. G.GAME.blind_on_deck
				)
				return container.states.visible and container.children[2]
			end, { visible = true })
	end,
	execute = function(self, context)
		Handy.fake_events.execute_button(function()
			return G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID("tag_" .. G.GAME.blind_on_deck).children[2]
		end)
		return true
	end,
})
Handy.controls.register("regular_keybinds_select_blind", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_select_blind, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,

	can_execute = function(self, context)
		return G.GAME
			and G.GAME.blind_on_deck
			and G.blind_select
			and G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck]
			and G.STATE == G.STATES.BLIND_SELECT
			and Handy.controls.default_can_execute(self, context)
			and Handy.fake_events.check_button(function()
				return G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID("select_blind_button")
			end)
	end,
	execute = function(self, context)
		Handy.fake_events.execute_button(function()
			return G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID("select_blind_button")
		end)
		return true
	end,
})
Handy.controls.register("regular_keybinds_reroll_boss", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_reroll_boss, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,

	can_execute = function(self, context)
		return G.GAME
			and G.GAME.blind_on_deck
			and G.blind_select
			and G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck]
			and G.STATE == G.STATES.BLIND_SELECT
			and Handy.controls.default_can_execute(self, context)
			and Handy.fake_events.check_button(function()
				return G.blind_prompt_box.UIRoot.children[3].children[1]
			end, {
				visible = true,
				require_exact_func = "reroll_boss_button",
			})
	end,
	execute = function(self, context)
		Handy.fake_events.execute_button(function()
			return G.blind_prompt_box.UIRoot.children[3].children[1]
		end)
		return true
	end,
})

Handy.controls.register("regular_keybinds_run_info", {
	get_module = function(self)
		return Handy.cc.regular_keybinds_run_info, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	can_execute = function(self, context)
		return (Handy.regular_keybinds.swappable_overlay or (not G.SETTINGS.paused and not G.OVERLAY_MENU))
			and G.STAGE == G.STAGES.RUN
			and Handy.controls.default_can_execute(self, context)
	end,
	execute = function(self, context)
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

	can_execute = function(self, context)
		return (Handy.regular_keybinds.swappable_overlay or (not G.SETTINGS.paused and not G.OVERLAY_MENU))
			and G.STAGE == G.STAGES.RUN
			and Handy.controls.default_can_execute(self, context)
	end,
	execute = function(self, context)
		Handy.override_create_tabs_chosen_by_label = localize("b_blinds")
		Handy.fake_events.execute({
			func = G.FUNCS.run_info,
		})
		Handy.override_create_tabs_chosen_by_label = nil
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

	can_execute = function(self, context)
		return (Handy.regular_keybinds.swappable_overlay or (not G.SETTINGS.paused and not G.OVERLAY_MENU))
			and G.STAGE == G.STAGES.RUN
			and Handy.controls.default_can_execute(self, context)
	end,
	execute = function(self, context)
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

	can_execute = function(self, context)
		return MP
			and G.FUNCS.lobby_info
			and Handy.b_is_in_multiplayer()
			and (Handy.regular_keybinds.swappable_overlay or (not G.SETTINGS.paused and not G.OVERLAY_MENU))
			and G.STAGE == G.STAGES.RUN
			and Handy.controls.default_can_execute(self, context)
	end,
	execute = function(self, context)
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

	can_execute = function(self, context)
		return not G.OVERLAY_MENU and Handy.controls.default_can_execute(self, context)
	end,
	execute = function()
		G.FUNCS.handy_options()
		return true
	end,
})

Handy.e_mitter.on("update", function(dt)
	if
		(G.CONTROLLER.locked and not G.SETTINGS.paused)
		or G.CONTROLLER.locks.frame
		or G.CONTROLLER.frame_buttonpress
	then
		return
	end
	if
		Handy.b_is_mod_active()
		and not Handy.b_is_in_multiplayer()
		and Handy.controls.is_module_enabled(Handy.cc.regular_keybinds)
		and Handy.controls.is_module_enabled(Handy.cc.regular_keybinds_restart)
		and Handy.controls.is_module_keys_activated(Handy.cc.regular_keybinds_restart, {
			check_context = false,
			exact_keys = true,
			hold_duration = 0.7,
		})
	then
		if not Handy.regular_keybinds.restart_lock and Handy.b_is_in_run() then
			Handy.regular_keybinds.restart_lock = true
			local old_hold_value = G.CONTROLLER.held_key_times.r
			G.CONTROLLER.held_key_times.r = 999
			Handy.regular_keybinds.bypass_restart = true
			G.CONTROLLER:key_hold_update("r", 0)
			Handy.regular_keybinds.bypass_restart = nil
			G.CONTROLLER.held_key_times.r = old_hold_value
		end
	else
		Handy.regular_keybinds.restart_lock = nil
	end
end)

Handy.controls.register("regular_keybinds_quick_restart", {
	get_module = function()
		return Handy.cc.regular_keybinds_quick_restart, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	require_exact_keys = true,
	no_mp = true,

	can_execute = function(self, context)
		return G.STAGE == G.STAGES.RUN
			and (not G.SETTINGS.paused or G.STATE == G.STATES.GAME_OVER)
			and Handy.controls.default_can_execute(self, context)
	end,
	execute = function()
		local old_hold_value = G.CONTROLLER.held_key_times.r
		G.CONTROLLER.held_key_times.r = 999
		Handy.animation_skip.skip_wipe_screen = true
		Handy.animation_skip.force_non_blocking = true
		Handy.regular_keybinds.bypass_restart = true
		G.CONTROLLER:key_hold_update("r", 0)
		Handy.regular_keybinds.bypass_restart = nil
		G.CONTROLLER.held_key_times.r = old_hold_value
		Handy.animation_skip.skip_wipe_screen = false
		Handy.animation_skip.force_non_blocking = false
		return true
	end,
})
Handy.controls.register("regular_keybinds_save_run", {
	get_module = function()
		return Handy.cc.regular_keybinds_save_run, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,
	no_mp = true,
	require_exact_keys = true,

	can_execute = function(self, context)
		return Handy.regular_keybinds.can_save_run(self, context, false)
	end,
	execute = function(self, context)
		Handy.regular_keybinds.save_run(self, context)
		return true
	end,
})
Handy.controls.register("regular_keybinds_reload_run", {
	get_module = function()
		return Handy.cc.regular_keybinds_reload_run, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	require_exact_keys = true,
	no_mp = true,

	can_execute = function(self, context)
		return not Handy.regular_keybinds.reload_run_blocker and Handy.controls.default_can_execute(self, context)
	end,
	execute = function()
		local in_menu = G.STAGE == G.STAGES.MAIN_MENU
		local s = G.SAVED_GAME
		if not s then
			s = get_compressed(G.SETTINGS.profile .. "/" .. "save.jkr")
			if s ~= nil then
				s = STR_UNPACK(s)
			end
		end
		if s then
			Handy.regular_keybinds.reload_run_blocker = true
			Handy.animation_skip.skip_wipe_screen = true
			Handy.animation_skip.force_non_blocking = true
			if in_menu then
				G.FUNCS.go_to_menu()
			end
			G.SETTINGS.current_setup = "Continue"
			G.SAVED_GAME = s
			G.FUNCS.start_setup_run()
			Handy.animation_skip.skip_wipe_screen = false
			Handy.animation_skip.force_non_blocking = false
			G.E_MANAGER:add_event(Event({
				no_delete = true,
				func = function()
					G.E_MANAGER:add_event(Event({
						no_delete = true,
						func = function()
							local msg = in_menu and "Handy_load_run_done" or "Handy_reload_run_done"
							Handy.UI.state_panel.display(function(state)
								state.items.reload_run = {
									text = Handy.L.variable(msg),
									hold = false,
									order = 7,
								}
								return true
							end, nil, 3)
							Handy.regular_keybinds.reload_run_blocker = false
							return true
						end,
					}))
					return true
				end,
			}))
			return true
		else
			local msg = in_menu and "Handy_load_run_nothing_to_load" or "Handy_reload_run_nothing_to_load"
			Handy.UI.state_panel.display(function(state)
				state.items.reload_run = {
					text = Handy.L.variable(msg),
					hold = false,
					order = 7,
				}
				return true
			end, nil, 3)
		end
		return false
	end,
})

Handy.controls.register("regular_keybinds_start_fantoms_preview", {
	get_module = function()
		return Handy.cc.regular_keybinds_start_fantoms_preview, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,

	can_execute = function(self, context)
		return FN
			and FN.SIM
			and FN.SIM.run
			and Handy.controls.default_can_execute(self, context)
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

--

Handy.e_mitter.on("update", function(dt)
	if Handy.b_is_mod_active() then
		Handy.regular_keybinds.show_deck_preview_hold = Handy.b_is_in_run()
			and Handy.controls.is_module_enabled(Handy.cc.regular_keybinds)
			and Handy.controls.is_module_enabled(Handy.cc.regular_keybinds_show_deck_preview)
			and Handy.controls.is_module_keys_activated(Handy.cc.regular_keybinds_show_deck_preview)
	else
		Handy.regular_keybinds.show_deck_preview_hold = not not G.CONTROLLER.held_buttons.triggerleft
	end
end)

--

Handy.controls.register("regular_keybinds_skip_booster", {
	get_module = function()
		return Handy.cc.regular_keybinds_skip_booster, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},
	trigger = "press",

	in_run = true,
	no_stop_use = true,

	can_execute = function(self, context)
		return not Handy.regular_keybinds.booster_pack_skipped
			and G.booster_pack
			and G.pack_cards
			and G.pack_cards.cards
			and G.pack_cards.cards[1]
			and Handy.controls.default_can_execute(self, context)
			and Handy.fake_events.check({
				func = G.FUNCS.can_skip_booster,
			})
	end,
	execute = function(self, context)
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
Handy.e_mitter.on("update", function(dt)
	if
		not Handy.controller.binding.current
		and not Handy.regular_keybinds.booster_pack_skipped
		and Handy.b_is_mod_active()
		and Handy.b_is_in_run()
		and not Handy.b_is_stop_use()
		and not Handy.controller.dp.b_is_console_opened()
		and G.booster_pack
		and G.pack_cards
		and G.pack_cards.cards
		and G.pack_cards.cards[1]
		and Handy.controls.is_module_enabled(Handy.cc.regular_keybinds)
		and Handy.controls.is_module_enabled(Handy.cc.regular_keybinds_skip_booster)
		and Handy.controls.is_module_keys_activated(Handy.cc.regular_keybinds_skip_booster)
		and Handy.fake_events.check({
			func = G.FUNCS.can_skip_booster,
		})
	then
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
	end
end)

--

Handy.controls.register("regular_keybinds_cash_out", {
	get_module = function()
		return Handy.cc.regular_keybinds_cash_out, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},
	trigger = "press",

	in_run = true,

	can_execute = function(self, context)
		return Handy.regular_keybinds.can_skip_cashout
			and not Handy.regular_keybinds.cashout_skipped
			and G.STATE == G.STATES.ROUND_EVAL
			and not G.TAROT_INTERRUPT
			and not G.PACK_INTERRUPT
			and G.round_eval
			and Handy.controls.default_can_execute(self, context)
	end,
	execute = function(self, context)
		Handy.regular_keybinds.cashout_skipped = true
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
})
Handy.e_mitter.on("update", function(dt)
	if
		not Handy.controller.binding.current
		and Handy.regular_keybinds.can_skip_cashout
		and not Handy.regular_keybinds.cashout_skipped
		and G.STATE == G.STATES.ROUND_EVAL
		and not G.TAROT_INTERRUPT
		and not G.PACK_INTERRUPT
		and G.round_eval
		and Handy.b_is_mod_active()
		and Handy.b_is_in_run()
		and not Handy.controller.dp.b_is_console_opened()
		and Handy.controls.is_module_enabled(Handy.cc.regular_keybinds)
		and Handy.controls.is_module_enabled(Handy.cc.regular_keybinds_cash_out)
		and Handy.controls.is_module_keys_activated(Handy.cc.regular_keybinds_cash_out)
	then
		Handy.regular_keybinds.cashout_skipped = true

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
	end
end)

--

Handy.controls.register("regular_keybinds_not_just_yet_interaction", {
	get_module = function()
		return Handy.cc.regular_keybinds_not_just_yet_interaction, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},
	trigger = "press",

	no_stop_use = true,
	in_run = true,

	can_execute = function(self, context)
		return G.FUNCS.njy_endround
			and G.STATE == G.STATES.SELECTING_HAND
			and G.buttons
			and G.buttons.states.visible
			and G.GAME.chips
			and G.GAME.blind
			and G.GAME.blind.chips
			and to_big(G.GAME.chips) >= to_big(G.GAME.blind.chips)
			and Handy.controls.default_can_execute(self, context)
	end,
	execute = function(self, context)
		stop_use()
		G.STATE = G.STATES.NEW_ROUND
		end_round()
		return true
	end,
})
Handy.e_mitter.on("update", function(dt)
	if
		not Handy.controller.binding.current
		and G.FUNCS.njy_endround
		and Handy.b_is_mod_active()
		and Handy.b_is_in_run()
		and not Handy.b_is_stop_use()
		and not Handy.controller.dp.b_is_console_opened()
		and G.STATE == G.STATES.SELECTING_HAND
		and G.buttons
		and G.buttons.states.visible
		and G.GAME.chips
		and G.GAME.blind
		and G.GAME.blind.chips
		and to_big(G.GAME.chips) >= to_big(G.GAME.blind.chips)
		and Handy.controls.is_module_enabled(Handy.cc.regular_keybinds)
		and Handy.controls.is_module_enabled(Handy.cc.regular_keybinds_not_just_yet_interaction)
		and Handy.controls.is_module_keys_activated(Handy.cc.regular_keybinds_not_just_yet_interaction)
	then
		stop_use()
		G.STATE = G.STATES.NEW_ROUND
		end_round()
	end
end)
