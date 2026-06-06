function Handy.dangerous_actions.is_preview_tag(tag)
	return not not Handy.dangerous_actions.get_preview_area() or tag.handy_dangerous_actions_preview
end
function Handy.dangerous_actions.get_tags_list(tag)
	return (Handy.utils.alive_element(Handy.UI.data.dangerous_actions_preview_tags) or {}).tags or G.GAME.tags
end

---

function Handy.dangerous_actions.can_process_tag(tag, remove)
	if not tag or not remove then
		return false
	end
	if tag.handy_dangerous_actions_used then
		return false
	end
	return (tag.HUD_tag or Handy.dangerous_actions.is_preview_tag(tag)) and true or false
end
function Handy.dangerous_actions.process_tag(tag, remove)
	tag.handy_dangerous_actions_used = true
	local queue = Handy.dangerous_actions.is_preview_tag(tag) and "preview" or "game"
	table.insert(Handy.dangerous_actions.queues[queue], { tag = tag, remove = remove })
	return false
end

---

function Handy.dangerous_actions.execute_tag(tag, remove, all_same, all)
	local ignore_self = Handy.cc.dangerous_actions_mass_sell_remove_mode.value == 2
	local tags_list = Handy.dangerous_actions.get_tags_list(tag)
	if all then
		for _, target_tag in ipairs(tags_list) do
			if not ignore_self or target_tag ~= tag then
				Handy.dangerous_actions.process_tag(target_tag, true)
			end
		end
		Handy.dangerous_actions.process_queue()
		return true
	elseif all_same then
		local tag_key = tag.key
		for _, target_tag in ipairs(tags_list) do
			if target_tag.key == tag_key then
				if not ignore_self or target_tag ~= tag then
					Handy.dangerous_actions.process_tag(target_tag, true)
				end
			end
		end
		Handy.dangerous_actions.process_queue()
		return true
	else
		Handy.dangerous_actions.process_tag(tag, true)
		return true
	end
end
