Handy.dictionary.register({
	key = "me",
	keywords = { "me sleepy sleepyg11 g11 sprite girl tyan anime self insert author" },
	loc_vars = function()
		return {
			vars = { "@lord.ruby" },
		}
	end,
})

Handy.dictionary.register({
	key = "me_in_mod_config",
	parent = "me",
	get_module = function()
		return Handy.cc.me_in_mod_config
	end,

	checkbox = true,
})
Handy.dictionary.register({
	key = "me_in_game_over",
	parent = "me",
	get_module = function()
		return Handy.cc.me_in_game_over
	end,

	checkbox = true,
})
Handy.dictionary.register({
	key = "me_in_game_win",
	parent = "me",
	get_module = function()
		return Handy.cc.me_in_game_win
	end,

	checkbox = true,
})
Handy.dictionary.register({
	key = "me_in_screenswipe",
	parent = "me",
	get_module = function()
		return Handy.cc.me_in_screenswipe
	end,

	checkbox = true,
})
