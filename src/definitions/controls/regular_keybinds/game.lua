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

	can_execute = function(self, ctx, args)
		ctx = Handy.controls.resolve_control_context(self, ctx)

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
			or not Handy.controls.can_execute_control(self, ctx, {
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
	execute = function(self, ctx, args)
		self.hold_lock = true
		self.last_hold = 0
		local old_hold_value = G.CONTROLLER.held_key_times.r
		G.CONTROLLER.held_key_times.r = 999
		Handy.ARGS.bypass_restart = true
		G.CONTROLLER:key_hold_update("r", 0)
		G.CONTROLLER.held_key_times.r = old_hold_value
		Handy.ARGS.bypass_restart = nil
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

	can_execute = function(self, ctx, args)
		return G.STAGE == G.STAGES.RUN
			and (not G.SETTINGS.paused or G.STATE == G.STATES.GAME_OVER)
			and Handy.controls.can_execute_control(self, ctx, args)
	end,
	execute = function()
		local old_hold_value = G.CONTROLLER.held_key_times.r
		G.CONTROLLER.held_key_times.r = 999
		Handy.ARGS.skip_wipe_screen = true
		Handy.ARGS.force_non_blocking_event = true
		Handy.ARGS.bypass_restart = true
		G.CONTROLLER:key_hold_update("r", 0)
		G.CONTROLLER.held_key_times.r = old_hold_value
		Handy.ARGS.bypass_restart = nil
		Handy.ARGS.skip_wipe_screen = nil
		Handy.ARGS.force_non_blocking_event = nil
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

	can_execute = function(self, ctx, args)
		return Handy.regular_keybinds.can_save_run(self, ctx, args, false)
	end,
	execute = function(self, ctx, args)
		Handy.regular_keybinds.save_run(self, ctx, args)
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

	can_execute = function(self, ctx, args)
		return not Handy.regular_keybinds.reload_run_blocker and Handy.controls.can_execute_control(self, ctx, args)
	end,
	execute = function(self, ctx, args)
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
			Handy.ARGS.skip_wipe_screen = true
			Handy.ARGS.force_non_blocking_event = true
			if in_menu then
				G.FUNCS.go_to_menu()
			end
			G.SETTINGS.current_setup = "Continue"
			G.SAVED_GAME = s
			G.FUNCS.start_setup_run()
			Handy.ARGS.skip_wipe_screen = nil
			Handy.ARGS.force_non_blocking_event = nil
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

	execute = function(self, ctx, args)
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

	execute = function(self, ctx, args)
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
