last_clicked_card = nil

local KEYS_DX = {
	left = -1,
	right = 1,
}

--

function handy_move_highlight_in_area(key)
	if not last_clicked_card then
		return
	end
	local area = last_clicked_card.area
	if not area then
		return
	end
	if area ~= G.consumeables and area ~= G.jokers and area ~= G.cine_quests then
		return
	end
	local dx = KEYS_DX[key]
	if not dx then
		return
	end
	local current_card = area.highlighted[1]
	if current_card then
		for current_index = #area.cards, 1, -1 do
			if area.cards[current_index] == current_card then
				local next_index = ((#area.cards + current_index + dx - 1) % #area.cards) + 1
				if current_index == next_index then
					return
				end
				local next_card = area.cards[next_index]

				area:remove_from_highlighted(current_card)
				area:add_to_highlighted(next_card)
				return
			end
		end
	end
end

function handy_insta_highlight_card(card)
	if not card.area then
		return false
	end
	if card.area ~= G.hand then
		return false
	end

	-- Do nothing if touchscreen is used
	-- TODO: fix it
	if next(love.touch.getTouches()) then
		return false
	end
	if not love.mouse.isDown(1) then
		return false
	end

	if not card.highlighted then
		card.area:add_to_highlighted(card)
		return false
	end
	return false
end

--

function fake_check_card_event(func, card, button, id)
	local fake_event = {
		UIBox = button,
		config = {
			ref_table = card,
			button = nil,
			id = id,
		},
	}
	func(fake_event)
	return fake_event.config.button ~= nil
end
function fake_execute_card_event(func, card, button, id)
	local fake_event = {
		UIBox = button,
		config = {
			ref_table = card,
			button = nil,
			id = id,
		},
	}
	func(fake_event)
end

function handy_insta_actions(card)
	local area = card.area
	if not area then
		return false
	end

	local is_shift_pressed = love.keyboard.isDown("lshift", "rshift")
	local is_ctrl_pressed = love.keyboard.isDown("lctrl", "rctrl")

	if not (is_shift_pressed or is_ctrl_pressed) then
		return false
	end

	local func = nil
	local button = nil
	local id = nil

	-- Shop button check

	local shop_button = nil
	if is_ctrl_pressed then
		shop_button = card.children.buy_and_use_button
	elseif is_shift_pressed then
		shop_button = card.children.buy_button
	end

	if shop_button then
		local shop_button_definition = shop_button.definition
		func = shop_button_definition.config.func
		button = shop_button_definition.config.button
		id = shop_button_definition.config.id

		if fake_check_card_event(G.FUNCS[func], card, shop_button, id) then
			fake_execute_card_event(G.FUNCS[button], card, shop_button, id)
			return true
		end

		return false
	end

	-- Sell/Use button check

	local base_background = G.UIDEF.card_focus_ui(card)
	local base_attach = base_background:get_UIE_by_ID("ATTACH_TO_ME").children

	local target_button = nil
	local is_booster_pack_card = (card.area == G.pack_cards and G.pack_cards) and not card.ability.consumeable

	if is_ctrl_pressed then
		target_button = base_attach.buy_and_use or (not is_booster_pack_card and base_attach.use)
	elseif is_shift_pressed then
		target_button = base_attach.buy
			or base_attach.redeem
			or base_attach.sell
			or (is_booster_pack_card and base_attach.use)
	end

	if target_button then
		local target_button_definition = target_button.definition.nodes[1]
		func = target_button_definition.config.func
		button = target_button_definition.config.button
		id = target_button_definition.config.id

		if fake_check_card_event(G.FUNCS[func], card, target_button, id) then
			fake_execute_card_event(G.FUNCS[button], card, target_button, id)
			base_background:remove()
			return true
		end
	end

	base_background:remove()
	return false
end
