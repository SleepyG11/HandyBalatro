Handy.L = {
	with_brackets = function(line, b)
		return b and "[" .. (line or "") .. "]" or line
	end,

	-- Shortcut for localizing `G.localization.misc.v_dictionary`
	variable = function(key, vars)
		return localize({
			type = "variable",
			key = key,
			vars = vars or {},
		})
	end,
	-- Returns nodes list for column
	multiline_text = function(type, set, key, vars, options)
		local raw_localization = {}
		local result_localization = {}

		localize({
			type = type,
			set = set,
			key = key,
			vars = vars or {},
			nodes = raw_localization,
			default_col = options.default_colour or G.C.WHITE,
		})

		local base_scale = type == "name" and 0.55 or 0.32
		local multiplier = (options.scale or base_scale) / base_scale
		if type ~= "name" and G.F_MOBILE_UI then
			multiplier = multiplier / 1.5
		end

		for _, line in ipairs(raw_localization) do
			for _, line_part in ipairs(line) do
				-- Regular text
				if line_part.config.scale then
					line_part.config.scale = line_part.config.scale * multiplier
				end
				-- Text with background
				if line_part.nodes then
					for _, subline in ipairs(line_part.nodes) do
						if subline.config.scale then
							subline.config.scale = subline.config.scale * multiplier
						end
					end
				end
				if type == "name" and line_part.config.object and DynaText.is(line_part.config.object) then
					local dynatext = line_part.config.object
					dynatext.scale = dynatext.scale * multiplier
					dynatext.text_offset.x = dynatext.text_offset.x * multiplier
					dynatext.text_offset.y = dynatext.text_offset.y * multiplier
					line_part.config.object:update_text(true)
				end
			end
			table.insert(result_localization, {
				n = G.UIT.R,
				config = {
					minw = options.minw,
					maxw = options.maxw,
					padding = options.padding,
					align = options.align,
				},
				nodes = line,
			})
		end

		return result_localization
	end,
	dictionary = function(key, index)
		local result = localize(key)
		if index then
			return type(result) == "table" and result[index] or "ERROR"
		end
		return result
	end,

	raw_name = function(set, key, vars)
		return localize({ type = "name_text", set = set, key = key, vars = vars or {} })
	end,
	multiline_unlock = function(set, key, vars, options)
		return Handy.L.multiline_text("unlocks", set, key, vars, options)
	end,
	multiline_description = function(set, key, vars, options)
		return Handy.L.multiline_text("descriptions", set, key, vars, options)
	end,

	keybind = function(key, with_brackets)
		if not key then
			key = "None"
		end
		-- Backwards compatibility
		if key == "[" then
			key = "Left Bracket"
		elseif key == "]" then
			key = "Right Bracket"
		end

		local result = localize(key, "handy_keybinds")
		return Handy.L.with_brackets(result == "ERROR" and key or result, with_brackets)
	end,
	keybind_label = function(key, with_brackets)
		return Handy.L.with_brackets(localize(key, "handy_keybind_labels"), with_brackets)
	end,
	keybinds_section = function(key, with_brackets)
		return Handy.L.with_brackets(localize(key, "handy_keybind_sections"), with_brackets)
	end,
	tab = function(key, with_brackets)
		return Handy.L.with_brackets(localize(key, "handy_tabs"), with_brackets)
	end,

	module_keybinds = function(module, only_first)
		local key_1, key_2 = "key_1", "key_2"
		if Handy.controller.is_gamepad() then
			key_1, key_2 = "key_1_gamepad", "key_2_gamepad"
		end

		local keys_table = {
			[key_1] = module[key_1] ~= "None" and module[key_1] or nil,
			[key_2] = module[key_2] ~= "None" and module[key_2] or nil,
		}

		local keys_count = 0
		if keys_table[key_1] then
			keys_count = keys_count + 1
		end
		if keys_table[key_2] then
			keys_count = keys_count + 1
		end

		if only_first or keys_count < 2 then
			return Handy.L.variable(
				"Handy_module_keys_single",
				{ Handy.L.keybind(keys_table[key_1] or keys_table[key_2] or "None") }
			)
		else
			return Handy.L.variable("Handy_module_keys_or", {
				Handy.L.keybind(keys_table[key_1]),
				Handy.L.keybind(keys_table[key_2]),
			})
		end
	end,

	module_checkbox_name = function(key, vars, options)
		return Handy.L.multiline_unlock("Handy_ConfigCheckbox", key, vars, options)
	end,
	module_checkbox_description = function(key, vars, options)
		return Handy.L.multiline_description("Handy_ConfigCheckbox", key, vars, options)
	end,
}
