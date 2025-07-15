local colours = {
	TEXT = HEX("FFFFFF"),
	BLACK = HEX("000000"),
	RED = HEX("FF0000"),

	DYN_BASE_APLHA = {
		CONTAINER = 0.7,

		TEXT = 1,
		TEXT_DANGEROUS = 1,
	},

	DYN = {
		CONTAINER = HEX("000000"),

		TEXT = HEX("FFFFFF"),
		TEXT_DANGEROUS = HEX("FFEEEE"),
	},
}
local localization_colours = {
	handy_secondary = HEX("BBBBBB"),
}

Handy.UI = {
	show_options_button = true,
	counter = 2,
	max_counter = 1.4,
	fade_part = 0.5,

	C = colours,
	LOC_COLOURS = localization_colours,

	search_input_value = "",
	config_tab_index = 1,
	keybinds_page = 1,
	quick_page = 1,

	update = function(dt, force)
		local old_counter = Handy.UI.counter
		if Handy.UI.state_panel.current_state.hold then
			Handy.UI.counter = 0
		elseif Handy.UI.counter < Handy.UI.max_counter then
			Handy.UI.counter = Handy.UI.counter + dt
		end
		if force or old_counter ~= Handy.UI.counter then
			local multiplier = math.min(1, math.max(0, (Handy.UI.max_counter - Handy.UI.counter) / Handy.UI.fade_part))
			for key, color in pairs(Handy.UI.C.DYN) do
				color[4] = (Handy.UI.C.DYN_BASE_APLHA[key] or 1) * multiplier
			end
		end
	end,
	init = function()
		Handy.UI.counter = Handy.UI.max_counter
		Handy.UI.state_panel.emplace()
		Handy.UI.update(0, true)
	end,
}

local loc_colour_ref = loc_colour
function loc_colour(_c, _default, ...)
	return Handy.UI.LOC_COLOURS[_c] or loc_colour_ref(_c, _default, ...)
end

require("handy/ui/parts")
require("handy/ui/config_dictionary")
require("handy/ui/state_panel")
require("handy/ui/functions")
require("handy/ui/config_tabs")
require("handy/ui/config")
