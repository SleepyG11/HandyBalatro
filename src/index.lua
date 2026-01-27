Handy.load_file("src/utils/index.lua")
Handy.load_file("src/core/index.lua")
Handy.load_file("src/config/index.lua")
Handy.load_file("src/presets/index.lua")
Handy.load_file("src/ui/index.lua")

Handy.load_file("src/controller/index.lua")
Handy.load_file("src/controller_v2/index.lua")
Handy.load_file("src/controls/index.lua")
Handy.load_file("src/controls_v2/index.lua")
Handy.load_file("src/dictionary/index.lua")

Handy.load_file("src/extensions/index.lua")

-- Blockers

Handy.e_mitter.on("raw_input", function()
	if not Handy.controller.is_propagation_stopped() then
		if Handy.is_input_prevented() then
			Handy.controller.stop_propagation()
		end
	end
end)

-- Base handlers

Handy.e_mitter.on("raw_input", function(type, key, released)
	if not Handy.controller.is_propagation_stopped() then
		Handy.e_mitter.emit("input", Handy.controller.get_input_context())
	end
end)
Handy.e_mitter.on("raw_card_click", function(card)
	if not Handy.controller.is_propagation_stopped() then
		Handy.e_mitter.emit("card_click", Handy.controller.get_card_context())
	end
end)
Handy.e_mitter.on("raw_card_hover", function(card)
	if not Handy.controller.is_propagation_stopped() then
		Handy.e_mitter.emit("card_hover", Handy.controller.get_card_context())
	end
end)
Handy.e_mitter.on("raw_card_stop_hover", function(card)
	if not Handy.controller.is_propagation_stopped() then
		Handy.e_mitter.emit("card_stop_hover", Handy.controller.get_card_context())
	end
end)
Handy.e_mitter.on("raw_tag_click", function(tag)
	if not Handy.controller.is_propagation_stopped() then
		Handy.e_mitter.emit("tag_click", Handy.controller.get_tag_context())
	end
end)
Handy.e_mitter.on("raw_tag_hover", function(tag)
	if not Handy.controller.is_propagation_stopped() then
		Handy.e_mitter.emit("tag_hover", Handy.controller.get_tag_context())
	end
end)
Handy.e_mitter.on("raw_tag_stop_hover", function(tag)
	if not Handy.controller.is_propagation_stopped() then
		Handy.e_mitter.emit("tag_stop_hover", Handy.controller.get_tag_context())
	end
end)

-- Controls handlers

Handy.e_mitter.on("input", function(context)
	if not Handy.controller.is_propagation_stopped() then
		Handy.controller.device.update_type({ [context.type] = true })
		Handy.controller.binding.process_binding(context)
		Handy.controller.dp.should_prevent()
	end
	if not Handy.controller.is_propagation_stopped() then
		Handy.controls.process_context(context)
		Handy.e_mitter.emit("update_state_panel", context)
	end
end)
Handy.e_mitter.on("card_click", function(context)
	if not Handy.controller.is_propagation_stopped() then
		Handy.controls.process_context(context)
		Handy.e_mitter.emit("update_state_panel", context)
	end
end)
Handy.e_mitter.on("card_hover", function(context)
	if not Handy.controller.is_propagation_stopped() then
		Handy.controls.process_context(context)
		Handy.e_mitter.emit("update_state_panel", context)
	end
end)
Handy.e_mitter.on("card_stop_hover", function(context)
	if not Handy.controller.is_propagation_stopped() then
		Handy.controls.process_context(context)
		Handy.e_mitter.emit("update_state_panel", context)
	end
end)
Handy.e_mitter.on("tag_click", function(context)
	if not Handy.controller.is_propagation_stopped() then
		Handy.controls.process_context(context)
		Handy.e_mitter.emit("update_state_panel", context)
	end
end)
Handy.e_mitter.on("tag_hover", function(context)
	if not Handy.controller.is_propagation_stopped() then
		Handy.controls.process_context(context)
		Handy.e_mitter.emit("update_state_panel", context)
	end
end)
Handy.e_mitter.on("tag_stop_hover", function(context)
	if not Handy.controller.is_propagation_stopped() then
		Handy.controls.process_context(context)
		Handy.e_mitter.emit("update_state_panel", context)
	end
end)

local game_start_up_ref = Game.start_up
function Game:start_up(...)
	local result = game_start_up_ref(self, ...)

	G.E_MANAGER.queues["handy_config"] = G.E_MANAGER.queues["handy_config"] or {}
	G.E_MANAGER.queues["handy_chars"] = G.E_MANAGER.queues["handy_chars"] or {}

	Handy.e_mitter.emit("game_start")
	return result
end

local love_update_ref = love.update
function love.update(dt, ...)
	Handy.e_mitter.emit("update", dt)
	Handy.UI.state_panel.update_state()
	return love_update_ref(dt, ...)
end

local old_tag_generate_ui = Tag.generate_UI
function Tag:generate_UI(...)
	local t = self
	local tag_cont, tag_sprite, a, b, c = old_tag_generate_ui(self, ...)

	tag_sprite.states.click.can = true
	local _handy_tag_click_ref = tag_sprite.click
	function tag_sprite:click(...)
		if Handy.controller.handle_tag_click(t) then
			return
		end
		return _handy_tag_click_ref(self, ...)
	end

	local _handy_tag_hover_ref = tag_sprite.hover
	function tag_sprite:hover(...)
		if Handy.controller.handle_tag_hover(t) then
			return
		end
		return _handy_tag_hover_ref(self, ...)
	end

	local _handy_tag_stop_hover_ref = tag_sprite.stop_hover
	function tag_sprite:stop_hover(...)
		if Handy.controller.handle_tag_stop_hover(t) then
			return
		end
		return _handy_tag_stop_hover_ref(self, ...)
	end

	return tag_cont, tag_sprite, a, b, c
end

-- Mod is ready, lets start!

Handy.e_mitter.emit("load")
