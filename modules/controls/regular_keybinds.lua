Handy.regular_keybinds = {
	shop_reroll_blocker = false,
	play_blocker = false,
	discard_blocker = false,

	shop_loaded = false,

	can_play = function(key)
		return not Handy.regular_keybinds.play_blocker
			and Handy.controller.is_module_key(Handy.cc.regular_keybinds.play, key)
			and not Handy.is_stop_use()
			and Handy.fake_events.check_button(function()
				return G.buttons.states.visible and G.buttons:get_UIE_by_ID("play_button")
			end, { visible = true })
	end,
	play = function()
		Handy.regular_keybinds.play_blocker = true
		Handy.fake_events.execute_button(function()
			return G.buttons:get_UIE_by_ID("play_button")
		end)
		G.E_MANAGER:add_event(Event({
			no_delete = true,
			blocking = false,
			func = function()
				Handy.regular_keybinds.play_blocker = false
				return true
			end,
		}))
		return true
	end,

	can_discard = function(key)
		return not Handy.regular_keybinds.discard_blocker
			and Handy.controller.is_module_key(Handy.cc.regular_keybinds.discard, key)
			and not Handy.is_stop_use()
			and Handy.fake_events.check_button(function()
				return G.buttons.states.visible and G.buttons:get_UIE_by_ID("discard_button")
			end, { visible = true })
	end,
	discard = function()
		Handy.regular_keybinds.discard_blocker = true
		Handy.fake_events.execute_button(function()
			return G.buttons:get_UIE_by_ID("discard_button")
		end)
		G.E_MANAGER:add_event(Event({
			no_delete = true,
			blocking = false,
			func = function()
				Handy.regular_keybinds.discard_blocker = false
				return true
			end,
		}))
		return true
	end,

	get_current_sorting = function(opposite)
		local hand_sorting = G.hand and G.hand.config.sort or "suit desc"
		local sortings = { "rank", "suit" }
		local sort_index = 0
		if hand_sorting == "suit desc" then
			sort_index = 1
		elseif hand_sorting == "desc" then
			sort_index = 0
		end
		if opposite then
			sort_index = (sort_index + 1) % 2
		end
		return sortings[sort_index + 1]
	end,
	can_change_sort = function(key)
		if Handy.is_stop_use() then
			return false, nil
		end
		if Handy.controller.is_module_key(Handy.cc.regular_keybinds.sort_by_rank, key) then
			return true, "rank"
		elseif Handy.controller.is_module_key(Handy.cc.regular_keybinds.sort_by_suit, key) then
			return true, "suit"
		elseif Handy.controller.is_module_key(Handy.cc.regular_keybinds.toggle_sort, key) then
			return true, Handy.regular_keybinds.get_current_sorting(true)
		else
			return false, nil
		end
	end,
	change_sort = function(sorter)
		if sorter == "rank" then
			Handy.fake_events.execute({
				func = G.FUNCS.sort_hand_value,
			})
			return true
		elseif sorter == "suit" then
			Handy.fake_events.execute({
				func = G.FUNCS.sort_hand_suit,
			})
			return true
		end
	end,

	on_shop_loaded = function()
		if not G.shop then
			return
		end
		Handy.regular_keybinds.shop_loaded = true
		local remove_func_ref = G.shop.remove
		function G.shop:remove(...)
			Handy.regular_keybinds.shop_loaded = false
			return remove_func_ref(self, ...)
		end
	end,
	can_reroll_shop = function(key)
		return not not (
			not Handy.regular_keybinds.shop_reroll_blocker
			and Handy.regular_keybinds.shop_loaded
			and Handy.controller.is_module_key(Handy.cc.regular_keybinds.reroll_shop, key)
			and not Handy.is_stop_use()
			and Handy.fake_events.check_button(function()
				return G.shop:get_UIE_by_ID("next_round_button").parent.children[2]
			end, { visible = true, require_exact_func = "can_reroll" })
		)
	end,
	reroll_shop = function()
		Handy.regular_keybinds.shop_reroll_blocker = true
		Handy.fake_events.execute_button(function()
			return G.shop:get_UIE_by_ID("next_round_button").parent.children[2]
		end)
		G.E_MANAGER:add_event(Event({
			no_delete = true,
			blocking = false,
			func = function()
				Handy.regular_keybinds.shop_reroll_blocker = false
				return true
			end,
		}))
		return true
	end,

	can_leave_shop = function(key)
		return Handy.controller.is_module_key(Handy.cc.regular_keybinds.leave_shop, key)
			and Handy.regular_keybinds.shop_loaded
			and not Handy.is_stop_use()
			and Handy.fake_events.check_button(function()
				return G.shop:get_UIE_by_ID("next_round_button")
			end, { visible = true })
	end,
	leave_shop = function()
		Handy.regular_keybinds.shop_loaded = false
		Handy.fake_events.execute_button(function()
			return G.shop:get_UIE_by_ID("next_round_button")
		end)
		return true
	end,

	can_select_blind = function(key)
		return Handy.controller.is_module_key(Handy.cc.regular_keybinds.select_blind, key)
			and G.GAME
			and G.GAME.blind_on_deck
			and G.blind_select
			and G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck]
			and not Handy.is_stop_use()
			and Handy.fake_events.check_button(function()
				return G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID("select_blind_button")
			end)
	end,
	select_blind = function()
		Handy.fake_events.execute_button(function()
			return G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID("select_blind_button")
		end)
		return true
	end,

	can_skip_blind = function(key)
		return not not (
			Handy.controller.is_module_key(Handy.cc.regular_keybinds.skip_blind, key)
			and not Handy.is_stop_use()
			and Handy.fake_events.check_button(function()
				local container = G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID(
					"tag_" .. G.GAME.blind_on_deck
				)
				return container.states.visible and container.children[2]
			end, { visible = true })
		)
	end,
	skip_blind = function()
		Handy.fake_events.execute_button(function()
			return G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID("tag_" .. G.GAME.blind_on_deck).children[2]
		end)
		return true
	end,

	can_reroll_boss = function(key)
		return Handy.controller.is_module_key(Handy.cc.regular_keybinds.reroll_boss, key)
			and not Handy.is_stop_use()
			and Handy.fake_events.check_button(function()
				return G.blind_prompt_box.UIRoot.children[3].children[1]
			end, {
				visible = true,
				require_exact_func = "reroll_boss_button",
			})
	end,
	reroll_boss = function()
		Handy.fake_events.execute_button(function()
			return G.blind_prompt_box.UIRoot.children[3].children[1]
		end)
		return true
	end,

	can_open_run_info = function(key)
		if Handy.controller.is_module_key(Handy.cc.regular_keybinds.run_info, key) then
			return true, 1
		elseif Handy.controller.is_module_key(Handy.cc.regular_keybinds.run_info_blinds, key) then
			return true, 2
		end
		return false, nil
	end,
	open_run_info = function(tab_index)
		if tab_index == 2 then
			Handy.override_create_tabs_chosen_by_label = localize("b_blinds")
		end
		Handy.fake_events.execute({
			func = G.FUNCS.run_info,
		})
		Handy.override_create_tabs_chosen_by_label = nil
		return true
	end,

	can_view_deck = function(key)
		return not not (Handy.controller.is_module_key(Handy.cc.regular_keybinds.view_deck, key))
	end,
	view_deck = function()
		Handy.fake_events.execute({
			func = G.FUNCS.deck_info,
		})
		return true
	end,

	use = function(key)
		if not Handy.controller.is_module_enabled(Handy.cc.regular_keybinds) then
			return false
		end
		if not G.SETTINGS.paused and G.STAGE == G.STAGES.RUN and not G.OVERLAY_MENU then
			local can_open_info, info_tab_index = Handy.regular_keybinds.can_open_run_info(key)
			if can_open_info then
				return Handy.regular_keybinds.open_run_info(info_tab_index)
			elseif Handy.regular_keybinds.can_view_deck(key) then
				return Handy.regular_keybinds.view_deck()
			elseif G.STATE == G.STATES.SELECTING_HAND then
				local need_sort, sorter = Handy.regular_keybinds.can_change_sort(key)
				if need_sort then
					local sort_result = Handy.regular_keybinds.change_sort(sorter)
					if Handy.cc.notifications_level >= 3 then
						Handy.UI.state_panel.display(function(state)
							state.items.change_sort = {
								text = localize({
									type = "variable",
									key = "Handy_hand_sorting",
									vars = {
										localize("k_" .. Handy.regular_keybinds.get_current_sorting(false)),
									},
								}),
								order = 30,
								hold = false,
							}
							return true
						end)
					end
					return sort_result
				elseif Handy.regular_keybinds.can_discard(key) then
					return Handy.regular_keybinds.discard()
				elseif Handy.regular_keybinds.can_play(key) then
					return Handy.regular_keybinds.play()
				end
				return false
			elseif G.STATE == G.STATES.SHOP then
				if Handy.regular_keybinds.can_reroll_shop(key) then
					return Handy.regular_keybinds.reroll_shop()
				elseif Handy.regular_keybinds.can_leave_shop(key) then
					return Handy.regular_keybinds.leave_shop()
				end
				return false
			elseif G.STATE == G.STATES.BLIND_SELECT then
				if Handy.regular_keybinds.can_skip_blind(key) then
					return Handy.regular_keybinds.skip_blind()
				elseif Handy.regular_keybinds.can_select_blind(key) then
					return Handy.regular_keybinds.select_blind()
				elseif Handy.regular_keybinds.can_reroll_boss(key) then
					return Handy.regular_keybinds.reroll_boss()
				end
				return false
			end
		end
		return false
	end,
}

Handy.register_module("regular_keybinds", Handy.regular_keybinds)
