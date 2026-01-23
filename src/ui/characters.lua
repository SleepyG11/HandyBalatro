Handy.UI.CHAR = {}
Handy.UI.CHAR.current = {}
Handy.UI.CHAR.previous = {}
Handy.UI.CHAR.characters = {
	SleepyG11_ui_left_border = {
		box_y_offset = -1.25,
		atlas = "handy_me",
		size = {
			h = 4.25,
		},
		offset = {
			default = {
				x = 0,
				y = 1,
			},
			hidden = {
				x = -4,
				y = 2,
			},
			visible = {
				x = -1.3175,
				y = 1,
			},
		},
		pos = {
			default = {
				x = 0,
				y = 0,
			},
			angry = {
				x = 1,
				y = 0,
			},
			scary = {
				x = 2,
				y = 0,
			},
			happy = {
				x = 3,
				y = 0,
			},
		},
	},
}

local load_atlas = function(asset)
	local file_data =
		assert(Handy.NFS.newFileData(asset.path), ("Failed to collect file data for Atlas %s"):format(asset.name))
	local image_data =
		assert(love.image.newImageData(file_data), ("Failed to initialize image data for Atlas %s"):format(asset.name))
	local image = love.graphics.newImage(image_data, { mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling })

	G.ASSET_ATLAS[asset.name] = {
		name = asset.name,
		image = image,
		type = asset.type,
		px = asset.px,
		py = asset.py,
	}
end
load_atlas({
	name = "handy_me",
	path = Handy.PATH .. "/assets/" .. G.SETTINGS.GRAPHICS.texture_scaling .. "x/me.png",
	px = 109,
	py = 142,
})

function Handy.UI.CHAR.emplace(args)
	if not G.OVERLAY_MENU then
		return
	end
	args = args or {}

	local ui_type = args.ui_type or "default"
	args.ui_type = ui_type

	local p, p_draw_parent
	pcall(function()
		p = G.OVERLAY_MENU.UIRoot.children[1]
		p_draw_parent = p
		if ui_type == "game_over" then
			p = p.children[2]
			p_draw_parent = p.children[1].children[1]
		else
			p_draw_parent = p.children[1]
		end
	end)
	if not p or not p_draw_parent then
		return
	end

	local container_x_offset = 0
	if ui_type == "game_over" then
		container_x_offset = -0.1
	elseif ui_type == "default" then
		container_x_offset = 0.0
	end

	args.pos = args.pos or "default"
	args.offset = args.offset or "default"

	local char = Handy.UI.CHAR.characters[args.character]
	local atlas = G.ASSET_ATLAS[char.atlas]
	local pos = (args.pos and char.pos[args.pos]) or char.pos.default or { x = 0, y = 0 }
	local offset = (args.offset and char.offset[args.offset]) or char.offset.default or { x = 0, y = 0 }

	local ratio = atlas.py / atlas.px
	local size = args.size or char.size
	local w = size.w
	local h = size.h
	if not w then
		w = h / ratio
	end
	if not h then
		h = w * ratio
	end

	local sprite = Sprite(0, 0, w, h, atlas, pos)
	local sprite_box = UIBox({
		definition = {
			n = G.UIT.ROOT,
			config = { colour = G.C.CLEAR },
			nodes = {
				{
					n = G.UIT.R,
					nodes = {
						{
							n = G.UIT.O,
							config = {
								object = sprite,
							},
						},
					},
				},
			},
		},
		config = {
			align = "cm",
			offset = {
				x = offset.x or 0,
				y = offset.y or 0,
			},
		},
	})
	local box = UIBox({
		definition = {
			n = G.UIT.ROOT,
			config = {
				colour = G.C.CLEAR,
				minw = args.box_w or 3,
				minh = args.box_h or 6,
			},
			nodes = {
				{
					n = G.UIT.O,
					config = {
						object = sprite_box,
					},
				},
			},
		},
		config = {
			parent = p,
			major = p,
			align = "cr",
			offset = { x = container_x_offset, y = char.box_y_offset or 0 },
		},
	})

	-- This is here because order of drawing matters. Sprite should be drawn before any popups
	table.insert(p_draw_parent.children, 1, box)

	local old_draw = box.draw
	function box:draw(...)
		if not self.handy_scissors then
			return old_draw(self, ...)
		end
		local tilescale = G.TILESCALE * G.TILESIZE * G.CANV_SCALE
		local _x = (self.VT.x + G.ROOM.T.x) * tilescale
		local _y = (self.VT.y + G.ROOM.T.y) * tilescale
		local _w = self.VT.w * tilescale
		local _h = self.VT.h * tilescale
		love.graphics.setScissor(_x, _y, _w, _h)
		local ret = old_draw(self, ...)
		love.graphics.setScissor()
		return ret
	end

	sprite.role.r_bond = "Strong"
	sprite.role.xy_bond = "Strong"
	sprite.role.scale_bond = "Strong"
	sprite_box.role.xy_bond = "Strong"
	sprite_box.role.r_bond = "Strong"
	sprite_box.role.scale_bond = "Strong"
	box.states.collide.can = false
	sprite_box.states.collide.can = false
	sprite.states.collide.can = false

	local t = {
		key = args.key,

		char = char,
		char_key = args.character,
		parent = p,

		sprite = sprite,
		sprite_box = sprite_box,
		box = box,

		args = args,
	}

	Handy.UI.CHAR.current[args.key] = t
	Handy.UI.CHAR.previous[args.key] = t

	if args.scissors ~= nil then
		box.handy_scissors = args.scissors
	end
end

function Handy.UI.CHAR.rerender()
	Handy.UI.CHAR.remove()
	Handy.UI.CHAR.current = Handy.utils.table_shallow_copy(Handy.UI.CHAR.previous)
	for k, v in pairs(Handy.UI.CHAR.current) do
		Handy.UI.CHAR.emplace(v.args)
	end
end

function Handy.UI.CHAR.remove(key)
	if key then
		local v = Handy.UI.CHAR.current[key]
		v.sprite:remove()
		v.sprite_box:remove()
		v.box:remove()

		v.parent["handy_char_" .. v.key] = nil
		Handy.UI.CHAR.current[key] = nil
	else
		for k, v in pairs(Handy.UI.CHAR.current) do
			Handy.UI.CHAR.remove(k)
		end
	end
end

function Handy.UI.CHAR.set_position(key, new_offset)
	local v = Handy.UI.CHAR.current[key]
	if not v or not v.sprite_box then
		return
	end

	local offset = v.char.offset[new_offset] or { x = 0, y = 0 }
	v.args.offset = new_offset

	v.sprite_box.alignment.offset.x = offset.x or 0
	v.sprite_box.alignment.offset.y = offset.y or 0
end
function Handy.UI.CHAR.ease_position(key, new_offset, duration)
	local v = Handy.UI.CHAR.current[key]
	if not v or not v.sprite_box then
		return
	end

	local offset = v.char.offset[new_offset] or { x = 0, y = 0 }
	v.args.offset = new_offset

	G.E_MANAGER:add_event(
		Event({
			trigger = "ease",
			ease = "quad",
			ref_table = v.sprite_box.alignment.offset,
			ref_value = "y",
			ease_to = offset.y,
			blocking = false,
			delay = duration or 0.15,
			pause_force = true,
			func = function(t)
				return t
			end,
		}),
		"handy_chars"
	)
	G.E_MANAGER:add_event(
		Event({
			trigger = "ease",
			ease = "quad",
			ref_table = v.sprite_box.alignment.offset,
			ref_value = "x",
			ease_to = offset.x,
			delay = duration or 0.15,
			pause_force = true,
			func = function(t)
				return t
			end,
		}),
		"handy_chars"
	)
end
function Handy.UI.CHAR.set_sprite_pos(key, new_pos)
	local v = Handy.UI.CHAR.current[key]
	if not v or not v.sprite then
		return
	end

	local pos = v.char.pos[new_pos] or { x = 0, y = 0 }
	v.pos = new_pos
	v.sprite:set_sprite_pos(pos)
end

function Handy.UI.CHAR.jump(key)
	local v = Handy.UI.CHAR.current[key]
	if not v or not v.sprite_box then
		return
	end

	local start_value = v.sprite_box.alignment.offset.y
	G.E_MANAGER:add_event(
		Event({
			trigger = "ease",
			ref_table = v.sprite_box.alignment.offset,
			ref_value = "y",
			ease_to = start_value - 0.2,
			delay = 0.06,
			pause_force = true,
			func = function(t)
				return t
			end,
		}),
		"handy_chars"
	)
	G.E_MANAGER:add_event(
		Event({
			trigger = "ease",
			ref_table = v.sprite_box.alignment.offset,
			ref_value = "y",
			ease_to = start_value,
			delay = 0.075,
			pause_force = true,
			func = function(t)
				return t
			end,
		}),
		"handy_chars"
	)
end
function Handy.UI.CHAR.hide(key)
	G.E_MANAGER:add_event(
		Event({
			blocking = false,
			no_delete = true,
			pause_force = true,
			func = function()
				Handy.UI.CHAR.toggle_scissors(key, true)
				return true
			end,
		}),
		"handy_chars"
	)
	Handy.UI.CHAR.ease_position(key, "hidden")
end
function Handy.UI.CHAR.show(key)
	Handy.UI.CHAR.ease_position(key, "visible")
	G.E_MANAGER:add_event(
		Event({
			no_delete = true,
			pause_force = true,
			blocking = false,
			func = function()
				Handy.UI.CHAR.toggle_scissors(key, false)
				return true
			end,
		}),
		"handy_chars"
	)
end

function Handy.UI.CHAR.toggle_scissors(key, b)
	local v = Handy.UI.CHAR.current[key]
	if not v or not v.box then
		return
	end
	v.args.scissors = b
	v.box.handy_scissors = b
end

local old_game_over = create_UIBox_game_over
function create_UIBox_game_over(...)
	local ret = old_game_over(...)
	G.E_MANAGER:add_event(
		Event({
			pause_force = true,
			blocking = false,
			blockable = false,
			no_delete = true,
			func = function()
				Handy.UI.CHAR.emplace({
					key = "game_over_me",

					character = "SleepyG11_ui_left_border",
					ui_type = "game_over",

					offset = "visible",
					pos = "scary",

					scissors = false,
				})
				delay(0.5, "handy_chars")
				Handy.UI.CHAR.hide("game_over_me")
				return true
			end,
		}),
		"handy_chars"
	)
	return ret
end

local old_you_win = create_UIBox_win
function create_UIBox_win(...)
	local ret = old_you_win(...)
	G.E_MANAGER:add_event(
		Event({
			pause_force = true,
			blocking = false,
			blockable = false,
			no_delete = true,
			func = function()
				Handy.UI.CHAR.emplace({
					key = "game_over_me",

					character = "SleepyG11_ui_left_border",
					ui_type = "game_over",

					offset = "visible",
					pos = "happy",

					scissors = false,
				})
				delay(0.05, "handy_chars")
				Handy.UI.CHAR.jump("game_over_me")
				delay(0.05, "handy_chars")
				Handy.UI.CHAR.jump("game_over_me")
				delay(0.5, "handy_chars")
				Handy.UI.CHAR.hide("game_over_me")
				return true
			end,
		}),
		"handy_chars"
	)
	return ret
end
