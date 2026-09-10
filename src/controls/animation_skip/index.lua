-- None, Messages, Animation, Everything, Unsafe
Handy.animation_skip = {
	ease_dollars_buffer = 0,
	no_modify_ease_dollars = false,
	mute_ease_dollars = 0,

	NONE = 1,
	MESSAGES = 2,
	ANIMATIONS = 3,
	EVERYTHING = 4,
	UNSAFE = 5,
}

-- Filters

function Handy.animation_skip.is_disabled_by_mp(lobby, lobby_config)
	return Handy.get_mp_lobby_config_value("handy_animation_skip_mode", {
		default_value = 1,
		force = true,
	}) == 1
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
	local min_value = Handy.animation_skip.NONE
	local max_value = Handy.animation_skip.UNSAFE
	if not Handy.animation_skip.can_dangerous() then
		max_value = Handy.animation_skip.EVERYTHING
	end
	local mp_value = Handy.get_mp_lobby_config_value("handy_animation_skip_mode", {
		force = true,
	})
	if mp_value then
		max_value = Handy.utils.clamp(1, math.floor(Handy.animation_skip.index_to_value(mp_value - 1)), max_value)
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
		return Handy.animation_skip.NONE
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
	local is_dangerous = value == Handy.animation_skip.UNSAFE
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
		if not Handy.animation_skip.can_dangerous() and dx > 0 and value == Handy.animation_skip.EVERYTHING then
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
	if Talisman and Talisman.config_file and Talisman.config_file.disable_anims then
		return true
	end
	return Handy.animation_skip.get_buffered_value() >= Handy.animation_skip.MESSAGES
end
function Handy.animation_skip.should_skip_animation()
	if Talisman and Talisman.config_file and Talisman.config_file.disable_anims then
		return true
	end
	return Handy.animation_skip.get_buffered_value() >= Handy.animation_skip.ANIMATIONS
end
function Handy.animation_skip.should_skip_everything()
	return Handy.animation_skip.get_buffered_value() >= Handy.animation_skip.EVERYTHING
end
function Handy.animation_skip.should_skip_unsafe()
	return Handy.animation_skip.get_buffered_value() >= Handy.animation_skip.UNSAFE
end

-- Aliases
function Handy.animation_skip.should_skip_animations()
	return Handy.animation_skip.should_skip_animation()
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
	if Handy.controls.is_module_enabled(Handy.cc.animation_skip) then
		local max_index = Handy.animation_skip.value_to_index(Handy.animation_skip.EVERYTHING)
		local min_index = Handy.animation_skip.value_to_index(Handy.animation_skip.NONE)
		local load_value
		if Handy.controls.is_module_enabled(Handy.cc.animation_skip_default_value) then
			load_value = math.floor(Handy.cc.animation_skip_default_value.value) or 1
			load_value = load_value - 1
		end
		if Handy.controls.is_module_enabled(Handy.cc.animation_skip_load_value) then
			load_value = math.floor(Handy.cc.animation_skip_load_value.value) or 1
			load_value = load_value - 1
		end
		if load_value then
			Handy.animation_skip.value =
				Handy.animation_skip.index_to_value(Handy.utils.clamp(min_index, load_value, max_index))
		end
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
Handy.e_mitter.on("config_load", function()
	Handy.animation_skip.change(0)
end)
Handy.e_mitter.on("config_save", function()
	Handy.animation_skip.change(0)
end)
Handy.e_mitter.on("quit", function()
	-- Plus one because value is 0-indexed and option_cycle is 1-indexed
	local value = Handy.animation_skip.value_to_index(Handy.animation_skip.value) + 1
	if value ~= Handy.cc.animation_skip_load_value.value then
		Handy.cc.animation_skip_load_value.value = value
		Handy.ARGS.save_on_quit = true
	end
end)
