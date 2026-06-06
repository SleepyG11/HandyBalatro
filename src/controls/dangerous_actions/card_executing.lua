function Handy.dangerous_actions.is_preview_card(card)
	return not not Handy.dangerous_actions.get_preview_area() or card.handy_preview_dangerous_actions
end
function Handy.dangerous_actions.get_cards_list(card)
	return card.area.cards
end

---

function Handy.dangerous_actions.can_process_card(card, remove)
	if not card or card.REMOVED then
		return false
	end
	if card.handy_dangerous_actions_used then
		return false
	end
	return (card.ability or Handy.dangerous_actions.is_preview_card(card)) and true or false
end
function Handy.dangerous_actions.process_card(card, remove)
	card.handy_dangerous_actions_used = true
	local queue = Handy.dangerous_actions.is_preview_card(card) and "preview" or "game"
	table.insert(Handy.dangerous_actions.queues[queue], { card = card, remove = remove })
	return false
end

---

function Handy.dangerous_actions.execute_card(card, remove, all_same, all)
	local ignore_self = Handy.cc.dangerous_actions_mass_sell_remove_mode.value == 2
	local cards = Handy.dangerous_actions.get_cards_list(card)
	if all then
		for _, target_card in ipairs(cards) do
			if not ignore_self or target_card ~= card then
				Handy.dangerous_actions.process_card(target_card, remove)
			end
		end
		Handy.dangerous_actions.process_queue()
		return true
	elseif all_same then
		local target_cards = {}
		local success, card_center_key = pcall(function()
			return card.config.center.key
		end)
		if success and card_center_key then
			for _, area_card in ipairs(cards) do
				local _success, area_card_center_key = pcall(function()
					return area_card.config.center.key
				end)
				if _success and area_card_center_key == card_center_key then
					table.insert(target_cards, area_card)
				end
			end
		end

		for _, target_card in ipairs(target_cards) do
			if not ignore_self or target_card ~= card then
				Handy.dangerous_actions.process_card(target_card, remove)
			end
		end
		Handy.dangerous_actions.process_queue()
		return true
	else
		Handy.dangerous_actions.process_card(card, remove)
		return true
	end
end
