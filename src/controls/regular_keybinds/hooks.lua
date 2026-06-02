local exit_overlay_menu_ref = G.FUNCS.exit_overlay_menu
function G.FUNCS.exit_overlay_menu(...)
	Handy.regular_keybinds.toggle_swappable_overlay(false)
	return exit_overlay_menu_ref(...)
end

local deck_info_ref = G.FUNCS.deck_info
function G.FUNCS.deck_info(...)
	Handy.regular_keybinds.toggle_swappable_overlay(true)
	return deck_info_ref(...)
end

local run_info_ref = G.FUNCS.run_info
function G.FUNCS.run_info(...)
	Handy.regular_keybinds.toggle_swappable_overlay(true)
	return run_info_ref(...)
end
