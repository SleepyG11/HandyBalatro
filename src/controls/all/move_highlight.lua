Handy.move_highlight = {
	dx = {
		one_left = -1,
		one_right = 1,
	},

	get_actions = function(area)
		return {
			swap = Handy.controls.is_module_enabled(Handy.cc.move_highlight_swap)
				and Handy.controls.is_module_keys_activated(Handy.cc.move_highlight_swap),
			to_end = Handy.controls.is_module_enabled(Handy.cc.move_highlight_to_end)
				and Handy.controls.is_module_keys_activated(Handy.cc.move_highlight_to_end),
		}
	end,

	can_swap = function(area)
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

	get_area = function()
		if Handy.UI.data.move_highlight_preview_area and not Handy.UI.data.move_highlight_preview_area.REMOVED then
			return Handy.UI.data.move_highlight_preview_area
		end
		local card_context = Handy.controller.get_card_context()
		local area = (card_context.clicked_current or card_context.clicked_previous or {}).area
		if
			area
			and area.highlighted
			and area.highlighted[1]
			and Handy.utils.table_contains({
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
	end,
	b_get_area = function()
		return Handy.buffered("move_highlight_area", Handy.move_highlight.get_area)
	end,

	can_execute = function(item, context)
		local area = Handy.move_highlight.b_get_area()
		if
			not area
			or not Handy.controls.default_can_execute(item, context, {
				allow_not_in_run = area == Handy.UI.data.move_highlight_preview_area,
                allow_mod_inactive = area == Handy.UI.data.move_highlight_preview_area,
			})
		then
			return false
		end
		return true
	end,

	move = function(item, context, dx)
		local area = Handy.move_highlight.b_get_area()
		if not area or not dx then
			return
		end

		local current_card = area.highlighted[1]
		for current_index = #area.cards, 1, -1 do
			if area.cards[current_index] == current_card then
				local actions = Handy.move_highlight.get_actions(area)
				local next_index = actions.to_end and (dx > 0 and #area.cards or 1)
					or ((#area.cards + current_index + dx - 1) % #area.cards) + 1
				if current_index == next_index then
					return
				end
				local next_card = area.cards[next_index]
				if not next_card then
					return
				end
				if actions.swap and Handy.move_highlight.can_swap(area) then
					if actions.to_end or next_index == 1 or next_index == #area.cards then
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
				return
			end
		end
	end,
}

Handy.controls.register("move_highlight_one_left", {
	get_module = function()
		return Handy.cc.move_highlight_dx_one_left, { Handy.cc.move_highlight }
	end,

	context_types = {
		input = {
			mouse = true,
			wheel = true,
			keyboard = true,
			gamepad = false,
		},
	},

	in_run = true,

	trigger = "trigger",

	can_execute = Handy.move_highlight.can_execute,
	execute = function(self, context)
		Handy.move_highlight.move(self, context, -1)
		return true
	end,
})
Handy.controls.register("move_highlight_one_right", {
	get_module = function()
		return Handy.cc.move_highlight_dx_one_right, { Handy.cc.move_highlight }
	end,

	context_types = {
		input = {
			mouse = true,
			wheel = true,
			keyboard = true,
			gamepad = false,
		},
	},

	in_run = true,

	trigger = "trigger",

	can_execute = Handy.move_highlight.can_execute,
	execute = function(self, context)
		Handy.move_highlight.move(self, context, 1)
		return true
	end,
})
