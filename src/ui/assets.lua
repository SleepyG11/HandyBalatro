function Handy.UI.load_atlas(asset)
	local asset_path = "assets/" .. G.SETTINGS.GRAPHICS.texture_scaling .. "x/"
	if Handy.LOCAL_PATH then
		asset_path = Handy.LOCAL_PATH .. "/" .. asset_path
		file_data = assert(
			love.filesystem.newFileData(asset_path .. asset.path),
			("Failed to collect file data for Atlas %s"):format(asset.key)
		)
	else
		asset_path = Handy.PATH .. "/" .. asset_path
		file_data = assert(
			Handy.NFS.newFileData(asset_path .. asset.path),
			("Failed to collect file data for Atlas %s"):format(asset.key)
		)
	end
	local image_data =
		assert(love.image.newImageData(file_data), ("Failed to initialize image data for Atlas %s"):format(asset.key))
	local image = love.graphics.newImage(image_data, { mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling })

	G.ASSET_ATLAS["handy_" .. asset.key] = {
		key = "handy_" .. asset.key,
		name = "handy_" .. asset.key,
		image = image,
		type = asset.type,
		px = asset.px,
		py = asset.py,
	}
end

function Handy.UI.load_all_atlases()
	Handy.UI.load_atlas({
		key = "modicon",
		px = 32,
		py = 32,
		path = "icon.png",
	})
	Handy.UI.load_atlas({
		key = "me",
		path = "me.png",
		px = 109,
		py = 142,
	})
	Handy.UI.load_atlas({
		key = "me_joker",
		path = "me_joker.png",
		px = 71,
		py = 95,
	})
end

local old_set_render_settings = Game.set_render_settings
function Game:set_render_settings(...)
	old_set_render_settings(self, ...)
	Handy.UI.load_all_atlases()
end
