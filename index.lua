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
-- 2. more pages (advanced, credits)
-- 3. maybe icons for menu buttons?
-- 4. toggle to allow speed & animations in MP
-- 5. keywords
-- 6. description for animation skip levels
-- 7. hold implementation for move highlight
-- 8. fix event stuck in base queue when exiting speed preview
-- 9. hold trigger

-- TODO: check controls (controller)
-- hand selection
-- speed
-- animations
-- move selection
-- insta actions
-- presets
-- scoring hold
-- regular keybinds:
--- game
--- menus
--- round
--- shop
--- blind select
-- dangerous

-- TODO: make sure every preview works identical:
--- work if mod disabled
