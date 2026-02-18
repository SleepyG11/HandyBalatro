-- TODO: properly insert them

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
	name = "handy_mod_icon",
	px = 32,
	py = 32,
	path = Handy.PATH .. "/assets/" .. G.SETTINGS.GRAPHICS.texture_scaling .. "x/icon.png",
})

load_atlas({
	name = "handy_me",
	path = Handy.PATH .. "/assets/" .. G.SETTINGS.GRAPHICS.texture_scaling .. "x/me.png",
	px = 109,
	py = 142,
})
load_atlas({
	name = "handy_me_joker",
	path = Handy.PATH .. "/assets/" .. G.SETTINGS.GRAPHICS.texture_scaling .. "x/me_joker.png",
	px = 71,
	py = 95,
})
