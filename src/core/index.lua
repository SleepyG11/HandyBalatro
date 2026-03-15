Handy.load_files({
	"utils/index.lua",

	"e_mitter.lua",
	"buffer.lua",
	"fake_events.lua",
	"flags.lua",
	"localization.lua",

	"config/index.lua",
	"presets/index.lua",
	"controller/index.lua",
	"updater/index.lua",
}, "src/core/")

function Handy.save_all_config()
	Handy.config.save()
	Handy.presets.save()
end
