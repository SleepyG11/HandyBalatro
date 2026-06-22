Handy.dictionary.register({
	key = "updater",
	keywords = { "auto mod update updating patch note notes patchnotes install github" },
	order = 5,

	get_module = function()
		return Handy.cc.updater
	end,

	checkbox = true,
})

Handy.dictionary.register({
	key = "updater_target_release_type",
	parent = "updater",
	order = 1,

	keywords = { "popup release" },
	get_module = function(self)
		return Handy.cc.updater_release_type
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	option_cycle = {
		get_values = function()
			return {
				options = {
					Handy.L.dictionary("handy_release_type_stable"),
					Handy.L.dictionary("handy_release_type_pre_release"),
				},
			}
		end,
	},
})
Handy.dictionary.register({
	key = "updater_notify_about_new_update",
	parent = "updater",
	order = 2,

	keywords = { "popup new update" },
	get_module = function(self)
		return Handy.cc.updater_notify_about_new_update
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	checkbox = true,
})
Handy.dictionary.register({
	key = "updater_auto_install_new_update",
	parent = "updater",
	order = 3,

	keywords = { "auto install" },
	get_module = function(self)
		return Handy.cc.updater_auto_install_new_update
	end,
	get_deps = function(self)
		return { self.parent }
	end,

	checkbox = true,
})
Handy.dictionary.register({
	key = "updater_auto_restart_game_after_update",
	parent = "updater",
	order = 4,

	keywords = { "auto install restart" },
	get_module = function(self)
		return Handy.cc.updater_auto_restart_game_after_update
	end,
	get_deps = function(self)
		return { self.parent, Handy.D.dictionary.updater_auto_install_new_update }
	end,
	colour = adjust_alpha(G.C.MULT, 0.1),

	checkbox = true,
})
