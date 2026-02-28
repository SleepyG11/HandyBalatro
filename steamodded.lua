--- STEAMODDED HEADER
--- MOD_NAME: Handy
--- MOD_ID: Handy
--- MOD_AUTHOR: [SleepyG11]
--- MOD_DESCRIPTION: Quality of Life controls & keybinds

--- PRIORITY: 0
--- DISPLAY_NAME: Handy
--- PREFIX: handy
--- VERSION: 2.0.0~ALPHA-7b
----------------------------------------------
------------MOD CODE -------------------------

if not SMODS or not SMODS.current_mod then
	return
end

if not Handy then
	error([[


Handy mod installed incorrectly.

To fix this, do one of the followings:
- Update Lovely to 0.9.0 or newer
- Make sure mod is not "nested" (folder in folder), like "/Mods/HandyBalatro/HandyBalatro"
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

Handy.e_mitter.emit("steamodded_load")
