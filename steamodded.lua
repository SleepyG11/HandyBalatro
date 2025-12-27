--- STEAMODDED HEADER
--- MOD_NAME: Handy
--- MOD_ID: Handy
--- MOD_AUTHOR: [SleepyG11]
--- MOD_DESCRIPTION: Quality of Life controls & keybinds

--- PRIORITY: 0
--- DISPLAY_NAME: Handy
--- PREFIX: handy
--- VERSION: 2.0.0-alpha1
----------------------------------------------
------------MOD CODE -------------------------

if Handy.current_mod then
	return
end

if not SMODS or not SMODS.current_mod then
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
