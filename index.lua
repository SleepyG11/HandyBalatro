to_big = to_big or function(x)
	return x
end

Handy = setmetatable({
	---@diagnostic disable-next-line: undefined-global
	NFS = (SMODS and SMODS.NFS) or NFS or require("handy/nativefs"),
	---@diagnostic disable-next-line: undefined-global
	PATH = Handy_main_file_path,
	LOCAL_PATH = nil,
	MOUNTED_LOCAL_PATH = nil,

	version = "2.0.0~ALPHA-5",

	meta = {
		["1.4.1b_patched_select_blind_and_skip"] = true,
		["1.5.0_update"] = true,
		["1.5.1a_multiplayer_check"] = true,
		["2.0.0_update"] = true,
		["2.0.0_mp_extension"] = true,
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
	Handy.LOCAL_PATH = new_local_path
end

Handy.JSON = Handy.load_file("src/libs/json.lua")

Handy.load_file("src/index.lua")

-- TODO:
-- 0. controller for all this shit (god help me)
-- 1. localization
-- 2. more pages (advanced, credits)
-- 3. maybe icons for menu buttons?
-- 4. decide should speed n animations preview work when mod is disabled
-- 10. touchscreen?
-- 11. fix doubletap in hand selection preview (somehow)
-- 12. override controller controls (somehow)
-- 14. fix non-smods visual bugs
-- 15. make swappable overlays close when they was opened by same keybind
-- 16. cleanup insta actions code, goddamn

-- TODO: check controls (controller)
-- hand selection - fix preview
-- insta actions - complicated
-- regular keybinds:
--- menus
-- dangerous
--- controller sensitivity
