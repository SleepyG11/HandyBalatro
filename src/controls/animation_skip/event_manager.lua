local event_manager_add_event_ref = EventManager.add_event
function EventManager:add_event(event, queue, ...)
	if Handy.animation_skip.is_skippable_queue(queue) then
		if (Handy.animation_skip.mute_ease_dollars or 0) > 0 then
			Handy.animation_skip.mute_ease_dollars = Handy.animation_skip.mute_ease_dollars - 1
		end
		if not event.handy_never_modify then
			if Handy.ARGS.event_queue_override then
				queue = Handy.ARGS.event_queue_override
			end
			if (Handy.ARGS.request_non_blocking_event or 0) > 0 then
				event.blocking = false
				Handy.ARGS.request_non_blocking_event = Handy.ARGS.request_non_blocking_event - 1
			end
			if (Handy.ARGS.request_non_blockable_event or 0) > 0 then
				event.blockable = false
				Handy.ARGS.request_non_blockable_event = Handy.ARGS.request_non_blockable_event - 1
			end
			if (Handy.ARGS.extract_func_from_event or 0) > 0 and event.trigger ~= "ease" then
				Handy.ARGS.extract_func_from_event = Handy.ARGS.extract_func_from_event - 1
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
				elseif Handy.ARGS.event_delay_multiplier then
					if Handy.animation_skip.is_skippable_timer(event.timer) then
						event.delay = (event.delay or 0) * Handy.ARGS.event_delay_multiplier
					end
				end
			end
		end
	end
	-- printCallerInfo()
	return event_manager_add_event_ref(self, event, queue, ...)
end
