Handy.regular_keybinds.save_run_blocker = nil

function Handy.regular_keybinds.can_save_run(item, ctx, args, check)
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
		and Handy.controls.can_execute_control(item, ctx, args)
	)
end

function Handy.regular_keybinds.save_run(item, ctx, args)
	Handy.regular_keybinds.save_run_blocker = true

	local function finish()
		if Handy.regular_keybinds.can_save_run(item, ctx, args, true) then
			save_run()
			G.FILE_HANDLER.force = true

			Handy.UI.state_panel.display(function(state)
				state.items.misc_save_run = {
					text = Handy.L.dictionary("ph_handy_notif_misc_save_run_saving"),
					order = 20,
				}
				return true
			end, nil, 3)

			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
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
	end

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
							finish()
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
end
