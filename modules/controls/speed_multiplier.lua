Handy.speed_multiplier = {
	value = 1,
	queue_retriggers_count = 0,

	throttle = false,

	get_queue_retriggers_count = function()
		if not Handy.is_mod_active() or not Handy.controller.is_module_enabled(Handy.cc.speed_multiplier) then
			return 0
		end
		return Handy.speed_multiplier.queue_retriggers_count
	end,

	accelerate_queue = function(queue)
		queue = queue or G.E_MANAGER
		local retriggers_count = Handy.speed_multiplier.get_queue_retriggers_count()
		local v = G.VIBRATION
		if retriggers_count > 0 then
			for i = 1, retriggers_count do
				queue:update(0, true)
			end
		end
		G.VIBRATION = v
	end,

	get_value = function()
		if not Handy.is_mod_active() or not Handy.controller.is_module_enabled(Handy.cc.speed_multiplier) then
			return 1
		end
		return math.min(Handy.speed_multiplier.value, Handy.speed_multiplier.throttle and 4 or math.huge)
	end,

	get_actions = function(key)
		return {
			multiply = Handy.controller.is_module_key(Handy.cc.speed_multiplier.multiply, key),
			divide = Handy.controller.is_module_key(Handy.cc.speed_multiplier.divide, key),
		}
	end,
	can_execute = function(key)
		return Handy.controller.is_module_enabled(Handy.cc.speed_multiplier)
			and (
				Handy.controller.is_module_enabled(Handy.cc.speed_multiplier.no_hold)
				or Handy.controller.is_module_key_down(Handy.cc.speed_multiplier)
			)
	end,

	execute = function(key)
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
				text = localize({
					type = "variable",
					key = "Handy_gamespeed_multiplier",
					vars = {
						Handy.speed_multiplier.value >= 1 and Handy.speed_multiplier.value
							or ("1/" .. (1 / Handy.speed_multiplier.value)),
					},
				}),
				hold = false,
				order = 5,
			}
			local retriggers_amount = Handy.speed_multiplier.get_queue_retriggers_count()
			if retriggers_amount > 0 then
				state.items.change_queue_retriggers_count = {
					text = localize({
						type = "variable",
						key = "Handy_event_queue_retriggers_amount",
						vars = {
							retriggers_amount + 1,
						},
					}),
					hold = false,
					order = 5.1,
				}
			end
			return true
		end)
	end,

	multiply = function()
		Handy.speed_multiplier.value = math.min(512, Handy.speed_multiplier.value * 2)
		Handy.speed_multiplier.queue_retriggers_count = math.max(0, math.floor(Handy.speed_multiplier.value / 64) - 1)
		Handy.speed_multiplier.show_notif()
	end,
	divide = function()
		Handy.speed_multiplier.value = math.max(0.001953125, Handy.speed_multiplier.value / 2)
		Handy.speed_multiplier.queue_retriggers_count = math.max(0, math.floor(Handy.speed_multiplier.value / 64) - 1)
		Handy.speed_multiplier.show_notif()
	end,

	use = function(key)
		return Handy.speed_multiplier.can_execute(key) and Handy.speed_multiplier.execute(key) or false
	end,
}

Handy.register_module("speed_multiplier", Handy.speed_multiplier)
