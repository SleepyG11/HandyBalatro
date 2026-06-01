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

	dictionary_sorted = false,
}

Handy.dictionary = Handy.D

--

local order_counter = 1
function Handy.D.register(item)
	if Handy.D.dictionary[item.key] then
		return Handy.D.dictionary[item.key]
	end

	Handy.D.dictionary_sorted = false
	item.loc_loaded = false

	if not item.order then
		item.order = order_counter
		order_counter = order_counter + 1
	else
		order_counter = math.max(item.order + 1, order_counter)
	end

	Handy.D.dictionary[item.key] = item
	table.insert(Handy.D.list, item)
	if item.checkbox then
		if type(item.checkbox) ~= "table" then
			item.checkbox = {}
		end
		table.insert(Handy.D.checkboxes, item)
	end
	if item.keybind then
		if type(item.keybind) ~= "table" then
			item.keybind = {}
		end
		table.insert(Handy.D.keybinds, item)
	end
	if item.option_cycle then
		if type(item.option_cycle) ~= "table" then
			item.option_cycle = {}
		end
		table.insert(Handy.D.option_cycles, item)
	end
	if item.simple_option_cycle then
		if type(item.simple_option_cycle) ~= "table" then
			item.simple_option_cycle = {}
		end
		table.insert(Handy.D.simple_option_cycles, item)
	end
	if item.slider then
		if type(item.slider) ~= "table" then
			item.slider = {}
		end
		table.insert(Handy.D.sliders, item)
	end

	item.get_module = item.get_module or function() end
	item.parents = item.parents or {}

	local keywords = item.keywords or {}
	item.keywords_list = Handy.utils.table_concat(
		(not keywords.replace and item.parent) and item.parent.keywords_list or {},
		Handy.utils.string_words_split(Handy.utils.string_join_keywords(keywords))
	)

	if type(item.parent) == "string" then
		item.parent = Handy.D.dictionary[item.parent]
	end
	if item.parent then
		item.parents = Handy.utils.table_concat(item.parent.parents or {}, { item.parent })
	end

	if item.items then
		table.insert(Handy.D.groups, item)
		for index, subitem in ipairs(item.items) do
			subitem.parent = item
			subitem.parents = Handy.utils.table_concat(item.parents or {}, { item })
			Handy.D.register(subitem)
		end
	else
		table.insert(Handy.D.items, item)
	end

	return item
end

--

function Handy.D.sorter(a, b)
	local a_p_order = a.parent and a.parent.order or 999999
	local b_p_order = b.parent and b.parent.order or 999999

	if a_p_order ~= b_p_order then
		return a_p_order < b_p_order
	end
	return a.order < b.order
end
function Handy.D.sort_dictionary()
	for _, t in ipairs({
		Handy.D.list,
		Handy.D.groups,
		Handy.D.items,
		Handy.D.checkboxes,
		Handy.D.keybinds,
		Handy.D.option_cycles,
		Handy.D.simple_option_cycles,
		Handy.D.sliders,
	}) do
		table.sort(t, Handy.D.sorter)
	end
	Handy.D.dictionary_sorted = true
end

--

function Handy.D.searchable_items(items)
	if not Handy.D.dictionary_sorted then
		Handy.D.sort_dictionary()
		Handy.D.load_localization()
	end
	local start_items = items or Handy.D.list
	local result_items = {}
	for _, item in ipairs(start_items) do
		if not item.no_search then
			table.insert(result_items, item)
		end
	end
	return result_items
end
function Handy.D.search(search_string, args)
	args = args or {}
	local items = args.items or Handy.D.searchable_items(Handy.D.list)
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
	e.config.func = e.config.handy_hover_set and "handy_setup_hover_popups" or "handy_noop"
end

--

function Handy.D.load_localization()
	local load_loc
	load_loc = function(v)
		if v.loc_loaded then
			return
		end
		v.loc_loaded = true
		local temp_keywords = {}

		local function insert_keywords(t)
			for _, word in ipairs(t or {}) do
				temp_keywords[string.lower(word)] = true
			end
		end
		insert_keywords(v.keywords_list or {})

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

	for k, v in pairs(Handy.D.dictionary) do
		load_loc(v)
	end
end

Handy.e_mitter.on("localization_load", function()
	for k, v in pairs(Handy.D.dictionary) do
		v.loc_loaded = false
	end
	Handy.D.load_localization()
end)

--

Handy.load_file("src/dictionary/items.lua")
