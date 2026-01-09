function Handy.utils.string_remove_balatro_formatting(str)
	str = str:gsub("#%d+#", "")
	str = str .. "{}"
	str = str:gsub("{[^}]*}", "")
	str = str:gsub("%b{}", "")
	return str
end

function Handy.utils.string_join_keywords(t)
	return table.concat(t, " ")
end

function Handy.utils.string_words_split(str)
	str = str or ""
	local result = {}
	for word in str:gsub("[%p%c%d]", " "):gmatch("%S+") do
		table.insert(result, word)
	end
	return result
end

function Handy.utils.split_loc_table_into_words(t)
	return Handy.utils.string_words_split(
		Handy.utils.string_remove_balatro_formatting(Handy.utils.string_join_keywords(Handy.utils.as_array(t)))
	)
end
