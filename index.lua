Handy = setmetatable({
	last_clicked_area = nil,
	last_clicked_card = nil,

	utils = {},
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
			if type(k) == "number" then
				table.insert(target, v)
			elseif type(k) == "string" then
				if type(v) == "table" then
					target[k] = target[k] or {}
					target[k] = Handy.utils.table_merge(target[k], v)
				else
					target[k] = v
				end
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

--

Handy.config = {
	default = {
		insta_highlight = {
			enabled = true,
		},
		insta_buy_or_sell = {
			enabled = true,
			key_1 = "Shift",
			key_2 = nil,
		},
		insta_use = {
			enabled = true,
			key_1 = "Ctrl",
			key_2 = nil,
		},
		move_highlight = {
			enabled = true,

			swap = {
				enabled = true,
				key_1 = "Shift",
				key_2 = nil,
			},
			to_end = {
				enabled = true,
				key_1 = "Ctrl",
				key_2 = nil,
			},

			dx = {
				one_left = {
					enabled = true,
					key_1 = "Left",
					key_2 = nil,
				},
				one_right = {
					enabled = true,
					key_1 = "Right",
					key_2 = nil,
				},
			},
		},

		insta_cash_out = {
			enabled = true,
			key_1 = "Enter",
			key_2 = nil,
		},

		dangerous_actions = {
			enabled = true,

			immediate_buy_and_sell = {
				enabled = true,
				key_1 = "Wheel Mouse Button",
				key_2 = nil,
			},
		},
	},
	current = {},
}
Handy.config.current = Handy.utils.table_merge({}, Handy.config.default)

--

Handy.fake_events = {
	check = function(arg)
		local fake_event = {
			UIBox = arg.UIBox,
			config = {
				ref_table = arg.card,
				button = arg.button,
				id = arg.id,
			},
		}
		arg.func(fake_event)
		return fake_event.config.button ~= nil
	end,
	execute = function(arg)
		arg.func({
			UIBox = arg.UIBox,
			config = {
				ref_table = arg.card,
				button = arg.button,
				id = arg.id,
			},
		})
	end,
}
Handy.controller = {
	parse = function(raw_key)
		if not raw_key then
			return nil
		end
		if raw_key == "lshift" or raw_key == "rshift" then
			return "Shift"
		elseif raw_key == "lctrl" or raw_key == "rctrl" then
			return "Ctrl"
		elseif raw_key == "lalt" or raw_key == "ralt" then
			return "Alt"
		elseif raw_key == "lgui" or raw_key == "rgui" then
			return "GUI"
		elseif raw_key == "return" or raw_key == "kpenter" then
			return "Enter"
		elseif string.sub(raw_key, 1, 2) == "kp" then
			return "NUM " .. string.sub(raw_key, 3)
		elseif raw_key == "pageup" then
			return "Page Up"
		elseif raw_key == "pagedown" then
			return "Page Down"
		elseif raw_key == "numlock" then
			return "Num Lock"
		elseif raw_key == "capslock" then
			return "Caps Lock"
		elseif raw_key == "scrolllock" then
			return "Scroll Lock"
		else
			return string.upper(string.sub(raw_key, 1, 1)) .. string.sub(raw_key, 2)
		end
	end,
	resolve = function(parsed_key)
		if not parsed_key then
			return nil
		end
		if parsed_key == "Shift" then
			return "lshift", "rshift"
		elseif parsed_key == "Ctrl" then
			return "lctrl", "rctrl"
		elseif parsed_key == "Alt" then
			return "lalt", "ralt"
		elseif parsed_key == "GUI" then
			return "lgui", "rgui"
		elseif parsed_key == "Enter" then
			return "return", "kpenter"
		elseif string.sub(parsed_key, 1, 4) == "NUM " then
			return "kp" .. string.sub(parsed_key, 5)
		else
			local str = string.gsub(string.lower(parsed_key), "%s+", "")
			return str
		end
	end,
	is_down = function(...)
		local parsed_keys = { ... }
		for i = 1, #parsed_keys do
			local parsed_key = parsed_keys[i]
			if parsed_key then
				local skip = false
				for j, key in ipairs({
					"Left Mouse Button",
					"Right Mouse Button",
					"Wheel Mouse Button",
					"Mouse 4",
					"Mouse 5",
				}) do
					if parsed_key == key then
						skip = true
						if love.mouse.isDown(j) then
							return true
						end
					end
				end
				if not skip and love.keyboard.isDown(Handy.controller.resolve(parsed_key)) then
					return true
				end
			end
		end
		return false
	end,
	is = function(raw_key, ...)
		if not raw_key then
			return false
		end
		local parsed_keys = { ... }
		for i = 1, #parsed_keys do
			local parsed_key = parsed_keys[i]
			if parsed_key then
				local resolved_key_1, resolved_key_2 = Handy.controller.resolve(parsed_key)
				if raw_key and (raw_key == resolved_key_1 or raw_key == resolved_key_2) then
					return true
				end
			end
		end
		return false
	end,

	is_module_key_down = function(module)
		return module and module.enabled and Handy.controller.is_down(module.key_1, module.key_2)
	end,
	is_module_key = function(module, raw_key)
		return module and module.enabled and Handy.controller.is(raw_key, module.key_1, module.key_2)
	end,
}

--

Handy.insta_cash_out = {
	is_skipped = false,
	is_button_created = false,
	dollars = nil,

	can_execute = function(key)
		return not not (
			not Handy.insta_cash_out.is_skipped
			and Handy.insta_cash_out.dollars
			and not G.SETTINGS.paused
			and G.round_eval
			and Handy.controller.is_module_key(Handy.config.current.insta_cash_out, key)
		)
	end,
	execute = function(key)
		Handy.insta_cash_out.is_skipped = true

		if Handy.insta_cash_out.is_button_created then
			G.GAME.current_round.dollars = Handy.insta_cash_out.dollars
			Handy.insta_cash_out.dollars = nil
		end
		G.E_MANAGER:add_event(Event({
			trigger = "immediate",
			func = function()
				G.FUNCS.cash_out({
					config = {
						id = "cash_out_button",
					},
				})
				G.E_MANAGER:add_event(Event({
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								Handy.insta_cash_out.is_skipped = false
								return true
							end,
						}))
						return true
					end,
				}))
				return true
			end,
		}))
		return true
	end,

	use = function(key)
		return Handy.insta_cash_out.can_execute(key) and Handy.insta_cash_out.execute(key) or false
	end,
}

Handy.insta_highlight = {
	can_execute = function(card)
		return Handy.config.current.insta_highlight.enabled
			and card
			and card.area == G.hand
			-- TODO: fix it
			and not next(love.touch.getTouches())
			and love.mouse.isDown(1)
			and not card.highlighted
	end,
	execute = function(card)
		card.area:add_to_highlighted(card)
		return false
	end,

	use = function(card)
		return Handy.insta_highlight.can_execute(card) and Handy.insta_highlight.execute(card) or false
	end,
}

Handy.insta_actions = {
	get_actions = function()
		return {
			buy_or_sell = Handy.controller.is_module_key_down(Handy.config.current.insta_buy_or_sell),
			use = Handy.controller.is_module_key_down(Handy.config.current.insta_use),
		}
	end,
	can_execute = function(card, buy_or_sell, use)
		return not not ((buy_or_sell or use) and card and card.area)
	end,
	execute = function(card, buy_or_sell, use)
		local target_button = nil
		local is_shop_button = false

		local base_background = G.UIDEF.card_focus_ui(card)
		local base_attach = base_background:get_UIE_by_ID("ATTACH_TO_ME").children
		local is_booster_pack_card = (G.pack_cards and card.area == G.pack_cards) and not card.ability.consumeable

		if use then
			target_button = base_attach.buy_and_use
				or (not is_booster_pack_card and base_attach.use)
				or card.children.buy_and_use_button
			is_shop_button = target_button == card.children.buy_and_use_button
		elseif buy_or_sell then
			target_button = card.children.buy_button
				or base_attach.buy
				or base_attach.redeem
				or base_attach.sell
				or (is_booster_pack_card and base_attach.use)
			is_shop_button = target_button == card.children.buy_button
		end

		if target_button then
			local target_button_definition = is_shop_button and target_button.definition
				or target_button.definition.nodes[1]

			local result_data = {
				func = target_button_definition.config.func,
				button = target_button_definition.config.button,
				id = target_button_definition.config.id,
				card = card,
				UIBox = target_button,
			}

			if
				Handy.fake_events.check({
					func = G.FUNCS[target_button_definition.config.func],
					button = nil,
					id = target_button_definition.config.id,
					card = card,
					UIBox = target_button,
				})
			then
				Handy.fake_events.execute({
					func = G.FUNCS[target_button_definition.config.button],
					button = nil,
					id = target_button_definition.config.id,
					card = card,
					UIBox = target_button,
				})
				base_background:remove()
				return true
			end
		end

		base_background:remove()
		return false
	end,

	use = function(card)
		if card.ability and card.ability.handy_dangerous_actions_used then
			return true
		end

		local actions = Handy.insta_actions.get_actions()

		return Handy.insta_actions.can_execute(card, actions.buy_or_sell, actions.use)
				and Handy.insta_actions.execute(card, actions.buy_or_sell, actions.use)
			or false
	end,
}

Handy.move_highlight = {
	dx = {
		one_left = -1,
		one_right = 1,
	},

	get_dx = function(key, area)
		for module_key, module in pairs(Handy.config.current.move_highlight.dx) do
			if Handy.controller.is_module_key(module, key) then
				return Handy.move_highlight.dx[module_key]
			end
		end
		return nil
	end,
	get_actions = function(key, area)
		return {
			swap = Handy.controller.is_module_key_down(Handy.config.default.move_highlight.swap),
			to_end = Handy.controller.is_module_key_down(Handy.config.default.move_highlight.to_end),
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
		if not (area and area.highlighted and area.highlighted[1]) then
			return false
		end
		return Handy.utils.table_contains({
			G.consumeables,
			G.jokers,
			G.cine_quests,
			G.pack_cards,
			G.shop_jokers,
			G.shop_booster,
			G.shop_vouchers,
		}, area)
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
					area.cards[next_index] = current_card
					area.cards[current_index] = next_card
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
}

Handy.dangerous_actions = {
	can_execute = function(card)
		return Handy.config.default.dangerous_actions.enabled
			and card
			and not (card.ability and card.ability.handy_dangerous_actions_used)
	end,
	execute = function(card)
		if Handy.controller.is_module_key_down(Handy.config.current.dangerous_actions.immediate_buy_and_sell) then
			local result = Handy.insta_actions.use(card)
			if result then
				G.CONTROLLER.locks.selling_card = nil
				G.CONTROLLER.locks.use = nil
				G.GAME.STOP_USE = 0

				if not card.ability then
					card.ability = {}
				end
				card.ability.handy_dangerous_actions_used = true
				G.E_MANAGER:add_event(Event({
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
		return false
	end,

	use = function(card)
		return Handy.dangerous_actions.can_execute(card) and Handy.dangerous_actions.execute(card) or false
	end,
}

--

function Handy.emplace_steamodded()
	Handy.current_mod = SMODS.current_mod
	Handy.config.current = Handy.utils.table_merge({}, Handy.config.current, SMODS.current_mod.config)
end
