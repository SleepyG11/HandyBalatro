Handy.hand_selection = {
	first_card_highlighted = nil,
	first_card_travel_distance = 0,
	first_card_travel_min_distance = 0.1,
	interpolation_min_distance = 0.35,
	interpolation_min_spacing = 0.35,
	interpolation_max_count = 10,
	interpolation_max_dt = 1 / 40,
}

--

function Handy.hand_selection.should_prevent_vanilla_deselect()
	return Handy.b_is_mod_active() and Handy.controls.is_module_enabled(Handy.cc.hand_selection)
end

function Handy.hand_selection.get_preview_area()
	return Handy.utils.alive_element(Handy.UI.data.hand_selection_preview_area)
end

--

function Handy.hand_selection.can_deselect_hand(area)
	if not area then
		return false
	end
	if area == Handy.hand_selection.get_preview_area() then
		return area.highlighted[1] and true or false
	end
	if area == G.hand then
		return G.STATE ~= G.STATES.HAND_PLAYED
			and G.hand.cards
			and G.hand.states.visible
			and G.hand.highlighted[1]
			and G.play
			and G.play.cards
			and #G.play.cards == 0
	end
	return false
end
function Handy.hand_selection.deselect_hand(area)
	area:unhighlight_all()
	return true
end

--

function Handy.hand_selection.can_select_entire_hand(area)
	if not area then
		return false
	end
	if area == Handy.hand_selection.get_preview_area() then
		return true
	end
	if area == G.hand then
		return G.STATE ~= G.STATES.HAND_PLAYED and G.hand.cards and G.hand.cards[1] and G.hand.states.visible
	end
	return false
end
function Handy.hand_selection.select_entire_hand(area)
	area:unhighlight_all()
	local cards_count = math.min(area.config.highlighted_limit, #area.cards)
	for i = 1, cards_count do
		local card = area.cards[i]
		if i ~= cards_count then
			area.cards[i]:highlight(true)
			area.highlighted[#area.highlighted + 1] = card
		else
			area:add_to_highlighted(card)
		end
	end
	return true
end

--

function Handy.hand_selection.is_card_select_preview(card)
	return card and card.handy_insta_highlight_preview
end
function Handy.hand_selection.can_select_card(card)
	if not card or G.CONTROLLER.dragging.target then
		return false
	end
	if Handy.hand_selection.is_card_select_preview(card) then
		return true
	end
	if G.STATE == G.STATES.HAND_PLAYED then
		return false
	end
	local area = card.area
	if not (area and area.cards and area.states.visible) then
		return false
	end
	if area == G.hand then
		return true
	end
	if area.handy_allow_hand_selection then
		return true
	end
	if area.config and area.config.handy_allow_hand_selection then
		return true
	end
	return false
end
function Handy.hand_selection.select_card(card)
	if Handy.hand_selection.first_card_highlighted == nil then
		Handy.hand_selection.first_card_highlighted = card.highlighted
			and Handy.controls.is_module_enabled(Handy.cc.hand_selection_insta_highlight_allow_deselect)
	end

	if
		(not not card.highlighted == not not Handy.hand_selection.first_card_highlighted)
		or (
			not Handy.hand_selection.should_interpolate()
			and Handy.controls.is_module_enabled(Handy.cc.hand_selection_combine_select_deselect)
		)
	then
		Handy.ARGS.increase_highlight_pitch = true
		card:click()
		Handy.ARGS.increase_highlight_pitch = nil
	end
	return true
end

function Handy.hand_selection.should_interpolate()
	return G.CONTROLLER.HID.touch or (G.real_dt or 0) > Handy.hand_selection.interpolation_max_dt
end

-- Inspired by idea from fork by C0mputery
function Handy.hand_selection.interpolate(ctx, area)
	if not area then
		return false
	end
	local is_any = false
	local ds = math.sqrt(ctx.sdx * ctx.sdx + ctx.sdy * ctx.sdy)
	local touched_cards
	if
		ds > Handy.hand_selection.interpolation_min_distance
		and area:collides_with_point({
			x = G.CURSOR.T.x + ctx.sdx,
			y = G.CURSOR.T.y + ctx.sdy,
		})
	then
		touched_cards = {}
		local sample_count = math.ceil(ds / Handy.hand_selection.interpolation_min_spacing)
		sample_count = math.max(1, math.min(Handy.hand_selection.interpolation_max_count, sample_count))

		for sample_index = 1, sample_count do
			local fraction = 1 - sample_index / sample_count
			local point = {
				x = G.CURSOR.T.x + ctx.sdx * fraction,
				y = G.CURSOR.T.y + ctx.sdy * fraction,
			}

			for i = #area.cards, 1, -1 do
				local card = area.cards[i]

				if card:collides_with_point(point) then
					if not touched_cards[card] and Handy.hand_selection.can_select_card(card) then
						is_any = true
						touched_cards[card] = true
						table.insert(touched_cards, card)
					end
					break
				end
			end
		end
	end
	return is_any, touched_cards
end
