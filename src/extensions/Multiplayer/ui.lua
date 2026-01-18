function Handy.EXT.UI.mp_lobby_tab_UIBox()
	return Handy.UI.mp_extension_page_definition()
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

local old_lobby_info = MP.UI.lobby_info
function MP.UI.lobby_info(...)
	Handy.__insert_mp_lobby_tab = true
	local r = old_lobby_info(...)
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

G.FUNCS.handy_set_mp_option_cycle = function(arg)
	arg.cycle_config.handy_ref_table[arg.cycle_config.handy_ref_value] = arg.to_key
	send_lobby_options()
end
