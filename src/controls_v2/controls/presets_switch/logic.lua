Handy.presets_switch = {
	get_next_preset_index = function(load_index)
		local ret = function(index)
			local preset = index and Handy.presets.current.user[index]
			return {
				index = index,
				load_index = preset and index or nil,
				preset = preset,
				config = preset and preset.config,
				enabled = preset and preset.enabled,
				loaded = preset and preset.config and preset.enabled,
			}
		end
		if not load_index then
			return ret()
		end
		if type(load_index) == "number" then
			return ret(load_index)
		end
		if load_index == "next" then
			local available = {}
			for i = 1, 3 do
				local preset = Handy.presets.current.user[i]
				if preset.enabled and preset.config then
					table.insert(available, i)
				end
			end
			if #available == 0 then
				return ret()
			elseif #available == 1 then
				return ret(available[1])
			else
				local current_index = Handy.presets.current.selected
				-- search for first index which is bigger than current
				for _, next_index in ipairs(available) do
					if next_index > current_index then
						return ret(next_index)
					end
				end
				-- If not, use lowest one
				return ret(available[1])
			end
		end
		return ret()
	end,

	execute = function(index)
		local switch_result = Handy.presets_switch.get_next_preset_index(index)
		if switch_result.loaded then
			Handy.presets.apply_index(switch_result.load_index)
			Handy.UI.rerender(true)
		end
		Handy.presets_switch.show_notif(switch_result)
		-- rerender config page
		return switch_result.loaded
	end,

	show_notif = function(switch_result)
		local text = ""
		if switch_result.loaded then
			text =
				Handy.L.variable("Handy_preset_loaded", { switch_result.load_index, switch_result.preset.name or "" })
		elseif switch_result.index == "next" then
			text = Handy.L.variable("Handy_preset_nothing_to_load")
		elseif switch_result.preset and not switch_result.enabled then
			text =
				Handy.L.variable("Handy_preset_disabled", { switch_result.load_index, switch_result.preset.name or "" })
		elseif switch_result.preset and not switch_result.config then
			text = Handy.L.variable("Handy_preset_empty", { switch_result.load_index, switch_result.preset.name or "" })
		else
			text = Handy.L.variable("Handy_preset_nothing_to_load")
		end
		Handy.UI.state_panel.display(function(state)
			state.items.presets_change = {
				text = text,
				hold = false,
				order = 15,
			}
			return true
		end, nil, 3)
	end,
}
