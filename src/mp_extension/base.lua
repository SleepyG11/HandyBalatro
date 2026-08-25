local mp_base = {}
Handy.MP.current = mp_base

function mp_base.is_in_lobby()
	return false
end

function mp_base.get_lobby()
	return nil
end
function mp_base.get_config(lobby)
	return nil
end
function mp_base.get_game_state(lobby)
	return nil
end

-- lobby, config, game_state
function mp_base.get_current()
	return nil, nil, nil
end

function mp_base.is_extension_active()
	return false
end
