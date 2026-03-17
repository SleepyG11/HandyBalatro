local old_attention_text = attention_text
function attention_text(...)
	local old_speedfactor = G.SPEEDFACTOR
	G.SPEEDFACTOR = G.HANDY_REAL_SPEEDFACTOR or G.SPEEDFACTOR
	local diff = old_speedfactor / G.SPEEDFACTOR
	if diff > 1 then
		G.SPEEDFACTOR = G.SPEEDFACTOR * math.pow(diff, 0.6)
	end
	local r = old_attention_text(...)
	G.SPEEDFACTOR = old_speedfactor
	return r
end

-- Inspired by event queue acceleration from frost's utils by frost
Handy.ARGS.current_frame_timers = {}
Handy.ARGS.previous_frame_timers = {}

local old_em_update = EventManager.update
local function update_manager(manager, preserve, progress, dt, forced, ...)
	local v = G.VIBRATION
	local j = G.ROOM.jiggle

	for timer, value in pairs(Handy.ARGS.current_frame_timers) do
		local pftv = Handy.ARGS.previous_frame_timers[timer]
		G.TIMERS[timer] = pftv + (value - pftv) * progress
	end
	old_em_update(manager, dt, forced, ...)

	if preserve then
		G.VIBRATION = v
		G.ROOM.jiggle = j
	end
end
function EventManager:update(real_dt, forced, ...)
	Handy.ARGS.previous_frame_timers = Handy.ARGS.previous_frame_timers or Handy.utils.table_shallow_copy(G.TIMERS)
	local pft = Handy.ARGS.previous_frame_timers
	local cft = Handy.ARGS.current_frame_timers

	if real_dt > 0 then
		local retriggers = Handy.speed_multiplier.get_queue_retriggers_count()
		if retriggers > 0 then
			local total_updates = retriggers + 1
			local partial_dt = real_dt / total_updates

			EMPTY(cft)
			for timer, value in pairs(G.TIMERS) do
				if pft[timer] and value > pft[timer] then
					cft[timer] = value
					G.TIMERS[timer] = pft[timer]
				end
			end

			local preserve = false
			for i = 1, total_updates do
				local events_count = 0
				for _k, _v in pairs(self.queues or {}) do
					events_count = events_count + #_v
				end
				if events_count < 3 then
					local exit_dt = (total_updates - i + 1) * partial_dt
					update_manager(self, preserve, 1, exit_dt, 1, true, ...)

					EMPTY(pft)
					Handy.utils.table_shallow_merge(pft, G.TIMERS)

					return
				end
				update_manager(self, preserve, i / total_updates, partial_dt, true, ...)
				preserve = true
			end
		end
	end

	EMPTY(pft)
	Handy.utils.table_shallow_merge(pft, G.TIMERS)
	return old_em_update(self, real_dt, forced, ...)
end

local nuGC_ref = nuGC
function nuGC(time_budget, ...)
	if G.STATE == G.STATES.HAND_PLAYED then
		time_budget = math.max(0.0333, time_budget or 3e-4)
	end
	return nuGC_ref(time_budget, ...)
end
