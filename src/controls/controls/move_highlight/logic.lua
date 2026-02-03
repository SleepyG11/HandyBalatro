Handy.move_highlight = {
	dx = {
		one_left = -1,
		one_right = 1,
	},

	get_actions = function()
		local dx
		local is_hold, hold_duration = Handy.controls.is_module_keys_hold(Handy.cc.move_highlight_dx_one_left)
		if is_hold then
			dx = Handy.move_highlight.dx.one_left
		else
			is_hold, hold_duration = Handy.controls.is_module_keys_hold(Handy.cc.move_highlight_dx_one_right)
			if is_hold then
				dx = Handy.move_highlight.dx.one_right
			else
				return {}
			end
		end

		return {
			dx = dx,
			hold_duration = hold_duration,
			swap = Handy.controls.is_module_enabled(Handy.cc.move_highlight_swap)
				and Handy.controls.is_module_keys_hold(Handy.cc.move_highlight_swap),
			to_end = Handy.controls.is_module_enabled(Handy.cc.move_highlight_to_end)
				and Handy.controls.is_module_keys_hold(Handy.cc.move_highlight_to_end),
		}
	end,
	can_swap = function(area)
		if not area then
			return false
		end
		if area.handy_allow_move_highlight then
			return not (area.handy_prevent_move_highlight_swap or area.config.handy_prevent_move_highlight_swap)
		end
		return not Handy.utils.table_contains({
			G.pack_cards,
			G.shop_jokers,
			G.shop_booster,
			G.shop_vouchers,
		}, area)
	end,
	get_area = function()
		if Handy.utils.alive_element(Handy.UI.data.move_highlight_preview_area) then
			return Handy.UI.data.move_highlight_preview_area, true
		end
		local card_context = Handy.controller.card.get_context()
		local area = (card_context.clicked_current or card_context.clicked_previous or {}).area
		if
			area
			and area.highlighted
			and area.highlighted[1]
			and (
				(area.handy_allow_move_highlight or area.config.handy_allow_move_highlight)
				or Handy.utils.table_contains({
					G.consumeables,
					G.jokers,
					G.cine_quests,
					G.pack_cards,
					G.shop_jokers,
					G.shop_booster,
					G.shop_vouchers,
				}, area)
			)
		then
			return area, false
		end
	end,
	get_next_trigger_dt = function(triggers_amount)
		triggers_amount = triggers_amount or 0
		if triggers_amount == 0 then
			return 0
		end
		return 0.5 * math.pow(triggers_amount, 2 / 3)
	end,

	can_execute = function(item, args)
		local area, is_preview = Handy.move_highlight.get_area()
		if not area then
			item.last_hold = 0
			item.triggers_count = 0
			return false
		end

		local ctx = Handy.controller.non_empty_context(args and args.ctx)
		if
			not ctx
			or not Handy.controls.can_execute_control(item, {
				allow_not_in_run = is_preview,
				allow_mod_inactive = is_preview,
				no_keybinds = true,
				ctx = ctx,
			})
		then
			item.last_hold = 0
			item.triggers_count = 0
			return false
		end

		local actions = Handy.move_highlight.get_actions()
		if not actions.dx then
			item.last_hold = 0
			item.triggers_count = 0
			return false
		end

		local data = {
			area = area,
			dx = actions.dx,
			swap = actions.swap,
			to_end = actions.to_end,
		}

		if ctx.input then
			return true, data
		elseif ctx.hold then
			if item.last_hold > actions.hold_duration then
				item.last_hold = actions.hold_duration
			end
			item.last_hold = item.last_hold + ctx.dt

			local next_dt = Handy.move_highlight.get_next_trigger_dt(item.triggers_count)
			return item.last_hold > next_dt, data
		else
			item.last_hold = 0
			item.triggers_count = 0
			return false
		end
	end,

	move = function(item, args, data)
		dat = data or {}
		local area = data.area
		local dx = data.dx

		if not area or not dx then
			return false
		end

		local swap = data.swap
		local to_end = data.to_end

		item.triggers_count = item.triggers_count + 1

		local current_card = area.highlighted[1]
		for current_index = #area.cards, 1, -1 do
			if area.cards[current_index] == current_card then
				local next_index = to_end and (dx > 0 and #area.cards or 1)
					or ((#area.cards + current_index + dx - 1) % #area.cards) + 1
				if current_index == next_index then
					return
				end
				local next_card = area.cards[next_index]
				if not next_card then
					return
				end
				if swap and Handy.move_highlight.can_swap(area) then
					if to_end or next_index == 1 or next_index == #area.cards then
						table.remove(area.cards, current_index)
						table.insert(area.cards, next_index, current_card)
					else
						area.cards[next_index] = current_card
						area.cards[current_index] = next_card
					end
					play_sound("paper1", math.random() * 0.2 + 0.9, 0.35)
				else
					area:remove_from_highlighted(current_card)
					area:add_to_highlighted(next_card, true)
					play_sound("paper1", math.random() * 0.2 + 0.9, 0.35)
				end
				return true
			end
		end
	end,
}
