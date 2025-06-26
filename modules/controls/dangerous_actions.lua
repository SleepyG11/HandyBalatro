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
	execute = function(key, card)
		if Handy.controller.is_module_key_down(Handy.cc.dangerous_actions.immediate_buy_and_sell, true) then
			if Handy.controller.is_module_key(Handy.cc.dangerous_actions.sell_all, key) then
				local options = Handy.dangerous_actions.get_options(card)
				for _, target_card in ipairs(card.area.cards) do
					Handy.dangerous_actions.process_card(target_card, true, options.remove)
				end
				Handy.dangerous_actions.sell_next_card()
				return true
			elseif Handy.controller.is_module_key(Handy.cc.dangerous_actions.sell_all_same, key) then
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

	use_click = function(card)
		return Handy.dangerous_actions.can_execute(card) and Handy.dangerous_actions.execute_click(card) or false
	end,
	use_hover = function(card)
		return Handy.dangerous_actions.can_execute(card) and Handy.dangerous_actions.execute_hover(card) or false
	end,
	use = function(key, released)
		if released or not Handy.controller.is_gamepad() then
			return false
		end
		return Handy.dangerous_actions.can_execute(Handy.last_hovered_card)
			and Handy.dangerous_actions.execute(key, Handy.last_hovered_card)
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
		if G.STAGE ~= G.STAGES.RUN or G.SETTINGS.paused or G.OVERLAY_MENU then
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
			state.items.sell_all = {
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

Handy.register_module("dangerous_actions", Handy.dangerous_actions)
