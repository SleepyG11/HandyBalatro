Handy.dangerous_actions = {
	sell_queue = {},
	preview_sell_queue = {},

	is_sell_disabled_in_mp = function(lobby, lobby_config)
		return (lobby_config.handy_dangerous_actions_mode or 1) <= 1
	end,
	is_remove_disabled_in_mp = function(lobby, lobby_config)
		return true
	end,

	sell_next_card_in_queue = function()
		local target = table.remove(Handy.dangerous_actions.sell_queue, 1)
		if not target then
			stop_use()
			return
		end

		if target.tag then
			local tag = target.tag
			if target.remove then
				tag.tag_sprite:stop_hover()
				tag:remove()
			end
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
		Handy.dangerous_actions.sell_next_card_in_queue()
	end,
	sell_next_card_in_preview_queue = function()
		local target = table.remove(Handy.dangerous_actions.preview_sell_queue, 1)
		if not target then
			return
		end

		if target.tag then
			local tag = target.tag
			if target.remove then
				tag.tag_sprite:stop_hover()
				tag.handy_dangerous_actions_used = nil
				tag:juice_up(0.6, 0.1)
				play_sound("generic1", 0.8 + (0.9 + 0.2 * math.random()) * 0.2, 1)
				Handy.UI.utils.attention_text({
					text = Handy.L.dictionary("k_handy_preview_remove"),
					scale = 1,
					hold = 0.2 * 1.25 - 0.2,
					background_colour = G.C.RED,
					align = "bm",
					major = tag.tag_sprite,
					offset = { x = 0, y = 0.1 },
					timer = "REAL",
					no_skip = true,
				})
			end
		elseif target.card then
			local card = target.card
			if target.remove then
				card.ability.handy_dangerous_actions_used = nil
				Handy.UI.utils.card_eval_status_text(card, "extra", nil, nil, nil, {
					message = Handy.L.dictionary("k_handy_preview_remove"),
					colour = G.C.RED,
					instant = true,
					timer = "REAL",
					no_skip = true,
					delay = 0.2,
				})
			else
				card.ability.handy_dangerous_actions_used = nil
				if not card.ability.eternal then
					Handy.UI.utils.card_eval_status_text(card, "extra", nil, nil, nil, {
						message = Handy.L.dictionary("k_handy_preview_sell"),
						colour = G.C.SECONDARY_SET.Tarot,
						instant = true,
						timer = "REAL",
						no_skip = true,
						delay = 0.2,
					})
				end
			end
		end
		Handy.dangerous_actions.sell_next_card_in_preview_queue()
	end,
	sell_next_card = function()
		if Handy.utils.alive_element(Handy.UI.data.dangerous_actions_preview_area) then
			Handy.dangerous_actions.sell_next_card_in_preview_queue()
		else
			Handy.dangerous_actions.sell_next_card_in_queue()
		end
	end,

	process_card = function(card, remove)
		if not card.ability then
			card.ability = {}
		end
		card.ability.handy_dangerous_actions_used = true
		if card.handy_preview_dangerous_actions then
			table.insert(Handy.dangerous_actions.preview_sell_queue, { card = card, remove = remove })
		else
			table.insert(Handy.dangerous_actions.sell_queue, { card = card, remove = remove })
		end
		return false
	end,
	process_tag = function(tag, remove)
		tag.handy_dangerous_actions_used = true
		if tag.handy_dangerous_actions_preview then
			table.insert(Handy.dangerous_actions.preview_sell_queue, { tag = tag, remove = remove })
		else
			table.insert(Handy.dangerous_actions.sell_queue, { tag = tag, remove = remove })
		end
		return false
	end,

	can_execute = function(remove, all_same, all, item, args)
		local ctx = Handy.controller.non_empty_context(args and args.ctx)
		if not ctx then
			return false
		end
		local is_preview = Handy.utils.alive_element(Handy.UI.data.dangerous_actions_preview_area)
		if
			not Handy.controls.can_execute_control(item, {
				allow_mod_inactive = is_preview,
				allow_no_stop_use = is_preview,
				allow_mp = is_preview,
				allow_not_in_run = is_preview,
				ctx = ctx,
				require_exact = true,
			})
		then
			return false
		end

		local is_correct_trigger
		if all_same or all then
			is_correct_trigger = ctx.click
		else
			is_correct_trigger = ctx.hover
		end

		if ctx.input then
			return ctx.release
		elseif remove and ctx.tag then
			if
				is_correct_trigger
				and ctx.target
				and (ctx.target.HUD_tag or ctx.target.handy_dangerous_actions_preview)
				and not ctx.target.handy_dangerous_actions_used
			then
				return true, { tag = ctx.target }
			end
		elseif ctx.card then
			if
				is_correct_trigger
				and ctx.target
				and not ctx.target.REMOVED
				and not (ctx.target.ability and ctx.target.ability.handy_dangerous_actions_used)
			then
				return true, { card = ctx.target }
			end
		end
		return false
	end,
	execute = function(remove, all_same, all, item, args, data)
		local ctx = Handy.controller.non_empty_context(args and args.ctx)
		if not ctx then
			return false
		end
		if ctx.input then
			if ctx.release then
				Handy.dangerous_actions.sell_next_card()
			end
		elseif ctx.card then
			ctx:prevent_default()
			return Handy.dangerous_actions.execute_card(ctx.target, remove, all_same, all)
		elseif remove and ctx.tag then
			ctx:prevent_default()
			return Handy.dangerous_actions.execute_tag(ctx.target, remove, all_same, all)
		end
	end,
	execute_card = function(card, remove, all_same, all)
		if all then
			for _, target_card in ipairs(card.area.cards) do
				Handy.dangerous_actions.process_card(target_card, remove)
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
				Handy.dangerous_actions.process_card(target_card, remove)
			end
			Handy.dangerous_actions.sell_next_card()
			return true
		else
			Handy.dangerous_actions.process_card(card, remove)
			return true
		end
	end,
	execute_tag = function(tag, remove, all_same, all)
		local tags_list = (Handy.utils.alive_element(Handy.UI.data.dangerous_actions_preview_tags) or {}).tags
			or G.GAME.tags
		if all then
			for _, target_tag in ipairs(tags_list) do
				Handy.dangerous_actions.process_tag(target_tag, true)
			end
			Handy.dangerous_actions.sell_next_card()
			return true
		elseif all_same then
			local tag_key = tag.key
			for _, target_tag in ipairs(tags_list) do
				if target_tag.key == tag_key then
					Handy.dangerous_actions.process_tag(target_tag, true)
				end
			end
			Handy.dangerous_actions.sell_next_card()
			return true
		else
			Handy.dangerous_actions.process_tag(tag, true)
			return true
		end
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
