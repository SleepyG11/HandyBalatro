--- STEAMODDED HEADER
--- MOD_NAME: Handy
--- MOD_ID: Handy
--- MOD_AUTHOR: [SleepyG11]
--- MOD_DESCRIPTION: Quality of Life controls & keybinds

--- PRIORITY: 0
--- DISPLAY_NAME: Handy
--- PREFIX: handy
--- VERSION: 2.0.0~ALPHA-4
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

if Handy.current_mod then
	return
end

Handy.current_mod = SMODS.current_mod

-- Config tabs
Handy.current_mod.config_tab = function()
	return Handy.UI.get_options_tabs()[1].tab_definition_function
end
Handy.current_mod.extra_tabs = function()
	local result = Handy.UI.get_options_tabs()
	table.remove(result, 1)
	return result
end

local create_UIBox_mods_ref = create_UIBox_mods
function create_UIBox_mods(...)
	if G.ACTIVE_MOD_UI and G.ACTIVE_MOD_UI == Handy.current_mod then
		-- I'll handle config UI myself ok?
		return { n = G.UIT.ROOT, config = { colour = G.C.CLEAR } }
	end
	return create_UIBox_mods_ref(...)
end

G.E_MANAGER:add_event(Event({
	trigger = "immediate",
	no_delete = true,
	force_pause = true,
	blocking = false,
	blockable = false,
	func = function()
		local old_open_UI = G.FUNCS.openModUI_Handy or function() end
		G.FUNCS.openModUI_Handy = function(e, ...)
			old_open_UI(e, ...)
			Handy.UI.data.from_smods = true
			if e and e.config and e.config.page == "config" then
				Handy.UI.data.options_tab_index = 3
			end
			G.FUNCS.handy_options()
		end
		return true
	end,
}))

-- Animation skip setup
local smods_calculate_effect_ref = SMODS.calculate_effect or function() end
function SMODS.calculate_effect(effect, ...)
	if Handy.animation_skip.should_skip_animation() then
		effect.juice_card = nil
	end
	return smods_calculate_effect_ref(effect, ...)
end
if (SMODS.Mods and SMODS.Mods["Talisman"] or {}).can_load then
	local nuGC_ref = nuGC
	function nuGC(time_budget, ...)
		if G.STATE == G.STATES.HAND_PLAYED then
			time_budget = 0.0333
		end
		return nuGC_ref(time_budget, ...)
	end
end

SMODS.Atlas({
	key = "modicon",
	path = "icon.png",
	px = 32,
	py = 32,
})

Handy.e_mitter.emit("steamodded_load")
