Handy.dictionary.register({
	key = "insta_actions",
	keywords = { "insta quick actions quick buy sell use" },
	checkbox = true,
	get_module = function(self)
		return Handy.cc.insta_actions
	end,

	items = {
		{
			key = "insta_actions_trigger_mode",
			keywords = { "trigger mode" },
			get_module = function(self)
				return Handy.cc.insta_actions_trigger_mode
			end,
			option_cycle = {
				save = true,
				get_values = function()
					return {
						options = {
							Handy.L.dictionary("handy_buy_sell_use_mode_hold_n_click"),
							Handy.L.dictionary("handy_buy_sell_use_mode_hover_n_press"),
						},
					}
				end,
			},
		},
		{
			key = "insta_actions_buy_or_sell",
			keywords = { "buy or sell card cards" },
			keybind = {
				allow_multiple = "advanced",
			},
			checkbox = true,

			get_module = function(self)
				return Handy.cc.insta_actions_buy_or_sell, { Handy.D.dictionary.insta_actions }
			end,

			loc_vars = function()
				return {
					vars = { Handy.L.name_text("Handy_ConfigDictionary", "insta_actions_trigger_mode") },
					key = Handy.cc.insta_actions_trigger_mode.value == 2 and "insta_actions_buy_or_sell_alt" or nil,
				}
			end,
		},
		{
			key = "insta_actions_buy_n_sell",
			keywords = { "buy and sell buy n sell card cards" },
			keybind = {
				allow_multiple = "advanced",
			},
			checkbox = true,

			get_module = function(self)
				return Handy.cc.insta_actions_buy_n_sell, { Handy.D.dictionary.insta_actions }
			end,

			loc_vars = function()
				return {
					vars = { Handy.L.name_text("Handy_ConfigDictionary", "insta_actions_trigger_mode") },
					key = Handy.cc.insta_actions_trigger_mode.value == 2 and "insta_actions_buy_n_sell_alt" or nil,
				}
			end,
		},
		{
			key = "insta_actions_use",
			keywords = { "use consumables consumeables card cards" },
			keybind = {
				allow_multiple = "advanced",
			},
			checkbox = true,

			get_module = function(self)
				return Handy.cc.insta_actions_use, { Handy.D.dictionary.insta_actions }
			end,

			loc_vars = function()
				return {
					vars = { Handy.L.name_text("Handy_ConfigDictionary", "insta_actions_trigger_mode") },
					key = Handy.cc.insta_actions_trigger_mode.value == 2 and "insta_actions_use_alt" or nil,
				}
			end,
		},
		-- {
		-- 	key = "insta_actions_cryptid_code_use_last_interaction",
		-- 	keywords = {},
		-- 	keybind = {
		-- 		allow_multiple = "advanced",
		-- 	},
		-- 	checkbox = true,

		-- 	get_module = function(self)
		-- 		return Handy.cc.insta_actions_cryptid_code_use_last_interaction, { Handy.D.dictionary.insta_actions }
		-- 	end,

		-- 	loc_vars = function()
		-- 		return {
		-- 			vars = { Handy.L.name_text("Handy_ConfigDictionary", "insta_actions_trigger_mode") },
		-- 			key = Handy.cc.insta_actions_trigger_mode.value == 2
		-- 					and "insta_actions_cryptid_code_use_last_interaction_alt"
		-- 				or nil,
		-- 		}
		-- 	end,
		-- },
	},
})
