local mp_api = {
	empty_config = {},
	empty_state = {},
}
Handy.MP.current = mp_api

-- Loading MP post-1.0
if MPAPI.create_account_avatar then
	local old_create_avatar = MPAPI.create_account_avatar
	function MPAPI.create_account_avatar(...)
		local avatar_card = old_create_avatar(...)
		if avatar_card and Handy.me.is_mp_user(MPAPI.connection_state.player_id) then
			Handy.me.set_joker_center(avatar_card)
		end
		return avatar_card
	end
end

if SPDRN then
	local old_create_options = SPDRN.create_run_options
	function SPDRN.create_run_options(...)
		local contents = old_create_options(...)
		local target = contents.nodes[1].nodes[1].nodes[1].nodes[1].nodes
		local index = table.maxn(target)
		-- if false and G.STAGE == G.STAGES.MAIN_MENU then
		-- 	table.insert(target, index + 1, {
		-- 		n = G.UIT.R,
		-- 		config = {
		-- 			padding = 0.08,
		-- 		},
		-- 		nodes = {
		-- 			Handy.UI.get_mp_extension_button(),
		-- 		},
		-- 	})
		-- 	index = index + 1
		-- end
		if not Handy.current_mod or not Handy.cc.hide_options_button.enabled then
			table.insert(target, index + 1, {
				n = G.UIT.R,
				config = {
					padding = 0.08,
				},
				nodes = {
					Handy.UI.get_mod_button(),
				},
			})
			index = index + 1
		end
		return contents
	end
end

function mp_api.is_in_lobby()
	local lobby = MPAPI.get_current_lobby()
	return not not (lobby and lobby.code)
end

function mp_api.get_lobby()
	local lobby = MPAPI.get_current_lobby()
	return (lobby and lobby.code and lobby) or nil
end
function mp_api.get_config(lobby)
	return lobby and mp_api.empty_config
end
function mp_api.get_game_state(lobby)
	return lobby and mp_api.empty_state
end

-- lobby, config, game_state
function mp_api.get_current()
	local lobby = mp_api.get_lobby()
	return lobby, mp_api.get_config(lobby), mp_api.get_game_state(lobby)
end

function mp_api.is_extension_active()
	return false
end
