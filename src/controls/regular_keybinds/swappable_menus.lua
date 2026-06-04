Handy.regular_keybinds.current_swappable_overlay = nil
Handy.regular_keybinds.swappable_overlay_opening = nil

function Handy.regular_keybinds.can_execute_swappable_overlay()
	return G.STAGE == G.STAGES.RUN
		and (Handy.regular_keybinds.current_swappable_overlay or (not G.SETTINGS.paused and not G.OVERLAY_MENU))
end
function Handy.regular_keybinds.create_swappable_overlay_execute(key, func)
	return function(item, ctx, args)
		local swappable_mode = Handy.cc.regular_keybinds_swappable_overlays_mode.value
		local close = function()
			Handy.fake_events.execute({
				func = G.FUNCS.exit_overlay_menu,
			})
		end
		local open = function()
			Handy.ARGS.remove_overlay_offset = G.OVERLAY_MENU
			Handy.regular_keybinds.swappable_overlay_opening = key
			func()
			Handy.ARGS.remove_overlay_offset = nil
			Handy.regular_keybinds.swappable_overlay_opening = nil
			if G.OVERLAY_MENU then
				Handy.regular_keybinds.current_swappable_overlay = key
			end
		end
		-- Press to open
		if swappable_mode == 1 then
			if ctx.trigger then
				open()
				return true
			end
		-- Press to open, Press again to close
		elseif swappable_mode == 2 then
			if ctx.trigger then
				if Handy.regular_keybinds.current_swappable_overlay == key then
					close()
				else
					open()
				end
				return true
			end
		-- Hold to open, Release to close
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
	end
end
function Handy.regular_keybinds.toggle_swappable_overlay(key)
	if Handy.regular_keybinds.swappable_overlay_opening then
		return
	end
	if not key then
		Handy.regular_keybinds.current_swappable_overlay = nil
	end
	G.E_MANAGER:add_event(Event({
		blockable = false,
		blocking = false,
		no_delete = true,
		pause_force = true,
		timer = "REAL",
		func = function()
			Handy.regular_keybinds.current_swappable_overlay = G.OVERLAY_MENU and key
			return true
		end,
	}))
end
