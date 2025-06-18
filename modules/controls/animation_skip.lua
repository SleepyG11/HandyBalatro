-- None, Messages, Animation, Everything, Unsafe

Handy.animation_skip = {
	value = 1,
	buffered_value = nil,
	immediate_event_queue = 0,
	ease_dollars_buffer = 0,

	force_non_blocking = false,
	force_non_blockable = false,

	allow_juice_up = false,
	mute_ease_dollars = 0,

	get_buffered_value = function()
		if Handy.animation_skip.buffered_value == nil then
			Handy.animation_skip.buffered_value = Handy.animation_skip.get_value()
		end
		return Handy.animation_skip.buffered_value
	end,

	should_skip_messages = function()
		return Handy.animation_skip.get_buffered_value() >= 2
	end,
	should_skip_animation = function()
		return Handy.animation_skip.get_buffered_value() >= 3
	end,
	should_skip_everything = function()
		return Handy.animation_skip.get_buffered_value() >= 4
	end,
	should_skip_unsafe = function()
		return Handy.animation_skip.get_buffered_value() >= 5
	end,

	get_value = function()
		if not Handy.is_mod_active() or not Handy.controller.is_module_enabled(Handy.cc.animation_skip) then
			return 1
		end
		if Handy.animation_skip.can_dangerous() then
			return Handy.animation_skip.value
		end
		return math.min(4, Handy.animation_skip.value)
	end,
	get_actions = function(key)
		return {
			increase = Handy.controller.is_module_key(Handy.cc.animation_skip.increase, key),
			decrease = Handy.controller.is_module_key(Handy.cc.animation_skip.decrease, key),
		}
	end,

	can_dangerous = function()
		return not not (
			Handy.is_dangerous_actions_active()
			and Handy.controller.is_module_enabled(Handy.cc.dangerous_actions.animation_skip_unsafe)
		)
	end,
	can_execute = function(key)
		return not not (
			Handy.controller.is_module_enabled(Handy.cc.animation_skip)
			and (
				Handy.controller.is_module_enabled(Handy.cc.animation_skip.no_hold)
				or Handy.controller.is_module_key_down(Handy.cc.animation_skip)
			)
		)
	end,
	execute = function(key)
		local actions = Handy.animation_skip.get_actions(key)
		if actions.increase then
			Handy.animation_skip.increase()
			Handy.animation_skip.show_notif(key)
			return not Handy.controller.is_module_enabled(Handy.cc.animation_skip.no_hold)
		end
		if actions.decrease then
			Handy.animation_skip.decrease()
			Handy.animation_skip.show_notif(key)
			return not Handy.controller.is_module_enabled(Handy.cc.animation_skip.no_hold)
		end
		return false
	end,

	show_notif = function(key)
		Handy.UI.state_panel.display(function(state)
			local actions = Handy.animation_skip.get_actions(key)

			if actions.increase or actions.decrease then
				local value = Handy.animation_skip.get_value()
				local localized_states = localize("handy_animation_skip_levels")
				local is_dangerous = value == 5

				if is_dangerous then
					if Handy.cc.notifications_level < 2 then
						return false
					end
				else
					if Handy.cc.notifications_level < 3 then
						return false
					end
				end

				state.items.change_animation_skip = {
					text = localize({
						type = "variable",
						key = "Handy_animation_skip",
						vars = { localized_states[value] or "ERROR" },
					}),
					hold = false,
					order = 4,
					dangerous = is_dangerous,
				}
				if not Handy.animation_skip.can_dangerous() and actions.increase and value == (5 - 1) then
					state.items.prevent_nopeus_unsafe = {
						text = localize("ph_handy_notif_animation_skip_unsafe_disabled"),
						hold = false,
						order = 4.05,
					}
				end
				return true
			end
			return false
		end)
	end,

	change = function(dx)
		Handy.animation_skip.value =
			math.max(1, math.min(Handy.animation_skip.can_dangerous() and 5 or 4, Handy.animation_skip.value + dx))
	end,
	increase = function()
		Handy.animation_skip.change(1)
	end,
	decrease = function()
		Handy.animation_skip.change(-1)
	end,

	use = function(key)
		return Handy.animation_skip.can_execute(key) and Handy.animation_skip.execute(key) or false
	end,

	update = function(dt)
		-- Defined in bottom, because have override dependencies
	end,
}

local card_eval_status_text_ref = card_eval_status_text
function card_eval_status_text(...)
	local args = { ... }
	local extra = args[6] or {}
	if Handy.animation_skip.should_skip_animation() then
		if extra and extra.playing_cards_created then
			playing_card_joker_effects(extra.playing_cards_created)
		end
		return
	elseif Handy.animation_skip.should_skip_messages() then
		if not extra.no_juice then
			if extra.instant then
				args[1]:juice_up(0.6, 0.1)
				G.ROOM.jiggle = G.ROOM.jiggle + 0.7
			else
				G.E_MANAGER:add_event(Event({
					func = function()
						args[1]:juice_up(0.6, 0.1)
						G.ROOM.jiggle = G.ROOM.jiggle + 0.7
						return true
					end,
				}))
			end
		end
		if extra and extra.playing_cards_created then
			playing_card_joker_effects(extra.playing_cards_created)
		end
		return
	end
	return card_eval_status_text_ref(...)
end
local moveable_juice_up_ref = Moveable.juice_up
function Moveable:juice_up(...)
	if Handy.animation_skip.should_skip_animation() and not Handy.animation_skip.allow_juice_up then
		return
	end
	return moveable_juice_up_ref(self, ...)
end
local delay_ref = delay
function delay(...)
	if Handy.animation_skip.should_skip_everything() then
		return
	end
	return delay_ref(...)
end
local update_hand_text_ref = update_hand_text
function update_hand_text(config, vals, ...)
	if
		Handy.animation_skip.should_skip_everything()
		or (G.STATE == G.STATES.HAND_PLAYED and Handy.animation_skip.should_skip_animation())
	then
		config = config or {}
		config.immediate = true
		config.delay = 0
		config.blocking = false
		vals.StatusText = nil
	end
	return update_hand_text_ref(config, vals, ...)
end
local juice_card_ref = juice_card
function juice_card(...)
	if Handy.animation_skip.should_skip_animation() then
		return
	end
	return juice_card_ref(...)
end
local draw_card_ref = draw_card
function draw_card(...)
	if Handy.animation_skip.should_skip_everything() then
		Handy.animation_skip.force_non_blocking = true
		draw_card_ref(...)
		Handy.animation_skip.force_non_blocking = false
		return
	end
	return draw_card_ref(...)
end
local ease_discards_ref = ease_discards
function ease_discards(...)
	if Handy.animation_skip.should_skip_everything() then
		local args = { ... }
		args[2] = true
		return ease_discards_ref(unpack(args))
	end
	return ease_discards_ref(...)
end
local ease_hands_played_ref = ease_hands_played
function ease_hands_played(...)
	if Handy.animation_skip.should_skip_everything() then
		local args = { ... }
		args[2] = true
		return ease_hands_played_ref(unpack(args))
	end
	return ease_hands_played_ref(...)
end
local ease_dollars_ref = ease_dollars
function ease_dollars(amount, instant, ...)
	if Handy.animation_skip.should_skip_animation() then
		Handy.animation_skip.ease_dollars_buffer = Handy.animation_skip.ease_dollars_buffer + amount
		return
	elseif Handy.animation_skip.should_skip_messages() then
		local result = ease_dollars_ref(amount, instant, ...)
		if Handy.animation_skip.mute_ease_dollars > 0 then
			Handy.animation_skip.mute_ease_dollars = Handy.animation_skip.mute_ease_dollars - 1
		else
			Handy.animation_skip.mute_ease_dollars = 2
		end
		return result
	else
		return ease_dollars_ref(amount, instant, ...)
	end
end
local level_up_hand_ref = level_up_hand
function level_up_hand(...)
	if Handy.animation_skip.should_skip_everything() then
		local args = { ... }
		args[3] = true
		return level_up_hand_ref(unpack(args))
	elseif Handy.animation_skip.should_skip_animation() then
		Handy.animation_skip.force_non_blocking = true
		level_up_hand_ref(...)
		Handy.animation_skip.force_non_blocking = false
		return
	end
	return level_up_hand_ref(...)
end
local event_manager_add_event_ref = EventManager.add_event
function EventManager:add_event(event, ...)
	if Handy.animation_skip.mute_ease_dollars > 0 then
		Handy.animation_skip.mute_ease_dollars = Handy.animation_skip.mute_ease_dollars - 1
	end
	if not event.handy_never_modify then
		if Handy.animation_skip.should_skip_unsafe() then
			event.blocking = false
			event.blockable = false
		else
			if Handy.animation_skip.force_non_blocking then
				event.blocking = false
			end
			if Handy.animation_skip.force_non_blockable then
				event.blockable = false
			end
		end
		if Handy.animation_skip.should_skip_everything() then
			-- This line basically taken from Nopeus by jenwalter666
			event.delay = (event.timer == "REAL") and event.delay or (event.trigger == "ease" and 0.0001 or 0)
		end
	end
	return event_manager_add_event_ref(self, event, ...)
end

function Handy.animation_skip.update(dt)
	Handy.animation_skip.mute_ease_dollars = 0
	if Handy.animation_skip.buffered_value then
		if G.STATE ~= G.STATES.HAND_PLAYED then
			Handy.animation_skip.buffered_value = nil
		end
	end
	if Handy.animation_skip.ease_dollars_buffer ~= 0 then
		ease_dollars_ref(Handy.animation_skip.ease_dollars_buffer, true)
		Handy.animation_skip.ease_dollars_buffer = 0
	end
end

local start_run_ref = G.FUNCS.start_run
G.FUNCS.start_run = function(...)
	local result
	if Handy.animation_skip.should_skip_everything() then
		Handy.animation_skip.skip_wipe_screen = true
		Handy.animation_skip.force_non_blocking = true
		result = start_run_ref(...)
		Handy.animation_skip.skip_wipe_screen = false
		Handy.animation_skip.force_non_blocking = false
	else
		result = start_run_ref(...)
	end
	return result
end

local wipe_on_ref = G.FUNCS.wipe_on
function G.FUNCS.wipe_on(...)
	if Handy.animation_skip.skip_wipe_screen then
		return
	end
	return wipe_on_ref(...)
end
local wipe_off_ref = G.FUNCS.wipe_off
function G.FUNCS.wipe_off(...)
	if Handy.animation_skip.skip_wipe_screen then
		return
	end
	return wipe_off_ref(...)
end

if SMODS then
	local smods_calculate_effect_ref = SMODS.calculate_effect
	function SMODS.calculate_effect(effect, ...)
		if Handy.animation_skip.should_skip_animation() then
			effect.juice_card = nil
		end
		return smods_calculate_effect_ref(effect, ...)
	end
end

Handy.register_module("animation_skip", Handy.animation_skip)

-- Code to debug event queue

-- local callstep = 0
-- function printCallerInfo()
-- 	-- Get debug info for the caller of the function that called printCallerInfo
-- 	local info = debug.getinfo(3, "Sl")
-- 	callstep = callstep + 1
-- 	if info then
-- 		print("[" .. callstep .. "] " .. (info.short_src or "???") .. ":" .. (info.currentline or "unknown"))
-- 	else
-- 		print("Caller information not available")
-- 	end
-- end
-- local emae = EventManager.add_event
-- function EventManager:add_event(x, y, z)
-- 	printCallerInfo()
-- 	return emae(self, x, y, z)
-- end
