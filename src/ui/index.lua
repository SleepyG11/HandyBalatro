Handy.UI = {}
Handy.UI.data = {}

function Handy.UI.rerender(silent)
	if Handy.UI.data.opened then
		if G.E_MANAGER then
			if not G.E_MANAGER.queues.handy_config then
				G.E_MANAGER.queues.handy_config = {}
			end
			G.E_MANAGER:clear_queue("handy_config")
		end
		Handy.__override_event_queue = nil
		Handy.__use_gamespeed = nil
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
		Handy.UI.CHAR.rerender()
		Handy.UI.attach_side_panel()
		G.OVERLAY_MENU:recalculate()
		Handy.utils.cleanup_dead_elements(G, "MOVEABLES")
	end
end

--

Handy.load_file("src/ui/components.lua")
Handy.load_file("src/ui/utils.lua")
Handy.load_file("src/ui/state_panel.lua")
Handy.load_file("src/ui/characters.lua")
Handy.load_file("src/ui/side_panel.lua")
Handy.load_file("src/ui/game_settings.lua")

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
}, "src/ui/pages/")

Handy.load_file("src/ui/options.lua")

--

function Handy.UI.check_for_cleanup()
	if (not G.OVERLAY_MENU or not G.OVERLAY_MENU.is_handy_config) and Handy.UI.data.opened then
		Handy.UI.data = {}
		if G.E_MANAGER then
			if not G.E_MANAGER.queues.handy_config then
				G.E_MANAGER.queues.handy_config = {}
			end
			G.E_MANAGER:clear_queue("handy_config")
		end

		Handy.__override_event_queue = nil
		Handy.__use_gamespeed = nil
	end
end

Handy.e_mitter.on("update", Handy.UI.check_for_cleanup)
Handy.e_mitter.on("device_change", function()
	Handy.UI.rerender(true)
end)

local old_overlay_menu = G.FUNCS.overlay_menu
function G.FUNCS.overlay_menu(d, ...)
	local r = old_overlay_menu(d, ...)
	if d and d.is_handy_config and G.OVERLAY_MENU then
		G.OVERLAY_MENU.is_handy_config = true
	end
	Handy.UI.check_for_cleanup()
	return r
end

local old_exit_overlay = G.FUNCS.exit_overlay_menu
function G.FUNCS.exit_overlay_menu(...)
	local r = old_exit_overlay(...)
	Handy.UI.check_for_cleanup()
	return r
end
