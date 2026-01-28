Handy.load_file("src/controls_v2/controls/animation_skip/logic.lua")
Handy.load_file("src/controls_v2/controls/animation_skip/hooks.lua")

-- Code to debug event queue

-- local callstep = 0
-- function printCallerInfo()
-- 	-- Get debug info for the caller of the function that called printCallerInfo
-- 	local info = debug.getinfo(3, "Sl")
-- 	callstep = callstep + 1
-- 	if info then
-- 		print("[" .. callstep .. "] " .. (info.source or "???") .. ":" .. (info.currentline or "unknown"))
-- 	else
-- 		print("Caller information not available")
-- 	end
-- end
-- local emae = EventManager.add_event
-- function EventManager:add_event(x, y, z)
-- 	printCallerInfo()
-- 	return emae(self, x, y, z)
-- end

---

Handy.controls_v2.register("animation_skip_toggle_temp_disabled", {
	get_module = function(self)
		return Handy.cc.animation_skip_toggle_temp_disabled, { Handy.cc.animation_skip }
	end,

	context_type = {
		input = true,
	},
	trigger = "trigger",

	execute = function(self, args, leftover_data)
		Handy.animation_skip.toggle_temp_disabled()
		return true
	end,
})
Handy.controls_v2.register("animation_skip_increase", {
	get_module = function(self)
		return Handy.cc.animation_skip_increase, { Handy.cc.animation_skip }
	end,

	context_type = {
		input = true,
	},
	trigger = "trigger",

	execute = function(self, args, leftover_data)
		Handy.animation_skip.change(1)
		return true
	end,
})
Handy.controls_v2.register("animation_skip_decrease", {
	get_module = function(self)
		return Handy.cc.animation_skip_decrease, { Handy.cc.animation_skip }
	end,

	context_type = {
		input = true,
	},
	trigger = "trigger",

	execute = function(self, args, leftover_data)
		Handy.animation_skip.change(-1)
		return true
	end,
})
