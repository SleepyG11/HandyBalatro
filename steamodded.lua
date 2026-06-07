if not SMODS or not SMODS.current_mod then
	return
end

if not Handy then
	error([[


Handy mod installed incorrectly.

To fix this, do the followings:
- Make sure mod is not "nested" (so there's no "folder in folder" like "/Mods/HandyBalatro/HandyBalatro")
- Optionally, if mod in .zip archive, unzip it
]])
end

if Handy.current_mod then
	return
end

Handy.current_mod = SMODS.current_mod

SMODS.Atlas({
	key = "modicon",
	path = "icon.png",
	px = 32,
	py = 32,
})

setmetatable(Handy.current_mod, {
	__index = function(t, k)
		if k == "debug_info" then
			local success, result = pcall(function()
				local speed_value = Handy.speed_multiplier.get_value() ~= 1 and Handy.speed_multiplier.value_text
					or "1x"
				local acceleration_value = Handy.speed_multiplier.get_queue_retriggers_count() + 1
				local debug_animation_levels = {
					[1] = "None",
					[2] = "Messages",
					[3] = "Animations",
					[4] = "Everything",
					[5] = "Unsafe",
				}
				local anim_value = Handy.animation_skip.get_value()
				local animation_value = debug_animation_levels[anim_value] or anim_value
				return {
					["Speed Multiplier"] = string.format(
						"%s | Event queue acceleration: %s | Animation Skip: %s",
						speed_value,
						acceleration_value,
						tostring(animation_value)
					),
				}
			end)
			return success and result or {}
		else
			return rawget(t, k)
		end
	end,
})

Handy.e_mitter.emit("steamodded_load")
