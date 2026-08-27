Handy.load_files({
	"utils/index.lua",

	"e_mitter.lua",
	"buffer.lua",
	"fake_events.lua",
	"flags.lua",
	"localization.lua",
	"me.lua",

	"config/index.lua",
	"presets/index.lua",
	"controller/index.lua",

	"controls.lua",
	"dictionary.lua",
	"stack.lua",

	"api.lua",
}, "src/core/")

if not Handy.meta.thunderstore_release then
	Handy.load_file("src/core/updater/index.lua")
end

function Handy.save_all_config()
	Handy.config.save()
	Handy.presets.save()
end
