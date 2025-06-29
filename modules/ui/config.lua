-- Inserting options button

function Handy.UI.reset_config_variables()
	Handy.UI.config_opened = nil
	Handy.UI.config_tab_index = 1
	Handy.UI.keybinds_page = 1
	Handy.UI.quick_page = 1
	Handy.UI.search_input_value = ""
end
Handy.UI.reset_config_variables()

function Handy.UI.get_options_button()
	return UIBox_button({ label = { "Handy" }, button = "handy_open_options", minw = 5, colour = G.C.CHIPS })
end
-- Code taken from Anhk by MathIsFun
local create_uibox_options_ref = create_UIBox_options
function create_UIBox_options()
	local contents = create_uibox_options_ref()
	if Handy.UI.show_options_button then
		table.insert(contents.nodes[1].nodes[1].nodes[1].nodes, Handy.UI.get_options_button())
	end
	return contents
end

-- Options render

function G.UIDEF.handy_options(from_smods)
	local tabs = Handy.UI.get_options_tabs()
	tabs[Handy.UI.config_tab_index or 1].chosen = true
	local t = create_UIBox_generic_options({
		back_func = from_smods and "mods_button" or "handy_exit_options",
		contents = {
			{
				n = G.UIT.R,
				config = { align = "cm", padding = 0 },
				nodes = {
					create_tabs({
						tabs = tabs,
						snap_to_nav = true,
						no_shoulders = true,
						colour = G.C.BOOSTER,
					}),
				},
			},
		},
	})
	return t
end

-- Rerender

-- TODO: fix optimization here at some point
function Handy.UI.rerender(silent)
	local result
	if SMODS and G.ACTIVE_MOD_UI and G.ACTIVE_MOD_UI == Handy.current_mod then
		result = {
			definition = G.UIDEF.handy_options(true),
		}
	elseif Handy.UI.config_opened then
		result = {
			definition = G.UIDEF.handy_options(),
		}
	end
	if result then
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
		G.OVERLAY_MENU:recalculate()
		Handy.utils.cleanup_dead_elements(G, "MOVEABLES")
	end
end

-- For some reason, rendering checkbox on search page make same checkboxes spawn without sprite in it (at least for a first frame)
-- No idea why tbh, but looks like they're working fine, so I'll just prevent this crash
local toggle_ref = G.FUNCS.toggle
function G.FUNCS.toggle(e, ...)
	if e.children and e.children[1] then
		return toggle_ref(e, ...)
	end
end

if SMODS then
	local create_UIBox_mods_ref = create_UIBox_mods
	function create_UIBox_mods(...)
		if G.ACTIVE_MOD_UI and G.ACTIVE_MOD_UI == Handy.current_mod then
			Handy.UI.reset_config_variables()
			Handy.UI.config_opened = true
			return G.UIDEF.handy_options(true)
		end
		return create_UIBox_mods_ref(...)
	end

	local mods_button_ref = G.FUNCS.mods_button
	function G.FUNCS.mods_button(...)
		Handy.UI.reset_config_variables()
		return mods_button_ref(...)
	end
end
