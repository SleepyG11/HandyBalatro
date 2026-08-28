local keybinds_per_page = 7

--

function Handy.UI.dictionary_tab_page_UIBox()
	local page = Handy.UI.data.dictionary.page or 1
	local initial_items = Handy.UI.data.dictionary.items or {}

	local group_keys = {}
	local group_rows = {
		n = G.UIT.R,
		config = {
			handy_level = 1,
			padding = 0,
		},
		nodes = {},
	}

	local new_index = 1
	for _, item in
		ipairs(
			-- ok vro
			Handy.utils.table_slice(
				initial_items,
				1 + (keybinds_per_page * (page - 1)),
				math.min(#initial_items, (keybinds_per_page * page))
			)
		)
	do
		local current_target = group_rows
		local target_insert

		local add_gap = function(t)
			if t.config.handy_level == 1 and t.nodes[1] then
				table.insert(t.nodes, Handy.UI.CP.r_sep(0.1))
			end
		end

		-- If item has no parents, treat is as possible parent and create new layer
		if not item.parents or #item.parents == 0 then
			new_index = new_index + 1
			target_insert = {
				n = G.UIT.R,
				config = {
					handy_level = current_target.config.handy_level + 1,
					handy_dangerous = item.dangerous,
					colour = adjust_alpha(HEX("000000"), 0.1),
					r = 0,
				},
				nodes = {},
			}
			group_keys[new_index] = target_insert
			add_gap(current_target)
			table.insert(current_target.nodes, target_insert)
			current_target = target_insert
		else
			-- Check every parent
			for _, parent in ipairs(item.parents or {}) do
				target_insert = group_keys[parent.key]
				-- Create parent's layer if it's not created already
				if not target_insert then
					target_insert = {
						n = G.UIT.R,
						config = {
							handy_parent = parent.key,
							handy_dangerous = parent.dangerous,
							handy_level = current_target.config.handy_level + 1,
							colour = parent.dangerous and adjust_alpha(G.C.MULT, 0.2)
								or adjust_alpha(HEX("000000"), 0.1),
							r = 0,
						},
						nodes = {
							Handy.UI.CP.dictionary_item(parent, { bg = true }),
						},
					}
					group_keys[parent.key] = target_insert
					add_gap(current_target)
					table.insert(current_target.nodes, target_insert)
				end
				current_target = target_insert
			end
		end
		add_gap(current_target)
		table.insert(
			current_target.nodes,
			Handy.UI.CP.dictionary_item(item, { dangerous_bg = not current_target.config.handy_dangerous })
		)
	end

	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					align = "cm",
					minh = 6.5,
				},
				nodes = {
					{
						n = G.UIT.C,
						nodes = {
							group_rows,
						},
					},
				},
			},
		},
	}
end
function Handy.UI.dictionary_tab_UIBox()
	local initial_items = Handy.UI.data.dictionary.items or {}

	local options = {}
	local max_page = math.max(1, math.ceil(#initial_items / keybinds_per_page))
	for i = 1, max_page do
		table.insert(options, localize("k_page") .. " " .. tostring(i) .. "/" .. tostring(max_page))
	end

	local definition_render = UIBox({
		definition = Handy.UI.dictionary_tab_page_UIBox(),
		config = {
			colour = G.C.CLEAR,
			align = "cm",
		},
	})

	local search_cycle_focus_args = { nav = "wide", handy_cycle = true, handy_imitate_vanilla_cycle = true }
	local search_cycle = create_option_cycle({
		options = options,
		w = 3.5,
		current_option = math.min(Handy.UI.data.dictionary.page or 1, max_page),
		colour = G.C.RED,
		no_pips = true,
		focus_args = search_cycle_focus_args,
		scale = 0.7,
		id = "handy_dictionary_paginator",

		opt_callback = "handy_change_ui_page",
		handy_container_id = "handy_keybinds_dictionary_render",
		handy_ref_table = Handy.UI.data.dictionary,
		handy_ref_value = "page",
		handy_page_definition = Handy.UI.dictionary_tab_page_UIBox,
		handy_snap_to = "handy_dictionary_paginator",
	})
	search_cycle_focus_args.type = "handy"
	search_cycle.nodes[1].config.func = "handy_gamepad_2step_control"

	local create_input_func = SMODS and SMODS.GUI and SMODS.GUI.text_input or create_text_input

	local footer = {
		n = G.UIT.R,
		config = { align = "cm", padding = 0.1, colour = { 0, 0, 0, 0.1 }, r = 0.25 },
		nodes = {
			{
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = {
					search_cycle,
				},
			},
			{
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							padding = 0.1,
						},
						nodes = {
							{
								n = G.UIT.O,
								config = {
									object = UIBox({
										definition = {
											n = G.UIT.ROOT,
											config = { colour = G.C.CLEAR },
											nodes = {
												create_input_func({
													w = 4,
													max_length = 32,
													ref_table = Handy.UI.data.dictionary,
													ref_value = "search",
													font = G.FONTS[6],
													id = "handy_dictionary_search",
													multi_language = true,
													prompt_text = localize("b_handy_search_placeholder"),
													extended_corpus = true,
													callback = function()
														if not Handy.controller.is_gamepad() then
															G.FUNCS.handy_apply_dictionary_search()
														end
													end,
												}),
											},
										},
										config = {
											align = "cm",
										},
									}),
								},
							},
							UIBox_button({
								label = { localize("b_handy_clear") },
								col = true,
								colour = G.C.MULT,
								scale = 0.35,
								minh = 0.6,
								maxh = 0.6,
								minw = 1.75,
								maxw = 1.75,
								button = "handy_clear_dictionary_search",
							}),

							UIBox_button({
								label = { localize("b_handy_search") },
								col = true,
								colour = G.C.CHIPS,
								scale = 0.35,
								minh = 0.6,
								maxh = 0.6,
								minw = 1.75,
								maxw = 1.75,
								button = "handy_apply_dictionary_search",
								focus_args = {
									type = "handy",
									handy_side_panel_bug = true,
								},
							}),
						},
					},
				},
			},
		},
	}

	return {
		n = G.UIT.C,
		config = { colour = { 0, 0, 0, 0.1 }, r = 0.25, padding = 0.1 },
		nodes = {
			{
				n = G.UIT.R,
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
						},
						nodes = {
							{
								n = G.UIT.O,
								config = {
									id = "handy_keybinds_dictionary_render",
									object = definition_render,
								},
							},
						},
					},
					Handy.UI.CP.r_sep(0.1),
					footer,
				},
			},
		},
	}
end

function Handy.UI.dictionary_tab()
	Handy.UI.data.dictionary = Handy.utils.table_shallow_merge({
		items = Handy.D.searchable_items(nil, {
			remove_parents = true,
		}),
		search = "",
		page = 1,
	}, Handy.UI.data.dictionary or {})

	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR },
		nodes = {
			Handy.UI.dictionary_tab_UIBox(),
		},
	}
end

--

G.FUNCS.handy_clear_dictionary_search = function(e)
	Handy.UI.data.dictionary = {
		items = Handy.D.searchable_items(nil, {
			remove_parents = true,
		}),
		search = "",
		page = 1,
	}
	Handy.UI.rerender(true)
end
G.FUNCS.handy_apply_dictionary_search = function(e)
	Handy.UI.data.dictionary.items = Handy.D.search(Handy.UI.data.dictionary.search, {
		remove_parents = true,
	})
	Handy.UI.data.dictionary.page = 1
	Handy.UI.rerender(true)
end

local function is_deps_resolved(item, quick)
	local module, deps = item:get_module(), item:get_deps()
	if not deps and not item.dangerous then
		return true, {}
	end
	local missing_list = {}
	local is_missing = false
	if module.enabled then
		if item.dangerous and not Handy.b_is_dangerous_actions_active() then
			is_missing = true
			if quick then
				return false, {}
			end
			table.insert(missing_list, Handy.D.dictionary.dangerous_actions)
		end
		if deps then
			for _, dep in ipairs(deps) do
				local _module = dep:get_module()
				if _module and not _module.enabled then
					is_missing = true
					if quick then
						return false, {}
					end
					table.insert(missing_list, dep)
				end
			end
		end
	end
	return not is_missing, missing_list
end
local function is_mod_deps_resolved(item, quick)
	if not item.mod_deps then
		return true, {}, {}
	end

	local missing_reqs = {}
	local conflicts = {}
	local optional_missing = {}
	local at_least_one_optional_resolved = false
	for mod, operator in pairs(item.mod_deps) do
		local mod_object = SMODS and SMODS.Mods and SMODS.Mods[mod] or {}
		local value = mod_object.can_load or false
		local name = mod_object.name or mod
		if type(operator) == "function" then
			value, operator, name = operator()
		end
		if operator == "required" and not value then
			table.insert(missing_reqs, { id = mod, name = name })
			if quick then
				return false
			end
		elseif operator == "conflict" and value then
			table.insert(conflicts, { id = mod, name = name })
			if quick then
				return false
			end
		elseif operator == "optional" then
			if value then
				at_least_one_optional_resolved = true
			end
			table.insert(optional_missing, { id = mod, name = name })
		end
	end
	if not at_least_one_optional_resolved then
		for _, m in ipairs(optional_missing) do
			table.insert(missing_reqs, m)
		end
	end
	return #missing_reqs == 0 and #conflicts == 0, missing_reqs, conflicts
end

-- this function is SO ASS, but it works ig
-- I definitely need to optimize it, later
G.FUNCS.handy_setup_dictionary_checkbox_alert = function(e)
	local item = e.config.handy_item
	if not e.handy_alert_popup_setup then
		e.handy_alert_popup_setup = true

		local deps = item:get_deps()
		if
			not (
				deps
				or item.dangerous
				or item.no_mp
				or item.no_gamepad
				or item.mod_deps
				or Handy.UI.data.tutorial_fake_alert
			)
		then
			e.config.func = nil
			return
		end

		local old_e = e
		e = e.children[1].children[1]
		local old_hover = e.hover
		e.states.hover.can = true
		e.states.collide.can = true
		function e:hover(...)
			if not self.children.handy_h_popup then
				local lines = { n = G.UIT.C, config = { align = "cm" }, nodes = {} }

				if Handy.UI.data.tutorial_fake_alert then
					local lines_col = Handy.L.description("Handy_Other", "tutorial_fake_alert", {
						align = "cm",
					})
					for _, l in ipairs(lines_col.nodes) do
						table.insert(lines.nodes, l)
					end
				end

				if item.no_gamepad and Handy.controller.is_gamepad() then
					local lines_col = Handy.L.description("Handy_Other", "cant_use_with_gamepad", {
						align = "cm",
					})
					for _, l in ipairs(lines_col.nodes) do
						table.insert(lines.nodes, l)
					end
				end

				if item.no_mp and Handy.disabled_in_mp_check(item.no_mp) then
					local lines_col = Handy.L.description("Handy_Other", "cant_use_in_mp", {
						align = "cm",
					})
					for _, l in ipairs(lines_col.nodes) do
						table.insert(lines.nodes, l)
					end
				end

				local is_resolved, missing_list = is_deps_resolved(item)
				if not is_resolved then
					local lines_col = Handy.L.description("Handy_Other", "missing_deps", {
						align = "cm",
					})
					for _, dep in ipairs(missing_list) do
						local res = Handy.L.loc_vars(dep, {
							set = "Handy_ConfigDictionary",
							key = dep.key,
						})
						table.insert(lines_col.nodes, {
							n = G.UIT.R,
							config = { align = "cm" },
							nodes = {
								{
									n = G.UIT.T,
									config = {
										text = Handy.L.name_text(res.set, res.key, res.vars or {}),
										scale = 0.32,
										colour = dep.dangerous and G.C.MULT or G.C.CHIPS,
									},
								},
							},
						})
					end
					if #lines.nodes > 0 then
						table.insert(lines.nodes, { n = G.UIT.R, config = { minh = 0.32 } })
					end
					for _, l in ipairs(lines_col.nodes) do
						table.insert(lines.nodes, l)
					end
				end

				local is_mods_resolved, missing_reqs, conflicts = is_mod_deps_resolved(item)
				if not is_mods_resolved then
					if missing_reqs and #missing_reqs > 0 then
						local lines_col = Handy.L.description("Handy_Other", "missing_req_mods", {
							align = "cm",
						})
						for _, req in ipairs(missing_reqs) do
							table.insert(lines_col.nodes, {
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = req.name,
											scale = 0.32,
											colour = G.C.CHIPS,
										},
									},
								},
							})
						end
						if #lines.nodes > 0 then
							table.insert(lines.nodes, { n = G.UIT.R, config = { minh = 0.32 } })
						end
						for _, l in ipairs(lines_col.nodes) do
							table.insert(lines.nodes, l)
						end
					end
					if conflicts and #conflicts > 0 then
						local lines_col = Handy.L.description("Handy_Other", "conflict_mods", {
							align = "cm",
						})
						for _, req in ipairs(conflicts) do
							table.insert(lines_col.nodes, {
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = req.name,
											scale = 0.32,
											colour = G.C.RED,
										},
									},
								},
							})
						end
						if #lines.nodes > 0 then
							table.insert(lines.nodes, { n = G.UIT.R, config = { minh = 0.32 } })
						end
						for _, l in ipairs(lines_col.nodes) do
							table.insert(lines.nodes, l)
						end
					end
				end

				if #lines.nodes > 0 then
					self.children.handy_h_popup = UIBox(Handy.UI.CP.popup_render(self, lines))
				end
			end
			return old_hover(self, ...)
		end
		local old_stop_hover = e.stop_hover
		function e:stop_hover(...)
			if self.children.handy_h_popup then
				self.children.handy_h_popup:remove()
				self.children.handy_h_popup = nil
			end
			return old_stop_hover(self, ...)
		end
		e = old_e
	end

	local is_mp_fail = item.no_mp and Handy.disabled_in_mp_check(item.no_mp)
	local is_gamepad_fail = item.no_gamepad and Handy.controller.is_gamepad()
	local is_mods_fail = item.mod_deps and not is_mod_deps_resolved(item, true)
	local is_fail = Handy.UI.data.tutorial_fake_alert
		or is_mods_fail
		or is_mp_fail
		or is_gamepad_fail
		or not is_deps_resolved(item, true)
	if not is_fail and e.children.handy_alert then
		e.children.handy_alert:remove()
		e.children.handy_alert = nil
	elseif is_fail and not e.children.handy_alert then
		e.children.handy_alert = UIBox({
			definition = Handy.UI.CP.alert_definition({
				scale_mod = 0.45,
				no_rotate = true,
				text_rot = 0,
				bump_rate = 7,
			}),
			config = {
				align = "tri",
				offset = {
					x = 0.065,
					y = -0.065,
				},
				major = e,
				instance_type = "ALERT",
			},
		})
		e.children.handy_alert.states.collide.can = false
	end
end
