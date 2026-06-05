Handy.insta_actions = {
	action_blocker = false,

	get_actions = function(ctx)
		return {
			buy_n_sell = Handy.controls.is_enabled_module_keys_hold(Handy.cc.insta_actions_buy_n_sell, { ctx = ctx }),
			buy_or_sell = Handy.controls.is_enabled_module_keys_hold(Handy.cc.insta_actions_buy_or_sell, { ctx = ctx }),
			use = Handy.controls.is_enabled_module_keys_hold(Handy.cc.insta_actions_use, { ctx = ctx }),
		}
	end,
	get_target_card = function(item, ctx)
		local target_card
		if ctx.card then
			target_card = ctx.target
		elseif ctx.input then
			target_card = G.CONTROLLER.dragging.target or Handy.controller.card.get_context().hovered_current
		end
		if target_card and target_card.area and target_card.is and target_card:is(Card) then
			return target_card
		end
	end,

	can_execute = function(item, ctx, args)
		if Handy.insta_actions.action_blocker then
			return false
		end
		ctx = Handy.controls.resolve_control_context(item, ctx)
		if not ctx then
			return false
		end
		local card = Handy.insta_actions.get_target_card(item, ctx)
		if not card then
			return false
		end
		local is_preview_card = card.handy_preview_insta_actions
		local trigger_mode = Handy.cc.insta_actions_trigger_mode.value
		if
			not Handy.controls.can_execute_control(item, ctx, {
				no_keybinds = true,
				allow_not_in_run = is_preview_card,
				allow_stop_use = is_preview_card,
				allow_mod_inactive = is_preview_card,
				allow_any_context = true,
			})
		then
			return false
		end
		local is_alt_mode = Handy.controller.is_gamepad() or trigger_mode == 2
		if is_alt_mode then
			if not ctx.input then
				return false
			end
		else
			if not ctx.card or not ctx.click then
				return false
			end
		end
		return true, { card = card }
	end,
	execute = function(item, ctx, args, data)
		local target_card = data and data.card
		if not target_card then
			return false
		end
		local actions = Handy.insta_actions.get_actions(ctx and ctx.input and ctx or nil)
		item.b_actions = actions
		if Handy.insta_actions.process_card(target_card, actions) then
			ctx:prevent_default()
			if not target_card.handy_preview_insta_actions then
				Handy.insta_actions.show_notif(actions)
			end
			return true
		end
	end,

	process_card = function(card, actions)
		if not card or card.REMOVED or not card.is or not card:is(Card) then
			return false
		end
		if card.ability and card.ability.handy_dangerous_actions_used then
			return true
		end

		if card.handy_preview_insta_actions then
			-- TODO: preview for code card (maybe later)
			if actions.use then
				card:handy_preview_use()
			elseif actions.buy_or_sell then
				card:handy_preview_buy_or_sell()
			elseif actions.buy_n_sell then
				card:handy_preview_buy_n_sell()
			else
				return false
			end
			return true
		end

		if not Handy.b_is_in_run() then
			return false
		end

		if false and actions.cryptid_code_use_last_interaction then
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
				local is_code_card_used = Handy.insta_actions.can_execute_card(card, false, true)
						and Handy.insta_actions.execute_card(card, false, true)
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
				local is_buyed = Handy.insta_actions.can_execute_card(card, true, false)
						and Handy.insta_actions.execute_card(card, true, false)
					or false
				if is_buyed then
					G.E_MANAGER:add_event(Event({
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									return (
										Handy.insta_actions.can_execute_card(card, true, false)
										and Handy.insta_actions.execute_card(card, true, false)
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
			return Handy.insta_actions.can_execute_card(card, actions.buy_or_sell, actions.use)
					and Handy.insta_actions.execute_card(card, actions.buy_or_sell, actions.use)
				or false
		end
	end,

	show_notif = function(actions)
		Handy.UI.state_panel.display(function(state)
			local result = false

			if actions.use then
				state.items.insta_use = {
					text = Handy.L.dictionary("ph_handy_notif_quick_use"),
					hold = false,
					order = 10,
					level = 4,
				}
				result = true
			end
			if actions.buy_or_sell then
				state.items.quick_buy_and_sell = {
					text = Handy.L.dictionary("ph_handy_notif_quick_buy_or_sell"),
					hold = false,
					order = 11,
					level = 4,
				}
				result = true
			end
			if actions.buy_n_sell then
				state.items.quick_buy_n_sell = {
					text = Handy.L.dictionary("ph_handy_notif_quick_buy_n_sell"),
					hold = false,
					order = 12,
					level = 4,
				}
				result = true
			end
			return result
		end, nil, 4)
	end,
}

---

function Handy.insta_actions.can_execute_card(card, buy_or_sell, use, only_sell)
	return not Handy.insta_actions.action_blocker
		and card
		and card.area
		and Handy.b_is_mod_active()
		and Handy.b_is_in_run()
		and not Handy.b_is_stop_use()
		and (buy_or_sell or use)
		and card.is
		and card:is(Card)
end
function Handy.insta_actions.execute_card(card, buy_or_sell, use, only_sell)
	if card.REMOVED then
		return false
	end

	local result = {}
	local cleanup = {}
	local current_card_state = card.highlighted
	if not current_card_state then
		card:highlight(true)
	end

	local data = Handy.insta_actions.collect_card_buttons(card, result, cleanup)

	local target_button
	if use then
		target_button = Handy.insta_actions.get_use_button(card, result, data)
	elseif buy_or_sell and only_sell then
		target_button = Handy.insta_actions.get_sell_button(card, result, data)
	elseif buy_or_sell then
		target_button = Handy.insta_actions.get_buy_or_sell_button(card, result, data)
	end

	local finish = function(leave_highlight)
		for _, f in ipairs(cleanup) do
			f()
		end
		if not current_card_state and not leave_highlight then
			card:highlight(false)
		end
	end

	if target_button then
		-- TODO: playable consumeable

		local button = target_button.button
		local check = not not target_button.action
		if target_button.func then
			check, button = Handy.fake_events.check({
				func = G.FUNCS[target_button.func],
				node = target_button.element,
			})
		end
		if check and button then
			Handy.insta_actions.action_blocker = true
			Handy.fake_events.execute({
				func = G.FUNCS[button],
				node = target_button.element,
			})
			G.E_MANAGER:add_event(Event({
				no_delete = true,
				blocking = false,
				func = function()
					Handy.insta_actions.action_blocker = false
					return true
				end,
			}))
			finish()
			return true
		end
	end

	finish()
	return false
end
