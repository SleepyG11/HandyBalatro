Handy.load_files({
	"logic.lua",
	"hooks.lua",
	"menus.lua",
}, "src/controls/controls/regular_keybinds/")

---

Handy.controls.register({
	key = "regular_keybinds_play",
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

	can_execute = function(self, args)
		return not Handy.regular_keybinds.play_blocker
			and G.STATE == G.STATES.SELECTING_HAND
			and Handy.controls.can_execute_control(self, args)
			and Handy.fake_events.check_button(function()
				return G.buttons.states.visible and G.buttons:get_UIE_by_ID("play_button")
			end, { visible = true })
	end,
	execute = function(self, args)
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
		return Handy.cc.regular_keybinds_discard, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	require_exact_keys = true,
	no_stop_use = true,
	in_run = true,

	can_execute = function(self, args)
		return not Handy.regular_keybinds.discard_blocker
			and G.STATE == G.STATES.SELECTING_HAND
			and Handy.controls.can_execute_control(self, args)
			and Handy.fake_events.check_button(function()
				return G.buttons.states.visible and G.buttons:get_UIE_by_ID("discard_button")
			end, { visible = true })
	end,
	execute = function(self, args)
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
		return Handy.cc.regular_keybinds_sort_by_rank, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,

	can_execute = function(self, args)
		return G.STATE == G.STATES.SELECTING_HAND and Handy.controls.can_execute_control(self, args)
	end,

	execute = function(self, args)
		Handy.regular_keybinds.change_sort("rank")
		return true
	end,
})
Handy.controls.register({
	key = "regular_keybinds_change_sort_suit",
	get_module = function(self)
		return Handy.cc.regular_keybinds_sort_by_suit, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,

	can_execute = function(self, args)
		return G.STATE == G.STATES.SELECTING_HAND and Handy.controls.can_execute_control(self, args)
	end,

	execute = function(self, args)
		Handy.regular_keybinds.change_sort("suit")
		return true
	end,
})
Handy.controls.register({
	key = "regular_keybinds_toggle_sort",
	get_module = function(self)
		return Handy.cc.regular_keybinds_toggle_sort, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,

	can_execute = function(self, args)
		return G.STATE == G.STATES.SELECTING_HAND and Handy.controls.can_execute_control(self, args)
	end,

	execute = function(self, args)
		Handy.regular_keybinds.change_sort(Handy.regular_keybinds.get_current_sorting(true))
		return true
	end,
})

Handy.controls.register({
	key = "regular_keybinds_reroll_shop",
	get_module = function(self)
		return Handy.cc.regular_keybinds_reroll_shop, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	require_exact_keys = true,
	no_stop_use = true,
	in_run = true,

	can_execute = function(self, args)
		return not Handy.regular_keybinds.shop_reroll_blocker
			and Handy.regular_keybinds.shop_loaded
			and G.STATE == G.STATES.SHOP
			and Handy.controls.can_execute_control(self, args)
			and Handy.fake_events.check_button(function()
				return G.shop:get_UIE_by_ID("next_round_button").parent.children[2]
			end, { visible = true, require_exact_func = "can_reroll" })
	end,
	execute = function(self, args)
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
Handy.controls.register({
	key = "regular_keybinds_leave_shop",
	get_module = function(self)
		return Handy.cc.regular_keybinds_leave_shop, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	require_exact_keys = true,
	no_stop_use = true,
	in_run = true,

	can_execute = function(self, args)
		return Handy.regular_keybinds.shop_loaded
			and G.STATE == G.STATES.SHOP
			and Handy.controls.can_execute_control(self, args)
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

Handy.controls.register({
	key = "regular_keybinds_skip_blind",
	get_module = function(self)
		return Handy.cc.regular_keybinds_skip_blind, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	require_exact_keys = true,
	no_stop_use = true,
	in_run = true,

	can_execute = function(self, args)
		return G.GAME
			and G.GAME.blind_on_deck
			and G.blind_select
			and G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck]
			and G.STATE == G.STATES.BLIND_SELECT
			and Handy.controls.can_execute_control(self, args)
			and Handy.fake_events.check_button(function()
				local container = G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID(
					"tag_" .. G.GAME.blind_on_deck
				)
				return container.states.visible and container.children[2]
			end, { visible = true })
	end,
	execute = function(self, args)
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

	context_types = {
		input = true,
	},

	trigger = "trigger",

	require_exact_keys = true,
	no_stop_use = true,
	in_run = true,

	can_execute = function(self, args)
		return G.GAME
			and G.GAME.blind_on_deck
			and G.blind_select
			and G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck]
			and G.STATE == G.STATES.BLIND_SELECT
			and Handy.controls.can_execute_control(self, args)
			and Handy.fake_events.check_button(function()
				return G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID("select_blind_button")
			end)
	end,
	execute = function(self, args)
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

	context_types = {
		input = true,
	},

	trigger = "trigger",

	require_exact_keys = true,
	no_stop_use = true,
	in_run = true,

	can_execute = function(self, args)
		return G.GAME
			and G.GAME.blind_on_deck
			and G.blind_select
			and G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck]
			and G.STATE == G.STATES.BLIND_SELECT
			and Handy.controls.can_execute_control(self, args)
			and Handy.fake_events.check_button(function()
				return G.blind_prompt_box.UIRoot.children[3].children[1]
			end, {
				visible = true,
				require_exact_func = "reroll_boss_button",
			})
	end,
	execute = function(self, args)
		Handy.fake_events.execute_button(function()
			return G.blind_prompt_box.UIRoot.children[3].children[1]
		end)
		return true
	end,
})

Handy.controls.register({
	key = "regular_keybinds_restart",
	get_module = function()
		return Handy.cc.regular_keybinds_restart, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		hold = true,
	},

	require_exact_keys = true,
	no_mp = true,
	in_run = true,
	only_holdable = true,

	hold_lock = false,
	last_hold = 0,

	can_execute = function(self, args)
		local ctx = Handy.controls.resolve_control_context(self, args)

		local is_hold, hold_duration = Handy.controls.is_module_keys_hold(Handy.cc.regular_keybinds_restart)
		if not is_hold or hold_duration < self.last_hold then
			self.hold_lock = false
		end

		if
			not ctx
			or not is_hold
			or self.hold_lock
			or (G.CONTROLLER.locked and not G.SETTINGS.paused)
			or G.CONTROLLER.locks.frame
			or G.CONTROLLER.frame_buttonpress
			or G.STAGE ~= G.STAGES.RUN
			or (G.SETTINGS.paused and G.STATE ~= G.STATES.GAME_OVER)
			or not Handy.controls.can_execute_control(self, {
				ctx = ctx,
				allow_any_context = true,
				no_keybinds = true,
			})
		then
			self.last_hold = 0
		else
			self.last_hold = self.last_hold + ctx.dt
		end

		return self.last_hold > 0.7
	end,
	execute = function(self)
		self.hold_lock = true
		self.last_hold = 0
		local old_hold_value = G.CONTROLLER.held_key_times.r
		G.CONTROLLER.held_key_times.r = 999
		Handy.regular_keybinds.bypass_restart = true
		G.CONTROLLER:key_hold_update("r", 0)
		Handy.regular_keybinds.bypass_restart = nil
		G.CONTROLLER.held_key_times.r = old_hold_value
		return true
	end,
})
Handy.controls.register({
	key = "regular_keybinds_quick_restart",
	get_module = function()
		return Handy.cc.regular_keybinds_quick_restart, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	require_exact_keys = true,
	no_mp = true,
	only_safe = true,

	can_execute = function(self, args)
		return G.STAGE == G.STAGES.RUN
			and (not G.SETTINGS.paused or G.STATE == G.STATES.GAME_OVER)
			and Handy.controls.can_execute_control(self, args)
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
Handy.controls.register({
	key = "regular_keybinds_save_run",
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

	can_execute = function(self, args)
		return Handy.regular_keybinds.can_save_run(self, args, false)
	end,
	execute = function(self, args)
		Handy.regular_keybinds.save_run(self, args)
		return true
	end,
})
Handy.controls.register({
	key = "regular_keybinds_reload_run",
	get_module = function()
		return Handy.cc.regular_keybinds_reload_run, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	require_exact_keys = true,
	no_mp = true,
	only_safe = true,

	can_execute = function(self, args)
		return not Handy.regular_keybinds.reload_run_blocker and Handy.controls.can_execute_control(self, args)
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
Handy.controls.register({
	key = "regular_keybinds_restart_game",
	get_module = function()
		return Handy.cc.regular_keybinds_restart_game, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	require_exact_keys = true,
	no_mp = true,
	only_safe = true,

	execute = function()
		Handy.utils.restart_game()
		return true
	end,
})
Handy.controls.register({
	key = "regular_keybinds_copy_log_file",
	get_module = function()
		return Handy.cc.regular_keybinds_copy_log_file, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",
	require_exact_keys = true,

	execute = function(self)
		pcall(function()
			local log_file_content = Handy.NFS.read(require("lovely").log_path)
			if log_file_content and log_file_content ~= "" then
				love.system.setClipboardText(log_file_content)
				Handy.UI.state_panel.display(function(state)
					state.items.copy_log_file = {
						text = Handy.L.variable("Handy_log_file_copied"),
						order = 6,
						hold = false,
					}
					return true
				end, nil, 3)
			end
		end)
		return true
	end,
})

Handy.controls.register({
	key = "regular_keybinds_start_fantoms_preview",
	get_module = function()
		return Handy.cc.regular_keybinds_start_fantoms_preview, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
	},

	trigger = "trigger",

	no_stop_use = true,
	in_run = true,

	can_execute = function(self, args)
		return FN
			and FN.SIM
			and FN.SIM.run
			and Handy.controls.can_execute_control(self, args)
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

Handy.controls.register({
	key = "regular_keybinds_skip_booster",
	get_module = function()
		return Handy.cc.regular_keybinds_skip_booster, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
		hold = true,
	},
	trigger = "press",

	require_exact_keys = true,
	in_run = true,
	no_stop_use = true,

	can_execute = function(self, args)
		return not Handy.regular_keybinds.booster_pack_skipped
			and G.booster_pack
			and G.pack_cards
			and G.pack_cards.cards
			and G.pack_cards.cards[1]
			and Handy.controls.can_execute_control(self, args)
			and Handy.fake_events.check({
				func = G.FUNCS.can_skip_booster,
			})
	end,
	execute = function(self, args)
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
Handy.controls.register({
	key = "regular_keybinds_cash_out",
	get_module = function()
		return Handy.cc.regular_keybinds_cash_out, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
		hold = true,
	},
	trigger = "press",

	in_run = true,

	can_execute = function(self, args)
		return Handy.regular_keybinds.can_skip_cashout
			and not Handy.regular_keybinds.cashout_skipped
			and G.STATE == G.STATES.ROUND_EVAL
			and not G.TAROT_INTERRUPT
			and not G.PACK_INTERRUPT
			and G.round_eval
			and Handy.controls.can_execute_control(self, args)
	end,
	execute = function(self, args)
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
Handy.controls.register({
	key = "regular_keybinds_not_just_yet_interaction",
	get_module = function()
		return Handy.cc.regular_keybinds_not_just_yet_interaction, { Handy.cc.regular_keybinds }
	end,

	context_types = {
		input = true,
		hold = true,
	},
	trigger = "press",

	require_exact_keys = true,
	no_stop_use = true,
	in_run = true,

	can_execute = function(self, args)
		return G.FUNCS.njy_endround
			and G.STATE == G.STATES.SELECTING_HAND
			and G.buttons
			and G.buttons.states.visible
			and G.GAME.chips
			and G.GAME.blind
			and G.GAME.blind.chips
			and to_big(G.GAME.chips) >= to_big(G.GAME.blind.chips)
			and Handy.controls.can_execute_control(self, args)
	end,
	execute = function(self, args)
		stop_use()
		G.STATE = G.STATES.NEW_ROUND
		end_round()
		return true
	end,
})
Handy.controls.register({
	key = "regular_keybinds_show_deck_preview",
	get_module = function(self)
		return Handy.cc.regular_keybinds_show_deck_preview, { Handy.cc.regular_keybinds }
	end,

	in_run = true,
	only_holdable = true,

	update = function(self, dt)
		if Handy.b_is_mod_active() and Handy.controls.is_module_enabled(Handy.cc.regular_keybinds) then
			Handy.regular_keybinds.show_deck_preview_hold = self:can_execute()
		else
			Handy.regular_keybinds.show_deck_preview_hold = not not G.CONTROLLER.held_buttons.triggerleft
		end
	end,
})

--
