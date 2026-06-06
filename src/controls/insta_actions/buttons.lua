function Handy.insta_actions.is_available_button_element(element)
	return element and element.states and element.states.visible and not element.REMOVED
end
function Handy.insta_actions.crawl(start_element, entry_prefix, entry_type, recursive, result)
	local iterator
	iterator = function(element)
		if Handy.insta_actions.is_available_button_element(element) then
			if element.config and (element.config.func or element.config.button) then
				local entry_key = entry_prefix .. (element.config.func or element.config.button)
				result[entry_key] = {
					key = entry_key,
					type = entry_type,
					element = element,
					func = element.config.func,
					button = element.config.button,
					action = element.config.handy_insta_action or nil,
				}
			end
			if recursive and element.children then
				for _, child_node in ipairs(element.children) do
					iterator(child_node)
				end
			end
		end
	end
	iterator(start_element)
end
function Handy.insta_actions.is_booster_pack_card(card)
	return (G.pack_cards and card.area == G.pack_cards) and not card.ability.consumeable
end

function Handy.insta_actions.crawl_for_attach_buttons(card, result, cleanup, data)
	local base_background = G.UIDEF.card_focus_ui(card)
	if not base_background then
		return
	end
	table.insert(cleanup, function()
		base_background:remove()
	end)

	local base_attach = base_background:get_UIE_by_ID("ATTACH_TO_ME")
	if not base_attach then
		return
	end

	for key, button in pairs(base_attach.children) do
		pcall(function()
			local entry_key = "attach_" .. tostring(key)
			local element = button.UIRoot.children[1]
			if Handy.insta_actions.is_available_button_element(element) then
				if element.config and (element.config.func or element.config.button) then
					result[entry_key] = {
						key = entry_key,
						type = "attach",
						element = element,
						func = element.config.func,
						button = element.config.button,
						action = element.config.handy_insta_action or nil,
					}
				end
			end
		end)
	end
	data.base_attach = base_attach
end
function Handy.insta_actions.crawl_for_use_and_sell_buttons(card, result, cleanup, data)
	local card_buttons = G.UIDEF.use_and_sell_buttons(card)
	local card_buttons_ui = UIBox({
		definition = card_buttons,
		config = {},
	})
	table.insert(cleanup, function()
		card_buttons_ui:remove()
	end)

	Handy.insta_actions.crawl(card_buttons_ui.UIRoot, "uas_", "use_and_sell", true, result)
	if Handy.insta_actions.is_available_button_element(card.children.use_button) then
		Handy.insta_actions.crawl(card.children.use_button.UIRoot, "uas_", "use_and_sell", true, result)
	end
	data.card_buttons_ui = card_buttons_ui
end
function Handy.insta_actions.crawl_for_shop_buttons(card, result, cleanup, data)
	for entry_key, button in pairs({
		["shop_buy_and_use"] = card.children.buy_and_use_button,
		["shop_buy"] = card.children.buy_button,
	}) do
		local element = button.UIRoot
		if Handy.insta_actions.is_available_button_element(element) then
			if element.config and (element.config.button or element.config.func) then
				result[entry_key] = {
					key = entry_key,
					type = "shop",
					element = element,
					func = element.config.func,
					button = element.config.button,
					action = element.config.handy_insta_action or nil,
				}
			end
		end
	end
end
function Handy.insta_actions.crawl_for_other_buttons(card, result, cleanup, data) end

function Handy.insta_actions.collect_card_buttons(card, result, cleanup)
	local data = {}
	Handy.insta_actions.crawl_for_attach_buttons(card, result, cleanup, data)
	Handy.insta_actions.crawl_for_use_and_sell_buttons(card, result, cleanup, data)
	Handy.insta_actions.crawl_for_shop_buttons(card, result, cleanup, data)
	Handy.insta_actions.crawl_for_other_buttons(card, result, cleanup, data)
	return data
end
function Handy.insta_actions.debug_collect(card)
	local result = {}
	local cleanup = {}
	local current_card_state = card.highlighted
	if not current_card_state then
		card:highlight(true)
	end
	Handy.insta_actions.collect_card_buttons(card, result, cleanup)
	if not current_card_state then
		card:highlight(false)
	end
	for key, entry in pairs(result) do
		print(key, entry.type, entry.action, entry.func, entry.button)
	end
	for _, f in ipairs(cleanup) do
		f()
	end
end

---

function Handy.insta_actions.get_use_button(card, result, data)
	-- TODO: playable consumeable

	-- Prevent cards to be selected when usage is required:
	-- Alchemical cards, Cines
	-- Is this even needed?
	if result.uas_can_select_alchemical or result.uas_can_select_crazy_card then
		return nil
	end
	for _, entry in pairs(result) do
		if entry.action == "use" then
			return entry
		end
	end
	local is_booster_pack_card = Handy.insta_actions.is_booster_pack_card(card)
	return result.attach_buy_and_use
		or result.uas_can_use_consumeable
		or (not is_booster_pack_card and result.attach_use)
		or result.shop_buy_and_use_button
		or nil

	-- if card.area == G.hand and card.ability.consumeable then
	-- 	local success, playale_consumeable_button = pcall(function()
	-- 		-- G.UIDEF.use_and_sell_buttons(G.hand.highlighted[1]).nodes[1].nodes[2].nodes[1].nodes[1]
	-- 		return card_buttons_ui.UIRoot.children[1].children[2].children[1].children[1]
	-- 	end)
	-- 	if success and playale_consumeable_button then
	-- 		target_button = playale_consumeable_button
	-- 		is_custom_button = true
	-- 		is_playable_consumeable = true
	-- 	end
	-- end
end
function Handy.insta_actions.get_sell_button(card, result, data)
	for _, entry in pairs(result) do
		if entry.action == "sell" then
			return entry
		end
	end
	return result.attach_sell or nil
end
function Handy.insta_actions.get_buy_or_sell_button(card, result, data)
	for _, entry in pairs(result) do
		if entry.action == "buy" or entry.action == "sell" or entry.action == "buy_or_sell" then
			return entry
		end
	end
	local is_booster_pack_card = Handy.insta_actions.is_booster_pack_card(card)
	return result.uas_can_select_crazy_card
		or result.uas_can_select_alchemical
		or result.uas_can_use_mupack
		or result.uas_can_reserve_card
		or result.shop_buy
		or result.attach_buy
		or result.attach_redeem
		or result.attach_sell
		or (is_booster_pack_card and result.attach_use)
		or nil
end
function Handy.insta_actions.debug_get_actions(card)
	local result = {}
	local cleanup = {}
	local current_card_state = card.highlighted
	if not current_card_state then
		card:highlight(true)
	end
	local data = Handy.insta_actions.collect_card_buttons(card, result, cleanup)
	local use_button = Handy.insta_actions.get_use_button(card, result, data)
	local sell_button = Handy.insta_actions.get_sell_button(card, result, data)
	local buy_or_sell_button = Handy.insta_actions.get_buy_or_sell_button(card, result, data)

	if not current_card_state then
		card:highlight(false)
	end

	if use_button then
		print("Use button", use_button.key)
	end
	if sell_button then
		print("Sell button", sell_button.key)
	end
	if buy_or_sell_button then
		print("Buy/Sell button", buy_or_sell_button.key)
	end

	for _, f in ipairs(cleanup) do
		f()
	end
end
