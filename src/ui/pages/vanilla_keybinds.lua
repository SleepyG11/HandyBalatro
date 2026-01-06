function Handy.UI.vanilla_keybinds_round_tab_definition()
	local content = {
		n = G.UIT.R,
		config = { align = "cm", colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.1 },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					colour = adjust_alpha(HEX("000000"), 0.1),
					align = "cm",
					r = 0.5,
				},
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm", r = 0.1 },
						nodes = {
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds, { bg = true }),
							Handy.UI.CP.r_sep(0.1),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_group_round, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_play),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_discard),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_change_sort_rank),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_change_sort_suit),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_toggle_sort),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_cash_out),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_not_just_yet_interaction),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_start_fantoms_preview),
						},
					},
				},
			},
		},
	}
	return {
		n = G.UIT.C,
		nodes = {
			content,
		},
	}
end
function Handy.UI.vanilla_keybinds_menus_tab_definition()
	local content = {
		n = G.UIT.R,
		config = { align = "cm", colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.1 },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					colour = adjust_alpha(HEX("000000"), 0.1),
					align = "cm",
					r = 0.5,
				},
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm", r = 0.1 },
						nodes = {
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds, { bg = true }),
							Handy.UI.CP.r_sep(0.1),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_group_game, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_quick_restart),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_save_run),
							Handy.UI.CP.r_sep(0.1),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_group_menus, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_run_info),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_run_info_blinds),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_view_deck),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_show_deck_preview),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_view_lobby_info),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_mod_settings),
						},
					},
				},
			},
		},
	}
	return {
		n = G.UIT.C,
		nodes = {
			content,
		},
	}
end
function Handy.UI.vanilla_keybinds_shop_n_blind_select_tab_definition()
	local content = {
		n = G.UIT.R,
		config = { align = "cm", colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.1 },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					colour = adjust_alpha(HEX("000000"), 0.1),
					align = "cm",
					r = 0.5,
				},
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm", r = 0.1 },
						nodes = {
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds, { bg = true }),
							Handy.UI.CP.r_sep(0.1),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_group_shop, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_skip_booster),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_reroll_shop),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_leave_shop),
							Handy.UI.CP.dictionary_item(
								Handy.D.dictionary.regular_keybinds_group_blind_select,
								{ bg = true }
							),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_skip_blind),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_select_blind),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.regular_keybinds_reroll_boss),
						},
					},
				},
			},
		},
	}
	return {
		n = G.UIT.C,
		nodes = {
			content,
		},
	}
end

function Handy.UI.get_vanilla_keybinds_tabs()
	local result = {
		{
			label = Handy.L.tab("Round"),
			tab_definition_function = function()
				return Handy.UI.vanilla_keybinds_round_tab_definition()
			end,
		},
		{
			label = Handy.L.tab("Shop & Blind Select"),
			tab_definition_function = function()
				return Handy.UI.vanilla_keybinds_shop_n_blind_select_tab_definition()
			end,
		},
		{
			label = Handy.L.tab("Game & Menus"),
			tab_definition_function = function()
				return Handy.UI.vanilla_keybinds_menus_tab_definition()
			end,
		},
	}
	for index, item in ipairs(result) do
		local old_def = item.tab_definition_function
		item.tab_definition_function = function()
			Handy.UI.data.vanilla_keybinds_page_tab_index = index
			return {
				n = G.UIT.ROOT,
				config = { colour = G.C.CLEAR, minh = 5, align = "cm" },
				nodes = {
					old_def(),
				},
			}
		end
	end
	return result
end

function Handy.UI.vanilla_keybinds_page_definition()
	local tabs = Handy.UI.get_vanilla_keybinds_tabs()
	tabs[Handy.UI.data.vanilla_keybinds_page_tab_index or 1].chosen = true

	local content = {
		n = G.UIT.R,
		config = { align = "cm" },
		nodes = {
			create_tabs({
				tabs = tabs,
				snap_to_nav = true,
				no_shoulders = true,
				colour = G.C.BOOSTER,
			}),
		},
	}

	return {
		n = G.UIT.C,
		nodes = {
			content,
		},
	}
end
function Handy.UI.vanilla_keybinds_page_UIBox()
	return create_UIBox_generic_options({
		contents = {
			Handy.UI.vanilla_keybinds_page_definition(),
		},
		back_func = "handy_back_to_options",
	})
end

function Handy.UI.vanilla_keybinds_page()
	Handy.UI.data.vanilla_keybinds_page_tab_index = nil
	Handy.UI.data.rerender_uibox_func = Handy.UI.vanilla_keybinds_page_UIBox
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = Handy.UI.vanilla_keybinds_page_UIBox(),
		is_handy_config = true,
	})
	Handy.UI.CHAR.rerender()
	Handy.UI.attach_side_panel()
	G.OVERLAY_MENU:recalculate()
end

G.FUNCS.handy_vanilla_keybinds = function(e)
	Handy.UI.vanilla_keybinds_page()
end
