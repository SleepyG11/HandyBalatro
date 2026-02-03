Handy.load_file("src/utils/index.lua")
Handy.load_file("src/core/index.lua")
Handy.load_file("src/config/index.lua")
Handy.load_file("src/presets/index.lua")
Handy.load_file("src/ui/index.lua")

Handy.load_file("src/controller_v2/index.lua")
Handy.load_file("src/controls_v2/index.lua")
Handy.load_file("src/dictionary/index.lua")

Handy.load_file("src/extensions/index.lua")

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
		if Handy.controller_v2.process_tag_click(t) then
			return
		end
		return _handy_tag_click_ref(self, ...)
	end

	local _handy_tag_hover_ref = tag_sprite.hover
	function tag_sprite:hover(...)
		if Handy.controller_v2.process_tag_hover(t) then
			return
		end
		return _handy_tag_hover_ref(self, ...)
	end

	local _handy_tag_stop_hover_ref = tag_sprite.stop_hover
	function tag_sprite:stop_hover(...)
		if Handy.controller_v2.process_tag_stop_hover(t) then
			return
		end
		return _handy_tag_stop_hover_ref(self, ...)
	end

	return tag_cont, tag_sprite, a, b, c
end

-- Mod is ready, lets start!

Handy.e_mitter.emit("load")
