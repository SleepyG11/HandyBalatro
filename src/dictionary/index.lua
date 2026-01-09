Handy.load_file("src/dictionary/items.lua")

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
