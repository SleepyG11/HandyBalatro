function Handy.regular_keybinds.can_change_sorting(area)
	if area and area == G.hand then
		return G.STATE == G.STATES.SELECTING_HAND
	end
	return false
end

function Handy.regular_keybinds.get_sorting(area)
	if area and area == G.hand then
		local hand_sorting = area and area.config.sort or "suit desc"
		if hand_sorting == "suit desc" then
			return "suit"
		elseif hand_sorting == "desc" then
			return "rank"
		end
	end
end
function Handy.regular_keybinds.get_next_sorting(area)
	if area and area == G.hand then
		local current_sorting = Handy.regular_keybinds.get_sorting(area)
		if current_sorting == "rank" then
			return "suit"
		elseif current_sorting == "suit" then
			return "rank"
		end
	end
end

function Handy.regular_keybinds.show_notif(area)
	if area and area == G.hand then
		local current_sorting = Handy.regular_keybinds.get_sorting(area)
		if current_sorting then
			Handy.UI.state_panel.display(function(state)
				state.items.change_sort = {
					text = Handy.L.variable("Handy_hand_sorting", {
						Handy.L.dictionary("k_" .. current_sorting),
					}),
					order = 30,
					hold = false,
				}
				return true
			end, nil, 3)
		end
	end
end

function Handy.regular_keybinds.set_sorting(area, sorting)
	if area and area == G.hand then
		if sorting == "rank" then
			Handy.fake_events.execute({
				func = G.FUNCS.sort_hand_value,
			})
		elseif sorting == "suit" then
			Handy.fake_events.execute({
				func = G.FUNCS.sort_hand_suit,
			})
		end
	end
	Handy.regular_keybinds.show_notif(area)
end
function Handy.regular_keybinds.set_next_sorting(area)
	Handy.regular_keybinds.set_sorting(area, Handy.regular_keybinds.get_next_sorting(area))
end
