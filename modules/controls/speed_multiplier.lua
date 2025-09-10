Handy.speed_multiplier = {
	value = 1,
	value_text = "1x",
	queue_retriggers_count = 0,

	throttle = false,

	get_queue_retriggers_count = function()
		if
			Handy.buffered_is_in_multiplayer()
			or not Handy.buffered_is_mod_active()
			or not Handy.controller.is_module_enabled(Handy.cc.speed_multiplier)
		then
			return 0
		end
		return Handy.speed_multiplier.queue_retriggers_count
	end,

	is_uncapped = function()
		return Handy.buffered_is_dangerous_actions_active()
			and Handy.controller.is_module_enabled(Handy.cc.dangerous_actions.speed_multiplier_uncap)
	end,

	accelerate_queue = function(queue)
		queue = queue or G.E_MANAGER
		local retriggers_count = Handy.speed_multiplier.get_queue_retriggers_count()
		if retriggers_count > 0 then
			local v = G.VIBRATION
			local j = G.ROOM.jiggle
			for i = 1, retriggers_count do
				local events_count = 0
				for k, v in pairs(queue.queues or {}) do
					events_count = events_count + #v
				end
				if events_count > 1 then
					queue:update(0, true)
				else
					break
				end
			end
			G.VIBRATION = v
			G.ROOM.jiggle = j
		end
	end,

	get_value = function()
		if
			Handy.buffered_is_in_multiplayer()
			or not Handy.buffered_is_mod_active()
			or not Handy.controller.is_module_enabled(Handy.cc.speed_multiplier)
		then
			return 1
		end
		return math.min(Handy.speed_multiplier.value, Handy.speed_multiplier.throttle and 4 or math.huge)
	end,
	localize_value = function()
		if Handy.speed_multiplier.value >= 1 then
			Handy.speed_multiplier.value_text = tostring(Handy.speed_multiplier.value)
		else
			Handy.speed_multiplier.value_text = "1/" .. tostring(1 / Handy.speed_multiplier.value)
		end
		Handy.speed_multiplier.value_text = Handy.speed_multiplier.value_text .. "x"
		return Handy.speed_multiplier.value_text
	end,
	load_default_value = function()
		if Handy.controller.is_module_enabled(Handy.cc.speed_multiplier) then
			local value = math.max(1, math.min(10, math.floor(Handy.cc.speed_multiplier.default_value) or 1))
			Handy.speed_multiplier.value = 2 ^ (value - 1)
		end
		Handy.speed_multiplier.change(0)
	end,

	get_actions = function(key)
		return {
			multiply = Handy.controller.is_module_key(Handy.cc.speed_multiplier.multiply, key),
			divide = Handy.controller.is_module_key(Handy.cc.speed_multiplier.divide, key),
		}
	end,
	can_execute = function(key, released)
		return not released
			and Handy.buffered_is_mod_active()
			and not Handy.buffered_is_in_multiplayer()
			and Handy.controller.is_module_enabled(Handy.cc.speed_multiplier)
			and (
				Handy.controller.is_module_enabled(Handy.cc.speed_multiplier.no_hold)
				or Handy.controller.is_module_key_down(Handy.cc.speed_multiplier)
			)
	end,

	execute = function(key, released)
		local actions = Handy.speed_multiplier.get_actions(key)
		if actions.multiply then
			Handy.speed_multiplier.multiply()
			return not Handy.controller.is_module_enabled(Handy.cc.speed_multiplier.no_hold)
		end
		if actions.divide then
			Handy.speed_multiplier.divide()
			return not Handy.controller.is_module_enabled(Handy.cc.speed_multiplier.no_hold)
		end
		return false
	end,

	show_notif = function()
		if Handy.cc.notifications_level < 3 then
			return
		end
		Handy.UI.state_panel.display(function(state)
			state.items.change_speed_multiplier = {
				text = Handy.L.variable("Handy_gamespeed_multiplier", {
					Handy.speed_multiplier.value_text,
				}),
				hold = false,
				order = 5,
				dangerous = Handy.speed_multiplier.value > 512,
			}
			local retriggers_amount = Handy.speed_multiplier.get_queue_retriggers_count()
			if retriggers_amount > 0 then
				state.items.change_queue_retriggers_count = {
					text = Handy.L.variable("Handy_event_queue_retriggers_amount", {
						retriggers_amount + 1,
					}),
					hold = false,
					order = 5.1,
					dangerous = retriggers_amount > 8,
				}
			end
			return true
		end)
	end,

	multiply = function()
		return Handy.speed_multiplier.change(1)
	end,
	divide = function()
		return Handy.speed_multiplier.change(-1)
	end,
	change = function(dx)
		local multiplier = 2 ^ (dx or 0)
		Handy.speed_multiplier.value = math.min(
			math.max(0.001953125, Handy.speed_multiplier.value * multiplier),
			Handy.speed_multiplier.is_uncapped() and 2 ^ 24 or 512
		)
		Handy.speed_multiplier.queue_retriggers_count = math.max(0, math.floor(Handy.speed_multiplier.value / 64) - 1)
		Handy.speed_multiplier.localize_value()
		if dx ~= 0 then
			Handy.speed_multiplier.show_notif()
		end
	end,

	use = function(key, released)
		return Handy.speed_multiplier.can_execute(key, released) and Handy.speed_multiplier.execute(key, released)
			or false
	end,
}

Handy.register_module("speed_multiplier", Handy.speed_multiplier)
