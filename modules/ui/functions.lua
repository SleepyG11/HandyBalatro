-- Utilities

function G.FUNCS.handy_empty()
	-- noop
end
function G.FUNCS.handy_rerender_after_input()
	G.E_MANAGER:add_event(Event({
		blocking = false,
		blockable = false,
		no_delete = true,
		func = function()
			Handy.UI.rerender(true)
			G.E_MANAGER:add_event(Event({
				blocking = false,
				blockable = false,
				no_delete = true,
				func = function()
					Handy.UI.rerender(true)
					return true
				end,
			}))
			return true
		end,
	}))
end

-- Opening-closing options

function G.FUNCS.handy_open_options(e)
	G.SETTINGS.paused = true
	Handy.UI.config_opened = true
	Handy.UI.config_tab_index = 1
	Handy.UI.keybinds_page = 1
	Handy.UI.quick_page = 1
	G.FUNCS.overlay_menu({
		definition = G.UIDEF.handy_options(),
	})
	Handy.utils.cleanup_dead_elements(G, "MOVEABLES")
end
function G.FUNCS.handy_exit_options(e)
	Handy.UI.config_opened = nil
	Handy.UI.config_tab_index = nil
	Handy.UI.keybinds_page = nil
	if e then
		return G.FUNCS.options(e)
	end
	Handy.utils.cleanup_dead_elements(G, "MOVEABLES")
end
local exit_overlay_ref = G.FUNCS.exit_overlay_menu
function G.FUNCS.exit_overlay_menu(...)
	Handy.UI.config_opened = nil
	Handy.UI.config_tab_index = nil
	local result = exit_overlay_ref(...)
	Handy.utils.cleanup_dead_elements(G, "MOVEABLES")
	return result
end

-- Setup popups

function G.FUNCS.handy_setup_config_popup(e)
	if e.handy_popup_processed then
		return
	end

	local loc_key = e.config.handy_loc_key
	local loc_vars = e.config.handy_loc_vars or {}
	local popup_hover = function(self)
		local is_gamepad = Handy.controller.is_gamepad()
		local loc_suffix = ""
		local is_popup_present = G.localization.descriptions.Handy_ConfigPopup[loc_key]
		if is_gamepad then
			if G.localization.descriptions.Handy_ConfigPopup[loc_key .. "_gamepad"] then
				is_popup_present = true
				loc_suffix = "_gamepad"
			end
		else
			if G.localization.descriptions.Handy_ConfigPopup[loc_key .. "_desktop"] then
				is_popup_present = true
				loc_suffix = "_desktop"
			end
		end
		if is_popup_present then
			local popup_content = {}
			localize({
				type = "descriptions",
				set = "Handy_ConfigPopup",
				key = loc_key .. loc_suffix,
				nodes = popup_content,
				vars = loc_vars,
			})
			local desc_lines = {}
			for _, line in ipairs(popup_content) do
				table.insert(desc_lines, {
					n = G.UIT.R,
					config = {
						align = "cm",
						padding = 0.01,
					},
					nodes = line,
				})
			end

			self.config.h_popup_config = { align = "mt", offset = { x = 0, y = -0.1 }, parent = self }
			self.config.h_popup = {
				n = G.UIT.ROOT,
				config = { align = "cm", colour = G.C.CLEAR },
				nodes = {
					{
						n = G.UIT.C,
						config = {
							align = "cm",
						},
						nodes = {
							{
								n = G.UIT.R,
								config = {
									padding = 0.05,
									r = 0.12,
									colour = lighten(G.C.JOKER_GREY, 0.5),
									emboss = 0.07,
								},
								nodes = {
									{
										n = G.UIT.R,
										config = {
											align = "cm",
											padding = 0.07,
											r = 0.1,
											colour = adjust_alpha(darken(G.C.BLACK, 0.1), 0.8),
										},
										nodes = { desc_from_rows({ desc_lines }) },
									},
								},
							},
						},
					},
				},
			}
		else
			self.config.h_popup_config = nil
			self.config.h_popup = nil
		end
		Node.hover(self)
	end

	e.float = true
	e.states.hover.can = true
	e.states.collide.can = true
	e.hover = popup_hover
	-- Well... it works xd
	pcall(function()
		if Handy.controller.is_gamepad() then
			e.children[2].children[1].children[2].children[1].children[1].hover = popup_hover
		end
	end)
	e.handy_popup_processed = true
end

-- Presets

function G.FUNCS.handy_toggle_preset_enabled(b, index)
	Handy.presets.save_index(index, { enabled = b })
	G.FUNCS.handy_rerender_after_input()
end
function G.FUNCS.handy_save_preset_index_with_name(e)
	local index = e.config.ref_table.index
	local new_name = e.config.ref_table.name_object.name
	Handy.presets.save_index(index, { name = new_name, apply = true })
	G.FUNCS.handy_rerender_after_input()
end
function G.FUNCS.handy_load_preset_index(e)
	local index = e.config.ref_table.index
	Handy.presets.apply_index(index)
	G.FUNCS.handy_rerender_after_input()
end
function G.FUNCS.handy_apply_preset_key(e)
	local key = e.config.ref_table.key
	Handy.presets.apply_example(key)
	G.FUNCS.handy_rerender_after_input()
end
function G.FUNCS.handy_clear_preset_index(e)
	local index = e.config.ref_table.index
	Handy.presets.clear_index(index)
	G.FUNCS.handy_rerender_after_input()
end

-- Paginations

function G.FUNCS.handy_change_keybinds_page(arg)
	if not G.OVERLAY_MENU then
		return
	end
	Handy.UI.keybinds_page = arg.to_key
	local page_definition = Handy.UI.get_keybinds_page(arg.to_key)
	local object_container = G.OVERLAY_MENU:get_UIE_by_ID("handy_keybinds_page_content")
	if object_container then
		object_container.config.object:remove()
		object_container.config.object = UIBox({
			definition = page_definition,
			config = {
				colour = G.C.CLEAR,
				parent = object_container,
				align = "cm",
			},
		})
		object_container.config.object:recalculate()
	end
end
function G.FUNCS.handy_change_quick_page(arg)
	if not G.OVERLAY_MENU then
		return
	end
	Handy.UI.quick_page = arg.to_key
	local page_definition = Handy.UI.get_quick_page(arg.to_key)
	local object_container = G.OVERLAY_MENU:get_UIE_by_ID("handy_quick_page_content")
	if object_container then
		object_container.config.object:remove()
		object_container.config.object = UIBox({
			definition = page_definition,
			config = {
				colour = G.C.CLEAR,
				parent = object_container,
				align = "cm",
			},
		})
		object_container.config.object:recalculate()
	end
end

-- Configs

function G.FUNCS.handy_toggle_module_enabled(arg, module)
	if not module then
		return
	end
	module.enabled = arg
	if module == Handy.cc.nopeus_interaction then
		Handy.nopeus_interaction.change(0)
	elseif module == Handy.cc.hide_options_button then
		Handy.UI.show_options_button = not Handy.cc.hide_options_button.enabled
	end
	Handy.config.save()
end

function G.FUNCS.handy_change_notifications_level(arg)
	Handy.cc.notifications_level = arg.to_key
	Handy.config.save()
end
function G.FUNCS.handy_change_keybinds_trigger_mode(arg)
	Handy.cc.keybinds_trigger_mode = arg.to_key
	Handy.config.save()
end
function G.FUNCS.handy_change_insta_actions_trigger_mode(arg)
	Handy.cc.insta_actions_trigger_mode = arg.to_key
	Handy.config.save()
end
function G.FUNCS.handy_change_current_device(arg)
	Handy.cc.current_device = arg.to_key
	Handy.config.save()
	Handy.controller.update_device_type({ check = true })
end

function G.FUNCS.handy_init_keybind_change(e)
	Handy.controller.init_bind(e)
end
