local controller_keys_functions = {
	regular_keybinds_show_deck_preview = function()
		return Handy.cc.regular_keybinds_show_deck_preview, {
			Handy.cc.regular_keybinds,
		}
	end,
	regular_keybinds_view_deck = function()
		return Handy.cc.regular_keybinds_view_deck, {
			Handy.cc.regular_keybinds,
		}
	end,
	regular_keybinds_leave_shop = function()
		return Handy.cc.regular_keybinds_leave_shop, {
			Handy.cc.regular_keybinds,
		}
	end,
	regular_keybinds_skip_booster = function()
		return Handy.cc.regular_keybinds_skip_booster, {
			Handy.cc.regular_keybinds,
		}
	end,
	regular_keybinds_discard_hand = function()
		return Handy.cc.regular_keybinds_discard, {
			Handy.cc.regular_keybinds,
		}
	end,
	regular_keybinds_reroll_shop = function()
		return Handy.cc.regular_keybinds_reroll_shop, {
			Handy.cc.regular_keybinds,
		}
	end,
	regular_keybinds_play_hand = function()
		return Handy.cc.regular_keybinds_play, {
			Handy.cc.regular_keybinds,
		}
	end,
	regular_keybinds_run_info = function()
		return Handy.cc.regular_keybinds_run_info, {
			Handy.cc.regular_keybinds,
		}
	end,
	regular_keybinds_options = function()
		return Handy.cc.regular_keybinds_options, {
			Handy.cc.regular_keybinds,
		}
	end,
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

Handy.controller.override_node_button = function(e)
	if e.REMOVED then
		return false
	end

	local patched_button = e.handy_gamepad_override
		and Handy.controller.gamepad_patched_buttons[e.handy_gamepad_override]
	if patched_button and patched_button.node == e then
		local new_button
		local is_replaced_button = Handy.b_is_mod_active() and patched_button.enabled_func()
		if is_replaced_button then
			new_button = nil
		else
			new_button = e.handy_replaced_button
		end
		if e.handy_previous_button ~= new_button then
			Handy.controller.remove_button_from_registry(e)
			e.config.focus_args.button = new_button
			if not is_replaced_button then
				Handy.controller.add_button_to_registry(e, e.handy_replaced_registry_menu_value)
			end
			e.handy_previous_button = new_button
			if e.children.button_pip then
				e.children.button_pip:remove()
				e.children.button_pip = nil
			end
			if not e.config.focus_args.button then
				return true
			end
		end
		return false
	end

	local override_key
	if
		not e.handy_gamepad_override_checked
		and e.config.focus_args
		and not e.handy_gamepad_override
		and not G.OVERLAY_MENU
	then
		e.handy_gamepad_override_checked = true
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
	end
	if override_key then
		local module, deps = controller_keys_functions[override_key]()
		local enabled_func = function()
			if not Handy.controls.is_module_enabled(module) then
				return false
			end
			for _, _module in ipairs(deps) do
				if not Handy.controls.is_module_enabled(_module) then
					return false
				end
			end
			return true
		end
		e.handy_gamepad_override = override_key
		e.handy_replaced_button = e.config.focus_args.button
		e.handy_replaced_registry_menu_value = (not not G.OVERLAY_MENU) or not not G.SETTINGS.paused

		if Handy.b_is_mod_active() and enabled_func() then
			Handy.controller.remove_button_from_registry(e)
			e.config.focus_args.button = nil
			e.handy_previous_button = new_button
		end
		Handy.controller.gamepad_patched_buttons[override_key] = {
			node = e,
			module = override_module,
			enabled_func = enabled_func,
		}
	end
	if not e.config.focus_args or not e.config.focus_args.button then
		if e.children.button_pip then
			e.children.button_pip:remove()
			e.children.button_pip = nil
		end
		return true
	end
	return false
end
