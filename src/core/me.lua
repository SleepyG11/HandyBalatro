Handy.me = {}

function Handy.me.get_joker_atlas()
	return G.ASSET_ATLAS["handy_me_joker"], { x = 0, y = 0 }
end
function Handy.me.set_joker_center(card)
	local atlas, pos = Handy.me.get_joker_atlas()
	if card.children.front then
		card.children.front.states.visible = false
	end
	card.children.center.atlas = atlas
	card.children.center:set_sprite_pos(pos)
	return card
end
function Handy.me.is_joker_center_replaced(card)
	return card.children.center.atlas == Handy.me.get_joker_atlas()
end

function Handy.me.is_mp_user(id)
	return id == "1ec9cf03-5c91-4284-80cd-bf959cce5a58"
end
function Handy.me.balanced(volume_mult)
	volume_mult = volume_mult or 1
	play_sound("gong", 0.94, 0.3 * volume_mult)
	play_sound("gong", 0.94 * 1.5, 0.2 * volume_mult)
	play_sound("tarot1", 1.5, volume_mult)
end

---

local wipe_on_ref = G.FUNCS.wipe_on
function G.FUNCS.wipe_on(...)
	local r = wipe_on_ref(...)
	if G.screenwipecard then
		if Handy.cc.me_in_screenswipe.enabled and math.random() > 0.875 then
			Handy.me.set_joker_center(G.screenwipecard)
		end
	end
	return r
end
