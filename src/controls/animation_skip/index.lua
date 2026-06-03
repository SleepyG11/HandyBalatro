-- None, Messages, Animation, Everything, Unsafe
Handy.animation_skip = {
	ease_dollars_buffer = 0,
	no_modify_ease_dollars = false,
	mute_ease_dollars = 0,
}

-- Filters

function Handy.animation_skip.is_disabled_by_mp(lobby, lobby_config)
	return lobby_config.handy_animation_skip_mode == 1
end
function Handy.animation_skip.can_dangerous()
	return Handy.b_is_dangerous_actions_active()
		and not Handy.b_is_in_multiplayer()
		and Handy.controls.is_module_enabled(Handy.cc.dangerous_actions_animation_skip_unsafe)
end

Handy.animation_skip.queues_to_skip = {
	["base"] = true,
	["handy_config"] = true,
}
function Handy.animation_skip.is_skippable_queue(queue)
	return not queue or Handy.animation_skip.queues_to_skip[queue]
end

Handy.animation_skip.non_skippable_timers = {
	["REAL"] = true,
	["REAL_SHADER"] = true,
	["UPTIME"] = true,
}
function Handy.animation_skip.is_skippable_timer(timer)
	return not Handy.animation_skip.non_skippable_timers[timer or "TOTAL"]
end

-- Dollars buffer

Handy.animation_skip.dollars_buffer_cleared = false

function Handy.animation_skip.request_dollars_buffer_reset()
	if Handy.animation_skip.dollars_buffer_cleared then
		return
	end
	Handy.animation_skip.dollars_buffer_cleared = true
	G.E_MANAGER:add_event(Event({
		func = function()
			G.GAME.dollar_buffer = 0
			return true
		end,
	}))
end

-- Value

Handy.animation_skip.value = 1
Handy.animation_skip.buffered_value = nil
Handy.animation_skip.value_text = ""
Handy.animation_skip.temp_disabled = false

function Handy.animation_skip.localize_value()
	Handy.animation_skip.value_text = Handy.L.dictionary("handy_animation_skip_levels", Handy.animation_skip.value)
end
function Handy.animation_skip.get_limited_value()
	local min_value = 1
	local max_value = 5
	if not Handy.animation_skip.can_dangerous() then
		max_value = 4
	end
	local mp_value = Handy.get_mp_lobby_config_value("handy_animation_skip_mode", {
		force = true,
	})
	if mp_value then
		max_value = math.max(1, math.min(math.floor(mp_value), max_value))
	end
	if Handy.animation_skip.value > max_value then
		Handy.animation_skip.value = max_value
		Handy.animation_skip.localize_value()
	end
	if Handy.animation_skip.value < min_value then
		Handy.animation_skip.value = min_value
		Handy.animation_skip.localize_value()
	end
	return Handy.animation_skip.value
end
function Handy.animation_skip.get_value()
	if
		Handy.animation_skip.temp_disabled
		or not Handy.b_is_mod_active()
		or Handy.disabled_in_mp_check(Handy.animation_skip.is_disabled_by_mp)
		or not Handy.controls.is_module_enabled(Handy.cc.animation_skip)
	then
		return 1
	end
	return Handy.animation_skip.get_limited_value()
end
function Handy.animation_skip.get_buffered_value()
	if Handy.animation_skip.buffered_value == nil then
		Handy.animation_skip.buffered_value = Handy.animation_skip.get_value()
	end
	return Handy.animation_skip.buffered_value
end

function Handy.animation_skip.show_notif(dx)
	dx = dx or 0
	local value = Handy.animation_skip.get_value()
	local is_dangerous = value == 5
	local level = (is_dangerous and not Handy.animation_skip.temp_disabled) and 2 or 3

	Handy.UI.state_panel.display(function(state)
		local text = Handy.L.variable("Handy_animation_skip", { Handy.animation_skip.value_text })
		local mp_check = Handy.disabled_in_mp_check(Handy.animation_skip.is_disabled_by_mp)
		if mp_check then
			text = text .. " " .. Handy.L.variable("Handy_disabled_in_mp")
		elseif Handy.animation_skip.temp_disabled or not Handy.controls.is_module_enabled(Handy.cc.animation_skip) then
			text = text .. " " .. Handy.L.variable("Handy_temp_disabled")
		end
		state.items.change_animation_skip = {
			text = text,
			hold = false,
			order = 4,
			dangerous = is_dangerous,
		}
		if not Handy.animation_skip.can_dangerous() and dx > 0 and value == (5 - 1) then
			state.items.prevent_animation_skip_unsafe = {
				text = Handy.L.dictionary("ph_handy_notif_animation_skip_unsafe_disabled"),
				hold = false,
				order = 4.05,
			}
		end

		return true
	end, nil, level)
end

function Handy.animation_skip.value_to_index(v)
	return v - 1
end
function Handy.animation_skip.index_to_value(v)
	return v + 1
end

-- Levels

function Handy.animation_skip.should_skip_messages()
	return Handy.animation_skip.get_buffered_value() >= 2
end
function Handy.animation_skip.should_skip_animation()
	return Handy.animation_skip.get_buffered_value() >= 3
end
function Handy.animation_skip.should_skip_everything()
	return Handy.animation_skip.get_buffered_value() >= 4
end
function Handy.animation_skip.should_skip_unsafe()
	return Handy.animation_skip.get_buffered_value() >= 5
end

-- Value manipulation

function Handy.animation_skip.change(dx)
	local index = Handy.animation_skip.value_to_index(Handy.animation_skip.value)
	Handy.animation_skip.value = Handy.animation_skip.index_to_value(index + dx)
	Handy.animation_skip.value = Handy.animation_skip.get_limited_value()
	Handy.animation_skip.localize_value()
	if dx ~= 0 then
		Handy.animation_skip.show_notif(dx)
	end
end
function Handy.animation_skip.increase()
	Handy.animation_skip.change(1)
end
function Handy.animation_skip.decrease()
	Handy.animation_skip.change(-1)
end
function Handy.animation_skip.load_default_value()
	if
		Handy.controls.is_module_enabled(Handy.cc.animation_skip)
		and Handy.controls.is_module_enabled(Handy.cc.animation_skip_default_value)
	then
		local value = math.max(1, math.min(4, math.floor(Handy.cc.animation_skip_default_value.value) or 1))
		Handy.animation_skip.value = Handy.animation_skip.index_to_value(value - 1)
	end
	Handy.animation_skip.change(0)
end

--

function Handy.animation_skip.toggle_temp_disabled(b)
	if b == nil then
		Handy.animation_skip.temp_disabled = not Handy.animation_skip.temp_disabled
	else
		Handy.animation_skip.temp_disabled = not not b
	end
	Handy.animation_skip.show_notif()
end

--

Handy.e_mitter.on("update", function(dt)
	Handy.animation_skip.mute_ease_dollars = 0
	if G.STATE ~= G.STATES.HAND_PLAYED then
		Handy.animation_skip.buffered_value = nil
		Handy.animation_skip.dollars_buffer_cleared = false
	end
	if Handy.animation_skip.ease_dollars_buffer ~= 0 then
		Handy.animation_skip.no_modify_ease_dollars = true
		ease_dollars(Handy.animation_skip.ease_dollars_buffer, true)
		Handy.animation_skip.no_modify_ease_dollars = false
		Handy.animation_skip.ease_dollars_buffer = 0
	end
end)
Handy.e_mitter.on("game_start", function()
	G.E_MANAGER:add_event(Event({
		no_delete = true,
		blocking = false,
		func = function()
			G.E_MANAGER:add_event(Event({
				no_delete = true,
				blocking = false,
				func = function()
					Handy.animation_skip.load_default_value()
					return true
				end,
			}))
			return true
		end,
	}))
end)
Handy.e_mitter.on("localization_load", function()
	Handy.animation_skip.localize_value()
end)
Handy.e_mitter.on("settings_save", function()
	Handy.animation_skip.change(0)
end)
