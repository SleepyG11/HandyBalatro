if Handy then
	return
end

Handy = setmetatable({
	version = "1.5.0-pre4",

	last_clicked_area = nil,
	last_clicked_card = nil,

	last_hovered_area = nil,
	last_hovered_card = nil,

	utils = {},

	meta = {
		["1.4.1b_patched_select_blind_and_skip"] = true,
		["1.5.0_update"] = true,
	},
}, {})

--- @generic T
--- @generic S
--- @param target T
--- @param source S
--- @param ... any
--- @return T | S
function Handy.utils.table_merge(target, source, ...)
	assert(type(target) == "table", "Target is not a table")
	local tables_to_merge = { source, ... }
	if #tables_to_merge == 0 then
		return target
	end

	for k, t in ipairs(tables_to_merge) do
		assert(type(t) == "table", string.format("Expected a table as parameter %d", k))
	end

	for i = 1, #tables_to_merge do
		local from = tables_to_merge[i]
		for k, v in pairs(from) do
			if type(v) == "table" then
				target[k] = target[k] or {}
				target[k] = Handy.utils.table_merge(target[k], v)
			else
				target[k] = v
			end
		end
	end

	return target
end

function Handy.utils.table_contains(t, value)
	for i = #t, 1, -1 do
		if t[i] and t[i] == value then
			return true
		end
	end
	return false
end

function Handy.utils.serialize_string(s)
	return string.format("%q", s)
end

function Handy.utils.serialize(t, indent)
	indent = indent or ""
	local str = "{\n"
	for k, v in ipairs(t) do
		str = str .. indent .. "\t"
		if type(v) == "number" then
			str = str .. v
		elseif type(v) == "boolean" then
			str = str .. (v and "true" or "false")
		elseif type(v) == "string" then
			str = str .. Handy.utils.serialize_string(v)
		elseif type(v) == "table" then
			str = str .. Handy.utils.serialize(v, indent .. "\t")
		else
			-- not serializable
			str = str .. "nil"
		end
		str = str .. ",\n"
	end
	for k, v in pairs(t) do
		if type(k) == "string" then
			str = str .. indent .. "\t" .. "[" .. Handy.utils.serialize_string(k) .. "] = "

			if type(v) == "number" then
				str = str .. v
			elseif type(v) == "boolean" then
				str = str .. (v and "true" or "false")
			elseif type(v) == "string" then
				str = str .. Handy.utils.serialize_string(v)
			elseif type(v) == "table" then
				str = str .. Handy.utils.serialize(v, indent .. "\t")
			else
				-- not serializable
				str = str .. "nil"
			end
			str = str .. ",\n"
		end
	end
	str = str .. indent .. "}"
	return str
end

function Handy.utils.cleanup_dead_elements(ref_table, ref_key)
	local new_values = {}
	local target = ref_table[ref_key]
	if not target then
		return
	end
	for k, v in pairs(target) do
		if not v.REMOVED and not v.removed then
			new_values[#new_values + 1] = v
		end
	end
	ref_table[ref_key] = new_values
	return new_values
end

--

Handy.config = {
	default = {
		handy = {
			enabled = true,
		},

		notifications_level = 3,
		keybinds_trigger_mode = 1,
		insta_actions_trigger_mode = 1,
		current_device = 1,
		hide_in_menu = false,

		hide_options_button = {
			enabled = false,
		},

		insta_highlight = {
			enabled = true,

			key_1 = "Left Mouse",
			key_2 = "None",
			key_1_gamepad = "Left Stick",
			key_2_gamepad = "None",

			allow_deselect = {
				enabled = false,
			},
		},
		insta_highlight_entire_f_hand = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
		insta_buy_n_sell = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
		insta_buy_or_sell = {
			enabled = true,
			key_1 = "Shift",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
		insta_use = {
			enabled = true,
			key_1 = "Ctrl",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},
		move_highlight = {
			enabled = true,

			swap = {
				enabled = true,
				key_1 = "Shift",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},
			to_end = {
				enabled = true,
				key_1 = "Ctrl",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},

			dx = {
				one_left = {
					enabled = true,
					key_1 = "Left",
					key_2 = "None",
					key_1_gamepad = "None",
					key_2_gamepad = "None",
				},
				one_right = {
					enabled = true,
					key_1 = "Right",
					key_2 = "None",
					key_1_gamepad = "None",
					key_2_gamepad = "None",
				},
			},
		},

		insta_cash_out = {
			enabled = true,
			key_1 = "Enter",
			key_2 = "None",
			key_1_gamepad = "(Y)",
			key_2_gamepad = "None",
		},
		insta_booster_skip = {
			enabled = true,
			key_1 = "Enter",
			key_2 = "None",
			key_1_gamepad = "(Y)",
			key_2_gamepad = "None",
		},
		show_deck_preview = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "Left Trigger",
			key_2_gamepad = "None",
		},

		dangerous_actions = {
			enabled = false,

			-- Use it as basic modifier for all dangerous controls
			-- Maybe I should change this but idk, backwards compatibility
			immediate_buy_and_sell = {
				enabled = false,
				key_1 = "Middle Mouse",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",

				queue = {
					enabled = false,
				},
			},

			sell_all_same = {
				enabled = false,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},

			sell_all = {
				enabled = false,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},

			card_remove = {
				enabled = false,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},

			nopeus_unsafe = {
				enabled = false,
			},
		},

		speed_multiplier = {
			enabled = true,

			key_1 = "Alt",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",

			no_hold = {
				enabled = false,
			},

			multiply = {
				enabled = true,
				key_1 = "Wheel Up",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},
			divide = {
				enabled = true,
				key_1 = "Wheel Down",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},
		},

		deselect_hand = {
			enabled = true,
			key_1 = "Right Mouse",
			key_2 = "None",
			key_1_gamepad = "Right Stick",
			key_2_gamepad = "None",
		},

		regular_keybinds = {
			enabled = true,

			play = {
				enabled = true,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "(X)",
				key_2_gamepad = "None",
			},
			discard = {
				enabled = true,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "(Y)",
				key_2_gamepad = "None",
			},
			sort_by_rank = {
				enabled = true,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "Right Bumper",
				key_2_gamepad = "None",
			},
			sort_by_suit = {
				enabled = true,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "Left Bumper",
				key_2_gamepad = "None",
			},

			reroll_shop = {
				enabled = true,
				key_1 = "Q",
				key_2 = "None",
				key_1_gamepad = "(X)",
				key_2_gamepad = "None",
			},
			leave_shop = {
				enabled = true,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "(Y)",
				key_2_gamepad = "None",
			},

			skip_blind = {
				enabled = true,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "(X)",
				key_2_gamepad = "None",
			},
			select_blind = {
				enabled = true,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "(Y)",
				key_2_gamepad = "None",
			},

			run_info = {
				enabled = true,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "(Guide)",
				key_2_gamepad = "None",
			},
			run_info_blinds = {
				enabled = true,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},

			view_deck = {
				enabled = true,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "Right Trigger",
				key_2_gamepad = "None",
			},
		},

		nopeus_interaction = {
			enabled = true,

			key_1 = "]",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",

			no_hold = {
				enabled = false,
			},

			increase = {
				enabled = true,
				key_1 = "Wheel Up",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},
			decrease = {
				enabled = true,
				key_1 = "Wheel Down",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},
		},

		not_just_yet_interaction = {
			enabled = true,
			key_1 = "Enter",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},

		cryptid_code_use_last_interaction = {
			enabled = true,
			key_1 = "None",
			key_2 = "None",
			key_1_gamepad = "None",
			key_2_gamepad = "None",
		},

		presets = {
			enabled = true,

			load_1 = {
				enabled = true,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},
			load_2 = {
				enabled = true,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},
			load_3 = {
				enabled = true,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},
			load_next = {
				enabled = true,
				key_1 = "None",
				key_2 = "None",
				key_1_gamepad = "None",
				key_2_gamepad = "None",
			},
		},
	},
	current = {},

	get_module = function(module)
		if not module then
			return nil
		end
		local override = Handy.get_module_override(module)
		if override then
			return Handy.utils.table_merge({}, module, override)
		end
		return module
	end,
	save = function()
		if SMODS and SMODS.save_mod_config and Handy.current_mod then
			Handy.current_mod.config = Handy.config.current
			SMODS.save_mod_config(Handy.current_mod)
		else
			love.filesystem.createDirectory("config")
			local serialized = "return " .. Handy.utils.serialize(Handy.config.current)
			love.filesystem.write("config/Handy.jkr", serialized)
		end
	end,
	load = function()
		Handy.config.current = Handy.utils.table_merge({}, Handy.config.default)
		local lovely_mod_config = get_compressed("config/Handy.jkr")
		if lovely_mod_config then
			Handy.config.current = Handy.utils.table_merge(Handy.config.current, STR_UNPACK(lovely_mod_config))
		end
		Handy.cc = Handy.config.current
	end,
}

-- Shorthand for `Handy.config.current`
Handy.cc = Handy.config.current
Handy.config.load()

function Handy.is_mod_active()
	return Handy.cc.handy.enabled
end
function Handy.is_dangerous_actions_active()
	return Handy.cc.dangerous_actions.enabled
end
function Handy.get_module_override(module)
	return nil
end

-- Ha-ha, funny Cryptid reference

-- Resolve module with overrides
function Handy.m(module)
	return Handy.config.get_module(module)
end

--

Handy.fake_events = {
	check = function(arg)
		if type(arg.func) ~= "function" then
			return false, nil
		end
		if arg.node then
			arg.func(arg.node)
			return arg.node.config.button ~= nil, arg.node.config.button
		else
			local fake_event = {
				UIBox = arg.UIBox,
				config = arg.config or {
					ref_table = arg.card,
					button = arg.button,
					id = arg.id,
				},
			}
			arg.func(fake_event)
			return fake_event.config.button ~= nil, fake_event.config.button
		end
	end,
	execute = function(arg)
		if type(arg.func) == "function" then
			if arg.node then
				arg.func(arg.node)
			else
				arg.func({
					UIBox = arg.UIBox,
					config = arg.config or {
						ref_table = arg.card,
						button = arg.button,
						id = arg.id,
					},
				})
			end
		end
	end,
	check_button = function(selector, options)
		options = options or {}
		local success, button = pcall(selector)
		if not success or not button or not button.config or not button.states then
			return false, button and button.config and button.config.button or nil
		end
		if options.visible and not button.states.visible then
			return false, button.config.button
		end
		local check_func = button.config.func
		if (options.require_func or options.require_exact_func) and not check_func then
			return false, button.config.button
		end
		if options.require_exact_func and check_func ~= options.require_exact_func then
			return false, button.config.button
		end
		if check_func then
			return Handy.fake_events.check({
				func = G.FUNCS[check_func],
				node = button,
			})
		else
			return true, button.config.button
		end
	end,
	execute_button = function(selector)
		local success, button = pcall(selector)
		if not success or not button or not button.config then
			return
		end
		if type(button.click) == "function" then
			button:click()
		else
			if button.config.button then
				Handy.fake_events.execute({
					func = G.FUNCS[button.config.button],
					node = button,
				})
			end
		end
	end,
}
Handy.controller = {
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
		G.CONTROLLER.button_registry[registry] = G.CONTROLLER.button_registry[registry] or {}
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
			if Handy.is_mod_active() and patched_button.enabled_func() then
				Handy.controller.remove_button_from_registry(e)
				new_button = Handy.controller.resolve_first_module_key(patched_button.module)
				e.config.focus_args.button = new_button
			else
				new_button = e.handy_replaced_button
				e.config.focus_args.button = new_button
				Handy.controller.add_button_to_registry(e, e.handy_replaced_registry_menu_value)
			end
			if e.handy_previous_button ~= new_button then
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
		if e.config.focus_args and not e.handy_gamepad_override and not G.OVERLAY_MENU then
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
			elseif button == G.F_GUIDE and "guide" or "back" then
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
		if not e.config.focus_args.button then
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
		Handy.controller.rerender_after_bind = button.config.ref_table.rerender or nil

		Handy.controller.update_bind_button_text(
			"["
				.. Handy.UI.PARTS.localize_keybind(Handy.controller.bind_module[Handy.controller.bind_key] or "None")
				.. "]"
		)
	end,
	complete_bind = function(key)
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

	parse_table = {
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
	},
	resolve_table = {
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
	},

	parse_gamepad_table = {
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
	},
	resolve_gamepad_table = {
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
	},
	non_holdable = {
		["Wheel Up"] = true,
		["Wheel Down"] = true,
	},

	mouse_to_key_table = {
		[1] = "mouse1",
		[2] = "mouse2",
		[3] = "mouse3",
		[4] = "mouse4",
		[5] = "mouse5",
	},
	wheel_to_key_table = {
		[1] = "wheelup",
		[2] = "wheeldown",
	},

	mouse_buttons = {
		["Left Mouse"] = 1,
		["Right Mouse"] = 2,
		["Middle Mouse"] = 3,
		["Mouse 4"] = 4,
		["Mouse 5"] = 5,
	},
	wheel_buttons = {
		["Wheel Up"] = 1,
		["Wheel Down"] = 2,
	},

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

	process_key = function(key, released)
		Handy.controller.update_device_type({ keyboard = true })
		G.njy_keybind = nil

		-----

		if not released and Handy.controller.process_bind(key) then
			return true
		end
		if key == "escape" or G.CONTROLLER.text_input_hook or not Handy.is_mod_active() then
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

		if not released then
			local _ = Handy.speed_multiplier.use(key) or Handy.nopeus_interaction.use(key)
		end

		if G.STAGE == G.STAGES.RUN and not G.SETTINGS.paused then
			if not released then
				Handy.insta_highlight.use_on_hovered(key)
			end
			if Handy.controller.is_triggered(released) then
				Handy.insta_actions.use_alt(key)
				Handy.move_highlight.use(key)
				Handy.regular_keybinds.use(key)
				Handy.insta_highlight_entire_f_hand.use(key)
				Handy.deselect_hand.use(key)
			end

			Handy.dangerous_actions.toggle_queue(key, released)
		end

		return finish(false)
	end,
	process_mouse = function(mouse, released, touch)
		Handy.controller.update_device_type({ mouse = not touch, touch = touch })
		G.njy_keybind = nil
		local key = Handy.controller.mouse_to_key_table[mouse]

		-----

		if not released and Handy.controller.process_bind(key) then
			return true
		end
		if G.CONTROLLER.text_input_hook or not Handy.is_mod_active() then
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

		if not released then
			local _ = Handy.speed_multiplier.use(key) or Handy.nopeus_interaction.use(key)
		end

		if G.STAGE == G.STAGES.RUN and not G.SETTINGS.paused and not G.OVERLAY_MENU then
			if not released then
				Handy.insta_highlight.use_on_hovered(key)
			end
			if Handy.controller.is_triggered(released) then
				Handy.insta_actions.use_alt(key)
				Handy.move_highlight.use(key)
				Handy.regular_keybinds.use(key)
				Handy.insta_highlight_entire_f_hand.use(key)
				Handy.deselect_hand.use(key)
			end

			Handy.dangerous_actions.toggle_queue(key, released)
		end

		return finish(false)
	end,
	process_wheel = function(wheel)
		Handy.controller.update_device_type({ mouse = true })
		local key = Handy.controller.wheel_to_key_table[wheel]

		-----

		if Handy.controller.process_bind(key) then
			return true
		end
		if G.CONTROLLER.text_input_hook or not Handy.is_mod_active() then
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

		if Handy.speed_multiplier.use(key) or Handy.nopeus_interaction.use(key) then
			return finish(false)
		end

		if G.STAGE == G.STAGES.RUN and not G.SETTINGS.paused and not G.OVERLAY_MENU then
			Handy.insta_actions.use_alt(key)
			Handy.move_highlight.use(key)
			Handy.regular_keybinds.use(key)
			Handy.insta_highlight_entire_f_hand.use(key)
			Handy.deselect_hand.use(key)
		end

		return finish(false)
	end,
	process_gamepad_button = function(joystick, button, released)
		Handy.controller.update_device_type({ gamepad = true })

		-----

		if not released and Handy.controller.process_bind(button, { gamepad = true }) then
			return true
		end
		if button == "back" or G.CONTROLLER.text_input_hook or not Handy.is_mod_active() then
			return false
		end

		local finish = function(result)
			Handy.UI.state_panel.update(button, released)
			return result
		end

		-----

		if Handy.presets_switch.use(button) then
			return finish(true)
		end

		if G.STAGE == G.STAGES.RUN and not G.SETTINGS.paused then
			if Handy.controller.is_triggered(released) then
				local _ = false
					or Handy.insta_actions.use_alt(button)
					-- or Handy.move_highlight.use(key)
					or Handy.regular_keybinds.use(button)
					or Handy.insta_highlight_entire_f_hand.use(button)
					or Handy.deselect_hand.use(button)
			end

			Handy.dangerous_actions.toggle_queue(button, released)
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
		if G.STAGE == G.STAGES.RUN and not G.SETTINGS.paused and not G.OVERLAY_MENU then
			if Handy.insta_actions.use(card) or Handy.dangerous_actions.use_click(card) then
				return true
			end
			Handy.last_clicked_card = card
			Handy.last_clicked_area = card.area
		end
		return false
	end,
	process_card_hover = function(card)
		if not Handy.is_mod_active() then
			return false
		end
		if G.STAGE == G.STAGES.RUN and not G.SETTINGS.paused and not G.OVERLAY_MENU then
			if Handy.insta_highlight.use(card) or Handy.dangerous_actions.use_hover(card) then
				return true
			end
			Handy.last_hovered_card = card
			Handy.last_hovered_area = card.area
		end

		return false
	end,

	process_tag_click = function(tag)
		if not Handy.is_mod_active() then
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

		Handy.insta_highlight.update()
		Handy.insta_booster_skip.update()
		Handy.insta_cash_out.update()
		Handy.show_deck_preview.update()
		Handy.not_just_yet_interaction.update()

		for key, button in pairs(Handy.controller.gamepad_patched_buttons) do
			if button.node.REMOVED then
				Handy.controller.gamepad_patched_buttons[key] = nil
			end
		end

		Handy.UI.update(dt)
	end,
}

--

Handy.insta_cash_out = {
	is_hold = false,

	can_skip = false,
	is_skipped = false,

	can_execute = function()
		return not not (
			Handy.insta_cash_out.is_hold
			and Handy.insta_cash_out.can_skip
			and not Handy.insta_cash_out.is_skipped
			and G.round_eval
		)
	end,
	execute = function()
		Handy.insta_cash_out.is_skipped = true

		G.E_MANAGER:add_event(Event({
			trigger = "immediate",
			func = function()
				Handy.fake_events.execute({
					func = G.FUNCS.cash_out,
					id = "cash_out_button",
				})
				return true
			end,
		}))
		return true
	end,

	update = function()
		Handy.insta_cash_out.is_hold = (
			G.STAGE == G.STAGES.RUN
			and Handy.is_mod_active()
			and Handy.controller.is_module_key_down(Handy.cc.insta_cash_out)
		)
		return Handy.insta_cash_out.can_execute() and Handy.insta_cash_out.execute() or false
	end,

	update_state_panel = function(state, key, released) end,
}

Handy.insta_booster_skip = {
	is_hold = false,
	is_skipped = false,

	can_execute = function(check)
		-- if check then
		-- 	return not not (
		-- 		Handy.insta_booster_skip.is_hold
		-- 		and not Handy.insta_booster_skip.is_skipped
		-- 		and G.booster_pack
		-- 	)
		-- end
		return not not (
			Handy.insta_booster_skip.is_hold
			and not Handy.insta_booster_skip.is_skipped
			and G.booster_pack
			and Handy.fake_events.check({
				func = G.FUNCS.can_skip_booster,
			})
		)
	end,
	execute = function()
		Handy.insta_booster_skip.is_skipped = true
		G.E_MANAGER:add_event(Event({
			func = function()
				Handy.fake_events.execute({
					func = G.FUNCS.skip_booster,
				})
				return true
			end,
		}))
		return true
	end,

	update = function()
		Handy.insta_booster_skip.is_hold = (
			G.STAGE == G.STAGES.RUN
			and Handy.is_mod_active()
			and Handy.controller.is_module_key_down(Handy.cc.insta_booster_skip)
		)
		return Handy.insta_booster_skip.can_execute() and Handy.insta_booster_skip.execute() or false
	end,

	update_state_panel = function(state, key, released)
		-- if G.STAGE ~= G.STAGES.RUN then
		-- 	return false
		-- end
		-- if Handy.cc.notifications_level < 4 then
		-- 	return false
		-- end
		-- if Handy.insta_booster_skip.can_execute(true) then
		-- 	state.items.insta_booster_skip = {
		-- 		text = "Skip Booster Packs",
		-- 		hold = Handy.insta_booster_skip.is_hold,
		-- 		order = 10,
		-- 	}
		-- 	return true
		-- end
		-- return false
	end,
}

Handy.show_deck_preview = {
	is_hold = false,

	get_is_hold = function()
		if Handy.is_mod_active() and Handy.controller.is_module_enabled(Handy.cc.show_deck_preview) then
			return G.STAGE == G.STAGES.RUN and Handy.controller.is_module_key_down(Handy.cc.show_deck_preview)
		else
			return G.CONTROLLER.held_buttons.triggerleft
		end
	end,

	update = function()
		Handy.show_deck_preview.is_hold = Handy.show_deck_preview.get_is_hold()
	end,
}

--

Handy.deselect_hand = {
	should_prevent = function()
		return Handy.is_mod_active() and Handy.controller.is_module_enabled(Handy.cc.deselect_hand)
	end,

	can_execute = function(key)
		return not not (
			G.hand
			and G.hand.highlighted[1]
			-- Vanilla check
			and not ((G.play and #G.play.cards > 0) or G.CONTROLLER.locked or G.CONTROLLER.locks.frame or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))
			and Handy.is_mod_active()
			and Handy.controller.is_module_key(Handy.cc.deselect_hand, key)
		)
	end,
	execute = function()
		G.hand:unhighlight_all()
		return true
	end,

	use = function(key)
		return Handy.deselect_hand.can_execute(key) and Handy.deselect_hand.execute() or false
	end,
}

Handy.regular_keybinds = {
	shop_reroll_blocker = false,
	play_blocker = false,
	discard_blocker = false,

	shop_loaded = false,

	can_play = function(key)
		return not Handy.regular_keybinds.play_blocker
			and Handy.controller.is_module_key(Handy.cc.regular_keybinds.play, key)
			and Handy.fake_events.check_button(function()
				return G.buttons.states.visible and G.buttons:get_UIE_by_ID("play_button")
			end, { visible = true })
	end,
	play = function()
		Handy.regular_keybinds.play_blocker = true
		Handy.fake_events.execute_button(function()
			return G.buttons:get_UIE_by_ID("play_button")
		end)
		G.E_MANAGER:add_event(Event({
			no_delete = true,
			func = function()
				Handy.regular_keybinds.play_blocker = false
				return true
			end,
		}))
		return true
	end,

	can_discard = function(key)
		return not Handy.regular_keybinds.discard_blocker
			and Handy.controller.is_module_key(Handy.cc.regular_keybinds.discard, key)
			and Handy.fake_events.check_button(function()
				return G.buttons.states.visible and G.buttons:get_UIE_by_ID("discard_button")
			end, { visible = true })
	end,
	discard = function()
		Handy.regular_keybinds.discard_blocker = true
		Handy.fake_events.execute_button(function()
			return G.buttons:get_UIE_by_ID("discard_button")
		end)
		G.E_MANAGER:add_event(Event({
			no_delete = true,
			func = function()
				Handy.regular_keybinds.discard_blocker = false
				return true
			end,
		}))
		return true
	end,

	can_change_sort = function(key)
		if Handy.controller.is_module_key(Handy.cc.regular_keybinds.sort_by_rank, key) then
			return true, "rank"
		elseif Handy.controller.is_module_key(Handy.cc.regular_keybinds.sort_by_suit, key) then
			return true, "suit"
		else
			return false, nil
		end
	end,
	change_sort = function(sorter)
		if sorter == "rank" then
			Handy.fake_events.execute({
				func = G.FUNCS.sort_hand_value,
			})
			return true
		elseif sorter == "suit" then
			Handy.fake_events.execute({
				func = G.FUNCS.sort_hand_suit,
			})
			return true
		end
	end,

	on_shop_loaded = function()
		if not G.shop then
			return
		end
		Handy.regular_keybinds.shop_loaded = true
		local remove_func_ref = G.shop.remove
		function G.shop:remove(...)
			Handy.regular_keybinds.shop_loaded = false
			return remove_func_ref(self, ...)
		end
	end,
	can_reroll_shop = function(key)
		return not not (
			not Handy.regular_keybinds.shop_reroll_blocker
			and Handy.regular_keybinds.shop_loaded
			and Handy.controller.is_module_key(Handy.cc.regular_keybinds.reroll_shop, key)
			and Handy.fake_events.check_button(function()
				return G.shop:get_UIE_by_ID("next_round_button").parent.children[2]
			end, { visible = true, require_exact_func = "can_reroll" })
		)
	end,
	reroll_shop = function()
		Handy.regular_keybinds.shop_reroll_blocker = true
		Handy.fake_events.execute_button(function()
			return G.shop:get_UIE_by_ID("next_round_button").parent.children[2]
		end)
		G.E_MANAGER:add_event(Event({
			no_delete = true,
			func = function()
				Handy.regular_keybinds.shop_reroll_blocker = false
				return true
			end,
		}))
		return true
	end,

	can_leave_shop = function(key)
		return Handy.controller.is_module_key(Handy.cc.regular_keybinds.leave_shop, key)
			and Handy.regular_keybinds.shop_loaded
			and Handy.fake_events.check_button(function()
				return G.shop:get_UIE_by_ID("next_round_button")
			end, { visible = true })
	end,
	leave_shop = function()
		Handy.regular_keybinds.shop_loaded = false
		Handy.fake_events.execute_button(function()
			return G.shop:get_UIE_by_ID("next_round_button")
		end)
		return true
	end,

	can_select_blind = function(key)
		return Handy.controller.is_module_key(Handy.cc.regular_keybinds.select_blind, key)
			and G.GAME
			and G.GAME.blind_on_deck
			and G.blind_select
			and G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck]
			and Handy.fake_events.check_button(function()
				return G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID("select_blind_button")
			end)
	end,
	select_blind = function()
		Handy.fake_events.execute_button(function()
			return G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID("select_blind_button")
		end)
		return true
	end,

	can_skip_blind = function(key)
		return not not (
			Handy.controller.is_module_key(Handy.cc.regular_keybinds.skip_blind, key)
			and Handy.fake_events.check_button(function()
				local container = G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID(
					"tag_" .. G.GAME.blind_on_deck
				)
				return container.states.visible and container.children[2]
			end, { visible = true })
		)
	end,
	skip_blind = function()
		Handy.fake_events.execute_button(function()
			return G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID("tag_" .. G.GAME.blind_on_deck).children[2]
		end)
		return true
	end,

	can_open_run_info = function(key)
		if Handy.controller.is_module_key(Handy.cc.regular_keybinds.run_info, key) then
			return true, 1
		elseif Handy.controller.is_module_key(Handy.cc.regular_keybinds.run_info_blinds, key) then
			return true, 2
		end
		return false, nil
	end,
	open_run_info = function(tab_index)
		if tab_index == 2 then
			Handy.override_create_tabs_chosen_by_label = localize("b_blinds")
		end
		Handy.fake_events.execute({
			func = G.FUNCS.run_info,
		})
		Handy.override_create_tabs_chosen_by_label = nil
		return true
	end,

	can_view_deck = function(key)
		return not not (Handy.controller.is_module_key(Handy.cc.regular_keybinds.view_deck, key))
	end,
	view_deck = function()
		Handy.fake_events.execute({
			func = G.FUNCS.deck_info,
		})
		return true
	end,

	use = function(key)
		if not Handy.controller.is_module_enabled(Handy.cc.regular_keybinds) then
			return false
		end
		if not G.SETTINGS.paused and G.STAGE == G.STAGES.RUN then
			local can_open_info, info_tab_index = Handy.regular_keybinds.can_open_run_info(key)
			if can_open_info then
				return Handy.regular_keybinds.open_run_info(info_tab_index)
			elseif Handy.regular_keybinds.can_view_deck(key) then
				return Handy.regular_keybinds.view_deck()
			elseif G.STATE == G.STATES.SELECTING_HAND then
				local need_sort, sorter = Handy.regular_keybinds.can_change_sort(key)
				if need_sort then
					return Handy.regular_keybinds.change_sort(sorter)
				elseif Handy.regular_keybinds.can_discard(key) then
					return Handy.regular_keybinds.discard()
				elseif Handy.regular_keybinds.can_play(key) then
					return Handy.regular_keybinds.play()
				end
				return false
			elseif G.STATE == G.STATES.SHOP then
				if Handy.regular_keybinds.can_reroll_shop(key) then
					return Handy.regular_keybinds.reroll_shop()
				elseif Handy.regular_keybinds.can_leave_shop(key) then
					return Handy.regular_keybinds.leave_shop()
				end
				return false
			elseif G.STATE == G.STATES.BLIND_SELECT then
				if Handy.regular_keybinds.can_skip_blind(key) then
					return Handy.regular_keybinds.skip_blind()
				elseif Handy.regular_keybinds.can_select_blind(key) then
					return Handy.regular_keybinds.select_blind()
				end
				return false
			end
		end
		return false
	end,
}

--

Handy.insta_highlight = {
	first_card_highlighted = nil,

	can_execute = function(card)
		return G.STATE ~= G.STATES.HAND_PLAYED
			and card
			and card.area == G.hand
			and not G.CONTROLLER.dragging.target
			and Handy.controller.is_module_key_down(Handy.cc.insta_highlight)
	end,
	execute = function(card)
		if Handy.insta_highlight.first_card_highlighted == nil then
			Handy.insta_highlight.first_card_highlighted = card.highlighted
				and Handy.controller.is_module_enabled(Handy.cc.insta_highlight.allow_deselect)
		end
		G.E_MANAGER:add_event(Event({
			trigger = "immediate",
			blocking = false,
			blockable = false,
			no_delete = true,
			func = function()
				if
					not G.CONTROLLER.dragging.target
					and (not not card.highlighted == not not Handy.insta_highlight.first_card_highlighted)
				then
					card:click()
				end
				return true
			end,
		}))
		return false
	end,

	use = function(card)
		return Handy.insta_highlight.can_execute(card) and Handy.insta_highlight.execute(card) or false
	end,

	use_on_hovered = function(key)
		if key == "mouse1" then
			return false
		end
		G.E_MANAGER:add_event(Event({
			type = "immediate",
			func = function()
				Handy.insta_highlight.use(G.CONTROLLER.hovering.target)
				return true
			end,
		}))
		return false
	end,

	update = function()
		if not Handy.controller.is_module_key_down(Handy.cc.insta_highlight, true) then
			Handy.insta_highlight.first_card_highlighted = nil
		end
	end,

	update_state_panel = function(state, key, released) end,
}

Handy.insta_highlight_entire_f_hand = {
	can_execute = function(key)
		return G.hand and Handy.controller.is_module_key(Handy.cc.insta_highlight_entire_f_hand, key)
	end,
	execute = function(key)
		G.hand:unhighlight_all()
		local cards_count = math.min(G.hand.config.highlighted_limit, #G.hand.cards)
		for i = 1, cards_count do
			local card = G.hand.cards[i]
			G.hand.cards[i]:highlight(true)
			G.hand.highlighted[#G.hand.highlighted + 1] = card
		end
		if G.STATE == G.STATES.SELECTING_HAND then
			G.hand:parse_highlighted()
		end
		return false
	end,

	use = function(key)
		return Handy.insta_highlight_entire_f_hand.can_execute(key) and Handy.insta_highlight_entire_f_hand.execute(key)
			or false
	end,
}

Handy.insta_actions = {
	action_blocker = false,

	crawl_for_buttons = function(ui_buttons, result)
		if not ui_buttons then
			return
		end
		local lua_wtf = {}
		lua_wtf.iterator = function(parent_node)
			if not parent_node or not parent_node.children then
				return
			end
			for _, node in ipairs(parent_node.children) do
				if node.config and node.config.func then
					result[node.config.func] = {
						node = node,
						action = node.config.handy_insta_action or nil,
					}
				end
				lua_wtf.iterator(node)
			end
		end
		lua_wtf.iterator(ui_buttons.UIRoot)
		return result
	end,

	get_actions = function()
		return {
			buy_n_sell = Handy.controller.is_module_key_down(Handy.cc.insta_buy_n_sell),
			buy_or_sell = not Handy.controller.is_gamepad()
				and Handy.controller.is_module_key_down(Handy.cc.insta_buy_or_sell),
			use = not Handy.controller.is_gamepad() and Handy.controller.is_module_key_down(Handy.cc.insta_use),
			cryptid_code_use_last_interaction = Handy.controller.is_module_key_down(
				Handy.cc.cryptid_code_use_last_interaction
			),
		}
	end,
	get_alt_actions = function(key)
		return {
			buy_n_sell = Handy.controller.is_module_key(Handy.cc.insta_buy_n_sell, key),
			buy_or_sell = not Handy.controller.is_gamepad()
				and Handy.controller.is_module_key(Handy.cc.insta_buy_or_sell, key),
			use = not Handy.controller.is_gamepad() and Handy.controller.is_module_key(Handy.cc.insta_use, key),
			cryptid_code_use_last_interaction = Handy.controller.is_module_key(
				Handy.cc.cryptid_code_use_last_interaction,
				key
			),
		}
	end,

	can_execute = function(card, buy_or_sell, use)
		return not not (not Handy.insta_actions.action_blocker and (buy_or_sell or use) and card and card.area)
	end,
	execute = function(card, buy_or_sell, use, only_sell)
		if card.REMOVED then
			return false
		end

		local target_button = nil
		local is_shop_button = false
		local is_custom_button = false
		local is_playable_consumeable = false

		local current_card_state = card.highlighted
		if not current_card_state then
			card:highlight(true)
		end
		local base_background = G.UIDEF.card_focus_ui(card)
		local base_attach = base_background:get_UIE_by_ID("ATTACH_TO_ME").children
		local card_buttons = G.UIDEF.use_and_sell_buttons(card)
		local card_buttons_ui = UIBox({
			definition = card_buttons,
			config = {},
		})

		local result_funcs = {}
		Handy.insta_actions.crawl_for_buttons(card_buttons_ui, result_funcs)
		Handy.insta_actions.crawl_for_buttons(card.children.use_button, result_funcs)
		local is_booster_pack_card = (G.pack_cards and card.area == G.pack_cards) and not card.ability.consumeable

		if use then
			if card.area == G.hand and card.ability.consumeable then
				local success, playale_consumeable_button = pcall(function()
					-- G.UIDEF.use_and_sell_buttons(G.hand.highlighted[1]).nodes[1].nodes[2].nodes[1].nodes[1]
					return card_buttons_ui.UIRoot.children[1].children[2].children[1].children[1]
				end)
				if success and playale_consumeable_button then
					target_button = playale_consumeable_button
					is_custom_button = true
					is_playable_consumeable = true
				end
			elseif result_funcs.can_select_alchemical or result_funcs.can_select_crazy_card then
				-- Prevent cards to be selected when usage is required:
				-- Alchemical cards, Cines
			else
				for _, node_info in pairs(result_funcs) do
					if node_info.action == "use" then
						target_button = node_info.node
						break
					end
				end
				target_button = target_button
					or base_attach.buy_and_use
					or (not is_booster_pack_card and base_attach.use)
					or card.children.buy_and_use_button
				is_shop_button = target_button == card.children.buy_and_use_button
			end
		elseif buy_or_sell then
			if only_sell then
				for _, node_info in pairs(result_funcs) do
					if node_info.action == "sell" then
						target_button = node_info.node
						break
					end
				end
				target_button = target_button or base_attach.sell or nil
			else
				for _, node_info in pairs(result_funcs) do
					if node_info.action == "buy" or node_info.action == "sell" or node_info.action == "buy_or_sell" then
						target_button = node_info.node
						break
					end
				end
				target_button = target_button
					or result_funcs.can_select_crazy_card -- Cines
					or result_funcs.can_select_alchemical -- Alchemical cards
					or result_funcs.can_use_mupack -- Multipacks
					or result_funcs.can_reserve_card -- Code cards, for example
					or card.children.buy_button
					or base_attach.buy
					or base_attach.redeem
					or base_attach.sell
					or (is_booster_pack_card and base_attach.use)
			end
			is_shop_button = target_button ~= nil and target_button == card.children.buy_button
		end

		if target_button and not is_shop_button then
			for _, node_info in pairs(result_funcs) do
				if node_info.node == target_button then
					is_custom_button = true
					break
				end
			end
		end

		local target_button_UIBox
		local target_button_definition

		local cleanup = function()
			base_background:remove()
			card_buttons_ui:remove()
			if not current_card_state then
				card:highlight(false)
			end
		end

		if target_button then
			if is_playable_consumeable then
				card.area:add_to_highlighted(card)
				if not card.highlighted then
					cleanup()
					return false
				end
			end

			target_button_UIBox = target_button
			target_button_definition = (is_custom_button and target_button)
				or (is_shop_button and target_button.definition)
				or target_button.definition.nodes[1]

			local check, button = Handy.fake_events.check({
				func = G.FUNCS[target_button_definition.config.func],
				node = is_custom_button and target_button or nil,
				UIBox = target_button_UIBox,
				config = target_button_definition.config,
			})
			if check then
				Handy.insta_actions.action_blocker = true
				if Handy.last_clicked_card == card then
					Handy.last_clicked_card = nil
					Handy.last_clicked_area = nil
				end
				if Handy.last_hovered_card == card then
					Handy.last_hovered_card = nil
					Handy.last_hovered_area = nil
				end
				Handy.fake_events.execute({
					func = G.FUNCS[button or target_button_definition.config.button],
					node = is_custom_button and target_button or nil,
					UIBox = target_button_UIBox,
					config = target_button_definition.config,
				})
				G.E_MANAGER:add_event(Event({
					no_delete = true,
					func = function()
						Handy.insta_actions.action_blocker = false
						return true
					end,
				}))
				cleanup()
				return true
			end
		end

		cleanup()
		return false
	end,

	process_card = function(card, actions)
		if not card or card.REMOVED then
			return false
		end
		if card.ability and card.ability.handy_dangerous_actions_used then
			return true
		end

		if actions.cryptid_code_use_last_interaction then
			local cards_events_list = {
				c_cry_variable = "variable_apply_previous",
				c_cry_pointer = "pointer_apply_previous",
				c_cry_class = "class_apply_previous",
				c_cry_exploit = "exploit_apply_previous",
			}
			local success, card_center = pcall(function()
				return card.config.center.key
			end)
			if success and card_center and cards_events_list[card_center] then
				local is_code_card_used = Handy.insta_actions.can_execute(card, false, true)
						and Handy.insta_actions.execute(card, false, true)
					or false
				if is_code_card_used then
					Handy.fake_events.execute({
						func = G.FUNCS[cards_events_list[card_center]],
					})
					return true
				end
			end
			return false
		elseif actions.buy_n_sell then
			if
				Handy.utils.table_contains({
					G.pack_cards,
					G.shop_jokers,
					G.shop_booster,
					G.shop_vouchers,
				}, card.area)
				and card.ability
				and (card.ability.set == "Joker" or card.ability.consumeable)
			then
				local is_buyed = Handy.insta_actions.can_execute(card, true, false)
						and Handy.insta_actions.execute(card, true, false)
					or false
				if is_buyed then
					G.E_MANAGER:add_event(Event({
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									return (
										Handy.insta_actions.can_execute(card, true, false)
										and Handy.insta_actions.execute(card, true, false)
									) or true
								end,
							}))
							return true
						end,
					}))
				end
				return is_buyed
			end
			return false
		else
			return Handy.insta_actions.can_execute(card, actions.buy_or_sell, actions.use)
					and Handy.insta_actions.execute(card, actions.buy_or_sell, actions.use)
				or false
		end
	end,

	use = function(card)
		return (not Handy.controller.is_gamepad() and Handy.cc.insta_actions_trigger_mode == 1)
			and Handy.insta_actions.process_card(card, Handy.insta_actions.get_actions())
	end,
	use_alt = function(key)
		return (Handy.controller.is_gamepad() or Handy.cc.insta_actions_trigger_mode == 2)
			and Handy.insta_actions.process_card(Handy.last_hovered_card, Handy.insta_actions.get_alt_actions(key))
	end,

	update_state_panel = function(state, key, released)
		if G.STAGE ~= G.STAGES.RUN or G.SETTINGS.paused then
			return false
		end
		if Handy.cc.notifications_level < 4 then
			return false
		end
		local result = false
		local is_alt_action = Handy.cc.insta_actions_trigger_mode == 2
		if is_alt_action and not Handy.controller.is_triggered(released) then
			return false
		end
		local actions = is_alt_action and Handy.insta_actions.get_alt_actions(key) or Handy.insta_actions.get_actions()
		if actions.use then
			state.items.insta_use = {
				text = localize("ph_handy_notif_quick_use"),
				hold = not is_alt_action,
				order = 10,
			}
			result = true
		end
		if actions.buy_or_sell then
			state.items.quick_buy_and_sell = {
				text = localize("ph_handy_notif_quick_buy_or_sell"),
				hold = not is_alt_action,
				order = 11,
			}
			result = true
		end
		if actions.buy_n_sell then
			state.items.quick_buy_n_sell = {
				text = localize("ph_handy_notif_quick_buy_n_sell"),
				hold = not is_alt_action,
				order = 12,
			}
			result = true
		end
		return result
	end,
}

Handy.move_highlight = {
	dx = {
		one_left = -1,
		one_right = 1,
	},

	get_dx = function(key, area)
		for module_key, module in pairs(Handy.cc.move_highlight.dx) do
			if Handy.controller.is_module_key(module, key) then
				return Handy.move_highlight.dx[module_key]
			end
		end
		return nil
	end,
	get_actions = function(key, area)
		return {
			swap = Handy.controller.is_module_key_down(Handy.cc.move_highlight.swap),
			to_end = Handy.controller.is_module_key_down(Handy.cc.move_highlight.to_end),
		}
	end,

	can_swap = function(key, area)
		if not area then
			return false
		end
		return not Handy.utils.table_contains({
			G.pack_cards,
			G.shop_jokers,
			G.shop_booster,
			G.shop_vouchers,
		}, area)
	end,
	cen_execute = function(key, area)
		return not not (
			Handy.controller.is_module_enabled(Handy.cc.move_highlight)
			and not Handy.controller.is_gamepad()
			and area
			and area.highlighted
			and area.highlighted[1]
			and Handy.utils.table_contains({
				G.consumeables,
				G.jokers,
				G.cine_quests,
				G.pack_cards,
				G.shop_jokers,
				G.shop_booster,
				G.shop_vouchers,
			}, area)
		)
	end,
	execute = function(key, area)
		local dx = Handy.move_highlight.get_dx(key, area)
		if not dx then
			return false
		end

		local current_card = area.highlighted[1]
		for current_index = #area.cards, 1, -1 do
			if area.cards[current_index] == current_card then
				local actions = Handy.move_highlight.get_actions(key, area)
				local next_index = actions.to_end and (dx > 0 and #area.cards or 1)
					or ((#area.cards + current_index + dx - 1) % #area.cards) + 1
				if current_index == next_index then
					return
				end
				local next_card = area.cards[next_index]
				if not next_card then
					return
				end
				if actions.swap and Handy.move_highlight.can_swap(key, area) then
					if actions.to_end or next_index == 1 or next_index == #area.cards then
						table.remove(area.cards, current_index)
						table.insert(area.cards, next_index, current_card)
					else
						area.cards[next_index] = current_card
						area.cards[current_index] = next_card
					end
				else
					area:remove_from_highlighted(current_card)
					area:add_to_highlighted(next_card)
				end
				return
			end
		end
	end,

	use = function(key, area)
		area = area or Handy.last_clicked_area
		return Handy.move_highlight.cen_execute(key, area) and Handy.move_highlight.execute(key, area) or false
	end,

	update_state_panel = function(state, key, released) end,
}

Handy.dangerous_actions = {
	sell_queue = {},

	sell_next_card = function()
		local target = table.remove(Handy.dangerous_actions.sell_queue, 1)
		if not target then
			stop_use()
			return
		end

		local card = target.card
		if target.remove then
			card:stop_hover()
			card:remove()
		else
			G.GAME.STOP_USE = 0
			Handy.insta_actions.execute(card, true, false, true)

			G.E_MANAGER:add_event(Event({
				blocking = false,
				func = function()
					if card.ability then
						card.ability.handy_dangerous_actions_used = nil
					end
					return true
				end,
			}))
		end
		if Handy.last_clicked_card == card then
			Handy.last_clicked_card = nil
			Handy.last_clicked_area = nil
		end
		if Handy.last_hovered_card == card then
			Handy.last_hovered_card = nil
			Handy.last_hovered_area = nil
		end
		Handy.dangerous_actions.sell_next_card()
	end,

	get_options = function(card)
		return {
			use_queue = Handy.controller.is_gamepad()
				or Handy.controller.is_module_enabled(Handy.cc.dangerous_actions.immediate_buy_and_sell.queue),
			remove = Handy.controller.is_module_key_down(Handy.cc.dangerous_actions.card_remove)
				and (card.area == G.jokers or card.area == G.consumeables),
		}
	end,

	process_card = function(card, use_queue, remove)
		if use_queue then
			if not card.ability then
				card.ability = {}
			end
			card.ability.handy_dangerous_actions_used = true

			table.insert(Handy.dangerous_actions.sell_queue, { card = card, remove = remove })
			Handy.UI.state_panel.update(nil, nil)
			return false
		elseif remove then
			card:stop_hover()
			card:remove()
			return true
		else
			local result = Handy.insta_actions.execute(card, true, false)
			if result then
				if not card.ability then
					card.ability = {}
				end
				card.ability.handy_dangerous_actions_used = true

				G.CONTROLLER.locks.selling_card = nil
				G.CONTROLLER.locks.use = nil
				G.GAME.STOP_USE = 0

				G.E_MANAGER:add_event(Event({
					no_delete = true,
					func = function()
						if card.ability then
							card.ability.handy_dangerous_actions_used = nil
						end
						return true
					end,
				}))
			end
			return result
		end
	end,

	can_execute = function(card)
		return Handy.is_dangerous_actions_active()
			and card
			and not (card.ability and card.ability.handy_dangerous_actions_used)
	end,
	execute_click = function(card)
		if Handy.controller.is_module_key_down(Handy.cc.dangerous_actions.immediate_buy_and_sell, true) then
			if Handy.controller.is_module_key_down(Handy.cc.dangerous_actions.sell_all) then
				local options = Handy.dangerous_actions.get_options(card)
				for _, target_card in ipairs(card.area.cards) do
					Handy.dangerous_actions.process_card(target_card, true, options.remove)
				end
				Handy.dangerous_actions.sell_next_card()
				return true
			elseif Handy.controller.is_module_key_down(Handy.cc.dangerous_actions.sell_all_same) then
				local target_cards = {}
				local success, card_center_key = pcall(function()
					return card.config.center.key
				end)
				if success and card_center_key then
					for _, area_card in ipairs(card.area.cards) do
						local _success, area_card_center_key = pcall(function()
							return area_card.config.center.key
						end)
						if _success and area_card_center_key == card_center_key then
							table.insert(target_cards, area_card)
						end
					end
				end

				local options = Handy.dangerous_actions.get_options(card)
				for _, target_card in ipairs(target_cards) do
					Handy.dangerous_actions.process_card(target_card, true, options.remove)
				end
				Handy.dangerous_actions.sell_next_card()
				return true
			end
		end
		return false
	end,
	execute_hover = function(card)
		if not Handy.controller.is_module_key_down(Handy.cc.dangerous_actions.immediate_buy_and_sell) then
			return false
		end
		if not Handy.insta_actions.get_actions().buy_or_sell then
			return false
		end
		local options = Handy.dangerous_actions.get_options(card)
		return Handy.dangerous_actions.process_card(card, options.use_queue, options.remove)
	end,

	use_click = function(card)
		return Handy.dangerous_actions.can_execute(card) and Handy.dangerous_actions.execute_click(card) or false
	end,
	use_hover = function(card)
		return Handy.dangerous_actions.can_execute(card) and Handy.dangerous_actions.execute_hover(card) or false
	end,

	can_execute_tag = function(tag)
		return Handy.is_dangerous_actions_active() and tag
	end,
	execute_tag_click = function(tag)
		if Handy.controller.is_module_key_down(Handy.cc.dangerous_actions.card_remove) then
			local target_tags = {}
			for _, target_tag in ipairs(G.GAME.tags) do
				table.insert(target_tags, target_tag)
			end
			if Handy.controller.is_module_key_down(Handy.cc.dangerous_actions.sell_all) then
				for _, target_tag in ipairs(target_tags) do
					target_tag:remove()
				end
				return true
			elseif Handy.controller.is_module_key_down(Handy.cc.dangerous_actions.sell_all_same) then
				local tag_key = tag.key
				for _, target_tag in ipairs(target_tags) do
					if target_tag.key == tag_key then
						target_tag:remove()
					end
				end
				return true
			end
		end
		return false
	end,
	use_tag_click = function(tag)
		return Handy.dangerous_actions.can_execute_tag(tag) and Handy.dangerous_actions.execute_tag_click(tag) or false
	end,

	toggle_queue = function(key, released)
		if Handy.controller.is_module_key(Handy.cc.dangerous_actions.immediate_buy_and_sell, key) then
			if released then
				Handy.dangerous_actions.sell_next_card()
			else
				Handy.dangerous_actions.sell_queue = {}
			end
		end
	end,

	update_state_panel = function(state, key, released)
		if G.STAGE ~= G.STAGES.RUN or G.SETTINGS.paused then
			return false
		end
		if Handy.cc.notifications_level < 2 then
			return false
		end

		local is_sell = Handy.controller.is_module_key_down(Handy.cc.dangerous_actions.immediate_buy_and_sell, true)
		if not is_sell then
			return false
		end

		if not Handy.controller.is_module_enabled(Handy.cc.dangerous_actions) then
			state.items.prevented_dangerous_actions = {
				text = localize("ph_handy_notif_unsafe_disabled"),
				hold = true,
				order = 99999999,
			}
			return true
		elseif not Handy.is_dangerous_actions_active() then
			state.items.prevented_dangerous_actions = {
				text = localize("ph_handy_notif_unsafe_disabled_by_other_mod"),
				hold = true,
				order = 99999999,
			}
			return true
		end

		local is_insta_sell = Handy.insta_actions.get_actions().buy_or_sell
			and Handy.controller.is_module_key_down(Handy.cc.dangerous_actions.immediate_buy_and_sell)
		local is_all = Handy.controller.is_module_key_down(Handy.cc.dangerous_actions.sell_all)
		local is_all_same = Handy.controller.is_module_key_down(Handy.cc.dangerous_actions.sell_all_same)
		local is_remove = Handy.controller.is_module_key_down(Handy.cc.dangerous_actions.card_remove)

		state.dangerous = true
		state.items.dangerous_hint = {
			text = localize("ph_handy_notif_unsafe"),
			dangerous = true,
			hold = true,
			order = 99999999,
		}

		if is_insta_sell then
			local text = localize(is_remove and "ph_handy_notif_insta_remove" or "ph_handy_notif_insta_sell")
			if Handy.controller.is_module_enabled(Handy.cc.dangerous_actions.immediate_buy_and_sell.queue) then
				text = text
					.. " "
					.. localize({
						type = "variable",
						key = "Handy_items_in_queue",
						vars = { #Handy.dangerous_actions.sell_queue },
					})
			end
			state.items.quick_buy_and_sell = {
				text = text,
				hold = true,
				order = 11,
				dangerous = true,
			}
		elseif is_all then
			local text = localize(is_remove and "ph_handy_notif_remove_all" or "ph_handy_notif_sell_all")
			state.items.sell_all_same = {
				text = text,
				hold = true,
				order = 12,
				dangerous = true,
			}
		elseif is_all_same then
			local text = localize(is_remove and "ph_handy_notif_remove_all_same" or "ph_handy_notif_sell_all_same")
			state.items.sell_all_same = {
				text = text,
				hold = true,
				order = 12,
				dangerous = true,
			}
		end
		return true
	end,
}

Handy.speed_multiplier = {
	value = 1,

	throttle = false,

	get_value = function()
		if not Handy.is_mod_active() or not Handy.controller.is_module_enabled(Handy.cc.speed_multiplier) then
			return 1
		end
		return math.min(Handy.speed_multiplier.value, Handy.speed_multiplier.throttle and 4 or math.huge)
	end,

	get_actions = function(key)
		return {
			multiply = Handy.controller.is_module_key(Handy.cc.speed_multiplier.multiply, key),
			divide = Handy.controller.is_module_key(Handy.cc.speed_multiplier.divide, key),
		}
	end,
	can_execute = function(key)
		return Handy.controller.is_module_enabled(Handy.cc.speed_multiplier)
			and (
				Handy.controller.is_module_enabled(Handy.cc.speed_multiplier.no_hold)
				or Handy.controller.is_module_key_down(Handy.cc.speed_multiplier)
			)
	end,

	execute = function(key)
		local actions = Handy.speed_multiplier.get_actions(key)
		if actions.multiply then
			Handy.speed_multiplier.multiply()
			return not Handy.controller.is_module_enabled(Handy.cc.speed_multiplier.no_hold)
		end
		if actions.divide then
			Handy.speed_multiplier.divide()
			return not Handy.controller.is_module_enabled(Handy.cc.speed_multiplier.no_hold)
		end
		return false
	end,

	multiply = function()
		Handy.speed_multiplier.value = math.min(512, Handy.speed_multiplier.value * 2)
	end,
	divide = function()
		Handy.speed_multiplier.value = math.max(0.001953125, Handy.speed_multiplier.value / 2)
	end,

	use = function(key)
		return Handy.speed_multiplier.can_execute(key) and Handy.speed_multiplier.execute(key) or false
	end,

	update_state_panel = function(state, key, released)
		if not key or not Handy.speed_multiplier.can_execute(key) then
			return false
		end
		if Handy.cc.notifications_level < 3 then
			return false
		end

		local actions = Handy.speed_multiplier.get_actions(key)

		if actions.multiply or actions.divide then
			state.items.change_speed_multiplier = {
				text = localize({
					type = "variable",
					key = "Handy_gamespeed_multiplier",
					vars = {
						Handy.speed_multiplier.value >= 1 and Handy.speed_multiplier.value
							or ("1/" .. (1 / Handy.speed_multiplier.value)),
					},
				}),
				hold = false,
				order = 5,
			}
			return true
		end
		return false
	end,
}

--

Handy.nopeus_interaction = {
	is_present = function()
		return type(Nopeus) == "table"
	end,

	get_actions = function(key)
		return {
			increase = Handy.controller.is_module_key(Handy.cc.nopeus_interaction.increase, key),
			decrease = Handy.controller.is_module_key(Handy.cc.nopeus_interaction.decrease, key),
		}
	end,

	can_dangerous = function()
		return not not (
			Handy.is_mod_active()
			and Handy.is_dangerous_actions_active()
			and Handy.controller.is_module_enabled(Handy.cc.dangerous_actions.nopeus_unsafe)
		)
	end,
	can_execute = function(key)
		return not not (
			Handy.nopeus_interaction.is_present()
			and Handy.controller.is_module_enabled(Handy.cc.nopeus_interaction)
			and (
				Handy.controller.is_module_enabled(Handy.cc.nopeus_interaction.no_hold)
				or Handy.controller.is_module_key_down(Handy.cc.nopeus_interaction)
			)
		)
	end,
	execute = function(key)
		local actions = Handy.nopeus_interaction.get_actions(key)
		if actions.increase then
			Handy.nopeus_interaction.increase()
			return not Handy.controller.is_module_enabled(Handy.cc.nopeus_interaction.no_hold)
		end
		if actions.decrease then
			Handy.nopeus_interaction.decrease()
			return not Handy.controller.is_module_enabled(Handy.cc.nopeus_interaction.no_hold)
		end
		return false
	end,

	change = function(dx)
		if not Handy.nopeus_interaction.is_present() then
			G.SETTINGS.FASTFORWARD = 0
		else
			local increment = Nopeus.Optimised and 1 or 0
			if G.SETTINGS.FASTFORWARD == (3 + increment) and dx > 0 then
				-- It's already unsafe, so leave it as it is
			else
				G.SETTINGS.FASTFORWARD = math.min(
					(Handy.nopeus_interaction.can_dangerous() and 3 or 2) + increment,
					math.max(0, (G.SETTINGS.FASTFORWARD or 0) + dx)
				)
			end
		end
	end,
	increase = function()
		Handy.nopeus_interaction.change(1)
	end,
	decrease = function()
		Handy.nopeus_interaction.change(-1)
	end,

	use = function(key)
		return Handy.nopeus_interaction.can_execute(key) and Handy.nopeus_interaction.execute(key) or false
	end,

	update_state_panel = function(state, key, released)
		if not Handy.nopeus_interaction.is_present() then
			return false
		end
		if not key or not Handy.nopeus_interaction.can_execute(key) then
			return false
		end

		local actions = Handy.nopeus_interaction.get_actions(key)

		if actions.increase or actions.decrease then
			local states = {
				Nopeus.Off,
				Nopeus.Planets,
				Nopeus.On,
				Nopeus.Unsafe,
			}
			if Nopeus.Optimised then
				states = {
					Nopeus.Off,
					Nopeus.Planets,
					Nopeus.On,
					Nopeus.Optimised,
					Nopeus.Unsafe,
				}
			end

			local is_dangerous = G.SETTINGS.FASTFORWARD == (#states - 1)

			if is_dangerous then
				if Handy.cc.notifications_level < 2 then
					return false
				end
				state.dangerous = true
			else
				if Handy.cc.notifications_level < 3 then
					return false
				end
			end

			state.items.change_nopeus_fastforward = {
				text = localize({
					type = "variable",
					key = "Handy_nopeus_fastforward",
					vars = { states[(G.SETTINGS.FASTFORWARD or 0) + 1] },
				}),
				hold = false,
				order = 4,
				dangerous = is_dangerous,
			}
			if
				not Handy.nopeus_interaction.can_dangerous()
				and actions.increase
				and G.SETTINGS.FASTFORWARD == (#states - 2)
			then
				state.items.prevent_nopeus_unsafe = {
					text = localize("ph_handy_notif_nopeus_unsafe_disabled"),
					hold = false,
					order = 4.05,
				}
			end
			return true
		end
		return false
	end,
}

Handy.not_just_yet_interaction = {
	is_present = function()
		return G and G.FUNCS and G.FUNCS.njy_endround ~= nil
	end,

	can_execute = function(check)
		return not not (
			Handy.not_just_yet_interaction.is_present()
			and GLOBAL_njy_vanilla_override
			and G.STATE_COMPLETE
			and G.buttons
			and G.buttons.states
			and G.buttons.states.visible
			and G.GAME
			and G.GAME.chips
			and G.GAME.blind
			and G.GAME.blind.chips
			and to_big(G.GAME.chips) >= to_big(G.GAME.blind.chips)
		)
	end,
	execute = function()
		stop_use()
		G.STATE = G.STATES.NEW_ROUND
		end_round()
	end,

	update = function()
		GLOBAL_njy_vanilla_override = (
			G.STAGE == G.STAGES.RUN
			and Handy.is_mod_active()
			and Handy.controller.is_module_key_down(Handy.cc.not_just_yet_interaction)
		)
		return Handy.not_just_yet_interaction.can_execute() and Handy.not_just_yet_interaction.execute() or false
	end,
}

--

--

Handy.UI = {
	show_options_button = true,
	counter = 1,
	C = {
		TEXT = HEX("FFFFFF"),
		BLACK = HEX("000000"),
		RED = HEX("FF0000"),

		DYN_BASE_APLHA = {
			CONTAINER = 0.7,

			TEXT = 1,
			TEXT_DANGEROUS = 1,
		},

		DYN = {
			CONTAINER = HEX("000000"),

			TEXT = HEX("FFFFFF"),
			TEXT_DANGEROUS = HEX("FFEEEE"),
		},
	},
	LOC_COLOURS = {
		handy_secondary = HEX("BBBBBB"),
	},
	state_panel = {
		element = nil,

		title = nil,
		items = nil,

		previous_state = {
			dangerous = false,
			title = {},
			items = {},
			sub_items = {},
			hold = false,
		},
		current_state = {
			dangerous = false,
			title = {},
			items = {},
			sub_items = {},
			hold = false,
		},

		get_definition = function()
			local state_panel = Handy.UI.state_panel

			local items_raw = {}
			for _, item in pairs(state_panel.current_state.items) do
				table.insert(items_raw, item)
			end

			table.sort(items_raw, function(a, b)
				return a.order < b.order
			end)

			local items = {}
			for _, item in ipairs(items_raw) do
				table.insert(items, {
					n = G.UIT.R,
					config = {
						align = "cm",
						padding = 0.035,
					},
					nodes = {
						{
							n = G.UIT.T,
							config = {
								text = item.text,
								scale = 0.225,
								colour = item.dangerous and Handy.UI.C.DYN.TEXT_DANGEROUS or Handy.UI.C.DYN.TEXT,
								shadow = true,
							},
						},
					},
				})
			end

			return {
				n = G.UIT.ROOT,
				config = { align = "cm", padding = 0.1, r = 0.1, colour = G.C.CLEAR, id = "handy_state_panel" },
				nodes = {
					{
						n = G.UIT.C,
						config = {
							align = "cm",
							padding = 0.125,
							r = 0.1,
							colour = Handy.UI.C.DYN.CONTAINER,
						},
						nodes = {
							{
								n = G.UIT.R,
								config = {
									align = "cm",
								},
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = state_panel.current_state.title.text,
											scale = 0.3,
											colour = Handy.UI.C.DYN.TEXT,
											shadow = true,
											id = "handy_state_title",
										},
									},
								},
							},
							{
								n = G.UIT.R,
								config = {
									align = "cm",
								},
								nodes = {
									{
										n = G.UIT.C,
										config = {
											align = "cm",
											id = "handy_state_items",
										},
										nodes = items,
									},
								},
							},
						},
					},
				},
			}
		end,
		emplace = function()
			-- Need to remake it at some point
			-- Like come on, create new panel every frame?
			if Handy.UI.state_panel.element then
				Handy.UI.state_panel.element:remove()
			end
			local element = UIBox({
				definition = Handy.UI.state_panel.get_definition(),
				config = {
					instance_type = "ALERT",
					align = "cm",
					major = G.ROOM_ATTACH,
					can_collide = false,
					offset = {
						x = 0,
						y = 3.5,
					},
				},
			})
			Handy.UI.state_panel.element = element
			Handy.UI.state_panel.title = element:get_UIE_by_ID("handy_state_title")
			Handy.UI.state_panel.items = element:get_UIE_by_ID("handy_state_items")
		end,

		render = function()
			local state_panel = Handy.UI.state_panel
			local state = state_panel.current_state

			if not state.title.text then
				if state.dangerous then
					state.title.text = localize("b_handy_notif_dangerous")
				else
					state.title.text = localize("b_handy_notif_quick")
				end
			end

			for _, item in pairs(state.items) do
				if item.hold then
					state.hold = true
				end
			end

			local color = Handy.UI.C.DYN.CONTAINER
			local target_color = state.dangerous and Handy.UI.C.RED or Handy.UI.C.BLACK
			color[1] = target_color[1]
			color[2] = target_color[2]
			color[3] = target_color[3]

			Handy.UI.counter = 0

			state_panel.emplace()
		end,

		update = function(key, released)
			local state_panel = Handy.UI.state_panel

			local state = {
				dangerous = false,
				title = {},
				items = {},
				sub_items = {},
			}

			local is_changed = false

			for _, part in ipairs({
				Handy.presets_switch,
				Handy.speed_multiplier,
				Handy.insta_booster_skip,
				Handy.insta_cash_out,
				Handy.insta_actions,
				Handy.insta_highlight,
				Handy.move_highlight,
				Handy.nopeus_interaction,
				Handy.dangerous_actions,
			}) do
				local temp_result = part.update_state_panel(state, key, released)
				is_changed = is_changed or temp_result or false
			end

			if is_changed then
				state_panel.previous_state = state_panel.current_state
				state_panel.current_state = state

				state_panel.render()
			else
				state_panel.current_state.hold = false
			end
		end,

		display = function(state_func, override)
			local state_panel = Handy.UI.state_panel

			local should_replace_state = override or not state_panel.current_state.hold
			local state_to_apply = should_replace_state
					and {
						dangerous = false,
						title = {},
						items = {},
						sub_items = {},
					}
				or state_panel.current_state
			local is_changed = state_func(state_to_apply)
			if is_changed then
				if should_replace_state then
					state_panel.previous_state = state_panel.current_state
					state_panel.current_state = state_to_apply
				end
				state_panel.render()
			end
		end,
	},

	update = function(dt)
		if Handy.UI.state_panel.current_state.hold then
			Handy.UI.counter = 0
		elseif Handy.UI.counter < 1 then
			Handy.UI.counter = Handy.UI.counter + dt
		end
		local multiplier = math.min(1, math.max(0, (1 - Handy.UI.counter) * 2))
		for key, color in pairs(Handy.UI.C.DYN) do
			color[4] = (Handy.UI.C.DYN_BASE_APLHA[key] or 1) * multiplier
		end
	end,
}

function Handy.UI.init()
	Handy.UI.counter = 1
	Handy.UI.state_panel.emplace()
	Handy.UI.update(0)
end

--

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

local init_localization_ref = init_localization
function init_localization(...)
	if not G.localization.__handy_injected then
		local en_loc = require("handy/localization/en-us")
		Handy.utils.table_merge(G.localization, en_loc)
		if G.SETTINGS.language ~= "en-us" then
			local success, current_loc = pcall(function()
				return require("handy/localization/" .. G.SETTINGS.language)
			end)
			if success and current_loc then
				Handy.utils.table_merge(G.localization, current_loc)
			end
		end
		G.localization.__handy_injected = true
	end
	return init_localization_ref(...)
end

local loc_colour_ref = loc_colour
function loc_colour(_c, _default, ...)
	return Handy.UI.LOC_COLOURS[_c] or loc_colour_ref(_c, _default, ...)
end

local card_open_ref = Card.open
function Card:open(...)
	local result = card_open_ref(self, ...)
	if self.ability.set == "Booster" then
		Handy.speed_multiplier.throttle = true
		G.E_MANAGER:add_event(Event({
			func = function()
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 1.5 * math.sqrt(G.SETTINGS.GAMESPEED),
					no_delete = true,
					func = function()
						Handy.speed_multiplier.throttle = false
						return true
					end,
				}))
				return true
			end,
		}))
	end
	return result
end

--

function Handy.emplace_steamodded()
	if Handy.current_mod then
		return
	end
	Handy.current_mod = (Handy_Preload and Handy_Preload.current_mod) or SMODS.current_mod
	Handy.current_mod.config_tab = true
	Handy.UI.show_options_button = not Handy.cc.hide_options_button.enabled

	Handy.current_mod.extra_tabs = function()
		return Handy.UI.get_options_tabs()
	end

	G.E_MANAGER:add_event(Event({
		func = function()
			G.njy_keybind = nil
			return true
		end,
	}))

	if Handy_Preload then
		Handy_Preload = nil
	end
end

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

if Handy_Preload then
	Handy.emplace_steamodded()
end
