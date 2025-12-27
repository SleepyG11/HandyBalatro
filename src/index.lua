Handy.load_file("src/utils/index.lua")
Handy.load_file("src/core/index.lua")
Handy.load_file("src/config/index.lua")
Handy.load_file("src/presets/index.lua")
Handy.load_file("src/ui/index.lua")

Handy.load_file("src/dictionary/index.lua")
Handy.load_file("src/controller/index.lua")
Handy.load_file("src/controls/index.lua")

-- Blockers

Handy.e_mitter.on("raw_input", function()
	if not Handy.controller.is_propagation_stopped() then
		if Handy.controller.dp.b_is_console_opened() then
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

-- Controls handlers

Handy.e_mitter.on("input", function(context)
	if not Handy.controller.is_propagation_stopped() then
		-- Update device type
		Handy.controller.device.update_type({ [context.type] = true })
		-- Update binding
		Handy.controller.binding.process_binding(context)
		Handy.controller.dp.should_prevent()
	end
	if not Handy.controller.is_propagation_stopped() then
		-- Process controls
		Handy.controls.process_context(context)
		Handy.e_mitter.emit("update_state_panel", context)
	end
end)
Handy.e_mitter.on("card_click", function(context)
	if not Handy.controller.is_propagation_stopped() then
		-- Process controls
		Handy.controls.process_context(context)
		Handy.e_mitter.emit("update_state_panel", context)
	end
end)
Handy.e_mitter.on("card_hover", function(context)
	if not Handy.controller.is_propagation_stopped() then
		-- Process controls
		Handy.controls.process_context(context)
		Handy.e_mitter.emit("update_state_panel", context)
	end
end)
Handy.e_mitter.on("card_stop_hover", function(context)
	if not Handy.controller.is_propagation_stopped() then
		-- Process controls
		Handy.controls.process_context(context)
		Handy.e_mitter.emit("update_state_panel", context)
	end
end)
Handy.e_mitter.on("tag_click", function(context)
	if not Handy.controller.is_propagation_stopped() then
		-- Process controls
		Handy.controls.process_context(context)
		Handy.e_mitter.emit("update_state_panel", context)
	end
end)

local game_start_up_ref = Game.start_up
function Game:start_up(...)
	local result = game_start_up_ref(self, ...)
	Handy.e_mitter.emit("game_start")
	return result
end

local love_update_ref = love.update
function love.update(dt, ...)
	Handy.e_mitter.emit("update", dt)
	Handy.UI.state_panel.update_state()
	return love_update_ref(dt, ...)
end

-- Mod is ready, lets start!

Handy.e_mitter.emit("load")
