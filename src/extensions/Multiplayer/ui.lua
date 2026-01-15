function Handy.EXT.UI.mp_lobby_tab_UIBox()
	return {
		n = G.UIT.C,
		config = {
			emboss = 0.05,
			minh = 6,
			r = 0.1,
			minw = 10,
			align = "tm",
			padding = 0.2,
			colour = G.C.BLACK,
		},
		nodes = {},
	}
end
function Handy.EXT.UI.mp_lobby_tab()
	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			Handy.EXT.UI.mp_lobby_tab_UIBox(),
		},
	}
end

--

local old_lobby_options = G.UIDEF.create_UIBox_lobby_options
function G.UIDEF.create_UIBox_lobby_options(...)
	Handy.__insert_mp_lobby_tab = true
	local r = old_lobby_options(...)
	Handy.__insert_mp_lobby_tab = nil
	return r
end

local old_create_tabs = create_tabs
function create_tabs(args, ...)
	if Handy.__insert_mp_lobby_tab then
		Handy.__insert_mp_lobby_tab = nil
		table.insert(args.tabs, {
			label = "Handy",
			tab_definition_function = function()
				return Handy.EXT.UI.mp_lobby_tab()
			end,
		})
	end
	return old_create_tabs(args, ...)
end

--
