Handy.speed_multiplier = {
	value = 1,
	value_text = "1x",
	queue_retriggers_count = 0,

	throttle = false,

	temp_disabled = false,

	get_queue_retriggers_count = function()
		if
			Handy.speed_multiplier.temp_disabled
			or Handy.b_is_in_multiplayer()
			or not Handy.b_is_mod_active()
			or not Handy.controls.is_module_enabled(Handy.cc.speed_multiplier)
		then
			return 0
		end
		return Handy.speed_multiplier.queue_retriggers_count
	end,

	is_uncapped = function()
		return Handy.b_is_dangerous_actions_active()
			and Handy.controls.is_module_enabled(Handy.cc.dangerous_actions_speed_multiplier_uncap)
	end,

	accelerate_queue = function(queue)
		queue = queue or G.E_MANAGER
		local retriggers_count = Handy.speed_multiplier.get_queue_retriggers_count()
		if retriggers_count > 0 then
			local v = G.VIBRATION
			local j = G.ROOM.jiggle
			for i = 1, retriggers_count do
				local events_count = 0
				for _k, _v in pairs(queue.queues or {}) do
					events_count = events_count + #_v
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
			Handy.speed_multiplier.temp_disabled
			or Handy.b_is_in_multiplayer()
			or not Handy.b_is_mod_active()
			or not Handy.controls.is_module_enabled(Handy.cc.speed_multiplier)
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
		if
			Handy.controls.is_module_enabled(Handy.cc.speed_multiplier)
			and Handy.controls.is_module_enabled(Handy.cc.speed_multiplier_default_value)
		then
			local value = math.max(1, math.min(10, math.floor(Handy.cc.speed_multiplier_default_value.value) or 1))
			Handy.speed_multiplier.value = 2 ^ (value - 1)
		end
		Handy.speed_multiplier.change(0)
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
			math.max(1 / 512, Handy.speed_multiplier.value * multiplier),
			Handy.speed_multiplier.is_uncapped() and 2 ^ 24 or 512
		)
		Handy.speed_multiplier.queue_retriggers_count = math.max(0, math.floor(Handy.speed_multiplier.value / 64) - 1)
		Handy.speed_multiplier.localize_value()
		if dx ~= 0 then
			Handy.speed_multiplier.show_notif()
		end
	end,

	toggle_temp_disabled = function(b)
		if b == nil then
			Handy.speed_multiplier.temp_disabled = not Handy.speed_multiplier.temp_disabled
		else
			Handy.speed_multiplier.temp_disabled = not not b
		end
		Handy.speed_multiplier.show_notif()
	end,

	-- TODO: notify about speed cap
	show_notif = function()
		local is_dangerous = Handy.speed_multiplier.value > 512 and not Handy.speed_multiplier.temp_disabled
		local level = is_dangerous and 2 or 3
		Handy.UI.state_panel.display(function(state)
            local text = Handy.L.variable("Handy_gamespeed_multiplier", { Handy.speed_multiplier.value_text })
            if Handy.speed_multiplier.temp_disabled then
                text = text .. " " .. Handy.L.variable("Handy_temp_disabled")
            end
			state.items.change_speed_multiplier = {
				text = text,
				hold = false,
				order = 5,
				dangerous = is_dangerous,
			}
			local retriggers_amount = Handy.speed_multiplier.get_queue_retriggers_count()
			if retriggers_amount > 0 and not Handy.speed_multiplier.temp_disabled then
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
		end, nil, level)
	end,
}

--

Handy.e_mitter.on("game_start", function()
	G.E_MANAGER:add_event(Event({
		no_delete = true,
		blocking = false,
		func = function()
			G.E_MANAGER:add_event(Event({
				no_delete = true,
				blocking = false,
				func = function()
					Handy.speed_multiplier.load_default_value()
					return true
				end,
			}))
			return true
		end,
	}))
end)
Handy.e_mitter.on("localization_load", function()
	Handy.speed_multiplier.localize_value()
end)
Handy.e_mitter.on("settings_save", function()
	Handy.speed_multiplier.change(0)
end)

--

Handy.controls.register("speed_multiplier_toggle_temp_disabled", {
	get_module = function(self)
		return Handy.cc.speed_multiplier_toggle_temp_disabled, { Handy.cc.speed_multiplier }
	end,

	context_types = { input = true },
	trigger = "trigger",
	no_mp = true,

	execute = function(self, context)
		Handy.speed_multiplier.toggle_temp_disabled()
		return true
	end,
})
Handy.controls.register("speed_multiplier_increase", {
	get_module = function(self)
		return Handy.cc.speed_multiplier_multiply, { Handy.cc.speed_multiplier }
	end,

	context_types = { input = true },
	trigger = "trigger",
	no_mp = true,

	execute = function(self, context)
		Handy.speed_multiplier.change(1)
		return true
	end,
})
Handy.controls.register("speed_multiplier_decrease", {
	get_module = function(self)
		return Handy.cc.speed_multiplier_divide, { Handy.cc.speed_multiplier }
	end,

	context_types = { input = true },
	trigger = "trigger",
	no_mp = true,

	execute = function(self, context)
		Handy.speed_multiplier.change(-1)
		return true
	end,
})
