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
function Handy.insta_actions.can_buy_n_sell_card(card)
	return card.ability
		and (card.ability.set == "Joker" or card.ability.consumeable)
		and card.area
		and Handy.utils.table_contains({
			G.pack_cards,
			G.shop_jokers,
			G.shop_booster,
			G.shop_vouchers,
		}, card.area)
end
function Handy.insta_actions.execute_card(card, buy_or_sell, use, only_sell)
	if card.REMOVED then
		return false
	end

	if Handy.insta_actions.is_preview_card(card) then
		return true
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
		if target_button.playable_consumeable then
			card.area:add_to_highlighted(card)
			if not card.highlighted then
				finish()
				return false
			end
		end

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
			finish(target_button.playable_consumeable)
			return true
		end
	end

	finish()
	return false
end
function Handy.insta_actions.process_card(card, actions)
	if not card or card.REMOVED or not card.is or not card:is(Card) then
		return false
	end
	if card.handy_dangerous_actions_used then
		return true
	end

	if Handy.insta_actions.is_preview_card(card) then
		-- TODO: preview for code card (maybe later)
		if actions.buy_n_sell then
			card:handy_preview_buy_n_sell()
		elseif actions.use then
			card:handy_preview_use()
		elseif actions.buy_or_sell then
			card:handy_preview_buy_or_sell()
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
		local is_buyed = Handy.insta_actions.can_buy_n_sell_card(card)
			and Handy.insta_actions.can_execute_card(card, true, false)
			and Handy.insta_actions.execute_card(card, true, false)

		if is_buyed then
			local sell = function()
				return Handy.insta_actions.can_execute_card(card, true, false)
					and Handy.insta_actions.execute_card(card, true, false)
			end
			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							sell()
							return true
						end,
					}))
					return true
				end,
			}))
		end
		return is_buyed or false
	else
		return Handy.insta_actions.can_execute_card(card, actions.buy_or_sell, actions.use)
				and Handy.insta_actions.execute_card(card, actions.buy_or_sell, actions.use)
			or false
	end
end
