to_big = to_big or function(x)
	return x
end

Handy = setmetatable({
	---@diagnostic disable-next-line: undefined-global
	NFS = NFS or require("handy/nativefs"),
	---@diagnostic disable-next-line: undefined-global
	PATH = Handy_main_file_path,
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

function Handy.load_file(file)
	return assert(load(Handy.NFS.read(Handy.PATH .. "/" .. file), '=[SMODS Handy "' .. file .. '"]'))()
end
function Handy.load_files(files, prefix)
	for _, file in pairs(files) do
		Handy.load_file(prefix .. file)
	end
end

Handy.load_file("src/index.lua")

-- TODO:
-- 0. controller for all this shit (god help me)
-- 1. component for checkbox and option cycle (UIKit mod?)
-- 2. more pages (advanced, credits)
-- 3. maybe icons for menu buttons?
-- 4. decide should speed n animations preview work when mod is disabled
-- 5. keywords (make it better if makes sense)
-- 7. hold implementation for move highlight
-- 8. fix event stuck in base queue when exiting speed preview
-- 9. decrease mod load when disabled (specifically input contexts)
-- 10. touchscreen?
-- 11. fix doubletap in hand selection preview (somehow)
-- 12. override controller controls (somehow)
-- 13. "update mod" button

-- TODO: check controls (controller)
-- hand selection - fix preview
-- insta actions - complicated
-- regular keybinds:
--- menus
-- dangerous
