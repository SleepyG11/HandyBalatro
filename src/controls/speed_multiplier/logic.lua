Handy.speed_multiplier = {
	value = 1,
	value_text = "1x",
	queue_retriggers_count = 0,

	max_speed = 2 ^ 18,
	max_safe_speed = 2 ^ 9,
	min_speed = 1 / (2 ^ 9),

	throttle = false,

	temp_disabled = false,

	is_disabled_by_mp = function(lobby, lobby_config)
		return (lobby_config.handy_speed_multiplier_mode or 1) == 1
	end,

	get_queue_retriggers_count = function()
		if
			G.SCORING_COROUTINE
			or Handy.speed_multiplier.temp_disabled
			or not Handy.b_is_mod_active()
			or Handy.disabled_in_mp_check(Handy.speed_multiplier.is_disabled_by_mp)
			or not Handy.controls.is_module_enabled(Handy.cc.speed_multiplier)
		then
			return 0
		end
		return Handy.speed_multiplier.queue_retriggers_count
	end,

	is_uncapped = function()
		return Handy.b_is_dangerous_actions_active()
			and not Handy.b_is_in_multiplayer()
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
				if events_count > 2 then
					queue:update(0, true)
				else
					break
				end
			end
			G.VIBRATION = v
			G.ROOM.jiggle = j
		end
	end,

	index_to_value = function(v)
		-- -3 = 0.125
		-- -2 = 0.25
		-- -1 = 0.5
		-- 0 = 1
		-- 1 = 1.5 <- exception
		-- 2 = 2
		-- 3 = 4
		-- 4 = 8
		v = math.floor(v)
		if v >= 2 then
			return 2 ^ (v - 1)
		end
		if v == 1 then
			return 1.5
		end
		if v == 0 then
			return 1
		end
		return 2 ^ v
	end,
	value_to_index = function(v)
		if v >= 2 then
			return math.floor(math.log(v, 2) + 1)
		end
		if v == 1.5 then
			return 1
		end
		if v == 1 then
			return 0
		end
		return math.floor(math.log(v, 2))
	end,
	get_value = function()
		if
			Handy.speed_multiplier.temp_disabled
			or not Handy.b_is_mod_active()
			or Handy.disabled_in_mp_check(Handy.speed_multiplier.is_disabled_by_mp)
			or not Handy.controls.is_module_enabled(Handy.cc.speed_multiplier)
		then
			return 1
		end
		return Handy.speed_multiplier.get_limited_value()
	end,
	get_limited_value = function()
		local min_value = Handy.speed_multiplier.min_speed
		if Handy.b_is_in_multiplayer() then
			min_value = 1
		end
		local max_value = Handy.speed_multiplier.max_speed
		if not Handy.speed_multiplier.is_uncapped() then
			max_value = Handy.speed_multiplier.max_safe_speed
		end
		local mp_value = Handy.get_mp_lobby_config_value("handy_speed_multiplier_mode", {
			force = true,
		})
		if mp_value then
			max_value = math.max(1, math.min(Handy.speed_multiplier.index_to_value(mp_value), max_value))
		end
		if Handy.speed_multiplier.value > max_value then
			Handy.speed_multiplier.value = max_value
			Handy.speed_multiplier.queue_retriggers_count =
				math.max(0, math.floor(Handy.speed_multiplier.value / 64) - 1)
			Handy.speed_multiplier.localize_value()
		end
		if Handy.speed_multiplier.value < min_value then
			Handy.speed_multiplier.value = min_value
			Handy.speed_multiplier.queue_retriggers_count = 0
			Handy.speed_multiplier.localize_value()
		end
		return Handy.speed_multiplier.value
	end,
	localize_value = function()
		local current_value = Handy.speed_multiplier.value
		if current_value >= 1 then
			Handy.speed_multiplier.value_text = tostring(current_value)
		else
			Handy.speed_multiplier.value_text = "1/" .. tostring(1 / current_value)
		end
		Handy.speed_multiplier.value_text = Handy.speed_multiplier.value_text .. "x"
		return Handy.speed_multiplier.value_text
	end,
	load_default_value = function()
		if
			Handy.controls.is_module_enabled(Handy.cc.speed_multiplier)
			and Handy.controls.is_module_enabled(Handy.cc.speed_multiplier_default_value)
		then
			local value = math.max(1, math.min(11, math.floor(Handy.cc.speed_multiplier_default_value.value) or 1))
			Handy.speed_multiplier.value = Handy.speed_multiplier.index_to_value(value - 1)
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
		local index = Handy.speed_multiplier.value_to_index(Handy.speed_multiplier.value)
		Handy.speed_multiplier.value = Handy.speed_multiplier.index_to_value(index + dx)
		Handy.speed_multiplier.value = Handy.speed_multiplier.get_limited_value()
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
			local mp_check = Handy.disabled_in_mp_check(Handy.speed_multiplier.is_disabled_by_mp)
			if mp_check then
				text = text .. " " .. Handy.L.variable("Handy_disabled_in_mp")
			elseif
				Handy.speed_multiplier.temp_disabled or not Handy.controls.is_module_enabled(Handy.cc.speed_multiplier)
			then
				text = text .. " " .. Handy.L.variable("Handy_temp_disabled")
			end
			state.items.change_speed_multiplier = {
				text = text,
				hold = false,
				order = 5,
				dangerous = is_dangerous,
			}
			local retriggers_amount = Handy.speed_multiplier.get_queue_retriggers_count()
			if retriggers_amount > 0 and not (Handy.speed_multiplier.temp_disabled or mp_check) then
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

---

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
