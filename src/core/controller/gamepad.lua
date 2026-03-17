local controller_overrides = {
	regular_keybinds_show_deck_preview = {
		get_module = function()
			return Handy.cc.regular_keybinds_show_deck_preview, {
				Handy.cc.regular_keybinds,
			}
		end,
	},
	regular_keybinds_view_deck = {
		get_module = function()
			return Handy.cc.regular_keybinds_view_deck, {
				Handy.cc.regular_keybinds,
			}
		end,
	},
	regular_keybinds_leave_shop = {
		align = "bm",
		offset = { x = 0, y = 0 },
		scale = 0.85 * 0.45,
		get_module = function()
			return Handy.cc.regular_keybinds_leave_shop, {
				Handy.cc.regular_keybinds,
			}
		end,
	},
	regular_keybinds_skip_booster = {
		get_module = function()
			return Handy.cc.regular_keybinds_skip_booster, {
				Handy.cc.regular_keybinds,
			}
		end,
	},
	regular_keybinds_discard_hand = {
		offset = { x = 0, y = 0.15 },
		get_module = function()
			return Handy.cc.regular_keybinds_discard, {
				Handy.cc.regular_keybinds,
			}
		end,
	},
	regular_keybinds_reroll_shop = {
		align = "bm",
		offset = { x = 0, y = 0 },
		scale = 0.85 * 0.45,
		get_module = function()
			return Handy.cc.regular_keybinds_reroll_shop, {
				Handy.cc.regular_keybinds,
			}
		end,
	},
	regular_keybinds_play_hand = {
		offset = { x = 0, y = 0.15 },
		get_module = function()
			return Handy.cc.regular_keybinds_play, {
				Handy.cc.regular_keybinds,
			}
		end,
	},
	regular_keybinds_run_info = {
		scale = 0.925 * 0.45,
		get_module = function()
			return Handy.cc.regular_keybinds_run_info, {
				Handy.cc.regular_keybinds,
			}
		end,
	},
}

Handy.controller.gamepad_patched_buttons = {}

Handy.controller.add_button_to_registry = function(e, menu)
	local registry = e.config.focus_args.button
	if not registry then
		return false
	end
	G.CONTROLLER.button_registry[registry] = G.CONTROLLER.button_registry[registry] or {}
	for _, v in ipairs(G.CONTROLLER.button_registry[registry]) do
		if v.node == (e.config.button_UIE or e) then
			return false
		end
	end
	table.insert(G.CONTROLLER.button_registry[registry], 1, { node = e.config.button_UIE or e, menu = menu or false })
	return true
end
Handy.controller.remove_button_from_registry = function(e)
	for k, registry in pairs(G.CONTROLLER.button_registry) do
		for i = #registry, 1, -1 do
			if registry[i].node == (e.config.button_UIE or e) then
				table.remove(registry, i)
			end
		end
	end
end

function Handy.controller.should_show_custom_pip()
	local v = Handy.cc.show_custom_pip.value
	if v == 1 then
		return false
	elseif v == 2 then
		return Handy.controller.is_gamepad()
	elseif v == 3 then
		return true
	end
end

Handy.controller.override_node_button = function(e)
	if e.REMOVED or Handy.ARGS.no_pip_override then
		return
	end

	-- Step 1: update override if change occurs
	local override = e.handy_gamepad_override
	if override then
		local new_button, new_button_arr
		local is_replaced_button = Handy.b_is_mod_active()
			and Handy.controller.should_show_custom_pip()
			and override.enabled_func()
		if is_replaced_button then
			-- Set buttons & array if it should be replaced
			if Handy.controller.is_gamepad() then
				new_button, new_button_arr =
					Handy.utils.first_non_empty_keys(override.module.keys_1_gamepad, override.module.keys_2_gamepad)
			else
				new_button, new_button_arr =
					Handy.utils.first_non_empty_keys(override.module.keys_1, override.module.keys_2)
			end
		else
			-- Return to vanilla keys
			new_button = nil
			new_button_arr = nil
		end
		if override.prev_button ~= new_button then
			override.prev_button = new_button
			override.render_array = true
			e.config.focus_args.button = nil

			Handy.controller.remove_button_from_registry(e)
			if not is_replaced_button then
				e.config.focus_args.button = override.button
				Handy.controller.add_button_to_registry(e, override.menu_value)
				override.render_array = false
			end

			override.prev_button = new_button
			override.prev_buttons_array = new_button_arr or {}

			-- Rerender the thing
			if e.children.button_pip then
				e.children.button_pip:remove()
				e.children.button_pip = nil
			end
		end
	end

	-- Step 2: setup new override if it's new element
	if
		not e.handy_gamepad_override_checked
		and e.config.focus_args
		and not e.handy_gamepad_override
		and not G.OVERLAY_MENU
	then
		e.handy_gamepad_override_checked = true
		local override_key
		local button = e.config.focus_args.button
		if button == "triggerleft" then
			if e.UIBox.parent == G.deck then
				override_key = "regular_keybinds_show_deck_preview"
			end
		elseif button == "triggerright" then
			if e.config.button == "deck_info" then
				override_key = "regular_keybinds_view_deck"
			end
		elseif button == "y" then
			if e.parent then
				if e.parent.config.id == "next_round_button" then
					override_key = "regular_keybinds_leave_shop"
				elseif e.parent.config.func == "can_skip_booster" then
					override_key = "regular_keybinds_skip_booster"
				elseif e.parent.parent then
					if e.parent.parent.config.id == "discard_button" then
						override_key = "regular_keybinds_discard_hand"
					end
				end
			end
		elseif button == "x" then
			if e.parent then
				if e.parent.config.func == "can_reroll" then
					override_key = "regular_keybinds_reroll_shop"
				elseif e.parent.parent then
					if e.parent.parent.config.id == "play_button" then
						override_key = "regular_keybinds_play_hand"
					end
				end
			end
		elseif button == (G.F_GUIDE and "guide" or "back") then
			if e.parent then
				if e.parent.parent then
					if e.parent.parent.config.id == "run_info_button" then
						override_key = "regular_keybinds_run_info"
					end
				end
			end
		-- elseif button == "start" then
		-- 	if e.parent then
		-- 		if e.parent.config.button == "options" then
		-- 			override_key = "regular_keybinds_options"
		-- 		end
		-- 	end
		elseif button == "leftshoulder" or button == "rightshoulder" then
			-- if e.parent then
			-- 	if e.parent.config.func and e.parent.config.ref_table then
			-- 		local actions_map = {
			-- 			["can_buy_and_use"] = "buy_and_use",
			-- 			["can_buy"] = "buy",
			-- 			["can_redeem"] = "buy",
			-- 			["can_open"] = "buy",
			-- 			["can_use_consumeable"] = "use",
			-- 			["can_sell_card"] = "sell",
			-- 		}
			-- 		local action = actions_map[e.parent.config.func]
			-- 		if action == "buy_and_use" or action == "use" then
			-- 			override_key, override_module = "insta_action_use", Handy.cc.insta_use
			-- 		elseif action == "sell" or action == "buy" then
			-- 			override_key, override_module = "insta_action_buy_or_sell", Handy.cc.insta_buy_or_sell
			-- 		end
			-- 	end
			-- end
		end
		if override_key and controller_overrides[override_key] then
			local definition = controller_overrides[override_key]
			local module, deps = definition.get_module()
			local enabled_func = function()
				if not Handy.controls.is_module_enabled(module) then
					return false
				end
				for _, _module in ipairs(deps or {}) do
					if not Handy.controls.is_module_enabled(_module) then
						return false
					end
				end
				return true
			end
			override = {
				node = e,
				module = module,

				key = override_key,
				button = e.config.focus_args.button,
				menu_value = (not not G.OVERLAY_MENU) or not not G.SETTINGS.paused,
				enabled_func = enabled_func,

				prev_buttons_array = {},
				prev_button = nil,
				render_array = false,

				arg = definition,
			}
			e.handy_gamepad_override = override

			if Handy.b_is_mod_active() and Handy.controller.should_show_custom_pip() and enabled_func() then
				Handy.controller.remove_button_from_registry(e)
				e.config.focus_args.button = nil
				if Handy.controller.is_gamepad() then
					override.prev_button, override.prev_buttons_array =
						Handy.utils.first_non_empty_keys(module.keys_1_gamepad, module.keys_2_gamepad)
				else
					override.prev_button, override.prev_buttons_array =
						Handy.utils.first_non_empty_keys(module.keys_1, module.keys_2)
				end
				override.render_array = true

				if e.children.button_pip then
					e.children.button_pip:remove()
					e.children.button_pip = nil
				end
			end
			Handy.controller.gamepad_patched_buttons[override_key] = override
		end
	end

	-- Step 3: render override. or return as usual
	if override and override.render_array then
		if #override.prev_buttons_array > 0 and not e.children.button_pip then
			local align = override.arg.align or e.config.focus_args.orientation or "cr"
			local offset = override.arg.offset
				or e.config.focus_args.offset
				or align == "bm" and { x = 0, y = 0.05 }
				or { x = 0.1, y = 0.05 }
			local scale = override.arg.scale or e.config.focus_args.scale

			e.children.button_pip = UIBox({
				definition = Handy.UI.custom_button_pip({
					override = override,
					scale = scale,
				}),
				config = {
					align = align,
					offset = offset,
					major = e,
					parent = e,
				},
			})
			e.children.button_pip.states.collide.can = false
		elseif #override.prev_buttons_array == 0 and e.children.button_pip then
			e.children.button_pip:remove()
			e.children.button_pip = nil
		end
		return true
	end

	-- Display vanilla controller things if we mimic gamepad
	if Handy.controller.is_gamepad() and not G.CONTROLLER.HID.controller then
		G.CONTROLLER.HID.controller = true
		Handy.ARGS.no_pip_override = true
		G.FUNCS.set_button_pip(e)
		G.CONTROLLER.HID.controller = nil
		Handy.ARGS.no_pip_override = nil
		return true
	else
		return false
	end
end
