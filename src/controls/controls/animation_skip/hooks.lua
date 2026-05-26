local attention_text_ref = attention_text
function attention_text(...)
	if G.STATE == G.STATES.HAND_PLAYED and Handy.animation_skip.should_skip_animation() then
		return
	end
	return attention_text_ref(...)
end
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
	if Handy.animation_skip.should_skip_animation() then
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
		Handy.animation_skip.extract_func_from_event = 1
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
		Handy.ARGS.force_non_blocking_event = true
		draw_card_ref(...)
		Handy.ARGS.force_non_blocking_event = nil
		return
	end
	return draw_card_ref(...)
end
local ease_discard_ref = ease_discard
function ease_discard(...)
	if Handy.animation_skip.should_skip_everything() then
		local args = { ... }
		args[2] = true
		return ease_discard_ref(unpack(args))
	end
	return ease_discard_ref(...)
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
	if Handy.animation_skip.no_modify_ease_dollars then
		return ease_dollars_ref(amount, instant, ...)
	end
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
		Handy.ARGS.force_non_blocking_event = true
		level_up_hand_ref(...)
		Handy.ARGS.force_non_blocking_event = nil
		return
	end
	return level_up_hand_ref(...)
end

local event_manager_add_event_ref = EventManager.add_event
function EventManager:add_event(event, queue, ...)
	if Handy.animation_skip.is_skippable_queue(queue) then
		if Handy.animation_skip.mute_ease_dollars > 0 then
			Handy.animation_skip.mute_ease_dollars = Handy.animation_skip.mute_ease_dollars - 1
		end
		if not event.handy_never_modify then
			if Handy.ARGS.event_queue_override then
				queue = Handy.ARGS.event_queue_override
			end
			if Handy.animation_skip.extract_func_from_event > 0 and event.trigger ~= "ease" then
				Handy.animation_skip.extract_func_from_event = Handy.animation_skip.extract_func_from_event - 1
				event.func()
				return
			end
			if Handy.animation_skip.should_skip_unsafe() then
				event.blocking = false
				event.blockable = false
				if Handy.animation_skip.is_skippable_timer(event.timer) then
					event.delay = (event.trigger == "ease" and 0.0001 or 0)
				end
			else
				if Handy.ARGS.force_non_blocking_event then
					event.blocking = false
				end
				if Handy.ARGS.force_non_blockable_event then
					event.blockable = false
				end
				if Handy.animation_skip.should_skip_everything() then
					if Handy.animation_skip.is_skippable_timer(event.timer) then
						event.delay = (event.delay or 0) * 0.01
					end
				end
			end
		end
	end
	-- printCallerInfo()
	return event_manager_add_event_ref(self, event, queue, ...)
end

local start_run_ref = G.FUNCS.start_run
G.FUNCS.start_run = function(...)
	local result
	if Handy.animation_skip.should_skip_everything() then
		Handy.ARGS.skip_wipe_screen = true
		Handy.ARGS.force_non_blocking_event = true
		result = start_run_ref(...)
		Handy.ARGS.skip_wipe_screen = nil
		Handy.ARGS.force_non_blocking_event = nil
	else
		result = start_run_ref(...)
	end
	return result
end

local wipe_on_ref = G.FUNCS.wipe_on
function G.FUNCS.wipe_on(...)
	if Handy.ARGS.skip_wipe_screen then
		return
	end
	return wipe_on_ref(...)
end
local wipe_off_ref = G.FUNCS.wipe_off
function G.FUNCS.wipe_off(...)
	if Handy.ARGS.skip_wipe_screen then
		return
	end
	return wipe_off_ref(...)
end
local play_sound_ref = play_sound
function play_sound(...)
	if G.STATE == G.STATES.HAND_PLAYED and Handy.animation_skip.should_skip_everything() then
		return
	end
	return play_sound_ref(...)
end

---

Handy.e_mitter.on("steamodded_load", function()
	local smods_calculate_effect_ref = SMODS.calculate_effect or function() end
	function SMODS.calculate_effect(effect, ...)
		if Handy.animation_skip.should_skip_animation() then
			effect.juice_card = nil
		end
		return smods_calculate_effect_ref(effect, ...)
	end
end)
