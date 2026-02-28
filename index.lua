to_big = to_big or function(x)
	return x
end
to_number = to_number or function(x)
	return tonumber(x)
end

Handy = setmetatable({
	---@diagnostic disable-next-line: undefined-global
	NFS = (SMODS and SMODS.NFS) or NFS or require("handy/nativefs"),
	---@diagnostic disable-next-line: undefined-global
	JSON = JSON or json or require("handy/json"),
	---@diagnostic disable-next-line: undefined-global
	PATH = Handy_main_file_path,
	NEW_PATH = nil,
	LOCAL_PATH = nil,
	LOCAL_REAL_PATH = nil,

	meta = {
		["1.4.1b_patched_select_blind_and_skip"] = true,
		["1.5.0_update"] = true,
		["1.5.1a_multiplayer_check"] = true,
		["2.0.0_update"] = true,
		["2.0.0_mp_extension"] = true,
		["2.0.0_updater"] = true,
	},

	keys_aliases = {
		["["] = "Left Bracket",
		["]"] = "Right Bracket",
	},
}, {})

function Handy.read_file(file)
	if Handy.LOCAL_PATH then
		return love.filesystem.read(Handy.LOCAL_PATH .. "/" .. file)
	else
		return Handy.NFS.read(Handy.PATH .. "/" .. file)
	end
end
function Handy.load_file(file)
	return assert(load(Handy.read_file(file), '=[SMODS Handy "' .. file .. '"]'))()
end
function Handy.load_files(files, prefix)
	for _, file in pairs(files) do
		Handy.load_file(prefix .. file)
	end
end

if not Handy.NFS.getInfo(Handy.PATH .. "/src") then
	local function normalize_path(path)
		return path:gsub("\\+", "/"):gsub("/+", "/"):gsub("/$", "")
	end

	local save_folder = love.filesystem.getSaveDirectory()
	local mods_folder = require("lovely").mod_dir

	local normalized_mod_path = normalize_path(Handy.PATH)
	local normalized_save_path = normalize_path(save_folder)
	local normalized_mods_path = normalize_path(mods_folder)
	local local_mod_folder = normalized_mod_path:sub(#normalized_save_path + 2)
	local mod_folder = normalized_mod_path:sub(#normalized_mods_path + 2)

	local new_local_path = "__SMODS_MOUNTS__/" .. mod_folder
	love.filesystem.mount(local_mod_folder, new_local_path)

	if not love.filesystem.getInfo(new_local_path .. "/src") then
		local found = false
		local folders = love.filesystem.getDirectoryItems(new_local_path)
		for _, folder in ipairs(folders) do
			if love.filesystem.getInfo(new_local_path .. "/" .. folder .. "/src") then
				found = true
				new_local_path = new_local_path .. "/" .. folder
				break
			end
		end
		if not found then
			error([[


Handy mod installed incorrectly.

To fix this, do one of the followings:
- Update Lovely to 0.9.0 or newer
- Make sure mod is not "nested" (folder in folder), like "/Mods/HandyBalatro/HandyBalatro"
- Optionally, if mod in .zip archive, unzip it
]])
		end
	end

	Handy.LOCAL_REAL_PATH = local_mod_folder
	Handy.LOCAL_PATH = new_local_path
end

Handy.mod_metadata = Handy.JSON.decode(Handy.read_file("metadata.json"))
Handy.version = Handy.mod_metadata.version

Handy.load_file("src/index.lua")

-- TODO:
-- 1. localization
-- 2. keywords
-- 3. API for adding items to dictionary
-- 4. Credits?
-- 5. Cleanup code
--- Insta actions
--- UI
-- 7. sprites loading
-- 8. fix slider
-- 9. cutting-edge technology: scrollbar for patchnotes

-- TODO: controller
-- 1. fix doubletap in hand selection preview (somehow)
-- 2. touchscreen? (somehow)
-- 3. override controller controls (somehow)
-- 4. multiple buttons render? (somehow)

-- TODO: check controls (controller & touchscreen)
-- hand selection - fix preview
-- insta actions - complicated
-- regular keybinds:
--- menus
-- dangerous
--- controller sensitivity

-- TODO: plans for v2.1
-- 1. keymapper
