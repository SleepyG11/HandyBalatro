Handy.insta_actions = {
	action_blocker = false,
}

---

function Handy.insta_actions.get_actions(ctx)
	local args = { ctx = ctx }
	return {
		buy_n_sell = Handy.controls.is_enabled_module_keys_hold(Handy.cc.insta_actions_buy_n_sell, args),
		buy_or_sell = Handy.controls.is_enabled_module_keys_hold(Handy.cc.insta_actions_buy_or_sell, args),
		use = Handy.controls.is_enabled_module_keys_hold(Handy.cc.insta_actions_use, args),
	}
end
function Handy.insta_actions.get_target_card(item, ctx)
	local target_card
	if ctx.card then
		target_card = ctx.target
	elseif ctx.input then
		target_card = G.CONTROLLER.dragging.target or Handy.controller.card.get_context().hovered_current
	end
	if target_card and target_card.area and target_card.is and target_card:is(Card) then
		return target_card
	end
end
function Handy.insta_actions.is_preview_card(card)
	return card and card.handy_preview_insta_actions
end

---

function Handy.insta_actions.show_notif(actions)
	Handy.UI.state_panel.display(function(state)
		local result = false

		if actions.buy_n_sell then
			state.items.quick_buy_n_sell = {
				text = Handy.L.dictionary("ph_handy_notif_quick_buy_n_sell"),
				hold = false,
				order = 12,
				level = 4,
			}
			result = true
		elseif actions.use then
			state.items.insta_use = {
				text = Handy.L.dictionary("ph_handy_notif_quick_use"),
				hold = false,
				order = 10,
				level = 4,
			}
			result = true
		elseif actions.buy_or_sell then
			state.items.quick_buy_and_sell = {
				text = Handy.L.dictionary("ph_handy_notif_quick_buy_or_sell"),
				hold = false,
				order = 11,
				level = 4,
			}
			result = true
		end
		return result
	end, nil, 4)
end

---

function Handy.insta_actions.can_execute(item, ctx, args)
	if Handy.insta_actions.action_blocker then
		return false
	end
	ctx = Handy.controls.resolve_control_context(item, ctx)
	if not ctx then
		return false
	end

	local trigger_mode = Handy.cc.insta_actions_trigger_mode.value
	local is_alt_mode = Handy.controller.is_gamepad() or trigger_mode == 2
	if is_alt_mode then
		if not ctx.input then
			return false
		end
	else
		if not ctx.card or not ctx.click then
			return false
		end
	end

	local card = Handy.insta_actions.get_target_card(item, ctx)
	if not card then
		return false
	end
	local is_preview_card = Handy.insta_actions.is_preview_card(card)
	if
		Handy.controls.can_execute_control(item, ctx, {
			no_keybinds = true,
			allow_not_in_run = is_preview_card,
			allow_stop_use = is_preview_card,
			allow_mod_inactive = is_preview_card,
			allow_any_context = true,
			allow_mp = is_preview_card,
		})
	then
		return true, { card = card }
	end

	return false
end
function Handy.insta_actions.execute(item, ctx, args, data)
	local target_card = data and data.card
	if not target_card then
		return false
	end
	local actions = Handy.insta_actions.get_actions(ctx and ctx.input and ctx or nil)
	if Handy.insta_actions.process_card(target_card, actions) then
		ctx:prevent_default()
		if not Handy.insta_actions.is_preview_card(target_card) then
			Handy.insta_actions.show_notif(actions)
		end
		return true
	end
end
