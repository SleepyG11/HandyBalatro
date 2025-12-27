Handy.utils = {}
Handy.load_file("src/utils/table.lua")
Handy.load_file("src/utils/keys_sort.lua")
Handy.load_file("src/utils/dictionary.lua")

function Handy.utils.cleanup_dead_elements(ref_table, ref_key)
	local new_values = {}
	local target = ref_table[ref_key]
	if not target then
		return
	end
	for k, v in pairs(target) do
		if not v.REMOVED and not v.removed then
			new_values[#new_values + 1] = v
		end
	end
	ref_table[ref_key] = new_values
	return new_values
end
