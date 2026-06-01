Handy.dictionary.register({
	key = "me",
	keywords = { "me sleepy sleepyg11 g11 sprite girl tyan anime self insert author" },
	loc_vars = function()
		return {
			vars = { "@lord.ruby" },
		}
	end,

	items = {
		{
			key = "me_in_mod_config",
			get_module = function()
				return Handy.cc.me_in_mod_config
			end,

			checkbox = true,
		},
		{
			key = "me_in_game_over",
			get_module = function()
				return Handy.cc.me_in_game_over
			end,

			checkbox = true,
		},
		{
			key = "me_in_game_win",
			get_module = function()
				return Handy.cc.me_in_game_win
			end,

			checkbox = true,
		},
		{
			key = "me_in_screenswipe",
			get_module = function()
				return Handy.cc.me_in_screenswipe
			end,

			checkbox = true,
		},
		-- {
		-- 	key = "me_in_handy_tag",
		-- 	get_module = function()
		-- 		return Handy.cc.me_in_handy_tag
		-- 	end,

		-- 	checkbox = true,
		-- },
	},
})
