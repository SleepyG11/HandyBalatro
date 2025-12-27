Handy.dangerous_actions = {
	sell_queue = {},

	sell_next_card = function()
		local target = table.remove(Handy.dangerous_actions.sell_queue, 1)
		if not target then
			stop_use()
			return
		end

		if target.tag then
			local tag = target.tag
			tag:stop_hover()
			tag:remove()
		elseif target.card then
			local card = target.card
			if target.remove then
				card:stop_hover()
				card:remove()
			else
				G.GAME.STOP_USE = 0
				Handy.insta_actions.execute_card(card, true, false, true)

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
		end

		Handy.dangerous_actions.sell_next_card()
	end,

	process_card = function(card, use_queue, remove)
		if use_queue then
			if not card.ability then
				card.ability = {}
			end
			card.ability.handy_dangerous_actions_used = true

			table.insert(Handy.dangerous_actions.sell_queue, { card = card, remove = remove })
			-- Handy.UI.state_panel.update(nil, nil)
			return false
		elseif remove then
			card.ability.handy_dangerous_actions_used = true
			card:stop_hover()
			card:remove()
			return true
		else
			local result = Handy.insta_actions.execute_card(card, true, false)
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
					blocking = false,
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
	process_tag = function(tag, use_queue, remove)
		if use_queue then
			tag.handy_dangerous_actions_used = true
			table.insert(Handy.dangerous_actions.sell_queue, { tag = tag, remove = remove })
			-- Handy.UI.state_panel.update(nil, nil)
			return false
		else
			tag.handy_dangerous_actions_used = true
			tag:stop_hover()
			tag:remove()
			return true
		end
	end,

	can_execute = function(item, context)
		if not Handy.controls.default_can_execute(item, context) then
			return false
		end
		if context.input_context then
			return true
		elseif context.tag_context then
			return context.tag and not context.tag.handy_dangerous_actions_used
		elseif context.card_context then
			return context.card and not (context.card.ability and context.card.ability.handy_dangerous_actions_used)
		else
			return true
		end
	end,
	execute_card = function(card, remove, all_same, all)
		Handy.controller.prevent_default()
		if all then
			for _, target_card in ipairs(card.area.cards) do
				Handy.dangerous_actions.process_card(target_card, true, remove)
			end
			Handy.dangerous_actions.sell_next_card()
			return true
		elseif all_same then
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

			for _, target_card in ipairs(target_cards) do
				Handy.dangerous_actions.process_card(target_card, true, remove)
			end
			Handy.dangerous_actions.sell_next_card()
			return true
		else
			Handy.dangerous_actions.process_card(card, true, remove)
			return true
		end
	end,
	execute_tag = function(tag, remove, all_same, all)
		Handy.controller.prevent_default()
		if all then
			for _, target_tag in ipairs(G.GAME.tags) do
				Handy.dangerous_actions.process_tag(target_tag, true, true)
			end
			Handy.dangerous_actions.sell_next_card()
			return true
		elseif all_same then
			local tag_key = tag.key
			for _, target_tag in ipairs(G.GAME.tags) do
				if target_tag.key == tag_key then
					Handy.dangerous_actions.process_tag(target_tag, true, true)
				end
			end
			Handy.dangerous_actions.sell_next_card()
			return true
		else
			Handy.dangerous_actions.process_tag(tag, true, true)
			return true
		end
	end,

	use = function(key, released)
		if released or not Handy.controller.is_gamepad() then
			return false
		end
		return Handy.dangerous_actions.can_execute(Handy.last_hovered_card)
			and Handy.dangerous_actions.execute(key, Handy.last_hovered_card)
	end,

	show_notif = function(item, state, context, executed, key)
		if executed then
			local text = Handy.L.dictionary(key)
			text = text .. " " .. Handy.L.variable("Handy_items_in_queue", { #Handy.dangerous_actions.sell_queue })
			state.items[item.key] = {
				text = text,
				hold = not context.released,
				order = 11,
				dangerous = true,
			}
			return true
		end
	end,
}

local items = {
	"dangerous_actions_sell_one",
	"dangerous_actions_remove_one",
	"dangerous_actions_sell_all_same",
	"dangerous_actions_remove_all_same",
	"dangerous_actions_sell_all",
	"dangerous_actions_remove_all",
}

Handy.e_mitter.on("update_state_panel", function(context)
	Handy.UI.state_panel.display(function(state)
		local holded = nil
		if Handy.b_is_mod_active() and Handy.b_is_in_run() then
			for _, item_key in ipairs(items) do
				local item = Handy.controls.dictionary[item_key]
				if Handy.controls.is_module_keys_activated(item:get_module(), false, context, nil, true, true) then
					holded = item
					break
				end
			end
		end
		if holded then
			if not Handy.cc.dangerous_actions.enabled then
				state.items.prevented_dangerous_actions = {
					text = Handy.L.dictionary("ph_handy_notif_unsafe_disabled"),
					hold = false,
					order = 99999999,
				}
				return true
			elseif not Handy.b_is_dangerous_actions_active() then
				state.items.prevented_dangerous_actions = {
					text = Handy.L.dictionary("ph_handy_notif_unsafe_disabled_by_other_mod"),
					hold = false,
					order = 99999999,
				}
				return true
			else
				local text = Handy.L.dictionary("ph_handy_" .. holded.key)
				text = text .. " " .. Handy.L.variable("Handy_items_in_queue", { #Handy.dangerous_actions.sell_queue })
				state.items.dangerous_actions = {
					text = text,
					hold = true,
					order = 11,
					dangerous = true,
					level = 2,
				}
				state.items.dangerous_hint = {
					text = Handy.L.dictionary("ph_handy_notif_unsafe"),
					dangerous = true,
					hold = true,
					order = 99999999,
					level = 2,
				}
				return true
			end
		elseif state.items.dangerous_actions and state.items.dangerous_actions.hold then
			state.items.dangerous_actions.hold = false
			state.items.dangerous_hint.hold = false
			return true
		end
	end, nil, 2)
end)

-- One-by-one
Handy.controls.register("dangerous_actions_sell_one", {
	get_module = function()
		return Handy.cc.dangerous_actions_sell_one
	end,

	context_triggers = {
		input = true,
		card = {
			hover = true,
		},
	},

	require_exact_keys = true,

	dangerous = true,
	in_run = true,
	no_stop_use = true,

	can_execute = Handy.dangerous_actions.can_execute,
	execute = function(self, context)
		if context.input_context then
			if context.released then
				Handy.dangerous_actions.sell_next_card()
			end
		elseif context.card_context then
			return Handy.dangerous_actions.execute_card(context.card, false)
		end
	end,
})
Handy.controls.register("dangerous_actions_remove_one", {
	get_module = function()
		return Handy.cc.dangerous_actions_remove_one
	end,

	context_triggers = {
		input = true,
		card = {
			hover = true,
		},
		tag = {
			hover = true,
		},
	},

	require_exact_keys = true,

	dangerous = true,
	in_run = true,
	no_stop_use = true,

	can_execute = Handy.dangerous_actions.can_execute,
	execute = function(self, context)
		if context.input_context then
			if not context.released then
				Handy.dangerous_actions.sell_next_card()
			end
		elseif context.tag_context then
			return Handy.dangerous_actions.execute_tag(context.tag, true)
		elseif context.card_context then
			return Handy.dangerous_actions.execute_card(context.card, true)
		end
	end,
})

-- All same
Handy.controls.register("dangerous_actions_sell_all_same", {
	get_module = function()
		return Handy.cc.dangerous_actions_sell_all_same
	end,

	context_triggers = {
		input = true,
		card = {
			click = true,
		},
	},

	require_exact_keys = true,

	dangerous = true,
	in_run = true,
	no_stop_use = true,

	can_execute = Handy.dangerous_actions.can_execute,
	execute = function(self, context)
		if context.card_context then
			return Handy.dangerous_actions.execute_card(context.card, false, true)
		end
	end,
})
Handy.controls.register("dangerous_actions_remove_all_same", {
	get_module = function()
		return Handy.cc.dangerous_actions_remove_all_same
	end,

	context_triggers = {
		input = true,
		card = {
			click = true,
		},
		tag = {
			click = true,
		},
	},

	require_exact_keys = true,

	dangerous = true,
	in_run = true,
	no_stop_use = true,

	can_execute = Handy.dangerous_actions.can_execute,
	execute = function(self, context)
		if context.tag_context then
			return Handy.dangerous_actions.execute_tag(context.tag, true, true)
		elseif context.card_context then
			return Handy.dangerous_actions.execute_card(context.card, true, true)
		end
	end,
})

-- All
Handy.controls.register("dangerous_actions_sell_all", {
	get_module = function()
		return Handy.cc.dangerous_actions_sell_all
	end,

	context_triggers = {
		input = true,
		card = {
			click = true,
		},
	},

	require_exact_keys = true,

	dangerous = true,
	in_run = true,
	no_stop_use = true,

	can_execute = Handy.dangerous_actions.can_execute,
	execute = function(self, context)
		if context.card_context then
			return Handy.dangerous_actions.execute_card(context.card, false, false, true)
		end
	end,
})
Handy.controls.register("dangerous_actions_remove_all", {
	get_module = function()
		return Handy.cc.dangerous_actions_remove_all
	end,

	context_triggers = {
		input = true,
		card = {
			click = true,
		},
		tag = {
			click = true,
		},
	},

	require_exact_keys = true,

	dangerous = true,
	in_run = true,
	no_stop_use = true,

	can_execute = Handy.dangerous_actions.can_execute,
	execute = function(self, context)
		if context.tag_context then
			return Handy.dangerous_actions.execute_tag(context.tag, true, false, true)
		elseif context.card_context then
			return Handy.dangerous_actions.execute_card(context.card, true, false, true)
		end
	end,
})
