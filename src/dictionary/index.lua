Handy.dictionary = {
	list = {},
	dictionary = {},

	checkboxes = {},
	keybinds = {},
	option_cycles = {},
	simple_option_cycles = {},
	sliders = {},

	sorted = false,
}

Handy.D = Handy.dictionary

--

local order_counter = 1
function Handy.dictionary.register(item)
	if Handy.dictionary.dictionary[item.key] then
		return Handy.dictionary.dictionary[item.key]
	end

	Handy.dictionary.sorted = false
	item.loc_loaded = false

	if not item.order then
		item.order = order_counter
		order_counter = order_counter + 1
	else
		order_counter = math.max(item.order + 1, order_counter)
	end

	Handy.dictionary.dictionary[item.key] = item
	table.insert(Handy.dictionary.list, item)
	if item.checkbox then
		if type(item.checkbox) ~= "table" then
			item.checkbox = {}
		end
	end
	if item.keybind then
		if type(item.keybind) ~= "table" then
			item.keybind = {}
		end
	end
	if item.option_cycle then
		if type(item.option_cycle) ~= "table" then
			item.option_cycle = {}
		end
	end
	if item.simple_option_cycle then
		if type(item.simple_option_cycle) ~= "table" then
			item.simple_option_cycle = {}
		end
	end
	if item.slider then
		if type(item.slider) ~= "table" then
			item.slider = {}
		end
	end

	item.get_module = item.get_module or function() end
	item.get_deps = item.get_deps or function() end
	item.parents = item.parents or {}

	local keywords = item.keywords or {}
	item.keywords_list = Handy.utils.table_concat(
		(not keywords.replace and item.parent) and item.parent.keywords_list or {},
		Handy.utils.string_words_split(Handy.utils.string_join_keywords(keywords))
	)

	if type(item.parent) == "string" then
		item.parent = Handy.dictionary.dictionary[item.parent]
	end
	if item.parent then
		item.parents = Handy.utils.table_concat(item.parent.parents or {}, { item.parent })
		item.parent.items = item.parent.items or {}
		table.insert(item.parent.items, item)
	end

	if item.items then
		for index, subitem in ipairs(item.items) do
			subitem.parent = item
			subitem.parents = Handy.utils.table_concat(item.parents or {}, { item })
			Handy.dictionary.register(subitem)
		end
	end

	return item
end

--

function Handy.dictionary.sort_item(item)
	item.result_order = Handy.dictionary.global_order
	Handy.dictionary.global_order = Handy.dictionary.global_order + 1

	if item.items then
		table.sort(item.items, function(a, b)
			return (a.order or 0) < (b.order or 0)
		end)
		for _, child in ipairs(item.items) do
			Handy.dictionary.sort_item(child)
		end
	end
end
function Handy.dictionary.sort()
	Handy.dictionary.global_order = 1
	for _, item in ipairs(Handy.dictionary.list) do
		item.result_order = nil
	end
	for _, item in ipairs(Handy.dictionary.list) do
		if not item.parent then
			Handy.dictionary.sort_item(item)
		end
	end
	table.sort(Handy.dictionary.list, function(a, b)
		return a.result_order < b.result_order
	end)
	Handy.dictionary.sorted = true
end

--

function Handy.dictionary.searchable_items(items, args)
	args = args or {}
	if not Handy.dictionary.sorted then
		Handy.dictionary.sort()
	end
	local start_items = items or Handy.dictionary.list
	local result_items = {}
	for _, item in ipairs(start_items) do
		if item.no_search or (args.remove_parents and item.items and #item.items > 0) then
		else
			table.insert(result_items, item)
		end
	end
	return result_items
end
function Handy.dictionary.search(search_string, args)
	args = args or {}
	local items = args.items or Handy.dictionary.searchable_items(Handy.dictionary.list, args)
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
		local found = true
		for _, word in ipairs(input_words) do
			if not string.find(item.result_keywords or "", word, 1, true) then
				found = false
				break
			end
		end
		if found then
			matches[item.key] = item
			if args.remove_parents then
				while item.parent do
					parents[item.parent.key] = true
					item = item.parent
				end
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
	table.sort(result, function(a, b)
		return a.result_order < b.result_order
	end)

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

function Handy.dictionary.clear_keywords()
	for k, v in pairs(Handy.dictionary.dictionary) do
		v.result_keywords = ""
		v.temp_keywords = {}

		for _, word in ipairs(v.keywords_list or {}) do
			v.temp_keywords[string.lower(word)] = true
		end
	end
end
function Handy.dictionary.process_keywords()
	local load_loc
	load_loc = function(v)
		if v.loc_loaded then
			return
		end
		v.loc_loaded = true

		local function insert_keywords(t)
			for _, word in ipairs(t or {}) do
				v.temp_keywords[string.lower(word)] = true
			end
		end

		pcall(function()
			local loc_table = G.localization.descriptions.Handy_ConfigDictionary[v.key] or {}
			insert_keywords(Handy.utils.split_loc_table_into_words(loc_table.name or {}))
			insert_keywords(Handy.utils.split_loc_table_into_words(loc_table.text or {}))
		end)
	end

	for k, v in pairs(Handy.dictionary.dictionary) do
		v.loc_loaded = false
	end
	for k, v in pairs(Handy.dictionary.dictionary) do
		load_loc(v)
	end
end
function Handy.dictionary.finish_keywords()
	local load_loc
	load_loc = function(v)
		if v.loc_loaded then
			return
		end
		v.loc_loaded = true

		v.result_keywords = ""
		for _, parent in ipairs(v.parents or {}) do
			load_loc(parent)
			v.result_keywords = v.result_keywords .. " " .. parent.result_keywords
		end
		for tk, _ in pairs(v.temp_keywords) do
			v.result_keywords = v.result_keywords .. " " .. tk
		end
	end

	for k, v in pairs(Handy.dictionary.dictionary) do
		v.loc_loaded = false
	end
	for k, v in pairs(Handy.dictionary.dictionary) do
		load_loc(v)
	end
end

--

Handy.load_file("src/dictionary/items.lua")
