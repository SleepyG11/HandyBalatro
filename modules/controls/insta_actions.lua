Handy.insta_actions = {
	action_blocker = false,

	crawl_for_buttons = function(ui_buttons, result)
		result = result or {}
		if not ui_buttons then
			return result
		end
		local lua_wtf = {}
		lua_wtf.iterator = function(node)
			if node and node.states and node.states.visible then
				if node.config and node.config.func then
					result[node.config.func] = {
						node = node,
						action = node.config.handy_insta_action or nil,
					}
				end
				if node.children then
					for _, child_node in ipairs(node.children) do
						lua_wtf.iterator(child_node)
					end
				end
			end
		end
		lua_wtf.iterator(ui_buttons.UIRoot)
		return result
	end,

	get_actions = function()
		return {
			buy_n_sell = Handy.controller.is_module_key_down(Handy.cc.insta_buy_n_sell),
			buy_or_sell = Handy.controller.is_module_key_down(Handy.cc.insta_buy_or_sell),
			use = Handy.controller.is_module_key_down(Handy.cc.insta_use),
			cryptid_code_use_last_interaction = Handy.controller.is_module_key_down(
				Handy.cc.cryptid_code_use_last_interaction
			),
		}
	end,
	get_alt_actions = function(key)
		return {
			buy_n_sell = Handy.controller.is_module_key(Handy.cc.insta_buy_n_sell, key),
			buy_or_sell = Handy.controller.is_module_key(Handy.cc.insta_buy_or_sell, key),
			use = Handy.controller.is_module_key(Handy.cc.insta_use, key),
			cryptid_code_use_last_interaction = Handy.controller.is_module_key(
				Handy.cc.cryptid_code_use_last_interaction,
				key
			),
		}
	end,

	can_execute = function(card, buy_or_sell, use)
		return not not (
			not Handy.insta_actions.action_blocker
			and (buy_or_sell or use)
			and card
			and card.area
			and card.is
			and card:is(Card)
			and not Handy.is_stop_use()
		)
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

		local get_node = function(a)
			return a and a.node
		end

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
						is_custom_button = true
						break
					end
				end
				target_button = target_button
					or base_attach.buy_and_use
					or get_node(result_funcs.can_use_consumeable)
					or (not is_booster_pack_card and base_attach.use)
					or card.children.buy_and_use_button
				is_shop_button = target_button == card.children.buy_and_use_button
			end
		elseif buy_or_sell then
			if only_sell then
				for _, node_info in pairs(result_funcs) do
					if node_info.action == "sell" then
						target_button = node_info.node
						is_custom_button = true
						break
					end
				end
				target_button = target_button or base_attach.sell or nil
			else
				for _, node_info in pairs(result_funcs) do
					if node_info.action == "buy" or node_info.action == "sell" or node_info.action == "buy_or_sell" then
						target_button = node_info.node
						is_custom_button = true
						break
					end
				end
				target_button = target_button
					or get_node(result_funcs.can_select_crazy_card) -- Cines
					or get_node(result_funcs.can_select_alchemical) -- Alchemical cards
					or get_node(result_funcs.can_use_mupack) -- Multipacks
					or get_node(result_funcs.can_reserve_card) -- Code cards, for example
					or card.children.buy_button
					or base_attach.buy
					or base_attach.redeem
					or base_attach.sell
					or (is_booster_pack_card and base_attach.use)
			end
			is_shop_button = target_button ~= nil and target_button == card.children.buy_button
		end

		if target_button and not is_shop_button and not is_custom_button then
			for _, node_info in pairs(result_funcs) do
				if node_info.node == target_button then
					is_custom_button = true
					break
				end
			end
		end

		local target_button_UIBox
		local target_button_definition

		local cleanup = function(leave_highlight)
			base_background:remove()
			card_buttons_ui:remove()
			if not leave_highlight and not current_card_state then
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
				cleanup(is_playable_consumeable)
				return true
			end
		end

		cleanup()
		return false
	end,

	process_card = function(card, actions)
		if not card or card.REMOVED or not card.is or not card:is(Card) then
			return false
		end
		if card.ability and card.ability.handy_dangerous_actions_used then
			return true
		end

		if actions.cryptid_code_use_last_interaction then
			local cards_events_list = {
				c_cry_variable = "variable_apply_previous",
				-- c_cry_pointer = "pointer_apply_previous",
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
		if Handy.controller.is_module_key_down(Handy.cc.dangerous_actions.immediate_buy_and_sell) then
			return false
		end
		return (Handy.controller.is_gamepad() or Handy.cc.insta_actions_trigger_mode == 2)
			and Handy.insta_actions.process_card(
				G.CONTROLLER.dragging.target or Handy.last_hovered_card,
				Handy.insta_actions.get_alt_actions(key)
			)
	end,

	update_state_panel = function(state, key, released)
		if G.STAGE ~= G.STAGES.RUN or G.SETTINGS.paused or G.OVERLAY_MENU then
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

Handy.register_module("insta_actions", Handy.insta_actions)
