Handy.hand_selection = {
	first_card_highlighted = nil,
	first_card_travel_distance = 0,
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
		Handy.controls.is_module_enabled(Handy.cc.hand_selection_combine_select_deselect)
		or (not not card.highlighted == not not Handy.hand_selection.first_card_highlighted)
	then
		Handy.ARGS.increase_highlight_pitch = true
		card:click()
		Handy.ARGS.increase_highlight_pitch = nil
	end
	return true
end
