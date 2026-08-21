Handy.debug_things = {}

function Handy.debug_things.can_use_debug()
	return not _RELEASE_MODE
end

function Handy.debug_things.reload_localization()
	G:set_language()
	init_localization()
	if SMODS then
		SMODS.injectObjects(SMODS._Loc_Pre)
		SMODS.injectObjects(SMODS._Loc_Post)
		init_localization()
	end
	Handy.UI.state_panel.display(function(state)
		state.items.debug_things_reload_localization = {
			text = Handy.L.dictionary("poh_handy_notif_reload_localization"),
			hold = false,
			order = 0,
		}
		return true
	end, nil, 2)
	return true
end

function Handy.debug_things.reload_prototypes()
	G:set_language()
	G:init_item_prototypes()
	Handy.UI.state_panel.display(function(state)
		state.items.debug_things_reload_localization = {
			text = Handy.L.dictionary("poh_handy_notif_reload_item_prototypes"),
			hold = false,
			order = 0,
		}
		return true
	end, nil, 2)
	return true
end
