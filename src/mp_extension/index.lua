Handy.MP = {}
Handy.load_file("src/mp_extension/base.lua")

--

function Handy.is_mp_lobby_extension_active()
	return Handy.MP.current.is_extension_active()
end
Handy.b_is_mp_lobby_extension_active =
	Handy.buffered("is_mp_lobby_extension_active", Handy.is_mp_lobby_extension_active)

function Handy.is_in_multiplayer()
	return Handy.MP.current.is_in_lobby()
end
Handy.b_is_in_multiplayer = Handy.buffered("is_in_multiplayer", Handy.is_in_multiplayer)

function Handy.get_mp_lobby()
	return Handy.MP.current.get_current()
end

function Handy.disabled_in_mp_check(func, args)
	local lobby, config, state = Handy.get_mp_lobby()
	if not lobby or not config then
		return false
	end

	args = args or Handy.ARGS.global_empty_table

	if not args.bypass_active and not Handy.b_is_mp_lobby_extension_active() then
		return true
	end
	if type(func) ~= "function" then
		return true
	end
	return func(lobby, config, state)
end

function Handy.get_mp_lobby_config_value(ref_value, args)
	local lobby, config, state = Handy.get_mp_lobby()

	-- no lobby - no value
	if not config then
		return args and args.default_value, false
	end

	args = args or Handy.ARGS.global_empty_table

	-- not enabled - no value
	if not args.bypass_active and not Handy.b_is_mp_lobby_extension_active() then
		return args.default_value, false
	end
	-- have forced value - use it
	if args.force and config[ref_value .. "_force"] then
		return config[ref_value .. "_force"], true
	end
	-- return actual value
	return config[ref_value] or default_value, false
end

--

Handy.e_mitter.on("game_start", function()
	Handy.ARGS.mod_id_override = "Handy"
	if MPAPI then
		Handy.MP.mod_type = "mp_api"
		Handy.load_file("src/mp_extension/mp_api.lua")
	elseif MP then
		Handy.MP.mod_type = "pre_release"
		Handy.load_file("src/mp_extension/pre_release.lua")
	end
	Handy.ARGS.mod_id_override = nil
end)

--

function Handy.MP.is_speedrun_mode(lobby, config, state)
	return Handy.MP.mod_type == "mp_api" and SPDRN and lobby.mod_id == SPDRN.id
end
function Handy.MP.is_pvp_mode(lobby, config, state)
	return Handy.MP.mod_type == "pre_release"
end
