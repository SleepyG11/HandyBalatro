Handy.dangerous_actions = {
	items = {
		"dangerous_actions_sell_one",
		"dangerous_actions_remove_one",
		"dangerous_actions_sell_all_same",
		"dangerous_actions_remove_all_same",
		"dangerous_actions_sell_all",
		"dangerous_actions_remove_all",
	},
}

---

function Handy.dangerous_actions.get_preview_area()
	return Handy.utils.alive_element(Handy.UI.data.dangerous_actions_preview_area)
end
function Handy.dangerous_actions.is_sell_disabled_in_mp(lobby, lobby_config)
	return Handy.get_mp_lobby_config_value("handy_dangerous_actions_mode", {
		default_value = 1,
		force = true,
	}) <= 1
end
function Handy.dangerous_actions.is_remove_disabled_in_mp(lobby, lobby_config)
	return true
end

---

Handy.dangerous_actions.queues = {
	game = {},
	preview = {},
}

function Handy.dangerous_actions.process_game_queue()
	local target = table.remove(Handy.dangerous_actions.queues.game, 1)
	if not target then
		stop_use()
		return
	end

	if target.tag then
		local tag = target.tag
		if target.remove then
			tag.tag_sprite:stop_hover()
			tag:remove()
		end
	elseif target.card then
		local card = target.card
		if target.remove then
			card:stop_hover()
			card:remove()
		else
			G.GAME.STOP_USE = 0
			Handy.insta_actions.execute_card(card, true, false, true)

			G.E_MANAGER:add_event(Event({
				blocking = false,
				func = function()
					card.handy_dangerous_actions_used = nil
					return true
				end,
			}))
		end
	end
	Handy.dangerous_actions.process_game_queue()
end
function Handy.dangerous_actions.process_preview_queue()
	local target = table.remove(Handy.dangerous_actions.queues.preview, 1)
	if not target then
		return
	end

	if target.tag then
		local tag = target.tag
		if target.remove then
			tag.tag_sprite:stop_hover()
			tag.handy_dangerous_actions_used = nil
			tag:juice_up(0.6, 0.1)
			play_sound("generic1", 0.8 + (0.9 + 0.2 * math.random()) * 0.2, 1)
			Handy.UI.utils.attention_text({
				text = Handy.L.dictionary("k_handy_preview_remove"),
				scale = 1,
				hold = 0.2 * 1.25 - 0.2,
				background_colour = G.C.RED,
				align = "bm",
				major = tag.tag_sprite,
				offset = { x = 0, y = 0.1 },
				timer = "REAL",
				no_skip = true,
			})
		end
	elseif target.card then
		local card = target.card
		if target.remove then
			card.handy_dangerous_actions_used = nil
			Handy.UI.utils.card_eval_status_text(card, "extra", nil, nil, nil, {
				message = Handy.L.dictionary("k_handy_preview_remove"),
				colour = G.C.RED,
				instant = true,
				timer = "REAL",
				no_skip = true,
				delay = 0.2,
			})
		else
			card.handy_dangerous_actions_used = nil
			if not card.ability.eternal then
				Handy.UI.utils.card_eval_status_text(card, "extra", nil, nil, nil, {
					message = Handy.L.dictionary("k_handy_preview_sell"),
					colour = G.C.SECONDARY_SET.Tarot,
					instant = true,
					timer = "REAL",
					no_skip = true,
					delay = 0.2,
				})
			end
		end
	end
	Handy.dangerous_actions.process_preview_queue()
end
function Handy.dangerous_actions.process_queue()
	if Handy.dangerous_actions.get_preview_area() then
		Handy.dangerous_actions.process_preview_queue()
	else
		Handy.dangerous_actions.process_game_queue()
	end
end

---

function Handy.dangerous_actions.create_can_execute(remove, all_same, all)
	return function(item, ctx, args)
		ctx = Handy.controls.resolve_control_context(item, ctx)
		if not ctx then
			return false
		end
		local is_preview = Handy.dangerous_actions.get_preview_area()
		if
			not Handy.controls.can_execute_control(item, ctx, {
				allow_mod_inactive = is_preview,
				allow_no_stop_use = is_preview,
				allow_mp = is_preview,
				allow_not_in_run = is_preview,
				allow_any_context = true,
				require_exact = true,
			})
		then
			return false
		end

		local is_correct_trigger = ctx.hover
		if all_same or all then
			is_correct_trigger = ctx.click
		end

		if ctx.input then
			return ctx.release
		elseif remove and ctx.tag then
			if is_correct_trigger and Handy.dangerous_actions.can_process_tag(ctx.target, remove) then
				return true, { tag = ctx.target }
			end
		elseif ctx.card then
			if is_correct_trigger and Handy.dangerous_actions.can_process_card(ctx.target, remove) then
				return true, { card = ctx.target }
			end
		end
		return false
	end
end
function Handy.dangerous_actions.create_execute(remove, all_same, all)
	return function(item, ctx, args, data)
		if not ctx then
			return false
		end
		if ctx.input then
			if ctx.release then
				Handy.dangerous_actions.process_queue()
			end
		elseif ctx.card then
			ctx:prevent_default()
			return Handy.dangerous_actions.execute_card(ctx.target, remove, all_same, all)
		elseif remove and ctx.tag then
			ctx:prevent_default()
			return Handy.dangerous_actions.execute_tag(ctx.target, remove, all_same, all)
		end
	end
end

---

function Handy.dangerous_actions.notif_func(state)
	local holded = nil
	local append_queue = false
	if
		Handy.dangerous_actions.get_preview_area()
		or (Handy.b_is_mod_active() and Handy.b_is_dangerous_actions_active() and Handy.b_is_in_run())
	then
		if not Handy.controller.binding.get_current() then
			for index, item_key in ipairs(Handy.dangerous_actions.items) do
				local item = Handy.controls.dictionary[item_key]
				if
					Handy.controls.is_enabled_module_keys_hold(item:get_module(), {
						require_exact = true,
					})
				then
					holded = item
					if index < 3 then
						append_queue = true
					end
					break
				end
			end
		end
	end
	if holded then
		if not Handy.cc.dangerous_actions.enabled then
			state.items.prevented_dangerous_actions = {
				text = Handy.L.dictionary("ph_handy_notif_unsafe_disabled"),
				hold = false,
				order = 99999999,
			}
			return true
		elseif not Handy.b_is_dangerous_actions_active() then
			state.items.prevented_dangerous_actions = {
				text = Handy.L.dictionary("ph_handy_notif_unsafe_disabled_by_other_mod"),
				hold = false,
				order = 99999999,
			}
			return true
		else
			local text = Handy.L.dictionary("ph_handy_" .. holded.key)
			local queue = Handy.dangerous_actions.get_preview_area() and Handy.dangerous_actions.queues.preview
				or Handy.dangerous_actions.queues.game

			if append_queue then
				text = text .. " " .. Handy.L.variable("Handy_items_in_queue", {
					#queue,
				})
			end
			state.items.dangerous_actions = {
				text = text,
				hold = true,
				order = 11,
				dangerous = true,
				level = 2,
			}
			state.items.dangerous_hint = {
				text = Handy.L.dictionary("ph_handy_notif_unsafe"),
				dangerous = true,
				hold = true,
				order = 99999999,
				level = 2,
			}
			return true
		end
	elseif state.items.dangerous_actions and state.items.dangerous_actions.hold then
		state.items.dangerous_actions.hold = false
		state.items.dangerous_hint.hold = false
		return true
	end
end

function Handy.dangerous_actions.show_notif()
	Handy.UI.state_panel.display(Handy.dangerous_actions.notif_func, nil, 2)
end

---

Handy.e_mitter.on("update", function(dt)
	Handy.dangerous_actions.show_notif()
end)
