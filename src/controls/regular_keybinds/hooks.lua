local exit_overlay_menu_ref = G.FUNCS.exit_overlay_menu
function G.FUNCS.exit_overlay_menu(...)
	Handy.regular_keybinds.toggle_swappable_overlay(nil)
	return exit_overlay_menu_ref(...)
end

local deck_info_ref = G.FUNCS.deck_info
function G.FUNCS.deck_info(...)
	Handy.regular_keybinds.toggle_swappable_overlay("deck")
	return deck_info_ref(...)
end

local run_info_ref = G.FUNCS.run_info
function G.FUNCS.run_info(...)
	Handy.regular_keybinds.toggle_swappable_overlay("run_info_poker_hands")
	return run_info_ref(...)
end

Handy.e_mitter.on("game_load", function()
	G.njy_keybind = nil
	if MP and G.FUNCS.lobby_info then
		local lobby_info_ref = G.FUNCS.lobby_info
		function G.FUNCS.lobby_info(...)
			Handy.regular_keybinds.toggle_swappable_overlay("lobby_info")
			return lobby_info_ref(...)
		end
	end
end)
