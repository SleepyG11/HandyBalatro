Handy.move_highlight = {
	dx = {
		one_left = -1,
		one_right = 1,
	},

	get_dx = function(key, released, area)
		for module_key, module in pairs(Handy.cc.move_highlight.dx) do
			if Handy.controller.is_module_key(module, key) then
				return Handy.move_highlight.dx[module_key]
			end
		end
		return nil
	end,
	get_actions = function(key, released, area)
		return {
			swap = Handy.controller.is_module_key_down(Handy.cc.move_highlight.swap),
			to_end = Handy.controller.is_module_key_down(Handy.cc.move_highlight.to_end),
		}
	end,

	can_swap = function(key, released, area)
		if not area then
			return false
		end
		return not Handy.utils.table_contains({
			G.pack_cards,
			G.shop_jokers,
			G.shop_booster,
			G.shop_vouchers,
		}, area)
	end,
	cen_execute = function(key, released, area)
		local is_preview = area == G.handy_config_storage.move_highlight_hand
		return not not (
			not released
			and not Handy.controller.is_gamepad()
			and (is_preview or (Handy.buffered_is_in_run() and not Handy.buffered_is_stop_use() and Handy.controller.is_module_enabled(
				Handy.cc.move_highlight
			)))
			and area
			and area.highlighted
			and area.highlighted[1]
			and (is_preview or Handy.utils.table_contains({
				G.consumeables,
				G.jokers,
				G.cine_quests,
				G.pack_cards,
				G.shop_jokers,
				G.shop_booster,
				G.shop_vouchers,
			}, area))
			and Handy.buffered_is_mod_active()
		)
	end,
	execute = function(key, released, area)
		local dx = Handy.move_highlight.get_dx(key, released, area)
		if not dx then
			return false
		end

		local current_card = area.highlighted[1]
		for current_index = #area.cards, 1, -1 do
			if area.cards[current_index] == current_card then
				local actions = Handy.move_highlight.get_actions(key, released, area)
				local next_index = actions.to_end and (dx > 0 and #area.cards or 1)
					or ((#area.cards + current_index + dx - 1) % #area.cards) + 1
				if current_index == next_index then
					return
				end
				local next_card = area.cards[next_index]
				if not next_card then
					return
				end
				if actions.swap and Handy.move_highlight.can_swap(key, released, area) then
					if actions.to_end or next_index == 1 or next_index == #area.cards then
						table.remove(area.cards, current_index)
						table.insert(area.cards, next_index, current_card)
					else
						area.cards[next_index] = current_card
						area.cards[current_index] = next_card
					end
				else
					area:remove_from_highlighted(current_card)
					area:add_to_highlighted(next_card)
				end
				return
			end
		end
	end,

	use = function(key, released, area)
		area = area or Handy.last_clicked_area
		return Handy.move_highlight.cen_execute(key, released, area)
				and Handy.move_highlight.execute(key, released, area)
			or false
	end,
}

Handy.register_module("move_highlight", Handy.move_highlight)
