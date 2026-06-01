Handy.L = {
	brackets = function(line)
		return "[" .. (line or "") .. "]"
	end,

	-- Shortcut for localizing `G.localization.misc.v_dictionary`
	variable = function(key, vars)
		return localize({
			type = "variable",
			key = key,
			vars = vars or {},
		})
	end,
	dictionary = function(key, index)
		local result = localize(key)
		if index then
			return type(result) == "table" and result[index] or "ERROR"
		end
		return result
	end,
	name_text = function(set, key, vars)
		local r = localize({ type = "name_text", set = set, key = key, vars = vars or {} })
		if type(r) == "table" then
			r = Handy.utils.string_remove_balatro_formatting(table.concat(r, " "))
		end
		return r
	end,

	parse_lines = function(lines, args, config)
		local align_overrides = args.align_overrides or {}
		local result_nodes = {}
		if lines then
			for index, line in ipairs(lines) do
				local localized = Handy.L.localize_box(type(line) == "string" and loc_parse_string(line) or line, args)
				table.insert(result_nodes, {
					n = G.UIT.R,
					config = { align = align_overrides[index] or args.align, minh = args.minh },
					nodes = localized,
				})
			end
		end
		return {
			n = G.UIT.C,
			config = config,
			nodes = result_nodes,
		}
	end,

	parsed = function(set, key, field, args, config)
		local success, lines, align_overrides = pcall(function()
			local content = G.localization.descriptions[set][key]
			local override_info = content.handy_override_align or {}
			return content[field .. "_parsed"], override_info[field] or {}
		end)
		args.align_overrides = align_overrides or {}
		return Handy.L.parse_lines(success and lines or {}, args, config)
	end,
	name = function(set, key, args, config)
		return Handy.L.parsed(set, key, "name", args, config)
	end,
	description = function(set, key, args, config)
		return Handy.L.parsed(set, key, "text", args, config)
	end,
	unlock = function(set, key, args, config)
		return Handy.L.parsed(set, key, "unlock", args, config)
	end,

	keys = function(key)
		if not key then
			key = "None"
		end

		local result = ""
		if type(key) == "table" then
			local p = false
			-- table.concat? nah
			for _, k in ipairs(key) do
				if k ~= "None" then
					if not p then
						p = true
					else
						result = result .. " + "
					end
					result = result .. Handy.L.keys(k)
				end
			end
			if result == "" then
				key = "None"
				result = localize("None", "handy_keybinds")
			end
		else
			key = Handy.keys_aliases[key] or key
			result = localize(key, "handy_keybinds")
		end

		return result == "ERROR" and key or result
	end,

	tab = function(key)
		return localize(key, "handy_tabs")
	end,

	loc_vars = function(item, res)
		if item.loc_vars and type(item.loc_vars) == "function" then
			local r = item:loc_vars()
			res.vars = r.vars or res.vars
			res.set = r.set or res.set
			res.key = r.key or res.key
		end
		return res
	end,
}

Handy.localization = Handy.L

-- This function is taken from SMODS
Handy.L.localize_box = function(lines, args)
	local function format_ui_value(value)
		if type(value) ~= "number" then
			return tostring(value)
		end
		return number_format(value, 1000000)
	end
	local final_line = {}
	for _, part in ipairs(lines) do
		local assembled_string = ""
		for _, subpart in ipairs(part.strings) do
			assembled_string = assembled_string
				.. (
					type(subpart) == "string" and subpart
					or format_ui_value(args.vars[tonumber(subpart[1])])
					or "ERROR"
				)
		end
		local desc_scale = (G.FONTS[tonumber(part.control.f)] or G.LANG.font).DESCSCALE
		if G.F_MOBILE_UI then
			desc_scale = desc_scale * 1.5
		end
		if part.control.handy_dyna then
			local _pop_in_rate, _custom_pop_in_duration = nil, nil
			local _float, _silent, _pop_in, _bump, _spacing = nil, true, nil, nil, nil
			local string_query = Handy.utils.parse_query(part.control.handy_dyna)
			_float = string_query.float or false
			_silent = string_query.silent or false
			_pop_in = string_query.pop_in and tonumber(string_query.pop_in) or 0
			_pop_in_rate = string_query.pop_in_rate and tonumber(string_query.pop_in_rate) or nil
			_custom_pop_in_duration = string_query.pop_in_duration and tonumber(string_query.pop_in_duration) or nil
			final_line[#final_line + 1] = {
				n = G.UIT.C,
				config = {
					align = "m",
					colour = part.control.X and loc_colour(part.control.X) or nil,
					r = 0.05,
					padding = 0.03,
					res = 0.15,
				},
				nodes = {},
			}
			final_line[#final_line].nodes[1] = {
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = { assembled_string },
						colours = {
							part.control.V and args.vars.colours[tonumber(part.control.V)]
								or loc_colour(part.control.C or nil),
						},
						float = _float,
						silent = _silent,
						pop_in = _pop_in,
						pop_in_rate = _pop_in_rate,
						bump = _bump,
						spacing = _spacing,
						font = (tonumber(part.control.f) and G.FONTS[tonumber(part.control.f)]),
						scale = 0.32 * (part.control.s and tonumber(part.control.s) or args.scale or 1) * desc_scale,
						handy_pop_in_duration = _custom_pop_in_duration,
					}),
				},
			}
		elseif part.control.E then
			local _float, _silent, _pop_in, _bump, _spacing = nil, true, nil, nil, nil
			if part.control.E == "1" then
				_float = true
				_silent = true
				_pop_in = 0
			elseif part.control.E == "2" then
				_bump = true
				_spacing = 1
			end
			final_line[#final_line + 1] = {
				n = G.UIT.C,
				config = {
					align = "m",
					colour = part.control.X and loc_colour(part.control.X) or nil,
					r = 0.05,
					padding = 0.03,
					res = 0.15,
				},
				nodes = {},
			}
			final_line[#final_line].nodes[1] = {
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = { assembled_string },
						colours = {
							part.control.V and args.vars.colours[tonumber(part.control.V)]
								or loc_colour(part.control.C or nil),
						},
						float = _float,
						silent = _silent,
						pop_in = _pop_in,
						bump = _bump,
						spacing = _spacing,
						font = (tonumber(part.control.f) and G.FONTS[tonumber(part.control.f)]),
						scale = 0.32 * (part.control.s and tonumber(part.control.s) or args.scale or 1) * desc_scale,
					}),
				},
			}
		elseif part.control.X then
			final_line[#final_line + 1] = {
				n = G.UIT.C,
				config = {
					align = "m",
					colour = loc_colour(part.control.X),
					r = 0.05,
					padding = 0.03,
					res = 0.15,
				},
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = assembled_string,
							colour = part.control.V and args.vars.colours[tonumber(part.control.V)]
								or loc_colour(part.control.C or nil),
							font = (tonumber(part.control.f) and G.FONTS[tonumber(part.control.f)]),
							scale = 0.32
								* (part.control.s and tonumber(part.control.s) or args.scale or 1)
								* desc_scale,
						},
					},
				},
			}
		else
			final_line[#final_line + 1] = {
				n = G.UIT.T,
				config = {
					detailed_tooltip = part.control.T and (G.P_CENTERS[part.control.T] or G.P_TAGS[part.control.T])
						or nil,
					text = assembled_string,
					shadow = args.shadow,
					colour = part.control.V and args.vars.colours[tonumber(part.control.V)]
						or not part.control.C and args.text_colour
						or loc_colour(part.control.C or nil, args.default_col),
					font = (tonumber(part.control.f) and G.FONTS[tonumber(part.control.f)]),
					scale = 0.32 * (part.control.s and tonumber(part.control.s) or args.scale or 1) * desc_scale,
				},
			}
		end
	end
	return final_line
end
-- if SMODS and SMODS.localize_box then
-- 	Handy.L.localize_box = SMODS.localize_box
-- end

--

local init_localization_ref = init_localization
function init_localization(...)
	if not G.localization.__handy_injected then
		local en_loc = Handy.load_file("loc_txt/en-us.lua")
		Handy.utils.table_merge_objects(G.localization, en_loc)
		-- Handy.UI.cache_config_dictionary_search()
		if G.SETTINGS.language ~= "en-us" then
			local success, current_loc = pcall(function()
				return Handy.load_file("loc_txt/" .. G.SETTINGS.language .. ".lua")
			end)
			-- local missing_keys = Handy.utils.deep_missing_keys(en_loc, current_loc)
			-- for _, missing_key in ipairs(missing_keys) do
			-- 	print("Missing key: " .. missing_key)
			-- end
			if success and current_loc then
				Handy.utils.table_merge_objects(G.localization, current_loc)
				-- Handy.UI.cache_config_dictionary_search(true)
			end
		end
		G.localization.__handy_injected = true
	end
	local result = init_localization_ref(...)
	Handy.e_mitter.emit("localization_load")
	return result
end
