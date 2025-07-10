--- STEAMODDED HEADER
--- MOD_NAME: Handy
--- MOD_ID: Handy
--- MOD_AUTHOR: [SleepyG11]
--- MOD_DESCRIPTION: Quality of Life controls & keybinds

--- PRIORITY: 0
--- DISPLAY_NAME: Handy
--- PREFIX: handy
--- VERSION: 1.5.1c
----------------------------------------------
------------MOD CODE -------------------------

if SMODS and SMODS.current_mod then
	if SMODS.current_mod.path then
		local function normalize_path(path)
			return path:gsub("\\+", "/"):gsub("/+", "/"):gsub("/$", "")
		end

		local function resolve_path(base, path)
			base = normalize_path(base)
			path = normalize_path(path)
			if path:sub(1, #base) == base then
				return path
			end
			local suffix = path:match("^Mods/(.+)")
			if suffix then
				return base .. "/" .. suffix
			end
			return base .. "/" .. path
		end

		local mod_folder = require("lovely").mod_dir
		local normalized_path = resolve_path(mod_folder, SMODS.current_mod.path)
		if not normalized_path:match("/Mods/[^/]+$") then
			local last = normalized_path:match("/([^/]+)$")
			local correct_path = normalize_path(mod_folder) .. "/" .. last
			error(string.format(
				[[


Handy mod installed incorrectly.

Right now it's placed in %s, which is called "Nested folder".
To make it work properly, move mentioned folder in %s,
so result mod directory should be %s
]],
				normalized_path,
				normalize_path(mod_folder),
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
