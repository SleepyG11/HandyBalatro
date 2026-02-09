function Handy.UI.get_options_button()
	return UIBox_button({
		label = { "Handy" },
		button = "handy_options",
		minw = 5,
		colour = G.C.CHIPS,
		func = "handy_updates_alert",
	})
end
function Handy.UI.get_mp_extension_button()
	return UIBox_button({
		label = { Handy.L.tab("MP Extension") },
		button = "handy_mp_extension_back_to_options",
		minw = 5,
		colour = Handy.UI.C.MP,
		minh = 0.7,
	})
end
local create_uibox_options_ref = create_UIBox_options
function create_UIBox_options()
	local contents = create_uibox_options_ref()
	if not Handy.current_mod or not Handy.cc.hide_options_button.enabled then
		table.insert(contents.nodes[1].nodes[1].nodes[1].nodes, Handy.UI.get_options_button())
	end
	-- TODO: fix buttons order
	if MP and MP.LOBBY and MP.LOBBY.code and G.STAGE == G.STAGES.MAIN_MENU then
		table.insert(contents.nodes[1].nodes[1].nodes[1].nodes, Handy.UI.get_mp_extension_button())
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
	if Handy.cc.me_in_mod_config.enabled then
		Handy.UI.CHAR.emplace({
			key = "me",
			character = "SleepyG11_ui_left_border",
			offset = "hidden",
			scissors = true,
			pos = Handy.cc.handy.enabled and "default" or "scary",
		})
		delay(0.05, "handy_chars")
		Handy.UI.CHAR.show("me")
	end
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
	if Handy.cc.me_in_mod_config.enabled then
		Handy.UI.CHAR.rerender()
		Handy.UI.CHAR.show("me")
		Handy.UI.CHAR.set_sprite_pos("me", Handy.cc.handy.enabled and "default" or "scary")
	end
	Handy.UI.attach_side_panel()
	G.OVERLAY_MENU:recalculate()
end

G.FUNCS.handy_options = function(e)
	Handy.UI.options()
end
G.FUNCS.handy_open_options = function(e)
	Handy.UI.options()
end
G.FUNCS.handy_back_to_options = function(e)
	return Handy.UI.back_to_options()
end

Handy.e_mitter.on("steamodded_load", function()
	local create_UIBox_mods_ref = create_UIBox_mods
	function create_UIBox_mods(...)
		if G.ACTIVE_MOD_UI and G.ACTIVE_MOD_UI == Handy.current_mod then
			-- I'll handle config UI myself ok?
			return { n = G.UIT.ROOT, config = { colour = G.C.CLEAR } }
		end
		return create_UIBox_mods_ref(...)
	end

	-- Config tabs
	Handy.current_mod.config_tab = function()
		return Handy.UI.get_options_tabs()[1].tab_definition_function
	end
	Handy.current_mod.extra_tabs = function()
		local result = Handy.UI.get_options_tabs()
		table.remove(result, 1)
		return result
	end

	G.E_MANAGER:add_event(Event({
		trigger = "immediate",
		no_delete = true,
		pause_force = true,
		blocking = false,
		blockable = false,
		func = function()
			local old_open_UI = G.FUNCS.openModUI_Handy or function() end
			G.FUNCS.openModUI_Handy = function(e, ...)
				old_open_UI(e, ...)
				Handy.UI.data.from_smods = true
				G.FUNCS.handy_options()
			end
			return true
		end,
	}))
end)

G.FUNCS.handy_updates_alert = function(e)
	local release_type = e.config.ref_table and e.config.ref_table.handy_release_type
	if release_type then
		local release_info = Handy.updater.get_release_info(release_type)
		is_update_present = release_info.is_new and Handy.updater.can_install_release(release_type)
	else
		is_update_present = Handy.cc.updater.enabled
			and not Handy.updater.installed_update
			and Handy.updater.get_new_available_release()
	end
	if not is_update_present and e.children.handy_alert then
		e.children.handy_alert:remove()
		e.children.handy_alert = nil
	elseif is_update_present and not e.children.handy_alert then
		e.children.handy_alert = UIBox({
			definition = Handy.UI.CP.alert_definition({
				scale_mod = 0.8,
			}),
			config = {
				align = "tri",
				offset = {
					x = 0.065,
					y = -0.065,
				},
				major = e,
				instance_type = "ALERT",
			},
		})
		e.children.handy_alert.states.collide.can = false
	end
end
