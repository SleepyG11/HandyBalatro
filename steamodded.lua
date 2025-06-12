--- STEAMODDED HEADER
--- MOD_NAME: Handy
--- MOD_ID: Handy
--- MOD_AUTHOR: [SleepyG11]
--- MOD_DESCRIPTION: Quality of Life controls for Balatro

--- PRIORITY: 0
--- DISPLAY_NAME: Handy
--- PREFIX: handy
--- VERSION: 1.5.0-pre6
----------------------------------------------
------------MOD CODE -------------------------

if SMODS and SMODS.current_mod then
	if SMODS.current_mod.path then
		local normalized_path = SMODS.current_mod.path:gsub("\\+", "/"):gsub("/+$", "")
		if not normalized_path:match("/Mods/[^/]+$") then
			local mod_folder = require("lovely").mod_dir:gsub("\\+", "/"):gsub("/+$", "")
			local last = normalized_path:match("/([^/]+)$")
			local correct_path = mod_folder .. "/" .. last
			error(string.format(
				[[


Handy mod installed incorrectly.

Right now it's placed in %s, which is called "Nested folder".
To make it work properly, move mentioned folder in %s,
so result mod directory should be %s
]],
				normalized_path,
				mod_folder,
				correct_path
			))
		end
	end

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
