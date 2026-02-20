to_big = to_big or function(x)
	return x
end
to_number = to_number or function(x)
	return tonumber(x)
end

Handy = setmetatable({
	---@diagnostic disable-next-line: undefined-global
	NFS = NFS or require("handy/nativefs"),
	---@diagnostic disable-next-line: undefined-global
	JSON = JSON or json or require("handy/json"),
	---@diagnostic disable-next-line: undefined-global
	PATH = Handy_main_file_path,
	version = "2.0.0~ALPHA-6b",

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
	return Handy.NFS.read(Handy.PATH .. "/" .. file)
end
function Handy.load_file(file)
	return assert(load(Handy.read_file(file), '=[SMODS Handy "' .. file .. '"]'))()
end
function Handy.load_files(files, prefix)
	for _, file in pairs(files) do
		Handy.load_file(prefix .. file)
	end
end

Handy.load_file("src/index.lua")

-- TODO:
-- 1. localization
-- 2. keywords
-- 3. API for adding items to dictionary
-- 4. Credits?
-- 5. Cleanup code
--- Insta actions
--- UI
-- 6. loading from archive
-- 7. sprites loading
-- 8. fix slider
-- 9. cutting-edge technology: scrollbar for patchnotes

-- TODO: controller
-- 1. fix doubletap in hand selection preview (somehow)
-- 2. touchscreen? (somehow)
-- 3. override controller controls (somehow)
-- 4. multiple buttons render?

-- TODO: check controls (controller & touchscreen)
-- hand selection - fix preview
-- insta actions - complicated
-- regular keybinds:
--- menus
-- dangerous
--- controller sensitivity
