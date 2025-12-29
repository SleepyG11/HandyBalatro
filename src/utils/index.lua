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

function Handy.utils.print_moveables_list()
	for index, m in ipairs(G.MOVEABLES) do
		if m:is(Sprite) then
			local s = m.sprite_pos or {}
			print(string.format("[%s] Sprite: %s (%s,%s)", index, m.atlas.name, s.x or "-", s.y or "-"))
		elseif m:is(CardArea) then
			print(
				string.format(
					"[%s] CardArea: %s (%s/%s) (%.1f,%.1f %.1fx%.1f)",
					index,
					m.config.type,
					m.config.card_count,
					m.config.temp_limit,
					m.T.x,
					m.T.y,
					m.T.w,
					m.T.h
				)
			)
		elseif m:is(Moveable) then
			local c = m.config or {}
			if m.UIT == G.UIT.T then
				if c.ref_table and c.ref_value then
					print(
						string.format(
							"[%s] T Moveable: %s | %s (ref_table[%s]) (%.1f,%.1f %.1fx%.1f)",
							index,
							c.id or "-",
							c.text,
							c.ref_value,
							m.T.x,
							m.T.y,
							m.T.w,
							m.T.h
						)
					)
				else
					print(
						string.format(
							"[%s] T Moveable: %s | %s (%.1f,%.1f %.1fx%.1f)",
							index,
							c.id or "-",
							c.text,
							m.T.x,
							m.T.y,
							m.T.w,
							m.T.h
						)
					)
				end
			else
				local UIT = "?"
				for k, v in pairs(G.UIT) do
					if v == m.UIT then
						UIT = "" .. k
					end
				end
				print(
					string.format(
						"[%s] %s Moveable: %s (%.1f,%.1f %.1fx%.1f)",
						index,
						UIT,
						c.id or "-",
						m.T.x,
						m.T.y,
						m.T.w,
						m.T.h
					)
				)
			end
		end
	end
end
