function Handy.UI.updater_release_definition(release_type)
	local releases = Handy.updater.get_releases()
	if not releases then
		return nil
	end

	local release = releases[release_type]

	local body_lines = Handy.UI.utils.wrap_text(release.body, 100)

	local patchnote_lines = {}
	for _, line in ipairs(Handy.utils.table_slice(body_lines, 1, 12)) do
		table.insert(patchnote_lines, {
			n = G.UIT.R,
			config = {
				minh = 0.3,
			},
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = line,
						scale = 0.3,
						colour = G.C.UI.TEXT_LIGHT,
					},
				},
			},
		})
	end

	local header = {
		n = G.UIT.R,
		config = { align = "cm", padding = 0.1 },
		nodes = {
			{
				n = G.UIT.R,
				config = {
					align = "cm",
				},
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = release.name,
							scale = 0.5,
							colour = G.C.UI.TEXT_LIGHT,
							shadow = true,
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = {
					align = "cm",
				},
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = Handy.UI.utils.format_iso_date(release.published_at, "%Y/%m/%d %H:%M"),
							scale = 0.3,
							colour = adjust_alpha(G.C.UI.TEXT_LIGHT, 0.6),
							shadow = true,
						},
					},
				},
			},
		},
	}
	local content = {
		n = G.UIT.R,
		config = { align = "cm", colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.1, minw = 13, minh = 4 },
		nodes = {
			{
				n = G.UIT.C,
				config = {},
				nodes = patchnote_lines,
			},
		},
	}
	local footer = {
		n = G.UIT.R,
		config = { align = "cm", padding = 0.25 },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					minw = 5.5,
					maxw = 5.5,
					align = "c",
				},
				nodes = {
					{
						n = G.UIT.R,
						nodes = {
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = {
											{
												ref_table = setmetatable({}, {
													__index = function()
														local can_install, reason_message =
															Handy.updater.can_install_release(release_type)
														if can_install then
															reason_message = "ready_for_installation"
														end
														return Handy.L.dictionary(
															"handy_updater_status_" .. reason_message
														)
													end,
												}),
												ref_value = "label",
											},
										},
										colours = { G.C.UI.TEXT_LIGHT },
										scale = 0.45,
										maxw = 4.5,
									}),
								},
							},
						},
					},
					Handy.UI.CP.r_sep(0.075),
					{
						n = G.UIT.R,
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = "v" .. Handy.version .. " -> " .. release.tag_name,
									scale = 0.3,
									colour = adjust_alpha(G.C.UI.TEXT_LIGHT, 0.6),
								},
							},
						},
					},
				},
			},
			{
				n = G.UIT.C,
				config = {
					align = "cm",
				},
				nodes = {
					UIBox_button({
						label = { Handy.L.dictionary("b_handy_install") },
						col = true,
						colour = G.C.CHIPS,
						scale = 0.45,
						minh = 0.75,
						maxh = 0.75,
						minw = 2.5,
						maxw = 2.5,
						button = "handy_install_release",
						ref_table = {
							release_type = release_type,
						},
						func = "handy_can_install_release",
					}),
				},
			},
		},
	}

	return {
		n = G.UIT.C,
		config = { align = "cm", colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.1 },
		nodes = {
			header,
			content,
			footer,
		},
	}
end
function Handy.UI.updater_settings_definition()
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
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.updater, { bg = true }),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.updater_target_release_type),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.updater_notify_about_new_update),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.updater_auto_install_new_update),
							Handy.UI.CP.dictionary_item(Handy.D.dictionary.updater_auto_restart_game_after_update),
						},
					},
				},
			},
		},
	}

	return {
		n = G.UIT.C,
		config = { minh = 6.5, align = "cm" },
		nodes = {
			content,
		},
	}
end

function Handy.UI.get_updater_tabs()
	local result = {
		{
			label = Handy.L.dictionary("handy_release_type_stable"),
			tab_definition_function = function()
				return Handy.UI.updater_release_definition("stable")
			end,
		},
		{
			label = Handy.L.dictionary("handy_release_type_pre_release"),
			tab_definition_function = function()
				return Handy.UI.updater_release_definition("pre_release")
			end,
		},
		{
			label = Handy.L.tab("Updater Settings"),
			tab_definition_function = function()
				return Handy.UI.updater_settings_definition()
			end,
		},
	}
	for index, item in ipairs(result) do
		local old_def = item.tab_definition_function
		item.tab_definition_function = function()
			Handy.UI.data.updater_page_tab_index = index
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
function Handy.UI.updater_page_definition()
	local tabs = Handy.UI.get_updater_tabs()
	tabs[Handy.UI.data.updater_page_tab_index or 1].chosen = true

	local content = {
		n = G.UIT.R,
		config = { align = "cm" },
		nodes = {
			create_tabs({
				tabs = tabs,
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
function Handy.UI.updater_page_UIBox()
	return create_UIBox_generic_options({
		contents = {
			Handy.UI.updater_page_definition(),
		},
		back_func = "handy_back_to_options",
	})
end
function Handy.UI.updater_page()
	Handy.UI.data.updater_page_tab_index = nil
	Handy.UI.data.rerender_uibox_func = Handy.UI.updater_page_UIBox
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = Handy.UI.updater_page_UIBox(),
		is_handy_config = true,
	})
	Handy.UI.CHAR.rerender()
	Handy.UI.attach_side_panel()
	G.OVERLAY_MENU:recalculate()
end

G.FUNCS.handy_updater = function(e)
	Handy.UI.updater_page()
end

G.FUNCS.handy_can_install_release = function(e)
	local release_type = e.config.ref_table.release_type
	local can_install = Handy.updater.can_install_release(release_type)
	if can_install then
		e.config.button = "handy_install_release"
		e.config.colour = G.C.CHIPS
	else
		e.config.button = nil
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
	end
end
G.FUNCS.handy_install_release = function(e)
	local release_type = e.config.ref_table.release_type
	Handy.updater.install_release(release_type)
end
