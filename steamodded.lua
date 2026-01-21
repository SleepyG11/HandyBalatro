--- STEAMODDED HEADER
--- MOD_NAME: Handy
--- MOD_ID: Handy
--- MOD_AUTHOR: [SleepyG11]
--- MOD_DESCRIPTION: Quality of Life controls & keybinds

--- PRIORITY: 0
--- DISPLAY_NAME: Handy
--- PREFIX: handy
--- VERSION: 2.0.0~ALPHA-5
----------------------------------------------
------------MOD CODE -------------------------

if not SMODS or not SMODS.current_mod then
	return
end

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
		local suffix = path:match("^[^/]+/(.+)")
		if suffix then
			return base .. "/" .. suffix
		end
		return base .. "/" .. path
	end

	local mod_folder = require("lovely").mod_dir
	local normalized_path = resolve_path(mod_folder, SMODS.current_mod.path)
	local last = normalized_path:match("/([^/]+)$")
	local correct_path = normalize_path(mod_folder) .. "/" .. last
	if normalized_path ~= correct_path then
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

if not Handy or Handy.current_mod then
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
