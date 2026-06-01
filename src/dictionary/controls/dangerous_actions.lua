Handy.dictionary.register({
	key = "dangerous_actions",
	get_module = function(self)
		return Handy.cc.dangerous_actions
	end,
	keywords = { "dangerous unsafe" },
	checkbox = true,
	dangerous = true,

	items = {
		{
			key = "dangerous_actions_sell_one",
			keywords = { "quick instant mass sell in bulk" },
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_sell_one
			end,
			no_mp = Handy.dangerous_actions.is_sell_disabled_in_mp,
		},
		{
			key = "dangerous_actions_remove_one",
			keywords = { "quick instant mass remove in bulk card cards skip tags" },
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_remove_one
			end,
			no_mp = Handy.dangerous_actions.is_remove_disabled_in_mp,
		},
		{
			key = "dangerous_actions_mass_sell_remove_mode",
			get_module = function()
				return Handy.cc.dangerous_actions_mass_sell_remove_mode
			end,
			dangerous = true,
			option_cycle = {
				get_values = function()
					return {
						options = {
							Handy.L.dictionary("handy_dangerous_actions_mass_sell_remove_mode", 1),
							Handy.L.dictionary("handy_dangerous_actions_mass_sell_remove_mode", 2),
						},
					}
				end,
			},
			loc_vars = function()
				return {
					vars = {
						Handy.L.brackets(
							Handy.L.name_text("Handy_ConfigDictionary", "dangerous_actions_sell_all_same")
						),
						Handy.L.brackets(
							Handy.L.name_text("Handy_ConfigDictionary", "dangerous_actions_remove_all_same")
						),
						Handy.L.brackets(Handy.L.name_text("Handy_ConfigDictionary", "dangerous_actions_sell_all")),
						Handy.L.brackets(Handy.L.name_text("Handy_ConfigDictionary", "dangerous_actions_remove_all")),
					},
				}
			end,
		},
		{
			key = "dangerous_actions_sell_all_same",
			keywords = { "quick instant mass sell in bulk all same copies card cards" },
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_sell_all_same
			end,
			no_mp = Handy.dangerous_actions.is_sell_disabled_in_mp,
		},
		{
			key = "dangerous_actions_remove_all_same",
			keywords = { "quick instant mass remove in bulk all same copies card cards skip tags" },
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_remove_all_same
			end,
			no_mp = Handy.dangerous_actions.is_remove_disabled_in_mp,
		},
		{
			key = "dangerous_actions_sell_all",
			keywords = { "quick instant mass sell in bulk all card cards" },
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_sell_all
			end,
			no_mp = Handy.dangerous_actions.is_sell_disabled_in_mp,
		},
		{
			key = "dangerous_actions_remove_all",
			keywords = { "quick instant mass remove in bulk all card cards skip tags" },
			checkbox = true,
			keybind = {
				allow_multiple = true,
			},
			dangerous = true,
			get_module = function(self)
				return Handy.cc.dangerous_actions_remove_all
			end,
			no_mp = Handy.dangerous_actions.is_remove_disabled_in_mp,
		},
		{
			key = "dangerous_actions_crash",
			keywords = { "crash game fuck you" },
			checkbox = true,
			dangerous = true,
			keybind = {
				allow_multiple = true,
				only_safe = true,
			},
			get_module = function(self)
				return Handy.cc.dangerous_actions_crash
			end,
			no_mp = true,
		},
		{
			key = "dangerous_actions_stack_overflow",
			keywords = { "crash game fuck you stack overflow" },
			checkbox = true,
			dangerous = true,
			keybind = {
				allow_multiple = true,
				only_safe = true,
			},
			get_module = function(self)
				return Handy.cc.dangerous_actions_stack_overflow
			end,
			no_mp = true,
		},
	},
})
