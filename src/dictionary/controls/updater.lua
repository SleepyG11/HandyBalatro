Handy.dictionary.register({
	key = "updater",
	keywords = { "auto mod update updating patch note notes patchnotes install" },

	get_module = function()
		return Handy.cc.updater
	end,

	checkbox = true,
	items = {
		{
			key = "updater_target_release_type",
			keywords = { "popup" },
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
		},
		{
			key = "updater_notify_about_new_update",
			keywords = { "popup" },
			get_module = function(self)
				return Handy.cc.updater_notify_about_new_update
			end,
			get_deps = function(self)
				return { self.parent }
			end,
			checkbox = true,
		},
		{
			key = "updater_auto_install_new_update",
			keywords = { "auto install" },
			get_module = function(self)
				return Handy.cc.updater_auto_install_new_update
			end,
			get_deps = function(self)
				return { self.parent }
			end,
			checkbox = true,
		},
		{
			key = "updater_auto_restart_game_after_update",
			keywords = { "auto restart" },
			get_module = function(self)
				return Handy.cc.updater_auto_restart_game_after_update
			end,
			get_deps = function(self)
				return { self.parent, Handy.D.dictionary.updater_auto_install_new_update }
			end,
			checkbox = true,
			colour = adjust_alpha(G.C.MULT, 0.1),
		},
	},
})
