Handy.D = {
	list = {},
	dictionary = {},

	groups = {},
	items = {},

	checkboxes = {},
	keybinds = {},
	option_cycles = {},
	simple_option_cycles = {},
	sliders = {},
}

--

Handy.load_file("src/dictionary/items.lua")

--

function Handy.D.sorter(a, b)
	local a_p_order = a.parent and a.parent.order or 999999
	local b_p_order = b.parent and b.parent.order or 999999

	if a_p_order ~= b_p_order then
		return a_p_order < b_p_order
	end
	return a.order < b.order
end

table.sort(Handy.D.list, Handy.D.sorter)
table.sort(Handy.D.checkboxes, Handy.D.sorter)
table.sort(Handy.D.keybinds, Handy.D.sorter)
table.sort(Handy.D.option_cycles, Handy.D.sorter)

--

function Handy.D.search(search_string, args)
	args = args or {}
	local items = args.items or Handy.D.list
	if not search_string or #search_string == 0 then
		return items
	end

	local matches = {}
	local parents = {}
	local input_words = Handy.utils.string_words_split(string.lower(search_string))
	if #input_words == 0 then
		return matches
	end

	for _, item in ipairs(items) do
		for _, word in ipairs(input_words) do
			if string.find(item.result_keywords or "", word, 1, true) then
				matches[item.key] = item
				if args.remove_parents then
					while item.parent do
						parents[item.parent.key] = true
						item = item.parent
					end
				end
				break
			end
		end
	end

	local result = {}
	for _, item in pairs(matches) do
		if
			-- remove groups which will be rendered anyway
			parents[item.key]
			-- remove groups which can be rendered but have nothing to render
			or (
				item.items
				and not (item.checkbox or item.keybind or item.option_cycle or item.simple_option_cycle or item.slider)
			)
		then
		else
			table.insert(result, item)
		end
	end
	table.sort(result, Handy.D.sorter)

	return result
end

--

G.FUNCS.handy_show_example_state_panel = function(e)
	local old_hover = e.hover
	e.states.hover.can = true
	e.states.collide.can = true
	function e:hover(...)
		Handy.UI.state_panel.display(function(state)
			state.items.example = {
				text = Handy.L.dictionary("handy_example_state_panel"),
				hold = false,
				order = -5,
			}
			return true
		end)
		return old_hover(self, ...)
	end
	e.config.func = e.config.handy_hover_set and "hand_setup_hover_popups" or "handy_noop"
end

--

Handy.e_mitter.on("localization_load", function()
	for k, v in pairs(Handy.D.dictionary) do
		v.loc_loaded = false
	end

	local load_loc
	load_loc = function(v)
		if not v.loc_loaded then
			v.loc_loaded = true
			local temp_keywords = {}

			local function insert_keywords(t)
				for _, word in ipairs(t or {}) do
					temp_keywords[string.lower(word)] = true
				end
			end
			insert_keywords(v.keywords_list or {})

			if v.checkbox then
				if type(v.checkbox) ~= "table" then
					v.checkbox = {}
				end
			end
			if v.keybind then
				if type(v.keybind) ~= "table" then
					v.keybind = {}
				end
			end
			if v.option_cycle then
				if type(v.option_cycle) ~= "table" then
					v.option_cycle = {}
				end
			end
			if v.simple_option_cycle then
				if type(v.simple_option_cycle) ~= "table" then
					v.simple_option_cycle = {}
				end
			end

			pcall(function()
				local loc_table = G.localization.descriptions.Handy_ConfigDictionary[v.key] or {}
				insert_keywords(Handy.utils.split_loc_table_into_words(loc_table.name or {}))
				insert_keywords(Handy.utils.split_loc_table_into_words(loc_table.text or {}))
			end)

			v.result_keywords = ""
			for _, parent in ipairs(v.parents or {}) do
				load_loc(parent)
				v.result_keywords = v.result_keywords .. " " .. parent.result_keywords
			end
			for tk, _ in pairs(temp_keywords) do
				v.result_keywords = v.result_keywords .. " " .. tk
			end
		end
	end

	for k, v in pairs(Handy.D.dictionary) do
		load_loc(v)
	end
end)
