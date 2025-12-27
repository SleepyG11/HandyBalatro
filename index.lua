to_big = to_big or function(x)
	return x
end

Handy = setmetatable({
	---@diagnostic disable-next-line: undefined-global
	NFS = NFS or require("handy/nativefs"),
	---@diagnostic disable-next-line: undefined-global
	PATH = Handy_main_file_path,
	version = "2.0.0-alpha1",

	meta = {
		["1.4.1b_patched_select_blind_and_skip"] = true,
		["1.5.0_update"] = true,
		["1.5.1a_multiplayer_check"] = true,
		["2.0.0_update"] = true,
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
-- 3. show when keybind supports combinations
-- 4. more pages (advanced, dangerous, credits)
-- 5. maybe icons for menu buttons?
-- 6. toggle to allow speed & animations in MP
-- 7. popup for checkbox if not available in MP (+ mechanism to enable all of them on double click) + optimize it
-- 8. fill scoring hold page with something (specifically displaying is it holded?)
-- 9. cleanup loc_txt
