function Handy.UI.get_options_button()
	return UIBox_button({ label = { "Handy" }, button = "handy_options", minw = 5, colour = G.C.CHIPS })
end
local create_uibox_options_ref = create_UIBox_options
function create_UIBox_options()
	local contents = create_uibox_options_ref()
	if not Handy.current_mod or not Handy.cc.hide_options_button.enabled then
		table.insert(contents.nodes[1].nodes[1].nodes[1].nodes, Handy.UI.get_options_button())
	end
	return contents
end

--

function Handy.UI.get_options_tabs()
	local result = {
		{
			label = "Handy",
			tab_definition_function = function()
				return Handy.UI.overall_tab()
			end,
		},
		{
			label = Handy.L.tab("Presets"),
			tab_definition_function = function()
				return Handy.UI.presets_tab()
			end,
		},
		{
			label = Handy.L.tab("Search"),
			tab_definition_function = function()
				return Handy.UI.dictionary_tab()
			end,
		},
	}
	for index, item in ipairs(result) do
		local old_def = item.tab_definition_function
		item.tab_definition_function = function()
			Handy.UI.data.options_tab_index = index
			return old_def()
		end
	end
	return result
end
function Handy.UI.options_UIBox()
	local tabs = Handy.UI.get_options_tabs()
	tabs[Handy.UI.data.options_tab_index or 1].chosen = true
	local t = create_UIBox_generic_options({
		back_func = (SMODS and G.ACTIVE_MOD_UI and G.ACTIVE_MOD_UI == Handy.current_mod) and "mods_button" or "options",
		contents = {
			{
				n = G.UIT.R,
				config = { align = "cm", padding = 0 },
				nodes = {
					create_tabs({
						tabs = tabs,
						colour = G.C.BOOSTER,
					}),
				},
			},
		},
	})
	return t
end

function Handy.UI.options()
	G.SETTINGS.paused = true
	Handy.UI.data.opened = true
	Handy.UI.data.rerender_uibox_func = Handy.UI.options_UIBox
	G.FUNCS.overlay_menu({
		definition = Handy.UI.options_UIBox(),
		is_handy_config = true,
	})
	Handy.UI.CHAR.emplace({
		key = "me",
		character = "SleepyG11_ui_left_border",
		offset = "hidden",
		scissors = true,
	})
	delay(0.05)
	Handy.UI.CHAR.show("me")
	Handy.UI.attach_side_panel()
	G.OVERLAY_MENU:recalculate()
end
function Handy.UI.back_to_options()
	G.SETTINGS.paused = true
	Handy.UI.data.rerender_uibox_func = Handy.UI.options_UIBox
	G.ROOM.jiggle = G.ROOM.jiggle - 1
	G.FUNCS.overlay_menu({
		definition = Handy.UI.options_UIBox(),
		is_handy_config = true,
	})
	Handy.UI.CHAR.rerender()
	Handy.UI.attach_side_panel()
	G.OVERLAY_MENU:recalculate()
end

G.FUNCS.handy_options = function(e)
	Handy.UI.options()
end
G.FUNCS.handy_back_to_options = function(e)
	return Handy.UI.back_to_options()
end
