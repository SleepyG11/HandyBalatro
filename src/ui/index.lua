Handy.UI = {}
Handy.UI.C = {
	DARK_EDITION_WEAK = { 1, 0, 0, 0.3 },
	MP = { 0, 0, 0, 1 },

	NONE_KEYBIND = { 0.9, 0.9, 0.9, 0.85 },
}
Handy.UI.data = {}

---

function Handy.UI.cleanup(full)
	if full then
		Handy.UI.data = {}
	end
	G.E_MANAGER:clear_queue("handy_config")

	Handy.ARGS.event_queue_override = nil
	Handy.ARGS.use_gamespeed = nil
end
function Handy.UI.check_for_cleanup(full)
	if (not G.OVERLAY_MENU or not G.OVERLAY_MENU.is_handy_config) and Handy.UI.data.opened then
		Handy.utils.cleanup_dead_elements(G, "MOVEABLES")
		Handy.UI.cleanup(full)
	end
end

function Handy.UI.rerender(silent)
	if Handy.UI.data.opened then
		Handy.UI.cleanup(false)
		local result = {
			definition = Handy.UI.data.rerender_uibox_func(),
			is_handy_config = true,
		}
		if silent then
			G.ROOM.jiggle = G.ROOM.jiggle - 1
			result.config = {
				offset = {
					x = 0,
					y = 0,
				},
			}
		end
		G.FUNCS.overlay_menu(result)
		if Handy.UI.data.rerender_callback then
			Handy.UI.data.rerender_callback()
		end
		if Handy.cc.me_in_mod_config.enabled then
			Handy.UI.CHAR.rerender()
		end
		Handy.UI.attach_side_panel()
		G.OVERLAY_MENU:recalculate()
		Handy.utils.cleanup_dead_elements(G, "MOVEABLES")
	end
end

--

Handy.e_mitter.on("update", function()
	local dew = Handy.UI.C.DARK_EDITION_WEAK
	dew[1] = G.C.DARK_EDITION[1]
	dew[2] = G.C.DARK_EDITION[2]
	dew[3] = G.C.DARK_EDITION[3]

	local mp = Handy.UI.C.MP
	local new_mp = mix_colours(G.C.RED, G.C.ORANGE, math.sin(G.TIMERS.REAL) * 0.2 + 0.8)
	mp[1] = new_mp[1]
	mp[2] = new_mp[2]
	mp[3] = new_mp[3]
	Handy.UI.check_for_cleanup(true)
end)
Handy.e_mitter.on("device_change", function()
	Handy.UI.rerender(true)
end)

local old_overlay_menu = G.FUNCS.overlay_menu
function G.FUNCS.overlay_menu(d, ...)
	local r = old_overlay_menu(d, ...)
	if d and d.is_handy_config and G.OVERLAY_MENU then
		G.OVERLAY_MENU.is_handy_config = true
	end
	Handy.UI.check_for_cleanup(true)
	return r
end
local old_exit_overlay = G.FUNCS.exit_overlay_menu
function G.FUNCS.exit_overlay_menu(...)
	local r = old_exit_overlay(...)
	Handy.UI.check_for_cleanup(true)
	return r
end

G.FUNCS.handy_noop = function() end

---

Handy.load_files({
	"utils.lua",
	"assets.lua",
	"components/index.lua",
	"state_panel.lua",
	"characters.lua",
	"side_panel.lua",
	"game_settings.lua",
	"tutorial.lua",
	"options.lua",
	"gamepad.lua",
}, "src/ui/")

Handy.load_files({
	"dictionary.lua",
	"presets.lua",
	"overall.lua",
}, "src/ui/tabs/")

Handy.load_files({
	"insta_actions.lua",
	"hand_selection.lua",
	"highlight_movement.lua",
	"vanilla_keybinds.lua",
	"appearance.lua",
	"speed_n_animations.lua",
	"dangerous.lua",
	"mp_extension.lua",
	"updater.lua",
}, "src/ui/pages/")
