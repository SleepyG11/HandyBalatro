to_big = to_big or function(x)
	return x
end
to_number = to_number or function(x)
	return tonumber(x)
end

Handy = {
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
		["2.0.0_alpha_update"] = true,
		["2.0.0_mp_extension"] = true,
		["2.0.0_updater"] = true,
		-- ["2.0.0_update"] = true,
	},

	keys_aliases = {
		["["] = "Left Bracket",
		["]"] = "Right Bracket",
	},

	ARGS = {},

	fs_loaded_files = {},
}

function Handy.get_fs()
	if Handy.LOCAL_PATH then
		return love.filesystem, Handy.LOCAL_PATH .. "/"
	else
		return Handy.NFS, Handy.PATH .. "/"
	end
end
function Handy.wrap_fs_function(func_name)
	return function(path, ...)
		local fs, start = Handy.get_fs()
		return fs[func_name](start .. path, ...)
	end
end
Handy.read_file = Handy.wrap_fs_function("read")
Handy.get_file_info = Handy.wrap_fs_function("getInfo")
Handy.get_directory_items = Handy.wrap_fs_function("getDirectoryItems")

function Handy.load_file(file, nocache)
	if Handy.fs_loaded_files[file] and not nocache then
		return unpack(Handy.fs_loaded_files[file])
	end
	Handy.fs_loaded_files[file] = { assert(load(Handy.read_file(file), '=[SMODS Handy "' .. file .. '"]'))() }
	return unpack(Handy.fs_loaded_files[file])
end
function Handy.load_files(files, prefix, nocache)
	for _, file in pairs(files) do
		Handy.load_file(prefix .. file, nocache)
	end
end

function Handy.load_directory(path, recursive, nocache)
	local index_info = Handy.get_file_info(path .. "/index.lua")
	if index_info and index_info.type == "file" then
		Handy.load_file(path .. "/index.lua")
	end
	for _, file in ipairs(Handy.get_directory_items(path)) do
		local partial_path = path .. "/" .. file
		local info = Handy.get_file_info(partial_path)
		if info.type == "directory" then
			if recursive then
				Handy.load_directory(partial_path, recursive, nocache)
			end
		elseif info.type == "file" then
			Handy.load_file(partial_path, nocache)
		end
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

To fix this, do the followings:
- Make sure mod is not "nested" (so there's no "folder in folder" like "/Mods/HandyBalatro/HandyBalatro")
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
-- 4. Credits?
-- 5. Cleanup code
--- UI
-- 10. touchscreen? (somehow)
-- 11. UI for gamepad

-- TODO: check controls (controller & touchscreen)
-- insta actions - complicated
-- dangerous - complicated

-- TODO: plans for v2.1
-- 1. keymapper

-- TODO: gamepad
-- fix a weird edge case which allows focus move to side panel only on "down" press, not "right"
