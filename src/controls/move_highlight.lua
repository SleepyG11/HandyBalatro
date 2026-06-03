Handy.move_highlight = {
	dx = {
		one_left = -1,
		one_right = 1,
	},
}

function Handy.move_highlight.get_preview_area()
	return Handy.utils.alive_element(Handy.UI.data.move_highlight_preview_area)
end

function Handy.move_highlight.get_actions()
	local is_hold, hold_duration = Handy.controls.is_module_keys_hold(Handy.cc.move_highlight_dx_one_left)
	local dx = Handy.move_highlight.dx.one_left
	if not is_hold then
		is_hold, hold_duration = Handy.controls.is_module_keys_hold(Handy.cc.move_highlight_dx_one_right)
		dx = Handy.move_highlight.dx.one_right
	end

	if is_hold then
		return {
			dx = dx,
			hold_duration = hold_duration,
			swap = Handy.controls.is_enabled_module_keys_hold(Handy.cc.move_highlight_swap),
			to_end = Handy.controls.is_enabled_module_keys_hold(Handy.cc.move_highlight_to_end),
		}
	else
		return {}
	end
end

function Handy.move_highlight.get_area()
	local card_context = Handy.controller.card.get_context()
	local area = Handy.utils.alive_element((card_context.clicked_current or card_context.clicked_previous or {}).area)

	if not (area and area.highlighted and area.highlighted[1]) then
		return
	end

	if area.handy_allow_move_highlight then
		return area
	end
	if area.config and area.config.handy_allow_move_highlight then
		return area
	end

	if
		Handy.utils.table_contains({
			G.consumeables,
			G.jokers,
			G.cine_quests,
			G.pack_cards,
			G.shop_jokers,
			G.shop_booster,
			G.shop_vouchers,
		}, area)
	then
		return area
	end
end

function Handy.move_highlight.can_swap(area)
	if not area then
		return false
	end

	if area.handy_prevent_move_highlight_swap then
		return false
	end
	if area.config and area.config.handy_prevent_move_highlight_swap then
		return false
	end

	if Handy.utils.table_contains({
		G.pack_cards,
		G.shop_jokers,
		G.shop_booster,
		G.shop_vouchers,
	}, area) then
		return false
	end

	return true
end

--

function Handy.move_highlight.get_next_trigger_dt(triggers_amount)
	triggers_amount = triggers_amount or 0
	if triggers_amount == 0 then
		return 0
	end
	return 0.5 * math.pow(triggers_amount, 2 / 3)
end
function Handy.move_highlight.reset_triggers_count(item)
	item.last_hold = 0
	item.triggers_count = 0
	return false
end

function Handy.move_highlight.can_execute_control(item, ctx, args)
	local preview_area = Handy.move_highlight.get_preview_area()
	if
		not Handy.controls.can_execute_control(item, ctx, {
			allow_not_in_run = preview_area,
			allow_mod_inactive = preview_area,
			no_keybinds = true,
		})
	then
		return Handy.move_highlight.reset_triggers_count(item)
	end

	local area = preview_area or Handy.move_highlight.get_area()
	if not area then
		return Handy.move_highlight.reset_triggers_count(item)
	end

	local actions = Handy.move_highlight.get_actions()
	if not actions.dx then
		return Handy.move_highlight.reset_triggers_count(item)
	end
	actions.area = area

	if ctx.input then
		return true, actions
	elseif ctx.hold then
		if item.last_hold > actions.hold_duration then
			item.last_hold = actions.hold_duration
		end
		item.last_hold = item.last_hold + ctx.dt

		local next_dt = Handy.move_highlight.get_next_trigger_dt(item.triggers_count)
		return item.last_hold > next_dt, actions
	else
		return Handy.move_highlight.reset_triggers_count(item)
	end
end

function Handy.move_highlight.execute_control(item, ctx, args, data)
	local area = data.area
	local dx = data.dx
	local swap = data.swap
	local to_end = data.to_end

	item.triggers_count = item.triggers_count + 1

	local current_card = area.highlighted[1]
	for current_index = 1, #area.cards do
		if area.cards[current_index] == current_card then
			local next_index = to_end and (dx > 0 and #area.cards or 1) or (#area.cards + current_index + dx)
			next_index = ((next_index - 1) % #area.cards) + 1
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
end
