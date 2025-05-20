--- STEAMODDED HEADER
--- MOD_NAME: Handy
--- MOD_ID: Handy
--- MOD_AUTHOR: [SleepyG11]
--- MOD_DESCRIPTION: Quality of Life controls for Balatro

--- PRIORITY: 0
--- DISPLAY_NAME: Handy
--- PREFIX: handy
--- VERSION: 1.5.0-pre4
----------------------------------------------
------------MOD CODE -------------------------

if SMODS and SMODS.current_mod then
	if Handy then
		if not Handy.current_mod then
			Handy.emplace_steamodded()
		end
	else
		Handy_Preload = {
			current_mod = SMODS.current_mod,
		}
	end

	SMODS.Atlas({
		key = "modicon",
		path = "icon.png",
		px = 32,
		py = 32,
	})
end

----------------------------------------------
------------MOD CODE END----------------------
