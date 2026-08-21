-- Card messages
local attention_text_ref = attention_text
function attention_text(...)
	if G.STATE == G.STATES.HAND_PLAYED and Handy.animation_skip.should_skip_animation() then
		return
	end
	if Handy.ARGS.prevent_attention_text then
		return
	end
	return attention_text_ref(...)
end

-- Things juicing
local moveable_juice_up_ref = Moveable.juice_up
function Moveable:juice_up(...)
	if Handy.animation_skip.should_skip_animation() and not Handy.ARGS.allow_juice_up then
		return
	end
	return moveable_juice_up_ref(self, ...)
end
local juice_card_ref = juice_card
function juice_card(...)
	if Handy.animation_skip.should_skip_animation() then
		return
	end
	return juice_card_ref(...)
end
Handy.e_mitter.on("steamodded_load", function()
	local smods_calculate_effect_ref = SMODS.calculate_effect or function() end
	function SMODS.calculate_effect(effect, ...)
		if effect and Handy.animation_skip.should_skip_animation() then
			effect.juice_card = nil
		end
		return smods_calculate_effect_ref(effect, ...)
	end
end)

-- Easings
local ease_discard_ref = ease_discard
function ease_discard(...)
	if Handy.animation_skip.should_skip_animation() then
		local old_block = Handy.ARGS.force_non_blocking_event
		Handy.ARGS.force_non_blocking_event = true
		local r = ease_discard_ref(...)
		Handy.ARGS.force_non_blocking_event = old_block
		return r
	end
	return ease_discard_ref(...)
end
local ease_hands_played_ref = ease_hands_played
function ease_hands_played(...)
	if Handy.animation_skip.should_skip_animation() then
		local old_block = Handy.ARGS.force_non_blocking_event
		Handy.ARGS.force_non_blocking_event = true
		local r = ease_hands_played_ref(...)
		Handy.ARGS.force_non_blocking_event = old_block
		return r
	end
	return ease_hands_played_ref(...)
end
local ease_dollars_ref = ease_dollars
function ease_dollars(amount, ...)
	if Handy.animation_skip.no_modify_ease_dollars then
		return ease_dollars_ref(amount, ...)
	end
	if Handy.animation_skip.should_skip_animation() then
		Handy.animation_skip.ease_dollars_buffer = Handy.animation_skip.ease_dollars_buffer + amount
		return
	elseif Handy.animation_skip.should_skip_messages() then
		local result = ease_dollars_ref(amount, ...)
		if Handy.animation_skip.mute_ease_dollars > 0 then
			Handy.animation_skip.mute_ease_dollars = Handy.animation_skip.mute_ease_dollars - 1
		else
			Handy.animation_skip.mute_ease_dollars = 2
		end
		return result
	else
		return ease_dollars_ref(amount, ...)
	end
end

-- Other
local play_sound_ref = play_sound
function play_sound(...)
	if G.STATE == G.STATES.HAND_PLAYED and Handy.animation_skip.should_skip_everything() then
		return
	end
	if Handy.ARGS.prevent_play_sound then
		return
	end
	return play_sound_ref(...)
end
local delay_ref = delay
function delay(...)
	if Handy.animation_skip.should_skip_animation() then
		return
	end
	return delay_ref(...)
end

-- Cards drawing
local draw_card_ref = draw_card
function draw_card(...)
	if Handy.animation_skip.should_skip_everything() then
		local old_block = Handy.ARGS.force_non_blocking_event
		Handy.ARGS.force_non_blocking_event = true
		draw_card_ref(...)
		Handy.ARGS.force_non_blocking_event = old_block
		return
	end
	return draw_card_ref(...)
end

local wipe_on_ref = G.FUNCS.wipe_on
function G.FUNCS.wipe_on(...)
	Handy.ARGS.skip_wipe_screen_request = Handy.ARGS.skip_wipe_screen or Handy.animation_skip.should_skip_everything()
	if Handy.ARGS.skip_wipe_screen_request then
		return
	end
	return wipe_on_ref(...)
end
local wipe_off_ref = G.FUNCS.wipe_off
function G.FUNCS.wipe_off(...)
	if Handy.ARGS.skip_wipe_screen_request then
		Handy.ARGS.skip_wipe_screen_request = nil
		return
	end
	return wipe_off_ref(...)
end

-- Hand level up
local level_up_hand_ref = level_up_hand
function level_up_hand(...)
	if Handy.animation_skip.should_skip_everything() then
		local args = { ... }
		args[3] = true
		return level_up_hand_ref(unpack(args))
	elseif Handy.animation_skip.should_skip_animation() then
		local old_block = Handy.ARGS.force_non_blocking_event
		Handy.ARGS.force_non_blocking_event = true
		level_up_hand_ref(...)
		Handy.ARGS.force_non_blocking_event = old_block
		return
	end
	return level_up_hand_ref(...)
end
local update_hand_text_ref = update_hand_text
function update_hand_text(config, vals, ...)
	if
		Handy.animation_skip.should_skip_everything()
		or (G.STATE == G.STATES.HAND_PLAYED and Handy.animation_skip.should_skip_animation())
	then
		Handy.ARGS.extract_func_from_event = 1
		config = config or {}
		config.immediate = true
		config.delay = 0
		config.blocking = false
		vals = vals or {}
		vals.StatusText = nil
		local r = update_hand_text_ref(config, vals, ...)
		Handy.ARGS.extract_func_from_event = nil
		return r
	else
		return update_hand_text_ref(config, vals, ...)
	end
end

-- Cash Out
local add_round_eval_row_ref = add_round_eval_row
function add_round_eval_row(...)
	if Handy.animation_skip.should_skip_animation() then
		local old_block = Handy.ARGS.force_non_blocking_event
		Handy.ARGS.force_non_blocking_event = true
		add_round_eval_row_ref(...)
		Handy.ARGS.force_non_blocking_event = old_block
		return
	end
	add_round_eval_row_ref(...)
end
