Handy.utils = {}
Handy.load_files({
	"table.lua",
	"keys_sort.lua",
	"dictionary.lua",
}, "src/core/utils/")

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

function Handy.utils.alive_element(area)
	return area and not area.REMOVED and area or nil
end

function Handy.utils.restart_game()
	Handy.save_all_config()
	if SMODS and SMODS.save_all_config then
		SMODS.save_all_config()
	end
	if SMODS and SMODS.restart_game then
		return SMODS.restart_game()
	end
	if ((G or {}).SOUND_MANAGER or {}).channel then
		G.SOUND_MANAGER.channel:push({
			type = "kill",
		})
	end
	if ((G or {}).SAVE_MANAGER or {}).channel then
		G.SAVE_MANAGER.channel:push({
			type = "kill",
		})
	end
	if ((G or {}).HTTP_MANAGER or {}).channel then
		G.HTTP_MANAGER.channel:push({
			type = "kill",
		})
	end
	if require("lovely").reload_patches then
		assert(require("lovely").reload_patches())
		love.event.quit("restart")
	else
		if love.system.getOS() ~= "OS X" then
			love.thread.newThread("os.execute(...)\n"):start('"' .. arg[-2] .. '" ' .. table.concat(arg, " "))
		else
			os.execute(
				'sh "/Users/$USER/Library/Application Support/Steam/steamapps/common/Balatro/run_lovely_macos.sh" &'
			)
		end

		love.event.quit()
	end
end

-- Ha-ha, math is fun
function Handy.utils.log2(x)
	assert(x > 0, "x must be greater than 0")
	local m, e = math.frexp(x)

	if m == 0.5 then
		return e - 1
	end

	return math.log(x) * 1.4426950408889634074 -- 1/ln(2)
end
