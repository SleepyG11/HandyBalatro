local key_from_raw_table = {
	["mouse1"] = "Left Mouse",
	["mouse2"] = "Right Mouse",
	["mouse3"] = "Middle Mouse",
	["mouse4"] = "Mouse 4",
	["mouse5"] = "Mouse 5",
	["wheelup"] = "Wheel Up",
	["wheeldown"] = "Wheel Down",
	["lshift"] = "Shift",
	["rshift"] = "Shift",
	["lctrl"] = "Ctrl",
	["rctrl"] = "Ctrl",
	["lalt"] = "Alt",
	["ralt"] = "Alt",
	["lgui"] = "GUI",
	["rgui"] = "GUI",
	["return"] = "Enter",
	["kpenter"] = "NUM Enter",
	["pageup"] = "Page Up",
	["pagedown"] = "Page Down",
	["numlock"] = "Num Lock",
	["capslock"] = "Caps Lock",
	["scrolllock"] = "Scroll Lock",
	["`"] = "Backquote",
	["'"] = "Singlequote",
	['"'] = "Quote",
	["["] = "Left Bracket",
	["]"] = "Right Bracket",
}
local keys_to_raw_table = {
	["Left Mouse"] = { "mouse1" },
	["Right Mouse"] = { "mouse2" },
	["Middle Mouse"] = { "mouse3" },
	["Mouse 4"] = { "mouse4" },
	["Mouse 5"] = { "mouse5" },
	["Wheel Up"] = { "wheelup" },
	["Wheel Down"] = { "wheeldown" },
	["Shift"] = { "lshift", "rshift" },
	["Ctrl"] = { "lctrl", "rctrl" },
	["Alt"] = { "lalt", "ralt" },
	["GUI"] = { "lgui", "rgui" },
	["Enter"] = { "return" },
	["NUM Enter"] = { "kpenter" },
	["Page Up"] = { "pageup" },
	["Page Down"] = { "pagedown" },
	["Num Lock"] = { "numlock" },
	["Caps Lock"] = { "capslock" },
	["Scroll Lock"] = { "scrolllock" },
	["Backquote"] = { "`" },
	["Singlequote"] = { "'" },
	["Quote"] = { '"' },
	["Left Bracket"] = { "[" },
	["Right Bracket"] = { "]" },
	["["] = { "[" },
	["]"] = { "]" },
}

local gamepad_key_from_raw_table = {
	["a"] = "(A)",
	["b"] = "(B)",
	["x"] = "(X)",
	["y"] = "(Y)",
	["back"] = "(Back)",
	["guide"] = "(Guide)",
	["start"] = "(Start)",
	["leftstick"] = "Left Stick",
	["rightstick"] = "Right Stick",
	["leftshoulder"] = "Left Bumper",
	["rightshoulder"] = "Right Bumper",
	["dpup"] = "(Up)",
	["dpdown"] = "(Down)",
	["dpleft"] = "(Left)",
	["dpright"] = "(Right)",
	-- Not present in current Love version (11.5.0)
	["misc1"] = "(Misc. Button)",
	["paddle1"] = "First Paddle",
	["paddle2"] = "Second Paddle",
	["paddle3"] = "Third Paddle",
	["paddle4"] = "Fourth Paddle",
	["touchpad"] = "Touchpad Press",
	-- Axis as button
	["triggerleft"] = "Left Trigger",
	["triggerright"] = "Right Trigger",
}
local gamepad_keys_to_raw_table = {
	["(A)"] = { "a" },
	["(B)"] = { "b" },
	["(X)"] = { "x" },
	["(Y)"] = { "y" },
	["(Back)"] = { "back" },
	["(Guide)"] = { "guide" },
	["(Start)"] = { "start" },
	["Left Stick"] = { "leftstick" },
	["Right Stick"] = { "rightstick" },
	["Left Bumper"] = { "leftshoulder" },
	["Right Bumper"] = { "rightshoulder" },
	["(Up)"] = { "dpup" },
	["(Down)"] = { "dpdown" },
	["(Left)"] = { "dpleft" },
	["(Right)"] = { "dpright" },
	-- Not present in current Love version (11.5.0)
	["(Misc. Button)"] = { "misc1" },
	["First Paddle"] = { "paddle1" },
	["Second Paddle"] = { "paddle2" },
	["Third Paddle"] = { "paddle3" },
	["Fourth Paddle"] = { "paddle4" },
	["Touchpad Press"] = { "touchpad" },
	-- Axis as button
	["Left Trigger"] = {
		"triggerleft",
		axis_check = function()
			return G.CONTROLLER.axis_buttons.l_trig.current == "triggerleft"
		end,
	},
	["Right Trigger"] = {
		"triggerright",
		axis_check = function()
			return G.CONTROLLER.axis_buttons.r_trig.current == "triggerright"
		end,
	},
}

local mouse_raw_from_index_table = {
	[1] = "mouse1",
	[2] = "mouse2",
	[3] = "mouse3",
	[4] = "mouse4",
	[5] = "mouse5",
}
local mouse_key_to_index_table = {
	["Left Mouse"] = 1,
	["Right Mouse"] = 2,
	["Middle Mouse"] = 3,
	["Mouse 4"] = 4,
	["Mouse 5"] = 5,
}

local wheel_raw_from_index_table = {
	[1] = "wheelup",
	[2] = "wheeldown",
}
local wheel_key_to_index_table = {
	["Wheel Up"] = 1,
	["Wheel Down"] = 2,
}

local non_holdable_keys_table = {
	["Wheel Up"] = true,
	["Wheel Down"] = true,
}
local non_safe_keys_table = {
	["Left Mouse"] = true,
	["Right Mouse"] = true,
	["(Left)"] = true,
	["(Right)"] = true,
	["(Up)"] = true,
	["(Down)"] = true,
	["(X)"] = true,
	["(Y)"] = true,
	["(A)"] = true,
	["(B)"] = true,
}

Handy.controller = {
	console_opened_timer = 0,

	debugplus_module = nil,
	get_debugplus_module = function()
		if Handy.controller.debugplus_module then
			return Handy.controller.debugplus_module
		end
		local success, dpconfig, dputils = pcall(function()
			return require("debugplus-config"), require("debugplus-util")
		end)
		if not success then
			success, dpconfig, dputils = pcall(function()
				return require("debugplus.config"), require("debugplus.util")
			end)
		end
		local console_success, dpconsole = pcall(function()
			return require("debugplus.console")
		end)
		if not success then
			Handy.controller.debugplus_module = {
				installed = false,
				config = nil,
				utils = nil,
				console = console_success and dpconsole or nil,
			}
		else
			Handy.controller.debugplus_module = {
				installed = true,
				config = dpconfig,
				utils = dputils,
				console = console_success and dpconsole or nil,
			}
		end
		if console_success and dpconsole and dpconsole.isConsoleFocused then
			function Handy.controller.update_is_console_opened()
				if dpconsole.isConsoleFocused() then
					Handy.controller.console_opened_timer = G.TIMERS.UPTIME + 0.333
				end
			end
		end
		return Handy.controller.debugplus_module
	end,

	device_type = "keyboard",

	get_device_type = function(options)
		options = options or {}
		if Handy.cc.current_device == 2 then
			return "keyboard"
		elseif Handy.cc.current_device == 3 then
			return "gamepad"
		elseif Handy.cc.current_device == 1 then
			if options.touch or options.check then
				return Handy.controller.device_type
			elseif options.joystick or options.gamepad or G.CONTROLLER.HID.controller then
				return "gamepad"
			elseif options.mouse or options.keyboard then
				return "keyboard"
			end
		end
		return "keyboard"
	end,
	update_device_type = function(options)
		options = options or {}
		local new_type = Handy.controller.get_device_type(options)
		if Handy.controller.device_type == new_type then
			return false
		end
		Handy.controller.device_type = new_type

		Handy.controller.cancel_bind()

		G.E_MANAGER:add_event(Event({
			blocking = false,
			blockable = false,
			no_delete = true,
			func = function()
				Handy.UI.rerender(false)
				return true
			end,
		}))
		return true
	end,

	is_gamepad = function()
		return Handy.controller.device_type == "gamepad"
	end,

	gamepad_patched_buttons = {},

	add_button_to_registry = function(e, menu)
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
		table.insert(
			G.CONTROLLER.button_registry[registry],
			1,
			{ node = e.config.button_UIE or e, menu = menu or false }
		)
		return true
	end,
	remove_button_from_registry = function(e)
		for k, registry in pairs(G.CONTROLLER.button_registry) do
			for i = #registry, 1, -1 do
				if registry[i].node == (e.config.button_UIE or e) then
					table.remove(registry, i)
				end
			end
		end
	end,

	override_node_button = function(e)
		if e.REMOVED then
			return false
		end

		local patched_button = e.handy_gamepad_override
			and Handy.controller.gamepad_patched_buttons[e.handy_gamepad_override]
		if patched_button and patched_button.node == e then
			local new_button
			local is_replaced_button = Handy.is_mod_active() and patched_button.enabled_func()
			if is_replaced_button then
				new_button = Handy.controller.resolve_first_module_key(patched_button.module)
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

		local override_key, override_module, override_enabled_func = nil, nil, nil
		if
			not e.handy_gamepad_override_checked
			and e.config.focus_args
			and not e.handy_gamepad_override
			and not G.OVERLAY_MENU
		then
			e.handy_gamepad_override_checked = true
			local button = e.config.focus_args.button
			if button == "triggerleft" then
				override_key, override_module = "show_deck_preview", Handy.cc.show_deck_preview
			elseif button == "triggerright" then
				override_key, override_module, override_enabled_func =
					"view_deck", Handy.cc.regular_keybinds.view_deck, function()
						return Handy.controller.is_module_enabled(Handy.cc.regular_keybinds) and Handy.controller.is_module_enabled(Handy.cc.regular_keybinds.view_deck)
					end
			elseif button == "y" then
				if e.parent then
					if e.parent.config.id == "next_round_button" then
						override_key, override_module, override_enabled_func =
							"leave_shop", Handy.cc.regular_keybinds.leave_shop, function()
								return Handy.controller.is_module_enabled(Handy.cc.regular_keybinds) and Handy.controller.is_module_enabled(Handy.cc.regular_keybinds.leave_shop)
							end
					elseif e.parent.config.func == "can_skip_booster" then
						override_key, override_module = "skip_booster", Handy.cc.insta_booster_skip
					elseif e.parent.parent then
						if e.parent.parent.config.id == "discard_button" then
							override_key, override_module, override_enabled_func =
								"discard", Handy.cc.regular_keybinds.discard, function()
									return Handy.controller.is_module_enabled(Handy.cc.regular_keybinds) and Handy.controller.is_module_enabled(Handy.cc.regular_keybinds.discard)
								end
						end
					end
				end
			elseif button == "x" then
				if e.parent then
					if e.parent.config.func == "can_reroll" then
						override_key, override_module, override_enabled_func =
							"reroll_shop", Handy.cc.regular_keybinds.reroll_shop, function()
								return Handy.controller.is_module_enabled(Handy.cc.regular_keybinds) and Handy.controller.is_module_enabled(Handy.cc.regular_keybinds.reroll_shop)
							end
					elseif e.parent.parent then
						if e.parent.parent.config.id == "play_button" then
							override_key, override_module, override_enabled_func =
								"play", Handy.cc.regular_keybinds.play, function()
									return Handy.controller.is_module_enabled(Handy.cc.regular_keybinds) and Handy.controller.is_module_enabled(Handy.cc.regular_keybinds.play)
								end
						end
					end
				end
			elseif button == (G.F_GUIDE and "guide" or "back") then
				if e.parent then
					if e.parent.parent then
						if e.parent.parent.config.id == "run_info_button" then
							override_key, override_module, override_enabled_func =
								"run_info", Handy.cc.regular_keybinds.run_info, function()
									return Handy.controller.is_module_enabled(Handy.cc.regular_keybinds) and Handy.controller.is_module_enabled(Handy.cc.regular_keybinds.run_info)
								end
						end
					end
				end
			elseif button == "leftshoulder" or button == "rightshoulder" then
				if e.parent then
					if e.parent.config.func and e.parent.config.ref_table then
						local actions_map = {
							["can_buy_and_use"] = "buy_and_use",
							["can_buy"] = "buy",
							["can_redeem"] = "buy",
							["can_open"] = "buy",
							["can_use_consumeable"] = "use",
							["can_sell_card"] = "sell",
						}
						local action = actions_map[e.parent.config.func]
						if action == "buy_and_use" or action == "use" then
							override_key, override_module = "insta_action_use", Handy.cc.insta_use
						elseif action == "sell" or action == "buy" then
							override_key, override_module = "insta_action_buy_or_sell", Handy.cc.insta_buy_or_sell
						end
					end
				end
			end
		end
		if override_key and override_module then
			local enabled_func = override_enabled_func
				or function()
					return Handy.controller.is_module_enabled(override_module)
				end
			e.handy_gamepad_override = override_key
			e.handy_replaced_button = e.config.focus_args.button
			e.handy_replaced_registry_menu_value = (not not G.OVERLAY_MENU) or not not G.SETTINGS.paused

			if Handy.is_mod_active() and enabled_func() then
				Handy.controller.remove_button_from_registry(e)
				local new_button = Handy.controller.resolve_first_module_key(override_module)
				e.config.focus_args.button = new_button
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
	end,

	bind_module = nil,
	bind_key = nil,
	bind_button = nil,
	rerender_after_bind = nil,

	update_bind_button_text = function(text)
		if not Handy.controller.bind_button then
			return
		end
		local button_text = Handy.controller.bind_button.children[1].children[1]
		button_text.config.text_drawable = nil
		button_text.config.text = text
		button_text:update_text()
		button_text.UIBox:recalculate()
	end,
	init_bind = function(button)
		button.config.button = nil
		Handy.controller.bind_button = button
		Handy.controller.bind_module = button.config.ref_table.module
		Handy.controller.bind_key = button.config.ref_table.key
		Handy.controller.only_holdable = button.config.ref_table.only_holdable or false
		Handy.controller.only_safe = button.config.ref_table.only_safe or false
		Handy.controller.rerender_after_bind = button.config.ref_table.rerender or nil

		Handy.controller.update_bind_button_text(
			"["
				.. Handy.UI.PARTS.localize_keybind(Handy.controller.bind_module[Handy.controller.bind_key] or "None")
				.. "]"
		)
	end,
	complete_bind = function(key)
		if Handy.controller.only_safe and Handy.controller.non_safe[key] then
			Handy.UI.state_panel.display(function(state)
				state.items.non_holdable = {
					text = localize("ph_handy_notif_cannot_bind_non_safe"),
					hold = false,
					order = 0,
				}
				return true
			end)
			return Handy.controller.cancel_bind()
		end
		if Handy.controller.only_holdable and Handy.controller.non_holdable[key] then
			Handy.UI.state_panel.display(function(state)
				state.items.non_holdable = {
					text = localize("ph_handy_notif_cannot_bind_non_holdable"),
					hold = false,
					order = 0,
				}
				return true
			end)
			return Handy.controller.cancel_bind()
		end
		Handy.controller.bind_module[Handy.controller.bind_key] = key or "None"
		Handy.controller.update_bind_button_text(Handy.UI.PARTS.localize_keybind(key or "None"))

		if Handy.controller.bind_button then
			Handy.controller.bind_button.config.button = "handy_init_keybind_change"
		end
		Handy.controller.bind_button = nil
		Handy.controller.bind_module = nil
		Handy.controller.bind_key = nil
		Handy.controller.only_holdable = nil
		Handy.controller.only_safe = nil

		if Handy.controller.rerender_after_bind then
			Handy.controller.rerender_after_bind = nil
			G.E_MANAGER:add_event(Event({
				blocking = false,
				blockable = false,
				no_delete = true,
				func = function()
					Handy.UI.rerender(true)
					return true
				end,
			}))
		end
	end,
	cancel_bind = function()
		if not Handy.controller.bind_module or not Handy.controller.bind_key or not Handy.controller.bind_button then
			return
		end
		Handy.controller.update_bind_button_text(
			Handy.UI.PARTS.localize_keybind(Handy.controller.bind_module[Handy.controller.bind_key] or "None")
		)

		Handy.controller.bind_button.config.button = "handy_init_keybind_change"
		Handy.controller.bind_button = nil
		Handy.controller.bind_module = nil
		Handy.controller.bind_key = nil
		Handy.controller.only_holdable = nil
		Handy.controller.only_safe = nil
		Handy.controller.rerender_after_bind = nil
	end,

	process_bind = function(key, options)
		if not Handy.controller.bind_button then
			return false
		end
		local parsed_key, is_discard_key = Handy.controller.parse(key, options)
		if is_discard_key then
			parsed_key = "None"
		end
		Handy.controller.complete_bind(parsed_key)
		Handy.config.save()
		return true
	end,

	parse_table = key_from_raw_table,
	resolve_table = keys_to_raw_table,

	parse_gamepad_table = gamepad_key_from_raw_table,
	resolve_gamepad_table = gamepad_keys_to_raw_table,

	mouse_to_key_table = mouse_raw_from_index_table,
	wheel_to_key_table = wheel_raw_from_index_table,

	mouse_buttons = mouse_key_to_index_table,
	wheel_buttons = wheel_key_to_index_table,

	non_holdable = non_holdable_keys_table,
	non_safe = non_safe_keys_table,

	parse = function(raw_key, options)
		if not raw_key then
			return nil, false
		end
		options = options or {}

		if options.gamepad or options.any then
			local gamepad_result = Handy.controller.parse_gamepad_table[raw_key]
			if gamepad_result or options.gamepad then
				return gamepad_result, gamepad_result == "(Back)"
			end
		end

		local result
		if Handy.controller.parse_table[raw_key] then
			result = Handy.controller.parse_table[raw_key]
		elseif string.sub(raw_key, 1, 2) == "kp" then
			result = "NUM " .. string.sub(raw_key, 3)
		else
			result = string.upper(string.sub(raw_key, 1, 1)) .. string.sub(raw_key, 2)
		end
		return result, result == "Escape"
	end,
	resolve = function(parsed_key, options)
		if not parsed_key or parsed_key == "None" then
			return nil
		end
		options = options or {}

		if options.gamepad or options.any then
			local result = Handy.controller.resolve_gamepad_table[parsed_key]
			if result or options.gamepad then
				return unpack(result or { nil })
			end
		end
		if Handy.controller.resolve_table[parsed_key] then
			return unpack(Handy.controller.resolve_table[parsed_key])
		elseif string.sub(parsed_key, 1, 4) == "NUM " then
			return "kp" .. string.sub(parsed_key, 5)
		else
			return string.gsub(string.lower(parsed_key), "%s+", "")
		end
	end,
	resolve_first_module_key = function(module, allow_disabled)
		module = Handy.m(module)
		if module and (allow_disabled or module.enabled) then
			if force_gamepad or Handy.controller.is_gamepad() then
				return Handy.controller.resolve(module.key_1_gamepad, { gamepad = true })
					or Handy.controller.resolve(module.key_2_gamepad, { gamepad = true })
			end
			return Handy.controller.resolve(module.key_1) or Handy.controller.resolve(module.key_2)
		end
		return nil
	end,
	is_down = function(...)
		local parsed_keys = { ... }
		for i = 1, #parsed_keys do
			local parsed_key = parsed_keys[i]
			if parsed_key and parsed_key ~= "Unknown" and parsed_key ~= "None" then
				if Handy.controller.wheel_buttons[parsed_key] then
					-- Well, skip
				elseif Handy.controller.mouse_buttons[parsed_key] then
					if
						love.mouse.isDown(Handy.controller.mouse_buttons[parsed_key])
						or (parsed_key == "Left Mouse" and (next(love.touch.getTouches())))
					then
						return true
					end
				elseif Handy.controller.resolve(parsed_key, { gamepad = true }) then
					local resolved_raw_value = Handy.controller.resolve_gamepad_table[parsed_key]
					if resolved_raw_value and resolved_raw_value.axis_check then
						local success, is_active = pcall(resolved_raw_value.axis_check)
						if success and is_active then
							return true
						end
					else
						local success, is_down = pcall(function()
							return G.CONTROLLER.GAMEPAD.object:isGamepadDown(
								Handy.controller.resolve(parsed_key, { gamepad = true })
							)
						end)
						if success and is_down then
							return true
						end
					end
				else
					local success, is_down = pcall(function()
						return love.keyboard.isDown(Handy.controller.resolve(parsed_key))
					end)
					if success and is_down then
						return true
					end
				end
			end
		end
		return false
	end,
	is = function(raw_key, ...)
		if not raw_key or raw_key == "Unknown" or raw_key == "None" then
			return false
		end
		local parsed_keys = { ... }
		for i = 1, #parsed_keys do
			local parsed_key = parsed_keys[i]
			if parsed_key then
				local resolved_key_1, resolved_key_2 = Handy.controller.resolve(parsed_key, { any = true })
				if raw_key == resolved_key_1 or raw_key == resolved_key_2 then
					return true
				end
			end
		end
		return false
	end,

	is_module_key_down = function(module, allow_disabled, force_gamepad)
		module = Handy.m(module)
		if module and (allow_disabled or module.enabled) then
			if force_gamepad or Handy.controller.is_gamepad() then
				return Handy.controller.is_down(module.key_1_gamepad, module.key_2_gamepad)
			end
			return Handy.controller.is_down(module.key_1, module.key_2)
		end
		return false
	end,
	is_module_key = function(module, raw_key, allow_disabled, force_gamepad)
		module = Handy.m(module)
		if module and (allow_disabled or module.enabled) then
			if force_gamepad or Handy.controller.is_gamepad() then
				return Handy.controller.is(raw_key, module.key_1_gamepad, module.key_2_gamepad)
			else
				return Handy.controller.is(raw_key, module.key_1, module.key_2)
			end
		end
		return false
	end,
	is_module_enabled = function(module)
		module = Handy.m(module)
		return module and module.enabled
	end,

	is_trigger_on_release = function()
		return Handy.cc.keybinds_trigger_mode == 2
	end,
	is_triggered = function(released)
		if Handy.controller.is_trigger_on_release() then
			return released
		end
		return not released
	end,
	is_debugplus_console_opened = function()
		return Handy.controller.console_opened_timer > G.TIMERS.UPTIME
	end,
	is_debugplus_triggered = function()
		local dp = Handy.controller.get_debugplus_module()
		if not (dp.installed and Handy.cc.prevent_if_debugplus.enabled) then
			return false
		end
		local success, is_triggered = pcall(function()
			return dp.config.getValue("ctrlKeybinds") and dp.utils.isCtrlDown()
		end)
		return success and is_triggered
	end,
	update_is_console_opened = function() end,
	prevent_if_debugplus = function(key, released)
		if Handy.controller.is_debugplus_triggered() then
			if Handy.cc.notifications_level > 2 and not Handy.controller.is(key, "Ctrl") then
				Handy.UI.state_panel.display(function(state)
					state.items.prevented_by_debugplus = {
						text = "Keybinds prevented by DebugPlus " .. Handy.UI.PARTS.localize_keybind("Ctrl", true),
						hold = false,
						order = 0,
					}
					return true
				end)
			end
			return true
		end
		return false
	end,

	process_key = function(key, released)
		Handy.controller.update_device_type({ keyboard = true })
		G.njy_keybind = nil

		-----

		if not Handy.is_mod_active() then
			return false
		end
		if Handy.controller.is_debugplus_console_opened() then
			return false
		end
		if not released and Handy.controller.process_bind(key) then
			return true
		end
		if key == "escape" or G.CONTROLLER.text_input_hook or not Handy.is_mod_active() then
			return false
		end
		if Handy.controller.prevent_if_debugplus(key, released) then
			return false
		end
		local finish = function(result)
			Handy.UI.state_panel.update(key, released)
			return result
		end

		-----

		if not released and Handy.presets_switch.use(key) then
			return finish(true)
		end

		if Handy.misc_controls.use(key, released) then
			return finish(true)
		end

		if not released then
			if
				Handy.speed_multiplier.use(key)
				or Handy.nopeus_interaction.use(key)
				or Handy.animation_skip.use(key)
			then
				return finish(true)
			end
		end

		local in_run = G.STAGE == G.STAGES.RUN and not G.SETTINGS.paused and not G.OVERLAY_MENU
		if in_run then
			if not released then
				Handy.insta_highlight.use_on_hovered(key)
			end
			if Handy.controller.is_triggered(released) then
				Handy.insta_actions.use_alt(key)
				Handy.move_highlight.use(key)
			end
		end
		if Handy.controller.is_triggered(released) then
			Handy.regular_keybinds.use(key)
		end
		if in_run then
			if Handy.controller.is_triggered(released) then
				Handy.insta_highlight_entire_f_hand.use(key)
				Handy.deselect_hand.use(key)
			end

			Handy.dangerous_actions.toggle_queue(key, released)
			Handy.dangerous_actions.use(key, released)
		end

		return finish(false)
	end,
	process_mouse = function(mouse, released, touch)
		Handy.controller.update_device_type({ mouse = not touch, touch = touch })
		G.njy_keybind = nil
		local key = Handy.controller.mouse_to_key_table[mouse]

		-----

		if not Handy.is_mod_active() then
			return false
		end
		if Handy.controller.is_debugplus_console_opened() then
			return false
		end
		if not released and Handy.controller.process_bind(key) then
			return true
		end
		if G.CONTROLLER.text_input_hook or not Handy.is_mod_active() then
			return false
		end
		if Handy.controller.prevent_if_debugplus(key, released) then
			return false
		end

		local finish = function(result)
			Handy.UI.state_panel.update(key, released)
			return result
		end

		-----

		if touch then
			return finish(false)
		end

		if not released and Handy.presets_switch.use(key) then
			return finish(true)
		end

		if Handy.misc_controls.use(key, released) then
			return finish(true)
		end

		if not released then
			if
				Handy.speed_multiplier.use(key)
				or Handy.nopeus_interaction.use(key)
				or Handy.animation_skip.use(key)
			then
				return finish(true)
			end
		end

		local in_run = G.STAGE == G.STAGES.RUN and not G.SETTINGS.paused and not G.OVERLAY_MENU
		if in_run then
			if not released then
				Handy.insta_highlight.use_on_hovered(key)
			end
			if Handy.controller.is_triggered(released) then
				Handy.insta_actions.use_alt(key)
				Handy.move_highlight.use(key)
			end
		end
		if Handy.controller.is_triggered(released) then
			Handy.regular_keybinds.use(key)
		end
		if in_run then
			if Handy.controller.is_triggered(released) then
				Handy.insta_highlight_entire_f_hand.use(key)
				Handy.deselect_hand.use(key)
			end

			Handy.dangerous_actions.toggle_queue(key, released)
			Handy.dangerous_actions.use(key, released)
		end

		return finish(false)
	end,
	process_wheel = function(wheel)
		Handy.controller.update_device_type({ mouse = true })
		local key = Handy.controller.wheel_to_key_table[wheel]

		-----

		if not Handy.is_mod_active() then
			return false
		end
		if Handy.controller.is_debugplus_console_opened() then
			return false
		end
		if Handy.controller.process_bind(key) then
			return true
		end
		if G.CONTROLLER.text_input_hook or not Handy.is_mod_active() then
			return false
		end
		if Handy.controller.prevent_if_debugplus(key, false) then
			return false
		end

		local finish = function(result)
			Handy.UI.state_panel.update(key, false)
			return result
		end

		-----

		if Handy.presets_switch.use(key) then
			return finish(true)
		end

		if Handy.misc_controls.use(key, false) then
			return finish(true)
		end

		if Handy.speed_multiplier.use(key) or Handy.nopeus_interaction.use(key) or Handy.animation_skip.use(key) then
			return finish(true)
		end

		if G.STAGE == G.STAGES.RUN and not G.SETTINGS.paused and not G.OVERLAY_MENU then
			Handy.insta_actions.use_alt(key)
			Handy.move_highlight.use(key)
			Handy.regular_keybinds.use(key)
			Handy.insta_highlight_entire_f_hand.use(key)
			Handy.deselect_hand.use(key)
			Handy.dangerous_actions.use(key, false)
		else
			Handy.regular_keybinds.use(key)
		end

		return finish(false)
	end,
	process_gamepad_button = function(joystick, button, released)
		Handy.controller.update_device_type({ gamepad = true })

		-----

		if not Handy.is_mod_active() then
			return false
		end
		if Handy.controller.is_debugplus_console_opened() then
			return false
		end
		if not released and Handy.controller.process_bind(button, { gamepad = true }) then
			return true
		end
		if button == "back" or G.CONTROLLER.text_input_hook or not Handy.is_mod_active() then
			return false
		end
		if Handy.controller.prevent_if_debugplus(button, released) then
			return false
		end

		local finish = function(result)
			Handy.UI.state_panel.update(button, released)
			return result
		end

		-----

		if not released and Handy.presets_switch.use(button) then
			return finish(true)
		end

		if Handy.misc_controls.use(button, released) then
			return finish(true)
		end

		if not released then
			if
				Handy.speed_multiplier.use(key)
				or Handy.nopeus_interaction.use(key)
				or Handy.animation_skip.use(key)
			then
				return finish(true)
			end
		end

		if G.STAGE == G.STAGES.RUN and not G.SETTINGS.paused and not G.OVERLAY_MENU then
			if not released then
				-- (A) corresponds to vanilla card selection and dragging
				if button ~= "a" then
					Handy.insta_highlight.use_on_hovered(key)
				end
			end
			if Handy.controller.is_triggered(released) then
				local _ = false
					or Handy.insta_actions.use_alt(button)
					-- or Handy.move_highlight.use(key)
					or Handy.regular_keybinds.use(button)
					or Handy.insta_highlight_entire_f_hand.use(button)
					or Handy.deselect_hand.use(button)
			end

			Handy.dangerous_actions.toggle_queue(button, released)
			Handy.dangerous_actions.use(button, released)
		else
			if Handy.controller.is_triggered(released) then
				Handy.regular_keybinds.use(button)
			end
		end

		Handy.UI.state_panel.update(button, released)

		return false
	end,
	process_gamepad_axis = function(joystick, axis, value)
		Handy.controller.update_device_type({ gamepad = true })
		return false
	end,
	process_card_click = function(card)
		if not Handy.is_mod_active() then
			return false
		end
		if Handy.controller.is_debugplus_console_opened() then
			return false
		end
		if G.STAGE == G.STAGES.RUN and not G.SETTINGS.paused and not G.OVERLAY_MENU then
			Handy.last_clicked_card = card
			Handy.last_clicked_area = card.area
			if Handy.insta_actions.use(card) or Handy.dangerous_actions.use_click(card) then
				return true
			end
		end
		return false
	end,
	process_card_hover = function(card)
		if not Handy.is_mod_active() then
			return false
		end
		if Handy.controller.is_debugplus_console_opened() then
			return false
		end
		if G.STAGE == G.STAGES.RUN and not G.SETTINGS.paused and not G.OVERLAY_MENU then
			Handy.last_hovered_card = card
			Handy.last_hovered_area = card.area
			if Handy.insta_highlight.use(card) or Handy.dangerous_actions.use_hover(card) then
				return true
			end
		end
		return false
	end,

	process_tag_click = function(tag)
		if not Handy.is_mod_active() then
			return false
		end
		if Handy.controller.is_debugplus_console_opened() then
			return false
		end
		if G.STAGE == G.STAGES.RUN and not G.SETTINGS.paused and not G.OVERLAY_MENU then
			if Handy.dangerous_actions.use_tag_click(tag) then
				return true
			end
		end
		return false
	end,

	process_update = function(dt)
		Handy.controller.update_device_type()
		Handy.controller.update_is_console_opened()

		for mod_module_key, mod_module in pairs(Handy.modules) do
			if mod_module.update then
				mod_module.update(dt)
			end
		end

		if Handy.last_clicked_card and Handy.last_clicked_card.REMOVED then
			Handy.last_clicked_card = nil
			Handy.last_clicked_area = nil
		end

		if Handy.last_hovered_card and Handy.last_hovered_card.REMOVED then
			Handy.last_hovered_card = nil
			Handy.last_hovered_area = nil
		end

		for key, button in pairs(Handy.controller.gamepad_patched_buttons) do
			if button.node.REMOVED then
				Handy.controller.gamepad_patched_buttons[key] = nil
			end
		end

		Handy.UI.update(dt)
	end,

	on_settings_save = function()
		Handy.UI.show_options_button = not SMODS or not Handy.cc.hide_options_button.enabled
		Handy.nopeus_interaction.change(0)
		Handy.animation_skip.change(0)
		Handy.speed_multiplier.change(0)
	end,
}

local love_update_ref = love.update
function love.update(dt, ...)
	love_update_ref(dt, ...)
	Handy.controller.process_update(dt)
end

local wheel_moved_ref = love.wheelmoved or function() end
function love.wheelmoved(x, y)
	wheel_moved_ref(x, y)
	Handy.controller.process_wheel(y > 0 and 1 or 2)
end

local controller_button_press_ref = Controller.button_press
function Controller:button_press(button, ...)
	if Handy.controller.process_gamepad_button(self.GAMEPAD.object, button, false) then
		return
	end
	return controller_button_press_ref(self, button, ...)
end

local controller_button_release_ref = Controller.button_release
function Controller:button_release(button, ...)
	if Handy.controller.process_gamepad_button(self.GAMEPAD.object, button, true) then
		return
	end
	return controller_button_release_ref(self, button, ...)
end

local controller_update_axis_ref = Controller.update_axis
function Controller:update_axis(...)
	local axis_interpretation = controller_update_axis_ref(self, ...)
	if axis_interpretation == "axis_cursor" then
		Handy.controller.cancel_bind()
	end
	return axis_interpretation
end

local create_button_binding_pip_ref = create_button_binding_pip
function create_button_binding_pip(args, ...)
	if not args or not args.button then
		return {
			n = G.UIT.ROOT,
			config = { align = "cm", colour = G.C.CLEAR },
			nodes = {
				{ n = G.UIT.O, config = { object = Moveable() } },
			},
		}
	end
	return create_button_binding_pip_ref(args, ...)
end
